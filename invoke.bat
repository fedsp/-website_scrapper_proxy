@echo off
aws lambda invoke ^
    --function-name selenium ^
    --payload "{}" ^
    --cli-binary-format raw-in-base64-out ^
    response.json

echo Lambda results:
type response.json
pause