
import boto3
import os


def lambda_handler(event, context):
    
    # Get the bucket name from an environment variable
    bucket_name = os.environ['BUCKET_NAME']

    # Initialize S3 client
    s3_client = boto3.client('s3')

    try:
        # Get s3 object
        object = s3_client.get_object(Bucket=bucket_name, Key=event['Key'])
        body = object['Body']
        csv_string = body.read().decode('utf-8')
        
        # Print Object content
        print(csv_string)

        # This is a demo file. Enter your code here

    except Exception as err:
        print(err)

    return {
        'status_code': 200 ,
        'reason': 'OK',
        'text': 'Object was successfully processed!'
    }
