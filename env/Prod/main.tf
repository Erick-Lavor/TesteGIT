module "aws-prod
    source = "../../infra"
    instancia = "t3.micro"
    regiao_aws = "us-east-1"
    chave = "NextcloudSebrae"
}