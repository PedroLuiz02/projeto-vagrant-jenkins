# Gerar a chave na VM2
set -e

SSH_DIR="/home/vagrant/.ssh"
KEY_FILE="$SSH_DIR/id_ed25519"

mkdir -p "$SSH_DIR"
chmod 700 "$SSH_DIR"

if [ ! -f "$KEY_FILE" ]; then
  sudo -u vagrant ssh-keygen -t ed25519 -N "" -f "$KEY_FILE" -C "vagrant@vm2"
fi

chown -R vagrant:vagrant "$SSH_DIR"