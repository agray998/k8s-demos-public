#!/bin/bash
sudo apt-get install -y bash-completion                # ensure bash completions are available
echo "source <(kubectl completion bash)" | tee -a ~/.bashrc  # enable bash completion for kubectl commands
echo "alias k=kubectl" | tee -a ~/.bashrc                    # set k as shorthand for kubectl
echo "complete -F __start_kubectl k" | tee -a ~/.bashrc      # enable completion to work with alias
echo "source <(helm completion bash)" | tee -a ~/.bashrc
source ~/.bashrc                                       # load new shell config
