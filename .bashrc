#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'
PS1='[\u@\h \W]\$ '
alias scripts="cd ~/.config/hypr/scripts"
alias hypr="cd ~/.config/hypr"
alias hyprland.conf="nano -l ~/.config/hypr/hyprland.conf"
