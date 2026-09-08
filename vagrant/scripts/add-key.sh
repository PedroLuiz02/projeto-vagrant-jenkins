# Na VM1, adiciona a chave da VM2 nas authorized_keys
set -e

PUBKEY_FILE="/vagrant/.shared/vm2_key.pub"
SSH_DIR="/home/vagrant/.ssh"

# Espera 30s pela chave
for i in $(seq 1 30); do
  if [ -f "$PUBKEY_FILE" ]; then
    break
  fi
  echo "Aguardando chave pública da vm2... ($i/30)"
  sleep 1
done

mkdir -p "$SSH_DIR"
chmod 700 "$SSH_DIR"

if [ -f "$PUBKEY_FILE" ]; then
  touch "$SSH_DIR/authorized_keys"

# Evitar duplicar se rodar o provision mais de uma vez
  if ! grep -qF "$(cat $PUBKEY_FILE)" "$SSH_DIR/authorized_keys"; then
    cat "$PUBKEY_FILE" >> "$SSH_DIR/authorized_keys"
  fi
  chmod 600 "$SSH_DIR/authorized_keys"
  chown -R vagrant:vagrant "$SSH_DIR"
else
  echo "Chave pública da vm2 ainda não encontrada em $PUBKEY_FILE"
  exit 1
fi