if [[ -z "$(ps aux | grep yubikey-agent | grep -v grep)" ]]; then
  yubikey-agent -l /opt/t/tmp/yubikey-agent.sock > /opt/t/tmp/yubikey-agent.log 2>&1 &
fi
