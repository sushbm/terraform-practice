
import json
from datetime import datetime, timezone

def handler(event, context):

    print("EventBridge triggered Lambda successfully!")

    print("Received event:", json.dumps(event))

    response = {
        "message": "Lambda executed successfully",
        "trigger": "EventBridge",
        "time": datetime.now(timezone.utc).isoformat()
    }

    print(json.dumps(response))

    return response
