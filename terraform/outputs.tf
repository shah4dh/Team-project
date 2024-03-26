output "vpc_id" {
  value = module.networking.vpc_id
}

output "frontend_repository_uri" {
  value = module.frontend.repository_uri
}

output "backend_repository_uri" {
  value = module.backend.repository_uri
}



