
provider "aws" {
  alias  = "us-east-1"
  region = "us-east-1"
}

provider "aws" {
  alias  = "us-west-1"
  region = "us-west-1"
}
resource "aws_dynamodb_table" "us-east-1" {
  provider = aws.us-east-1

  name           = "recipes"
  hash_key       = "recipe_id"
  range_key      = "recipe_name"
  read_capacity  = 20
  write_capacity = 20
  billing_mode   = "PROVISIONED"
  attribute {
    name = "recipe_id"
    type = "N"
  }
  attribute {
    name = "recipe_name"
    type = "S"
  }
}

resource "aws_dynamodb_table" "us-west-1" {
  provider = aws.us-west-1

  name           = "recipes"
  hash_key       = "recipe_id"
  range_key      = "recipe_name"
  billing_mode   = "PROVISIONED"
  read_capacity  = 20
  write_capacity = 20
  attribute {
    name = "recipe_id"
    type = "N"
  }
  attribute {
    name = "recipe_name"
    type = "S"
  }

}

output "table" {
  value = tomap({
    arn  = "${aws_dynamodb_table.us-east-1.arn}",
    name = "${aws_dynamodb_table.us-east-1.id}",
  })
}
/*
provider "aws" {
  alias  = "us-east-1"
  region = "us-east-1"
}

provider "aws" {
  alias  = "us-west-1"
  region = "us-west-1"
}

resource "aws_dynamodb_table" "us-east-1" {
  provider = aws.us-east-1

  hash_key         = "recipe_id"
  range_key = "recipe_name"
  name             = "recipes"
  stream_enabled   = true
  stream_view_type = "NEW_AND_OLD_IMAGES"
  read_capacity    = 1
  write_capacity   = 1

  attribute {
    name = "recipe_id"
    type = "N"
  }

  attribute {
    name = "recipe_name"
    type = "S"
  }
}

resource "aws_dynamodb_table" "us-west-1" {
  provider = aws.us-west-1
  
  hash_key         = "recipe_id"
  range_key = "recipe_name"
  name             = "recipes"
  stream_enabled   = true
  stream_view_type = "NEW_AND_OLD_IMAGES"
  read_capacity    = 1
  write_capacity   = 1

   attribute {
    name = "recipe_id"
    type = "N"
  }

  attribute {
    name = "recipe_name"
    type = "S"
  }
}

resource "aws_dynamodb_global_table" "myTable" {
  depends_on = [
    aws_dynamodb_table.us-east-1,
    aws_dynamodb_table.us-west-1,
  ]
  provider = aws.us-east-1

  name = "recipes"

  replica {
    region_name = "us-east-1"
  }

  replica {
    region_name = "us-west-1"
  }
}
*/
