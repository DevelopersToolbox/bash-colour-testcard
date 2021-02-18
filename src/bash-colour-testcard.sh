#!/usr/bin/env bash

# -------------------------------------------------------------------------------- #
# Description                                                                      #
# -------------------------------------------------------------------------------- #
# This is a simple script to display a matrix of colours based on the number of    #
# colours that your terminal is able to support.                                   #
#                                                                                  #
# It will make best efforts to size the output to the size of your terminal making #
# it display nicely in most terminals.                                             #
#                                                                                  #
# It has 4 main use cases:                                                         #
#     -c = Show a complete display of all the available colour combinations        #
#     -n = Display just the number of colours the terminal supports                #
#     -s = Show a simple display of the available colours (default)                #
#     -t = Test mode - show what a colour looks like for inputted values           #
# -------------------------------------------------------------------------------- #

# -------------------------------------------------------------------------------- #
# Global Variables                                                                 #
# -------------------------------------------------------------------------------- #
# The following global variables are used simple to make the header look nice.     #
# -------------------------------------------------------------------------------- #

SCRIPT_TITLE="Bash Colour Testcard"

LIMITED_MODE=false

# -------------------------------------------------------------------------------- #
# Script/Command Line Parameters                                                   #
# -------------------------------------------------------------------------------- #
# The following functions are directly linked to the command line parameters that  #
# users are able to specify when running the script.                               #
#                                                                                  #
# There are 4 main parameters:                                                     #
#     -c = Show a complete display of all the available colour combinations        #
#     -n = Display just the number of colours the terminal supports                #
#     -s = Show a simple display of the available colours (default)                #
#     -t = Test mode - show what a colour looks like for inputted values           #
#                                                                                  #
# There is 1 other additional parameter:                                           #
#     -h = Display the help page                                                   #
# -------------------------------------------------------------------------------- #

# -------------------------------------------------------------------------------- #
# -n parameter                                                                     #
# -------------------------------------------------------------------------------- #
# This function is run when the user passes -n to the script, and it shows the     #
# most minimal information possible. In this case it is a stripped down version    #
# of the script header showing the number of colours supported by the terminal.    #
# -------------------------------------------------------------------------------- #

function show_colour_count
{
    printf '%s\n' "${SCRIPT_TITLE}"
    printf 'Your terminal appears to support %s colours\n' "${ncolors}"
}

# -------------------------------------------------------------------------------- #
# -s (default) parameter                                                           #
# -------------------------------------------------------------------------------- #
# This function is run when the user passes -s to the script, and it shows the     #
# user a complete list of all available colour codes and an example of what the    #
# colour will look like. It does NOT show the foreground and background versions   #
# instead it uses just the background colour for simplicity.                       #
#                                                                                  #
# It uses the 'screen_width' in order to try to make the full use of the terminal  #
# and make the display effectively 'full screen'.                                  #
# -------------------------------------------------------------------------------- #

function show_simple_colours
{
    local local_colors

    if [[ "${LIMITED_MODE}" == false ]]; then
        show_header "${SCRIPT_TITLE}" "Simple Mode with ${ncolors} colours supported"
        local_colors=$ncolors
    else
        show_header "${SCRIPT_TITLE}" "Simple Mode limited to ${limited_colors} colours out of ${ncolors} (user limit)"
        local_colors=$limited_colors
    fi

    columns=$((screen_width / 22))

    for color in $(eval echo "{0..$local_colors}")
    do
        set_background=$(tput setab "${color}")
        printf ' %s        %s (Code: %3s) ' "${set_background}" "${reset}" "${color}"
        if (( (color + 1) % columns == 0 )); then
            printf '%s\n' "${reset}"
        fi
    done
    if (( (color + 1) % columns != 0 )); then
        printf '%s\n' "${reset}"
    fi

    show_footer
}

