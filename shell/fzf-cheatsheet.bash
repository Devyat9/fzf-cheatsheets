fzf-cheatsheets-widget() {
    local cmd
    cmd=$(echo "${READLINE_LINE}" | awk '{ print $1 }')
    local query
    query=$(echo "${READLINE_LINE}" | awk '{for (i=2; i<NF; i++) print $i " "; print $NF}')
    local selected
    if [ -z "${cmd}" ]; then
      selected="$(fzf-cheatsheets)"
    else
      selected="$(fzf-cheatsheets "${cmd}" -- "${query}")"
    fi
    local ret=$?
    if [ $ret -eq 0 ]; then
        READLINE_LINE="$selected"
        READLINE_POINT=${#selected}
    else
        echo -n "$selected" 1>&2
    fi
    return $ret
}

bind -m emacs-standard -x '"\ec": fzf-cheatsheets-widget'
bind -m vi-command -x '"\ec": fzf-cheatsheets-widget'
bind -m vi-insert -x '"\ec": fzf-cheatsheets-widget'
