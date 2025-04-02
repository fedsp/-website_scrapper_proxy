@echo off
REM Define variables for easy configuration
set AWS_REGION=[[[MY AWS REGION]]]
set AWS_ACCOUNT_ID=[[[MY AWS ACCOUNT ID]]]
set ECR_REPO=fedsp/selenium
set IMAGE_TAG=1.0
set FUNCTION_NAME=selenium

REM Authenticate with Amazon ECR
aws ecr get-login-password --region %AWS_REGION% | docker login --username AWS --password-stdin %AWS_ACCOUNT_ID%.dkr.ecr.%AWS_REGION%.amazonaws.com

REM Build and push the Docker image
docker buildx build --platform linux/amd64 --provenance false --tag %AWS_ACCOUNT_ID%.dkr.ecr.%AWS_REGION%.amazonaws.com/%ECR_REPO%:%IMAGE_TAG% --push .

REM Update the AWS Lambda function with the new image
aws lambda update-function-code --function-name %FUNCTION_NAME% --image-uri %AWS_ACCOUNT_ID%.dkr.ecr.%AWS_REGION%.amazonaws.com/%ECR_REPO%:%IMAGE_TAG%