# -------------------------------------------------------------------------------- #
# -c parameter                                                                     #
# -------------------------------------------------------------------------------- #
# This function is run when the user passes -c to the script, and it shows the     #
# user a complete list of all available colour codes and an example of what the    #
# colour will look like.                                                           #
#                                                                                  #
# The mian difference with complete mode is it will show both the foreground and   #
# and the background colours for every variation possible.                         #
#                                                                                  #
# It uses the 'screen_width' in order to try to make the full use of the terminal  #
# and make the display effectively 'full screen'.                                  #
#                                                                                  #
# NOTE: This can take a long time to run especially if you support 256 (or more)   #
# colours as it tries to show every permutation.                                   #
# -------------------------------------------------------------------------------- #

function show_complete_colours
{
    local local_colors
    local count=0

    if [[ "${LIMITED_MODE}" == false ]]; then
        show_header "${SCRIPT_TITLE}" "Complete Mode with ${ncolors} colours supported"
        local_colors=$ncolors
    else
        show_header "${SCRIPT_TITLE}" "Complete Mode limited to ${limited_colors} colours out of ${ncolors} (user limit)"
        local_colors=$limited_colors
    fi

    columns=$((screen_width / 26))

    for fg_color in $(eval echo "{0..$local_colors}")
    do
        set_foreground=$(tput setaf "${fg_color}")
        for bg_color in $(eval echo "{0..$local_colors}")
        do
            count=$(( count + 1 ))
            set_background=$(tput setab "${bg_color}")

            printf '%s F:%3s B:%3s %s' "${set_background}${set_foreground}" "${fg_color}" "${bg_color}" "${reset}"
            printf '%s F:%3s B:%3s %s' "${bold}${set_background}${set_foreground}" "${fg_color}" "${bg_color}" "${reset}"

            if (( count % columns == 0 )); then
                printf '%s\n' "${reset}"
            fi
        done
    done

    if (( count % columns != 0 )); then
        printf '%s\n' "${reset}"
    fi

    show_footer
}

# -------------------------------------------------------------------------------- #
# -t parameter                                                                     #
# -------------------------------------------------------------------------------- #
# This function is run when the user passes -t to the script, and it will prompt   #
# the user to enter 2 values, one for foreground and one for background, it will   #
# then display a test message using those values as colour codes.                  #
# -------------------------------------------------------------------------------- #

function test_mode
{
    local fg_color
    local bg_color
    local done=false
    local correct_response=false

    show_header "${SCRIPT_TITLE}" "Test Mode with ${ncolors} colours supported"

    while [[ "${done}" == false ]]; do

        correct_response=false
        while [[ "${correct_response}" == false ]]; do
            read -p "Enter a foreground colour code (0-${ncolors}): " -r fg_color
            if [[ $fg_color =~ ^[[:digit:]]+$ ]] && [[ ${fg_color} -ge 0 ]] && [[ ${fg_color} -le ${ncolors} ]]; then
                correct_response=true
            fi
        done

        correct_response=false
        while [[ "${correct_response}" == false ]]; do
            read -p "Enter a background colour code (0-${ncolors}): " -r bg_color
            if [[ $bg_color =~ ^[[:digit:]]+$ ]] && [[ ${bg_color} -ge 0 ]] && [[ ${bg_color} -le ${ncolors} ]]; then
                correct_response=true
            fi
        done

        set_foreground=$(tput setaf "${fg_color}")
        set_background=$(tput setab "${bg_color}")

        printf '\t%sThis is what your colours will like%s\n' "${set_background}${set_foreground}" "${reset}"
        printf '\t%sThis is what your colours will like with bold text%s\n' "${bold}${set_background}${set_foreground}" "${reset}"

        correct_response=false
        while [[ "${correct_response}" == false ]]; do
            read -p "Would you like to run another test (y/n) ? " -n 1 -r
            echo
            if [[ $REPLY =~ ^[Nn]$ ]]; then
                done=true
                correct_response=true
            elif [[ $REPLY =~ ^[Yy]$ ]]; then
                correct_response=true
            else
              echo "Please enter Y or N"
            fi
        done
    done
    show_footer
}

