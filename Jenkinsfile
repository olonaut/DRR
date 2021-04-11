pipeline {
    agent any
    stages {
        stage('Build') {
            steps {
                sh '''
                mkdir -p bin
                BUILDNO=$(git rev-list --count ${GIT_COMMIT})
                ln -sfn ~/Godot_v3.2.3-stable_linux_headless.64 .
                find . -type f -print0 | xargs -0 sed -i "s/##jenkins-buildno##/$BUILDNO/g"
                find . -type f -print0 | xargs -0 sed -i "s/##jenkins-builddate##/$(date --iso-8601=minutes)/g"
                /opt/godot/godot.headless --path DRR --export "Linux/X11" bin/${BRANCH_NAME}-${BUILDNO}-linux.bin
                /opt/godot/godot.headless --path DRR --export "Windows Desktop" bin/${BRANCH_NAME}-${BUILDNO}-win64.exe
                cd bin
                zip ${JOB_NAME}${BRANCH_NAME}-${BUILDNO}-win64.zip ${BRANCH_NAME}-${BUILDNO}-win64.exe ${BRANCH_NAME}-${BUILDNO}-win64.pck
                zip ${JOB_NAME}${BRANCH_NAME}-${BUILDNO}-linux.zip ${BRANCH_NAME}-${BUILDNO}-linux.bin
                rm ${JOB_NAME}${BRANCH_NAME}-${BUILDNO}-win64.exe ${BRANCH_NAME}-${BUILDNO}-win64.pck
                rm ${JOB_NAME}${BRANCH_NAME}-${BUILDNO}-linux.bin
                '''
            }
        }
    }
}