#!/bin/bash

target_dir=${HOME}/.profile.d

if [[ ! -d ${target_dir} ]]
then
    echo "Cannot install profile scripts to '${target_dir}'"
    exit -1
fi

source_dir=$1
if [[ "${source_dir}" == "" ]]
then
    echo "No source dir provided!"
    exit -1
fi

if [[ ! -d ${source_dir} ]]
then
    echo "Invalid source dir '${source_dir}'"
    exit -1
fi

cd $target_dir

rc=0

for i in $source_dir/[0-9]*.sh
do
    echo "Installing $i"
    base=`basename $i`
    if [[ -e $base ]]
    then
        if [[ `readlink $base` != ${i} ]]
        then
            echo "$target_dir/$base already exists."
            let rc=$((rc+1))
        else
            echo "$target_dir/$base already exists, but points to same place"
        fi
    else
        ln -sf $i
    fi
done

echo "All profile scripts installed to $target_dir with $rc errors"

exit $rc

