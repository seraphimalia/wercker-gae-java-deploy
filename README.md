# gae-java-deploy

This step vendors the Google App Engine (GAE) Java SDK, and allows the user to execute the
update command. Options are passed along to the `appcfg.sh` script as is.

# Options:

* `project` - Google App Engine project name, as defined on the [Google Cloud console](https://console.cloud.google.com/), for example `major-mandolin`.
* `module` - Google App Engine module. If your project does not have module, specify "default" for this option.
* `version` - Google App Engine version.  This can be omitted if your project is built with a versions.txt containing something like `GAE_VERSION=1.0.0` in the build target folder.  If your version contains "." it will ve changed to "-" (e.g. 1-0-0) because Google Versions do not support "."
* `jsonKeyfile` - Service Account JSON Key file to be used for publishing.  This Service account will need the "Project Editor" permission in order to deploy new versions in GAE.  The service account can be created on the [Service Account Admin page in the Google Cloud Console](https://console.cloud.google.com/iam-admin/serviceaccounts/project) (NB! - Make sure you have the correct project selected before creating the service account and downloading the JSON key file.)  (NBx2! - The JSON Key file is downloaded with Line Breaks.  Remove all Line breaks before pasting the contents of the file into this Option.
* `buildTargetFolder` - The build folder relative to the project being built.  e.g: target/major-mandolin-1.0.0/

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
