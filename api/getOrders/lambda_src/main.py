import boto3
import json
from boto3.dynamodb.conditions import Key

def lambda_handler(event,context):
    
    dynamodb = boto3.resource('dynamodb')
    table = dynamodb.Table('')  
    user=  event['requestContext']['authorizer']['claims']['email']
    
    resp= table.scan(
        FilterExpression='#user= :user',
        ExpressionAttributeNames={
            "#user":"user"
       },
        ExpressionAttributeValues={
             ":user": user,
        }
        )['Items']       

    posts = []

    for item in resp:
        posts.append(item)
    
    response={
        'headers': {
         "Access-Control-Allow-Origin": "*"
         },
        "statusCode": 200,
        "body": json.dumps(posts)
    } 
    return response