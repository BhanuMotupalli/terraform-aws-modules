output "id" {
  value = aws_vpc.base.id
}

output "public_subnets_id" {
  value = aws_subnet.public[*].id

}
output "private_subnets_id" {
  value = aws_subnet.private[*].id

}

output "public_route_table_id" {
  value = aws_route_table.public[*].id
}

output "private_route_table_id" {
  value = aws_route_table.private[*].id
}