# -------------------------------------------------------------------------------- #
# Utiltity Functions                                                               #
# -------------------------------------------------------------------------------- #
# The following functions are all utility functions used within the script but     #
# are not specific to the display of the colours and only serve to handle things   #
# like, signal handling, user interface and command line option processing.        #
# -------------------------------------------------------------------------------- #

# -------------------------------------------------------------------------------- #
# Signal Handling                                                                  #
# -------------------------------------------------------------------------------- #
# This function is execute when a SIGINT or SIGTERM is caught. It allows us to     #
# exit the script nice and clean so do we not mess up the end users terminal.      #
# -------------------------------------------------------------------------------- #

function control_c
{
    printf '%s\n\n\n** Trapped CTRL-C **\n\n\n' "${reset}"
    show_footer
    exit
}

# -------------------------------------------------------------------------------- #
# Center text                                                                      #
# -------------------------------------------------------------------------------- #
# This is a simple function that will center text on a screen, be calculating the  #
# correct amount of padding based on the 'screen_width' and the length of the      #
# text supplied to the function.                                                   #
# -------------------------------------------------------------------------------- #

function center_text()
{
    textsize=${#1}
    span=$(((screen_width + textsize) / 2))

    printf '%*s\n' "${span}" "$1"
}

# -------------------------------------------------------------------------------- #
# Draw Line                                                                        #
# -------------------------------------------------------------------------------- #
# This function will draw a line on the screen to a given width. It does this by   #
# using 'screen_width' and by adding control codes to create an unbroken line.     #
# -------------------------------------------------------------------------------- #

function draw_line()
{
    local start=$'\e(0' end=$'\e(B' line='qqqqqqqqqqqqqqqq'

    while ((${#line} < screen_width));
    do
        line+="$line";
    done
    printf '%s%s%s\n' "$start" "${line:0:screen_width}" "$end"
}

# -------------------------------------------------------------------------------- #
# Show Header                                                                      #
# -------------------------------------------------------------------------------- #
# This is a simple wrapper function to make display the header easier to do. It    #
# will handle multiple lines passed as seperate parameters.                        #
#                                                                                  #
# In addition it will clear the screen fire, and wrap the header between to        #
# unbroken lines - attempting to make a cleaner interface for the end user.        #
# -------------------------------------------------------------------------------- #

function show_header()
{
    printf '%s' "${cls}"

    draw_line

    if [[ $# -gt 0 ]]; then
        for i in "$@"
        do
            center_text "${i}"
        done
        draw_line
    fi
}

# -------------------------------------------------------------------------------- #
# Show Footer                                                                      #
# -------------------------------------------------------------------------------- #
# A very simple (almost pointless) wrapper which will draw a line after at the     #
# bottom of the screen. We could just called 'draw_line' instead but this was      #
# added for 2 reasons. 1. Constistancy - we have draw_header, 2. Extensibility -   #
# we might want to do more things in the footer at a later date.                   #
# -------------------------------------------------------------------------------- #

function show_footer()
{
    draw_line
}

# -------------------------------------------------------------------------------- #
# Show Error                                                                       #
# -------------------------------------------------------------------------------- #
# A simple wrapper function to show something was an error.                        #
# -------------------------------------------------------------------------------- #

function show_error()
{
    if [[ -n $1 ]]; then
        printf '%s%s%s\n' "${red}" "${1}" "${reset}"
    fi
}

# -------------------------------------------------------------------------------- #
# Init                                                                             #
# -------------------------------------------------------------------------------- #
# A simple init function which will setup anything that is needed at the start of  #
# the script, for example set up the signal handler and work out the width of the  #
# screen that we have available.                                                   #
# -------------------------------------------------------------------------------- #

function init()
{
    # trap ctrl-c and call ctrl_c()
    trap control_c SIGINT
    trap control_c SIGTERM
}

# -------------------------------------------------------------------------------- #
# Check Colours                                                                    #
# -------------------------------------------------------------------------------- #
# This function will check to see if we are able to support colours and how many   #
# we are able to support.                                                          #
#                                                                                  #
# The script will give and error and exit if there is no colour support or there   #
# are less than 8 supported colours.                                               #
#                                                                                  #
# NOTE: Do NOT use show_error for the error messages are it requires colour!       #
# -------------------------------------------------------------------------------- #

function check_colours()
{
    if ! test -t 1; then
        printf 'Colour support not available not running inside a terminal - Aborting\n'
        exit 1
    fi

    if ! tput longname > /dev/null 2>&1; then
        printf 'Unknown terminal type %s - Aborting\n' "${TERM}"
        exit 1
    fi

    ncolors=$(tput colors)

    if ! test -n "${ncolors}" || test "${ncolors}" -le 7; then
        printf 'Colour support not available or less than 8 colours available - Aborting\n'
        exit 1
    fi

    red=$(tput setaf 1)
    bold=$(tput bold)
    cls=$(tput clear)
    reset=$(tput sgr0)
    screen_width=$(tput cols)

    declare -g ncolors
    declare -g red
    declare -g bold
    declare -g cls
    declare -g reset
    declare -g screen_width
}

# -------------------------------------------------------------------------------- #
# Usage (-h parameter)                                                             #
# -------------------------------------------------------------------------------- #
# This function is used to show the user 'how' to use the script.                  #
# -------------------------------------------------------------------------------- #

function usage()
{
cat <<EOF

  Usage: $0 [ -h ] [ -cnst ] [ -m number ]

    -h    : Print this screen
    -c    : complete mode (foreground & background [${ncolors} x ${ncolors}])
    -m    : set the maximum number of colours to display (between 0-${ncolors})
    -n    : display just the number of supported colours
    -s    : simple mode (colour codes only [${ncolors}])
    -t    : test mode (will prompt you for colour codes and display the results)

    Note: -c, -n, -s & -t must be used independently and not combined.

EOF
    exit 1;
}

# -------------------------------------------------------------------------------- #
# Process Input                                                                    #
# -------------------------------------------------------------------------------- #
# This function will process the input from the command line and work out what it  #
# is that the user wants to see.                                                   #
#                                                                                  #
# This is the main processing function where all the processing logic is handled.  #
# -------------------------------------------------------------------------------- #

function process_input()
{
    local mode

    if [[ -z $1 ]]; then
        show_simple_colours
    else
        while getopts ":hcnstm:" arg
        do
            case $arg in
                h)
                    usage
                    ;;
                m)
                    if [[ $OPTARG -lt 1 ]] || [[ $OPTARG -gt $ncolors ]]; then
                        show_error "You must specify a number between 0-${ncolors}"
                        usage
                    fi
                    limited_colors=$OPTARG
                    LIMITED_MODE=true
                    ;;
                c)
                    if [[ -n "${mode}" ]]; then
                        usage
                    fi
                    mode="complete"
                    ;;
                n)
                    if [[ -n "${mode}" ]]; then
                        usage
                    fi
                    mode="count"
                    ;;
                s)
                    if [[ -n "${mode}" ]]; then
                        usage
                    fi
                    mode="simple"
                    ;;
                t)
                    if [[ -n "${mode}" ]]; then
                        usage
                    fi
                    mode="test"
                    ;;
                :)
                    show_error "Option -$OPTARG requires an argument."
                    usage
                    ;;
                \?)
                    show_error "Invalid option: -$OPTARG"
                    usage
                    ;;
            esac
        done

        case "${mode}" in
            complete)
                show_complete_colours
                ;;
            count)
                show_colour_count
                ;;
            simple)
                show_simple_colours
               ;;
            test)
                test_mode
                ;;
        esac
    fi
}

# -------------------------------------------------------------------------------- #
# Main()                                                                           #
# -------------------------------------------------------------------------------- #
# This is the actual 'script' and the functions/sub routines are called in order.  #
# -------------------------------------------------------------------------------- #

init
check_colours
process_input "$@"

# -------------------------------------------------------------------------------- #
# End of Script                                                                    #
# -------------------------------------------------------------------------------- #
# This is the end - nothing more to see here.                                      #
# -------------------------------------------------------------------------------- #
