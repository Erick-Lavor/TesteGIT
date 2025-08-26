module "aws-dev" {
    source = "../../infra"
    instancia = "t2.micro"
    regiao_aws = "us-east-1"
    chave = "NextcloudSebrae"
    grupoDeSeguraca = "DEV"
    minimo = 0
    maximo = 1
    nomeGrupo = "grupoDEV"
}

output "IP" {
    value = module.aws-dev.IP_Publico
  
}