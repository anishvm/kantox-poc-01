import boto3
import json
import logging
from botocore.exceptions import ClientError

def lambda_handler(event, context=None):
    try:
        manifest = json.loads(event['body'])
        client = boto3.client('dynamodb')
        try:
            for i in manifest:
                response = client.update_item(
                    TableName='kantox-poc-db',
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
            logging.info("Updated Successfully")
        except ClientError as e:
            logging.error(e)
    except ValueError as e:
        logging.error(e)





