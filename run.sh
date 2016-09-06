#!/bin/sh

cli="appcfg.sh"

main() {

	if [ -z "$WERCKER_GAE_JAVA_DEPLOY_PROJECT" ]; then
		fail "gae-java-deploy: project argument cannot be empty"
	fi

	if [ -z "$WERCKER_GAE_JAVA_DEPLOY_MODULE" ]; then
		fail "gae-java-deploy: module argument cannot be empty"
	fi

	if [ -z "$WERCKER_GAE_JAVA_DEPLOY_VERSION" ]; then
		fail "gae-java-deploy: version argument cannot be empty"
	fi

	if [ -z "$WERCKER_GAE_JAVA_DEPLOY_JSONKEYFILE" ]; then
		fail "gae-java-deploy: jsonKeyfile argument cannot be empty"
	fi

	if [ -z "$WERCKER_GAE_JAVA_DEPLOY_BUILDTARGETFOLDER" ]; then
		fail "gae-java-deploy: buildTargetFolder argument cannot be empty"
	fi

	# Command
	cmd="update"
	cmd_promote="set_default_version"

	# Command arguments
	args=

	# project
	if [ -n "$WERCKER_GAE_JAVA_DEPLOY_PROJECT" ]; then
		args="$args -A \"$WERCKER_GAE_JAVA_DEPLOY_PROJECT\""
	fi

	# module
	if [ -n "$WERCKER_GAE_JAVA_DEPLOY_MODULE" ]; then
		args="$args -M \"$WERCKER_GAE_JAVA_DEPLOY_MODULE\""
	fi

    WERCKER_GAE_JAVA_DEPLOY_VERSION_FIXED="${WERCKER_GAE_JAVA_DEPLOY_VERSION//./-}"

	# version
	if [ -n "$WERCKER_GAE_JAVA_DEPLOY_VERSION_FIXED" ]; then
		args="$args -V \"$WERCKER_GAE_JAVA_DEPLOY_VERSION_FIXED\""
	fi

	# jsonKeyfile
	if [ -n "$WERCKER_GAE_JAVA_DEPLOY_JSONKEYFILE" ]; then
		args="$args --service_account_json_key_file=\"$WERCKER_STEP_ROOT/service-account.json\""
	fi

	if [ -n "$WERCKER_GAE_JAVA_DEPLOY_JSONKEYFILE" ]; then
        cat > $WERCKER_STEP_ROOT/service-account.json << EOF
$WERCKER_GAE_JAVA_DEPLOY_JSONKEYFILE
EOF
	fi

	# find the build folder
	WERCKER_GAE_JAVA_DEPLOY_TARGET_XML_FILE=`find $WERCKER_GAE_JAVA_DEPLOY_BUILDTARGETFOLDER -name 'appengine-web.xml'`
	WERCKER_GAE_JAVA_DEPLOY_TARGET=${WERCKER_GAE_JAVA_DEPLOY_TARGET_XML_FILE%/WEB-INF/appengine-web.xml}


	# run the command
    if [ "$WERCKER_GAE_JAVA_DEPLOY_DEBUG" = "TRUE" ]; then
		echo "$cli" "$args" "$cmd" $WERCKER_GAE_JAVA_DEPLOY_TARGET
	fi

	eval "$cli" "$args" "$cmd" $WERCKER_GAE_JAVA_DEPLOY_TARGET

	# promote the version
    if [ "$WERCKER_GAE_JAVA_DEPLOY_AUTOPROMOTEVERSION" = "TRUE" ]; then
	    if [ "$WERCKER_GAE_JAVA_DEPLOY_DEBUG" = "TRUE" ]; then
			echo "$cli" "$args" "$cmd_promote" $WERCKER_GAE_JAVA_DEPLOY_TARGET
		fi
		eval "$cli" "$args" "$cmd_promote" $WERCKER_GAE_JAVA_DEPLOY_TARGET
    fi


        #echo Downloading App Engine Java SDK
        #export APPENGINE_SDK=appengine-java-sdk-1.9.42
        #curl -o $WERCKER_STEP_ROOT/$APPENGINE_SDK.zip https://storage.googleapis.com/appengine-sdks/featured/$APPENGINE_SDK.zip
        #echo Unzipping App Engine Java SDK
        #apt-get -y install unzip
        #mkdir $WERCKER_STEP_ROOT/appengine-sdk
        #unzip -q -d $WERCKER_STEP_ROOT/appengine-sdk/ $WERCKER_STEP_ROOT/$APPENGINE_SDK.zip
        #export PATH=$PATH:$WERCKER_STEP_ROOT/appengine-sdk/$APPENGINE_SDK/bin

}

main;
