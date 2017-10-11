#!/bin/bash

# "set -e" makes it so if any step fails, the script aborts:
set -e

cd "${BASH_SOURCE%/*}"
source config.sh

echo "Installing gulp packages"
npm i

echo "Building Lambda Versioner"
cd src/codepipeline-lambda-versioner
../../node_modules/.bin/gulp build
cd ../..

echo "Building Lambda Aliaser"
cd src/codepipeline-lambda-aliaser
../../node_modules/.bin/gulp build
cd ../..

echo "Packaging CloudFormation template"
aws cloudformation package --template-file sam-template.json --output-template-file sam-output.yml --s3-bucket "$S3Bucket" --s3-prefix "$S3Prefix"

echo "Deploying CloudFormation stack $StackName"
aws cloudformation deploy --template-file sam-output.yml --stack-name "$StackName" --capabilities CAPABILITY_IAM --parameter-overrides CodePipelineS3Bucket="$CodePipelineS3Bucket"

echo "Removing SAM output template file"
rm -f sam-output.yml

echo "Done"

