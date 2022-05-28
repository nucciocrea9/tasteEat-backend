
resource "aws_dynamodb_table" "us-east-1" {
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

resource "aws_dynamodb_table" "order" {

  name           = "orders"
  hash_key       = "order_id"
  range_key      = "user"
  read_capacity  = 20
  write_capacity = 20
  billing_mode   = "PROVISIONED"
  attribute {
    name = "order_id"
    type = "S"
  }
  attribute {
    name = "user"
    type = "S"
  }
}


