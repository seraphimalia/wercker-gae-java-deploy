# gae-java-deploy

This step vendors the Google App Engine (GAE) Java SDK, and allows the user to execute the
update command. Options are passed along to the `appcfg.sh` script as is.

# Options:

* `project` - Google App Engine project name, as defined on the [Google Cloud console](https://console.cloud.google.com/), for example `major-mandolin`.
* `module` - Google App Engine module. If your project does not have module, specify "default" for this option.
* `version` - (Optional if `versionFilePath` is specified) Google App Engine version to deploy to.
* `versionFilePath` - (Optional if `version` is specified) Relative path to a file in `buildTargetFolder` that contains the version to deploy.  If specified it will overwrite the above Version parameter.  Example of file contents: $WERCKER_GAE_JAVA_DEPLOY_VERSION=1.0.0 
* `jsonKeyfile` - Service Account JSON Key file to be used for publishing.  This Service account will need the "Project Editor" permission in order to deploy new versions in GAE.  The service account can be created on the [Service Account Admin page in the Google Cloud Console](https://console.cloud.google.com/iam-admin/serviceaccounts/project) (NB! - Make sure you have the correct project selected before creating the service account and downloading the JSON key file.)  (NBx2! - The JSON Key file is downloaded with Line Breaks.  Remove all Line breaks before pasting the contents of the file into this Option.
* `buildTargetFolder` - (Optional - Default "target/") The build folder relative to the project being built.  e.g: target/  - This folder will be traversed to find the deploy folder that contains the WEB-INF folder (containing the appengine-web.xml).
* `autoPromoteVersion` - (Optional - Default "FALSE")  This can be either "TRUE" or "FALSE".  Set it to "TRUE" if you want this step to automatically set the new default version in GAE to the one that has just been deployed.

# Example

```
deploy:
    steps:
      - gae-java-deploy:
          project: $GAE_PROJECT
          module: $GAE_MODULE
          version: $GAE_VERSION
          jsonKeyfile: $APPENGINE_JSON_KEYFILE
          buildTargetFolder: $BUILD_TARGET_FOLDER
          
```

# License

The MIT License (MIT)

# Changelog

## 1.0.0

- Initial release
