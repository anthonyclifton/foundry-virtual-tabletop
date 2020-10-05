resource "aws_iam_user" "foundry_s3_user" {
    name = "foundry-s3-user"
    path = "/vtt/"

    tags = {
        system = "vtt"
    }
}