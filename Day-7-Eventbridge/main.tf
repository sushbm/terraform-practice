
# IAM Role for Lambda
resource "aws_iam_role" "lambda_exec" {
  name = "lambda_exec_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "lambda.amazonaws.com"
        }
      }
    ]
  })
}

# Attach CloudWatch Logs permission to Lambda
resource "aws_iam_role_policy_attachment" "lambda_exec_policy" {
  role       = aws_iam_role.lambda_exec.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

# Create Lambda Function
resource "aws_lambda_function" "name" {
  function_name = "my_lambda_function"
  role          = aws_iam_role.lambda_exec.arn

  handler = "index.handler"
  runtime = "python3.12"

  filename         = "index.zip"
  source_code_hash = filebase64sha256("index.zip")

  depends_on = [
    aws_iam_role_policy_attachment.lambda_exec_policy
  ]
}

# Create EventBridge Rule
resource "aws_cloudwatch_event_rule" "name" {
  name                = "my_event_rule"
  description         = "Trigger Lambda every 5 minutes"
  schedule_expression = "rate(5 minutes)"
}

# Connect EventBridge to Lambda
resource "aws_cloudwatch_event_target" "name" {
  rule      = aws_cloudwatch_event_rule.name.name
  target_id = "my_lambda_target"
  arn       = aws_lambda_function.name.arn
}

# Allow EventBridge to invoke Lambda
resource "aws_lambda_permission" "name" {
  statement_id  = "AllowExecutionFromEventBridge"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.name.function_name
  principal     = "events.amazonaws.com"
  source_arn    = aws_cloudwatch_event_rule.name.arn
}
