output "repository_url" {
  value = aws_ecr_repository.repository.repository_url
}
output "image_latest" {
  value = "${aws_ecr_repository.repository.repository_url}:latest"
}
output "id" {
  value = aws_ecr_repository.repository.id
}
output "name" {
  value = aws_ecr_repository.repository.name
}
output "arn" {
  value = aws_ecr_repository.repository.arn
}