_patch_help() {
    if [[ "$*" == "direnv" ]]; then
        $@ --help | sed -e 's/^  /        /' -e 's/^\(\w\+\).*:$/  \1/'  -e '/Available commands/,+1 c\Commands:' 
    fi
}

_patch_table() { 
    if [[ "$*" == "direnv" ]]; then
        _patch_table_edit_arguments ';;'
    elif [[ "$*" == "direnv allow" ]] || [[ "$*" == "direnv deny" ]] || [[ "$*" == "direnv edit" ]]; then
        _patch_table_edit_arguments ';;' 'file;[`_choice_path_to_rc`]'
    elif [[ "$*" == "direnv exec" ]]; then
        _patch_table_edit_arguments ';;' 'dir' 'cmd;[`_choice_cmd`]' 'args;~[`_choice_args`]'
    elif [[ "$*" == "direnv fetchurl" ]]; then
        _patch_table_edit_arguments ';;' 'urls...'
    elif [[ "$*" == "direnv hook" ]]; then
        _patch_table_edit_arguments ';;' 'shell;[`_choice_hook_shell`]'
    else
        cat
    fi
}

_choice_path_to_rc() {
    _argc_util_comp_file exts=.envrc,.env
}

_choice_cmd() {
    _argc_util_comp_file
    _choice_command
}

_choice_command() {
    if [[ "$ARGC_OS" != "windows" ]]; then
        compgen -c
    fi
}

_choice_args() {
    _argc_util_comp_subcommand 1
}

_choice_hook_shell() {
    printf "%s" bash elvish fish tcsh zsh
}