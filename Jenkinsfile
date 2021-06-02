pipeline {
    agent any
    stages {
        stage('Build') {
            steps {
                sh '''
                mkdir -p bin
                rm -rf bin/*
                BUILDNO=$(git rev-list --count ${GIT_COMMIT})
                find . -type f -print0 | xargs -0 sed -i "s/##jenkins-buildno##/$BUILDNO/g"
                find . -type f -print0 | xargs -0 sed -i "s/##jenkins-builddate##/$(date --iso-8601=minutes)/g"
                /opt/godot/godot.headless --path DRR --export "Linux/X11" bin/drr-${BRANCH_NAME}-${BUILDNO}-linux.bin
                /opt/godot/godot.headless --path DRR --export "Windows Desktop" bin/drr-${BRANCH_NAME}-${BUILDNO}-win64.exe
                '''
            }
        }
        stage('Archive') {
            steps {
                sh '''
                BUILDNO=$(git rev-list --count ${GIT_COMMIT})
                cd bin  
                zip drr-${BRANCH_NAME}-${BUILDNO}-win64.zip drr-${BRANCH_NAME}-${BUILDNO}-win64.exe drr-${BRANCH_NAME}-${BUILDNO}-win64.pck
                zip drr-${BRANCH_NAME}-${BUILDNO}-linux.zip drr-${BRANCH_NAME}-${BUILDNO}-linux.bin
                rm drr-${BRANCH_NAME}-${BUILDNO}-win64.exe drr-${BRANCH_NAME}-${BUILDNO}-win64.pck
                rm drr-${BRANCH_NAME}-${BUILDNO}-linux.bin
                '''
                archiveArtifacts artifacts: 'bin/*.zip', fingerprint: true
            }
        }
    }
}