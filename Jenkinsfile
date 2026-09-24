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
                sh 'cd app && npm run build'
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
                echo 'Mandando aplicação para VM app...'

                sshagent(['app']) {
                    sh "ssh vagrant@192.168.56.10 host"
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