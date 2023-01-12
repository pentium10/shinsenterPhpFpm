# This repo is to diagnose problems raised in 

https://github.com/shinsenter/php/issues/19

# Cloud Run Button

If you have a public repository, you can add this button to your `README.md` and
let anyone deploy your application to [Google Cloud Run][run] with a single
click.

[run]: https://cloud.google.com/run

Try it out with a "hello, world" Go application ([source](https://github.com/pentium10/shinsenterPhpFpm)):

[![Run on Google
Cloud](https://deploy.cloud.run/button.svg)](https://deploy.cloud.run/?git_repo=https://github.com/pentium10/shinsenterPhpFpm.git)

### Demo

1. Using the button

2. If the repo contains a `Dockerfile`, it will be built using the `docker build` command.  

### Customizing deployment parameters

If you edit `cloudbuild.yaml` at the root of your repository, it allows you
customize the experience such as defining an alternative service name, or
prompting for additional environment variables.

To submit manually you need to execute

    ```text
    gcloud submit builds 
    ```

For example, a fully populated `cloudbuild.yaml` file looks like this:

```yaml
substitutions:
  _IMAGE_NAME: "gcr.io/${PROJECT_ID}/shinsenterPhpFpm"
  _SERVICE_NAME: "shinsenterPhpFpm"
options:
  dynamic_substitutions: true
steps:
# Build the container image
- name: 'gcr.io/cloud-builders/docker'
  args: ['build', '-t', "${_IMAGE_NAME}", '.']
# Push the image to Container Registry
- name: 'gcr.io/cloud-builders/docker'
  args: ['push', "${_IMAGE_NAME}"]
# Deploy image to Cloud Run
- name: 'gcr.io/cloud-builders/gcloud-slim'
  args: ['run', 'deploy', "${_SERVICE_NAME}", '--image', "${_IMAGE_NAME}", 
  '--region', 'us-central1', 
  '--platform', 'managed', '--allow-unauthenticated',
  '--max-instances','20','--concurrency','40',
  '--memory','256M'
  ]
timeout: 1800s
```

### Notes

- Disclaimer: This is not an officially supported Google product.