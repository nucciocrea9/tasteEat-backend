import json
import boto3

client = boto3.client('dynamodb')

def lambda_handler(event, context):
    # Set the default error response
    

    scan_result = client.scan(TableName='')['Items']

    posts = []

    for item in scan_result:
        posts.append(item)

    response = {
        'headers': {
          
         "Access-Control-Allow-Origin": "*"
    },
        "statusCode": 200,
        "body": json.dumps(posts)
    }

    return response