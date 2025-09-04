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
                script {
                    sh '''
                    echo 'Build Docker Image'
                    docker build -t akiran0593/cicd-e2e-python:${BUILD_NUMBER} .
                    echo 'Build Complete'
                    '''
                    }
            }
                    
        }
        stage('Pushing Artifacts') {
            
            //environment {
                //DOCKER_IMAGE = "akiran0593/ultimate-cicd:${BUILD_NUMBER}"
                //REGISTRY_CREDENTIALS = credentials('docker-cred')
                //}
            steps {
                withCredentials([usernamePassword(credentialsId: 'docker-cred', usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASS')]) {
                    script {
                        sh '''
                        echo "$DOCKER_PASS" | docker login -u "$DOCKER_USER" --password-stdin
                        echo 'Push to Docker Hub'
                        docker push akiran0593/cicd-e2e-python:${BUILD_NUMBER}
                        echo 'Push Complete'
                        '''
                }
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
            environment {
            GIT_REPO_NAME = "completeCICD-Python"
            GIT_USER_NAME = "abheelasha"
        }


            steps {
                
                script{
                    withCredentials([string(credentialsId: 'github', variable: 'GITHUB_TOKEN')]) {
                    //withCredentials([usernamePassword(credentialsId: 'f87a34a8-0e09-45e7-b9cf-6dc68feac670', passwordVariable: 'GIT_PASSWORD', usernameVariable: 'GIT_USERNAME')]) {
                        sh '''
                        pwd
                        git config --global --add safe.directory "*"
                        git config user.email "kiran.abheelasha@gmail.com"
                        git config user.name "abheelasha"
                        cat deploy/deploy.yaml
                        sed -i "s/v1/${BUILD_NUMBER}/g" deploy/deploy.yaml
                        cat deploy/deploy.yaml
                        git add deploy/deploy.yaml
                        git commit -m 'Updated the deploy yaml | Jenkins Pipeline'
                        git remote -v
                        git push https://${GITHUB_TOKEN}@github.com/${GIT_USER_NAME}/${GIT_REPO_NAME} HEAD:main
                        '''                        
                    }
                }
            }
        }
    }


    
}