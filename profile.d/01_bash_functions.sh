#
# Generic shell functions that are useful
#

#
# Date time
#
function today() {
    date +"%Y%m%d"
}

function yesterday() {
    date --date="yesterday" +"%Y%m%d"
}

function tomorrow() {
    date --date="tomorrow" +"%Y%m%d"
}

function tmptoday() {
    mkdir -p ~/tmp/`today`
    rm -f ~/tmp/today
    ln -sf ~/tmp/`today` ~/tmp/today
}

function now() {
    date +"%Y%m%d.%H%M%S"
}

#
# text
#

function to_lower() {
    echo "$@" | tr [:upper:] [:lower:]
}

function to_upper() {
    echo "$@" | tr [:lower:] [:upper:]
}

function echo_err() {
    echo "$@" 1>&2
}

#The ANSI standard defines 8 colours, plus a bright mode, giving a total of 16
# posibilities. The sequence is:
#
# \e[<number>m
#
#Where <number> is one of:
#
#Foreground:
#
#    30 Black
#    31 Red
#    32 Green
#    33 Yellow
#    34 Blue
#    35 Magenta
#    36 Cyan
#    37 White
#
#Background:
#
#    40 Black
#    41 Red
#    42 Green
#    43 Yellow
#    44 Blue
#    45 Magenta
#    46 Cyan
#
#    47 White
#
#    0 Reset all
#    1 Bold
#
function ansi_fg() {
    local my_result=""
    local c=""
    for c in $@
    do
        local color=$(to_lower $c)
        #echo_err "color=$color"
        case $color in
            reset)
            my_result="${my_result}\e[0m"
            ;;
            bold)
            my_result="${my_result}\e[1m"
            ;;
            black)
            my_result="${my_result}\e[30m"
            ;;
            red)
            my_result="${my_result}\e[31m"
            ;;
            green)
            my_result="${my_result}\e[32m"
            ;;
            yellow)
            my_result="${my_result}\e[33m"
            ;;
            blue)
            my_result="${my_result}\e[34m"
            ;;
            magenta)
            my_result="${my_result}\e[35m"
            ;;
            cyan)
            my_result="${my_result}\e[36m"
            ;;
            white)
            my_result="${my_result}\e[37m"
            ;;
            *)
            echo_err "ansi_fg: Undefined color '$color'" 1>&2
            ;;
        esac
    done
    echo $my_result
}

function ansi_bg() {
    local my_result=""
    local c=""
    for c in $@
    do
        local color=$(to_lower $c)
        #echo_err "color=$color"
        case $color in
            reset)
            my_result="${my_result}\e[0m"
            ;;
            bold)
            my_result="${my_result}\e[1m"
            ;;
            black)
            my_result="${my_result}\e[40m"
            ;;
            red)
            my_result="${my_result}\e[41m"
            ;;
            green)
            my_result="${my_result}\e[42m"
            ;;
            yellow)
            my_result="${my_result}\e[43m"
            ;;
            blue)
            my_result="${my_result}\e[44m"
            ;;
            magenta)
            my_result="${my_result}\e[45m"
            ;;
            cyan)
            my_result="${my_result}\e[46m"
            ;;
            white)
            my_result="${my_result}\e[47m"
            ;;
            [0-9])
            ;;
            *)
            echo_err "ansi_bg: Undefined color '$color'" 1>&2
            ;;
        esac
    done
    echo $my_result
}

#
# Echo a red line
#

function bg_line() {
    local start=$(ansi_bg $@)
    local end=$(ansi_bg reset)
    local count=${!#}
    local START=1
    local END=1
    #echo_err "count=$count"
    case $count in
        [0-9])
            END=$count
        ;;
        [0-9][0-9])
            END=$count
        ;;
        *)
            END=1
        ;;
    esac
    #echo_err "START=$START"
    #echo_err "END=$END"

    for (( c=$START; c<=$END; c++ ))
    do
        echo -e "$start                                                                                $end"
    done
}

alias bgl="bg_line red 1"

function echo_red() {
echo -e "\e[41m                                                                                \e[0m"
}

