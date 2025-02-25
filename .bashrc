#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'
PS1='[\u@\h \W]\$ '

#checkGPUTemperature
alias gputemp='watch -n 1 sensors'

#neovim
alias nvim='sudo -E nvim'

#screenshot
#alias sc='grim -g "$(slurp)" screenshot.png'

#fastfetch
fastfetch
