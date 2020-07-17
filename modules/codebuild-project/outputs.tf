output "name" {
  value = aws_codebuild_project.project.name
}
output "id" {
  value = aws_codebuild_project.project.id
}
output "arn" {
  value = aws_codebuild_project.project.arn
}
output "artifacts" {
  value = aws_codebuild_project.project.artifacts
}
output "role_name" {
  value = aws_iam_role.role.name
}
output "role_arn" {
  value = aws_iam_role.role.arn
}
output "badge_url" {
  value = aws_codebuild_project.project.badge_url
}
