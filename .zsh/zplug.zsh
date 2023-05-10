# 補完、syntax highlight 履歴系
zplug "zsh-users/zsh-completions"
zplug "zsh-users/zsh-autosuggestions"
: ${ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=015'}
zplug "zsh-users/zsh-syntax-highlighting", defer:2
zplug "zsh-users/zsh-history-substring-search", defer:2, \
    hook-load: """
	bindkey '^[[A' history-substring-search-up;
	bindkey '^[[B' history-substring-search-down
	"""

# SSH ログインしているときでも矢印キーを動作させるための workaround
if [ -n "$SSH_CONNECTION" ]; then
    bindkey '\eOA' history-substring-search-up
    bindkey '\eOB' history-substring-search-down
fi

# enhance cd
zplug "b4b4r07/enhancd", use:init.sh

# gitでの^エスケープ
zplug "kamuiroeru/zsh-git-escape-magic"

# # Emoji
# zplug "stedolan/jq", \
#     from:gh-r, \
#     as:command, \
#     rename-to:jq
# zplug "b4b4r07/emoji-cli", \
#     on:"stedolan/jq"
#
#
zplug "chrissicool/zsh-256color"
#
# zplug "mollifier/cd-gitroot"
# alias cdu='cd-gitroot'
