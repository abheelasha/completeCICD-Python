pipeline {
    /* insert Declarative Pipeline here */
    agent any
    environment {
        IMAGE_TAG = '${BUILD_NUMBER}'
    }
    
    stages {
        stage('Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/abheelasha/completeCICD-Python'
                echo 'checking out git repos'
            }
        }

        stage('Build Docker') {
            steps {
                scripts {
                    sh '''
                    echo 'Build Docker Image'
                    docker build -t akiran0593/cicd-e2e-python:${BUILD_NUMBER} .
                    echo 'Build Complete'
                    }
                
            }
        }
        stage('Pushing Artifacts') {
            steps {
                scripts {
                    sh '''
                    echo 'Push to Docker Hub'
                    docker push -t akiran0593/cicd-e2e-python:${BUILD_NUMBER}
                    echo 'Push Complete'
                }
            }
        }
        stage('Checkout K8s manifest to SCM') {
            steps {
                git branch: 'main', url: 'https://github.com/abheelasha/completeCICD-Python'
                echo 'checking out to manifest git repos'
            }
        }

        stage('Update K8S manifest & push to Repo'){
            steps {
                script{
                    withCredentials([usernamePassword(credentialsId: 'f87a34a8-0e09-45e7-b9cf-6dc68feac670', passwordVariable: 'GIT_PASSWORD', usernameVariable: 'GIT_USERNAME')]) {
                        sh '''
                        cat deploy.yaml
                        sed -i '' "s/32/${BUILD_NUMBER}/g" deploy.yaml
                        cat deploy.yaml
                        git add deploy.yaml
                        git commit -m 'Updated the deploy yaml | Jenkins Pipeline'
                        git remote -v
                        git push https://github.com/abheelasha/completeCICD-Python.git HEAD:main
                        '''                        
                    }
                }
            }
        }
    }


    
}