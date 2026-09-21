pipeline {
    agent any

    stages {
        stage('Install') {
            steps {
                echo "Instalando dependencias..."
                sh 'cd app && npm install'
            }
        }

        stage('Build') {
            steps {
                echo "Construindo aplicacao..."
                sh 'cd app && npm run build --if-present'
            }
        }

        stage('Test') {
            steps {
                echo "Rodando testes..."
                sh 'cd app && npm test'
            }
        }

                stage('Deploy') {
            steps {
                echo "Enviando aplicacao para a VM prod..."
                sshagent(['app']) {
                    sh '''
                        tar --exclude=node_modules -czf app.tar.gz -C app .
                        ssh vagrant@192.168.56.20 "mkdir -p ~/app-prod && rm -rf ~/app-prod/*"
                        scp app.tar.gz vagrant@192.168.56.20:/tmp/app.tar.gz
                        ssh vagrant@192.168.56.20 "tar -xzf /tmp/app.tar.gz -C ~/app-prod && cd ~/app-prod && npm ci --omit=dev"
                        ssh vagrant@192.168.56.20 "pkill -f '[n]ode server.js' || true"
                        ssh vagrant@192.168.56.20 "cd ~/app-prod && nohup npm start > app.log 2>&1 < /dev/null &"
                        sleep 5
                        curl -f http://192.168.56.20:3000
                    '''
                }
            }
        }
    }
    post{
        success{
            echo "Pipeline executada com sucesso!"
        }
        
        failure{
            echo "Pipeline falhou."
        }
    }
}