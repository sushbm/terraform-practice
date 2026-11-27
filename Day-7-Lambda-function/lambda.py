
import json
from datetime import datetime

def lambda_handler(event, context):

    print("Lambda function started!")

    name = event.get("name", "Sushmitha")

    return {
        "statusCode": 200,
        "body": json.dumps({
            "message": f"Hello {name}! Welcome to AWS Lambda.",
            "status": "SUCCESS",
            "date": datetime.now().isoformat()
        })
    }
