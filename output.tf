output "rds_address" {
  value = module.rds_mysql.address
}

output "jumpserver_instance_id" {
  value = module.jumpserver.instance_id
}

output "jumpserver_public_dns" {
  value = module.jumpserver.public_dns
}
