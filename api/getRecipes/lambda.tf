resource "aws_iam_role" "iam_for_lambda" {
  name = "iam_for_lambda"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

data "archive_file" "python_lambda_package" {
  type = "zip"
  source_file = "${path.module}/lambda_src/main.py"
  output_path = "nametest.zip"
}

resource "aws_lambda_function" "function" {
  //source  = "terraform-aws-module/lambda/aws"
 // version = "2.22.0"

  function_name = "getRecipes"
  //filename      = "${path.module}/lambda_src/main.py"
  filename      = "nametest.zip"
  source_code_hash = data.archive_file.python_lambda_package.output_base64sha256
  handler       = "main.lambda_handler"
  runtime       = "python3.8"
  architectures = ["x86_64"]
  publish       = true
  role          = aws_iam_role.iam_for_lambda.arn
  timeout = 30
   environment {
    variables = {
      table = var.db_table
    }
  }
  //source_path = "${path.module}/lambda_src"

 // store_on_s3 = false
}
resource "aws_iam_policy" "lambda_dyndb_update_item_userpool_get_user" {
  name        = "lambda_dyndb_update_item_userpool_get_user"
  policy = jsonencode(
    {
      Version = "2012-10-17"
      Statement = [
        {
          Action   = ["dynamodb:*"]
          Effect   = "Allow"
          Resource = "*"
        },
      ]
    }
  )
}

resource "aws_iam_role_policy_attachment" "lambda_dyndb_update_item_userpool_get_user" {
  role       = aws_iam_role.iam_for_lambda.name
  policy_arn = aws_iam_policy.lambda_dyndb_update_item_userpool_get_user.arn
}

resource "aws_lambda_permission" "api_invoke_lambda" {
  statement_id  = "AllowApiGatewayInvokeLambda"
  action        = "lambda:InvokeFunction"
  function_name =  aws_lambda_function.function.arn
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${var.rest_api_execution_arn}/*/${var.share_doc_http_method}${var.parent_resource_path}"
}
