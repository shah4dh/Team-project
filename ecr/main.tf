resource "aws_ecr_repository" "public_repo" {
  name                 = var.repository_name
  image_tag_mutability = "MUTABLE" 
}