pipeline {
    agent any
    stages {
        stage('Build') {
            steps {
                sh '''
                mkdir -p bin
                rm -rf bin/*
                BUILDNO=$(git rev-list --count ${GIT_COMMIT})
                find . -type f -print0 | xargs -0 sed -i "s/##ci-buildno##/$BUILDNO/g"
                find . -type f -print0 | xargs -0 sed -i "s/##ci-builddate##/$(date --iso-8601=minutes)/g"
                /opt/godot/godot.headless --headless --path . --export-debug "Linux/X11" bin/DRR-${BRANCH_NAME}-${BUILDNO}-linux.bin
                /opt/godot/godot.headless --headless --path . --export-debug "Windows Desktop" bin/DRR-${BRANCH_NAME}-${BUILDNO}-win64.exe
                '''
            }
        }
        stage('Archive') {
            steps {
                sh '''
                BUILDNO=$(git rev-list --count ${GIT_COMMIT})
                cd bin  
                zip DRR-${BRANCH_NAME}-${BUILDNO}-win64.zip DRR-${BRANCH_NAME}-${BUILDNO}-win64.exe DRR-${BRANCH_NAME}-${BUILDNO}-win64.pck
                zip DRR-${BRANCH_NAME}-${BUILDNO}-linux.zip DRR-${BRANCH_NAME}-${BUILDNO}-linux.bin DRR-${BRANCH_NAME}-${BUILDNO}-linux.pck
                rm DRR-${BRANCH_NAME}-${BUILDNO}-win64.exe DRR-${BRANCH_NAME}-${BUILDNO}-win64.pck
                rm DRR-${BRANCH_NAME}-${BUILDNO}-linux.bin
                '''
                archiveArtifacts artifacts: 'bin/*.zip', fingerprint: true
            }
        }
    }
}
