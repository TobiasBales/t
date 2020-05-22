unbind r
bind r source-file ~/.tmux.conf

bind-key C-a send-prefix

set-option -g mouse on
set-option -g allow-rename off

set-option -g visual-activity off
set-option -g visual-bell off
set-option -g visual-silence off
set-window-option -g monitor-activity off
set-option -g bell-action none

set-option -g renumber-windows on

set-option -ga terminal-overrides ',*256col*:Tc'
