variable "allocated_storage" {
  description = "Amount of storage to allocate for the database"
  default = 10
}

variable "db_name" {
  description = "Name of the database"
  default = "project"
}

variable "identifier" {
  description = "ID value for the database"
  default = "project-db"
}

variable "engine" {
  description = "Engine for the database"
  default = "postgres"
}

variable "instance_class" {
  description = "Type of instance to store database on"
  default = "db.t3.micro"
}

variable "publicly_accessible" {
  description = "Whether or not the database is publicly accessible"
  default = true
}

variable "skip_final_snapshot" {
  description = "Whether or not to skip the final snapshot"
  default = true
}

variable "secret_id" {
  description = "ID of amazon secret"
  default = "project-db-credentials"
}