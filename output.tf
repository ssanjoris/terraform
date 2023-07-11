output "fingerprint" {
  value = data.aws_key_pair.aws_ex_keypair.fingerprint
}

output "name" {
  value = data.aws_key_pair.aws_ex_keypair.key_name
}

output "id" {
  value = data.aws_key_pair.aws_ex_keypair.id
}

output "VPC_ID" {
  value = aws_vpc.new_vpc
}

output "VPC_ARN" {
  value = aws_vpc.new_vpc.arn
}