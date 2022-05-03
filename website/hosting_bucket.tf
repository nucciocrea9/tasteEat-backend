
resource "aws_s3_bucket" "hosting" {
  bucket_prefix= var.bucket_prefix
  force_destroy = true #this is not working we need to empty the bucket

  website {
    index_document = "index.html"
    error_document = "error.html"
  }

}

resource "aws_s3_bucket_policy" "hosting_under_cdn" {
 // count  = var.use_cdn ? 1 : 0
  bucket = aws_s3_bucket.hosting.id

  policy = <<POLICY
{
    "Version": "2008-10-17",
    "Statement": [
        {
            "Sid": "AllowPublicRead",
            "Effect": "Allow",
            "Principal": {
                "AWS": "*"
            },
            "Action": "s3:GetObject",
            "Resource": [
        "${aws_s3_bucket.hosting.arn}/*",
        "${aws_s3_bucket.hosting.arn}"
      ]
        }
    ]
}

POLICY
}
/*
resource "aws_s3_bucket_policy" "hosting_direct" {
  count  = var.use_cdn ? 1 : 0
  bucket = aws_s3_bucket.hosting.id

  policy = <<POLICY
  {
    "Version": "2012-10-17",
    "Statement": [
    {
      "Sid": "PublicReadGetObject",
            "Effect": "Allow",
            "Principal": "*",
            "Action": [
                "s3:GetObject"
            ],
            "Resource": [
                "${aws_s3_bucket.hosting.arn}/*",
                "${aws_s3_bucket.hosting.arn}"
            ]
    }
  ]
  }
  POLICY
}
*/