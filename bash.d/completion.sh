# cdp and aliases
_cdp() {
    local IFS=$'\t\n'
    local dirs=$(echo ${COMP_WORDS[0]} | tr [:lower:] [:upper:])_DIRS[@]
    COMPREPLY=( $(
        for dir in "${!dirs}"; do
            for i in $(
                cd "$dir" 2> /dev/null && 
                compgen -d -- "${COMP_WORDS[COMP_CWORD]}"
            ); do
                    #  If i not dir in current dir, append extra slash '/'
                    #  NOTE: With bash > v2, if i is also dir in current dir, 
                    #+       'complete -o filenames' automatically appends 
                    #+       slash '/'
                (( $BASH_VERSINFO == 2 )) || [ ! -d ${i#$dir} ] && i="$i/"
                echo "$i"
            done
        done
    ) )
    return 0
} # _cdp()

# NOTE: '-o filenames' escapes special characters, whereas '-o dirnames' doesn't
complete -o filenames -o nospace -F _cdp cdp

# Bash completion for rabbitvcs modules
# ---------------------------------------------------------------------------
_rabitvcs_opts()
{
    rabbitvcs 2>&1 |
    sed '
        5,/^$/!d
        s/,\s*/,/g
    ' |
    awk -F',' '
        {
            for (i = 1; i < NF; i++) { arr[length(arr)] = $i }
        }
        END{
            for (e in arr) { print arr[e] }
        }' | 
    grep "^$2.*";
}
complete -C _rabitvcs_opts -o default rabbitvcs

# ---------------------------------------------------------------------------


# ANSI colours
# ---------------------------------------------------------------------------
_complete_ansi_color()
{
   echo "black red green brown blue purple cyan light_gray dark_gray light_red light_green yellow light_blue light_purple light_cyan white none" | 
   tr ' ' '\n' | grep "^$2.*"
}
complete -C _complete_ansi_color -o default set_prompt_color
complete -C _complete_ansi_color -o default ansi_color
# ---------------------------------------------------------------------------


if [ -f `brew --prefix`/etc/bash_completion ]; then
  . `brew --prefix`/etc/bash_completion
fi
