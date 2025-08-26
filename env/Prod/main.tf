module "aws-prod" {
    source = "../../infra"
    instancia = "t3.micro"
    regiao_aws = "us-east-1"
    chave = "NextcloudSebrae"
    grupoDeSeguraca = "Producao"
    minimo = 1
    maximo = 5
    nomeGrupo = "grupoProd"
    
}
