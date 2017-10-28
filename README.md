# lard

A collection of resources in support of AWS serverless continuous delivery.

*More information to come...*

## Pre-Installation

* Node preparation
  1. [Install nvm](https://github.com/creationix/nvm)
  2. With `nvm ls`, verify that you are using node >= 6.10.3
  3. With `npm --version`, verify that you are using npm >= 5.4.2

* AWS preparation
  1. [Install AWS CLI](http://docs.aws.amazon.com/cli/latest/userguide/installing.html)
  2. [Configure AWS CLI credentials](http://docs.aws.amazon.com/cli/latest/userguide/cli-chap-getting-started.html)
  3. Create or locate an S3 bucket for storing CloudFormation package artifacts

## Installation

1. Clone the Lard repository and enter its directory:

    `git clone https://github.com/lafiosca/lard.git && cd lard`

2. Copy `config.sh.example` to `config.sh` and modify it to suit your needs:

    `S3Bucket`: an existing readable/writable S3 bucket for CloudFormation package artifact storage (no default; must be set)

    `S3Prefix`: the path prefix to use for the package artifacts stored within `S3Bucket` (default: "cloudformation/lard")

    `StackName`: the name the Lard CloudFormation stack will be created with (default: "Lard")

    `CodePipelineS3Bucket`: an existing readable/writable S3 bucket for CodePipeline artifact storage for use in Lard-based projects; if blank, automatically create a new bucket (default: value of `S3Bucket`)

    `CodePipelineServiceRoleArn`: an existing CodePipeline service role for use in Lard-based projects; if blank, automatically create a new role (default: blank)

    You will need to set `S3Bucket`. The other values may be left as their defaults unless you have a reason to change them.

3. Run `./deploy.sh` to install gulp locally, build the packages, and deploy the Lard CloudFormation stack.

