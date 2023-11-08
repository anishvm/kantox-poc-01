import boto3
import json
import logging
import os
from botocore.exceptions import ClientError

logger = logging.getLogger()
logger.setLevel(logging.INFO)
logger.addHandler(logging.StreamHandler())

def lambda_handler(event, context=None):
    try:
        manifest = json.loads(event['body'])
        client = boto3.client('dynamodb')
        try:
            for i in manifest:
                response = client.update_item(
                    TableName=os.environ['DynamoDB_Table_Name'],
                    Key={
                        "Id": {
                            'N': i,
                        }
                    },
                    UpdateExpression="set #fn=:n, planet=:p, power_level=:pl",
                    ExpressionAttributeValues={":n": {'S': manifest[i]['name']}, ":p": {'S': manifest[i]['planet']},
                                               ":pl": {'N': str(manifest[i]['power_level'])}},
                    ExpressionAttributeNames={
                        "#fn": "name"
                    }
                )
            logger.info("Updated Successfully")
            return {
                "statusCode": 200,
                "body": json.dumps('Updated Successfully')
            }
        except ClientError as e:
            logger.error(e)
    except ValueError as e:
        logger.error(e)
