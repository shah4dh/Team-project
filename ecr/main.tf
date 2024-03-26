resource "aws_ecr_repository" "public_repo" {
  count = 2
  name                 = var.repository_name[count.index]
  image_tag_mutability = "MUTABLE" 
}