#!/bin/sh
tmux new-session -d -s main

tmux new-window -t main:1 'bash'
tmux send-keys -t main:1 'cd ~/git/jupyter/agent; docker compose up'
tmux new-window -t main:2 'bash'
tmux send-keys -t main:2 'cd ~/git/; nvim'
tmux new-window -t main:3 'bash'
tmux send-keys -t main:3 'cd ~/git/'

tmux select-window -t main:1
tmux -2 attach-session -t main
