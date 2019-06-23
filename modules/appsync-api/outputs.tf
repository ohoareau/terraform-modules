output "id" {
  value = aws_appsync_graphql_api.api.id
}
output "endpoint" {
  value = aws_appsync_graphql_api.api.uris["GRAPHQL"]
}
output "arn" {
  value = aws_appsync_graphql_api.api.arn
}
