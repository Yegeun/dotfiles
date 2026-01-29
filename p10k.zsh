# Simplified Powerlevel10k configuration
'builtin' 'local' '-a' 'p10k_config_opts'
[[ ! -o 'aliases'         ]] || p10k_config_opts+=('aliases')
[[ ! -o 'sh_glob'         ]] || p10k_config_opts+=('sh_glob')
[[ ! -o 'no_brace_expand' ]] || p10k_config_opts+=('no_brace_expand')
'builtin' 'setopt' 'no_aliases' 'no_sh_glob' 'brace_expand'

() {
  emulate -L zsh -o extended_glob

  unset -m '(POWERLEVEL9K_*|DEFAULT_USER)~POWERLEVEL9K_GITSTATUS_DIR'

  [[ $ZSH_VERSION == (5.<1->*|<6->.*) ]] || return

  # Left prompt elements
  typeset -g POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(
    dir
    vcs
    uv_project
    prompt_char
  )

  # Right prompt elements
  typeset -g POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(
    status
    command_execution_time
    background_jobs
    time
  )

  # Character set
  typeset -g POWERLEVEL9K_MODE=nerdfont-v3
  typeset -g POWERLEVEL9K_ICON_PADDING=none

  # No newlines
  typeset -g POWERLEVEL9K_PROMPT_ADD_NEWLINE=false

  # Separators
  typeset -g POWERLEVEL9K_LEFT_SUBSEGMENT_SEPARATOR=''
  typeset -g POWERLEVEL9K_RIGHT_SUBSEGMENT_SEPARATOR=''
  typeset -g POWERLEVEL9K_LEFT_SEGMENT_SEPARATOR=''
  typeset -g POWERLEVEL9K_RIGHT_SEGMENT_SEPARATOR=''

  # Prompt char
  typeset -g POWERLEVEL9K_PROMPT_CHAR_BACKGROUND=
  typeset -g POWERLEVEL9K_PROMPT_CHAR_OK_{VIINS,VICMD,VIVIS,VIOWR}_FOREGROUND=76
  typeset -g POWERLEVEL9K_PROMPT_CHAR_ERROR_{VIINS,VICMD,VIVIS,VIOWR}_FOREGROUND=196
  typeset -g POWERLEVEL9K_PROMPT_CHAR_{OK,ERROR}_VIINS_CONTENT_EXPANSION='❯'
  typeset -g POWERLEVEL9K_PROMPT_CHAR_{OK,ERROR}_VICMD_CONTENT_EXPANSION='❮'

  # Directory
  typeset -g POWERLEVEL9K_DIR_BACKGROUND=237
  typeset -g POWERLEVEL9K_DIR_FOREGROUND=117
  typeset -g POWERLEVEL9K_SHORTEN_STRATEGY=truncate_to_unique
  typeset -g POWERLEVEL9K_SHORTEN_DELIMITER=
  typeset -g POWERLEVEL9K_DIR_SHORTENED_FOREGROUND=110
  typeset -g POWERLEVEL9K_DIR_ANCHOR_FOREGROUND=159
  typeset -g POWERLEVEL9K_DIR_ANCHOR_BOLD=true

  # Git
  typeset -g POWERLEVEL9K_VCS_CLEAN_BACKGROUND=2
  typeset -g POWERLEVEL9K_VCS_MODIFIED_BACKGROUND=3
  typeset -g POWERLEVEL9K_VCS_UNTRACKED_BACKGROUND=2
  typeset -g POWERLEVEL9K_VCS_CONFLICTED_BACKGROUND=1
  typeset -g POWERLEVEL9K_VCS_LOADING_BACKGROUND=8

  # Status
  typeset -g POWERLEVEL9K_STATUS_EXTENDED_STATES=true
  typeset -g POWERLEVEL9K_STATUS_OK=false
  typeset -g POWERLEVEL9K_STATUS_OK_PIPE=true
  typeset -g POWERLEVEL9K_STATUS_ERROR=true
  typeset -g POWERLEVEL9K_STATUS_ERROR_SIGNAL=true
  typeset -g POWERLEVEL9K_STATUS_ERROR_PIPE=true
  typeset -g POWERLEVEL9K_STATUS_ERROR_FOREGROUND=1
  typeset -g POWERLEVEL9K_STATUS_ERROR_BACKGROUND=0

  # Command execution time
  typeset -g POWERLEVEL9K_COMMAND_EXECUTION_TIME_FOREGROUND=0
  typeset -g POWERLEVEL9K_COMMAND_EXECUTION_TIME_BACKGROUND=3
  typeset -g POWERLEVEL9K_COMMAND_EXECUTION_TIME_THRESHOLD=3

  # Background jobs
  typeset -g POWERLEVEL9K_BACKGROUND_JOBS_FOREGROUND=6
  typeset -g POWERLEVEL9K_BACKGROUND_JOBS_BACKGROUND=0
  typeset -g POWERLEVEL9K_BACKGROUND_JOBS_VERBOSE=false

  # Time
  typeset -g POWERLEVEL9K_TIME_FOREGROUND=0
  typeset -g POWERLEVEL9K_TIME_BACKGROUND=7
  typeset -g POWERLEVEL9K_TIME_FORMAT='%D{%H:%M}'

  # Custom uv project indicator
  function prompt_uv_project() {
    [[ -f pyproject.toml ]] || return
    local name=$(grep -m1 '^name' pyproject.toml 2>/dev/null | cut -d'"' -f2)
    [[ -n $name ]] || name=$(basename $PWD)
    p10k segment -f 0 -b 4 -t " $name"
  }
  typeset -g POWERLEVEL9K_UV_PROJECT_FOREGROUND=0
  typeset -g POWERLEVEL9K_UV_PROJECT_BACKGROUND=4

  # Transient prompt
  typeset -g POWERLEVEL9K_TRANSIENT_PROMPT=always

  # Instant prompt
  typeset -g POWERLEVEL9K_INSTANT_PROMPT=quiet

  # Disable hot reload
  typeset -g POWERLEVEL9K_DISABLE_HOT_RELOAD=true

  (( ! $+functions[p10k] )) || p10k reload
}

typeset -g POWERLEVEL9K_CONFIG_FILE=${${(%):-%x}:a}

(( ${#p10k_config_opts} )) && setopt ${p10k_config_opts[@]}
'builtin' 'unset' 'p10k_config_opts'
