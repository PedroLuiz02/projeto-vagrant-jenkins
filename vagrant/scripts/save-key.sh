# Na VM2, guarda a chave pública na pasta compartilhada
set -e

SRC="/home/vagrant/.ssh/id_ed25519.pub"
DEST="/vagrant/.shared/vm2_key.pub"

mkdir -p /vagrant/.shared
cp "$SRC" "$DEST"