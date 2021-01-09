provider "aws" {
}

// configuration
locals {
  services = {
    access_analyzer                = {service = "access-analyzer",                type = "Interface"}
    acm_pca                        = {service = "acm-pca",                        type = "Interface"}
    application_autoscaling        = {service = "application-autoscaling",        type = "Interface"}
    appmesh                        = {service = "appmesh-envoy-management",       type = "Interface"}
    athena                         = {service = "athena",                         type = "Interface"}
    autoscaling                    = {service = "autoscaling",                    type = "Interface"}
    cassandra                      = {service = "cassandra",                      type = "Interface"}
    cloudformation                 = {service = "cloudformation",                 type = "Interface"}
    cloudtrail                     = {service = "cloudtrail",                     type = "Interface"}
    cloudwatch                     = {service = "logs",                           type = "Interface"}
    codebuild                      = {service = "codebuild",                      type = "Interface"}
    codecommit                     = {service = "codecommit",                     type = "Interface"}
    codedeploy                     = {service = "codedeploy",                     type = "Interface"}
    codepipeline                   = {service = "codepipeline",                   type = "Interface"}
    config                         = {service = "config",                         type = "Interface"}
    datasync                       = {service = "datasync",                       type = "Interface"}
    dms                            = {service = "dms",                            type = "Interface"}
    dynamodb                       = {service = "dynamodb",                       type = "Gateway"}
    ebs                            = {service = "ebs",                            type = "Interface"}
    ec2                            = {service = "ec2",                            type = "Interface"}
    ec2messages                    = {service = "ec2messages",                    type = "Interface"}
    ecr                            = {service = "ecr.api",                        type = "Interface"}
    ecr_dkr                        = {service = "ecr.dkr",                        type = "Interface"}
    ecs                            = {service = "ecs",                            type = "Interface"}
    ecs_agent                      = {service = "ecs-agent",                      type = "Interface"}
    ecs_telemetry                  = {service = "ecs-telemetry",                  type = "Interface"}
    elasticbeanstalk               = {service = "elasticbeanstalk",               type = "Interface"}
    elasticbeanstalk_health        = {service = "elasticbeanstalk-health",        type = "Interface"}
    elasticfilesystem              = {service = "elasticfilesystem",              type = "Interface"}
    elasticfilesystem_fips         = {service = "elasticfilesystem-fips",         type = "Interface"}
    elasticloadbalancing           = {service = "elasticloadbalancing",           type = "Interface"}
    elasticmapreduce               = {service = "elasticmapreduce",               type = "Interface"}
    eventbridge                    = {service = "events",                         type = "Interface"}
    apigateway                     = {service = "execute-api",                    type = "Interface"}
    git_codecommit                 = {service = "git-codecommit",                 type = "Interface"}
    glue                           = {service = "glue",                           type = "Interface"}
    imagebuilder                   = {service = "imagebuilder",                   type = "Interface"}
    kinesis_firehose               = {service = "kinesis-firehose",               type = "Interface"}
    kinesis_streams                = {service = "kinesis-streams",                type = "Interface"}
    kms                            = {service = "kms",                            type = "Interface"}
    lambda                         = {service = "lambda",                         type = "Interface"}
    license_manager                = {service = "license-manager",                type = "Interface"}
    logs                           = {service = "logs",                           type = "Interface"}
    macie                          = {service = "macie2",                         type = "Interface"}
    monitoring                     = {service = "monitoring",                     type = "Interface"}
    rds                            = {service = "rds",                            type = "Interface"}
    rds_data                       = {service = "rds-data",                       type = "Interface"}
    redshift                       = {service = "redshift",                       type = "Interface"}
    s3                             = {service = "s3",                             type = "Gateway"}
    sagemaker                      = {service = "sagemaker.api",                  type = "Interface"}
    sagemaker_featurestore_runtime = {service = "sagemaker.featurestore-runtime", type = "Interface"}
    // sagemaker_notebook: probably not working
    sagemaker_notebook             = {service = "sagemaker.notebook",             type = "Interface"}
    sagemaker_runtime              = {service = "sagemaker.runtime",              type = "Interface"}
    // sagemaker_studio: probably not working
    sagemaker_studio               = {service = "sagemaker.studio",               type = "Interface"}
    secretsmanager                 = {service = "secretsmanager",                 type = "Interface"}
    servicecatalog                 = {service = "servicecatalog",                 type = "Interface"}
    ses                            = {service = "email-smtp",                     type = "Interface"}
    sms                            = {service = "sms",                            type = "Interface"}
    sns                            = {service = "sns",                            type = "Interface"}
    sqs                            = {service = "sqs",                            type = "Interface"}
    ssm                            = {service = "ssm",                            type = "Interface"}
    ssmmessages                    = {service = "ssmmessages",                    type = "Interface"}
    step_functions                 = {service = "states",                         type = "Interface"}
    storagegateway                 = {service = "storagegateway",                 type = "Interface"}
    sts                            = {service = "sts",                            type = "Interface"}
    synthetics                     = {service = "synthetics",                     type = "Interface"}
    textract                       = {service = "textract",                       type = "Interface"}
    transcribe                     = {service = "transcribe",                     type = "Interface"}
    transfer                       = {service = "transfer",                       type = "Interface"}
    transfer_server                = {service = "transfer-server",                type = "Interface"}
  }
}

// automatic local variables
locals {
  svc          = local.services[var.name]
  service      = local.svc["service"]
  type         = local.svc["type"]
  isInterface  = "Interface" == local.type
  isGateway    = "Gateway" == local.type
  gatewayCount = local.isGateway ? 1 : 0
}

data "aws_vpc_endpoint_service" "service" {
  service = local.service
}

resource "aws_vpc_endpoint" "service" {
  vpc_id              = var.vpc_id
  service_name        = data.aws_vpc_endpoint_service.service.service_name
  // common
  vpc_endpoint_type   = local.type
  // for Interface endpoints
  security_group_ids  = local.isInterface ? var.security_group_ids : null
  subnet_ids          = local.isInterface ? var.subnet_ids : null
  private_dns_enabled = local.isInterface ? var.private_dns_enabled : null
  // for Gateway endpoints
  route_table_ids = local.isInterface[var.route_table_id]
}

// Gateway only
resource "aws_vpc_endpoint_route_table_association" "service" {
  count = local.gatewayCount
  route_table_id  = var.route_table_id
  vpc_endpoint_id = aws_vpc_endpoint.service.id
}
