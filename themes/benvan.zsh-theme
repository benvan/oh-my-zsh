# the idea of this theme is to contain a lot of info in a small string, by
# compressing some parts and colorcoding, which bring useful visual cues,
# while limiting the amount of colors and such to keep it easy on the eyes.
# When a command exited >0, the timestamp will be in red and the exit code
# will be on the right edge.
# The exit code visual cues will only display once.
# (i.e. they will be reset, even if you hit enter a few times on empty command prompts)

typeset -A host_repr

# translate hostnames into shortened, colorcoded strings
host_repr=('dieter-ws-a7n8x-arch' "%{$fg_bold[green]%}ws" 'dieter-p4sci-arch' "%{$fg_bold[blue]%}p4")

# local time, color coded by last return code
time_enabled="%(?.%{$fg[green]%}.%{$fg[red]%})%*%{$reset_color%}"
time_disabled="%{$fg[green]%}%*%{$reset_color%}"
time=$time_enabled

# user part, color coded by privileges
local user="%(!.%{$fg[blue]%}.%{$fg[blue]%})%n%{$reset_color%}"

# Hostname part.  compressed and colorcoded per host_repr array
# if not found, regular hostname in default color
local host="@${host_repr[$(hostname)]:-$(hostname)}%{$reset_color%}"

# Compacted $PWD
#local pwd="%{$fg[blue]%}%c%{$reset_color%}"
local pwd="[%{$fg[blue]%}%30<...<%~%<<%{$reset_color%}]"

PROMPT='${time} ${pwd} '

# git theming
ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg_bold[gray]%}(%{$fg_no_bold[yellow]%}%B"
ZSH_THEME_GIT_PROMPT_SUFFIX="%b%{$fg_bold[gray]%})%{$reset_color%} "
ZSH_THEME_GIT_PROMPT_CLEAN=""
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg_bold[red]%}✱"

# elaborate exitcode on the right when >0
return_code_enabled="%(?..%{$fg[red]%}%? ↵%{$reset_color%})"
return_code_disabled=
return_code=$return_code_enabled

RPS1='$(git_prompt_info)${return_code}'

function accept-line-or-clear-warning () {
	if [[ -z $BUFFER ]]; then
		time=$time_disabled
		return_code=$return_code_disabled
	else
		time=$time_enabled
		return_code=$return_code_enabled
	fi
	zle accept-line
}
zle -N accept-line-or-clear-warning
bindkey '^M' accept-line-or-clear-warning

#------------------
# mh theme

# LS colors, made with http://geoff.greer.fm/lscolors/
export LSCOLORS="Gxfxcxdxbxegedabagacad"
export LS_COLORS='no=00:fi=00:di=01;34:ln=00;36:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=41;33;01:ex=00;32:*.cmd=00;32:*.exe=01;32:*.com=01;32:*.bat=01;32:*.btm=01;32:*.dll=01;32:*.tar=00;31:*.tbz=00;31:*.tgz=00;31:*.rpm=00;31:*.deb=00;31:*.arj=00;31:*.taz=00;31:*.lzh=00;31:*.lzma=00;31:*.zip=00;31:*.zoo=00;31:*.z=00;31:*.Z=00;31:*.gz=00;31:*.bz2=00;31:*.tb2=00;31:*.tz2=00;31:*.tbz2=00;31:*.avi=01;35:*.bmp=01;35:*.fli=01;35:*.gif=01;35:*.jpg=01;35:*.jpeg=01;35:*.mng=01;35:*.mov=01;35:*.mpg=01;35:*.pcx=01;35:*.pbm=01;35:*.pgm=01;35:*.png=01;35:*.ppm=01;35:*.tga=01;35:*.tif=01;35:*.xbm=01;35:*.xpm=01;35:*.dl=01;35:*.gl=01;35:*.wmv=01;35:*.aiff=00;32:*.au=00;32:*.mid=00;32:*.mp3=00;32:*.ogg=00;32:*.voc=00;32:*.wav=00;32:'
