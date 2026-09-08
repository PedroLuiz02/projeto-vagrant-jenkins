apt-get update

# Install Java
apt-get update
apt-get install -y openjdk-21-jdk
java -version

# Install Jenkins
apt-get update
apt-get install -y wget

# Adicionar chave de repositório Jenkins
wget -O /etc/apt/keyrings/jenkins-keyring.asc \
    https://pkg.jenkins.io/debian-stable/jenkins.io-2026.key

# Adicionar Jenkins repository
echo "deb [signed-by=/etc/apt/keyrings/jenkins-keyring.asc] https://pkg.jenkins.io/debian-stable binary/" \
    > /etc/apt/sources.list.d/jenkins.list

apt-get update
apt-get install -y jenkins

# Iniciar Jenkins
systemctl enable jenkins
systemctl start jenkins

echo "Jenkins instalado!"