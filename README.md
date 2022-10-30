# O projeto consistem em provisionar EC2 + LB + VPC + SG

## Requisito

#### Deve ser criada uma chave .pem na aws na região Ohio us-east-2 em seguida baixar e armazenar ### chave.pem no mesmo diretório dos arquivo.tf e adicionar o nome da chave no arquivo ec2.tf nas linhas 8 e 15


### Entre no diretório baixado
`cd aws_ec2_lb`

### Inicie o terraform
`terraform init`

### Aplique a infra como código
`terraform apply`
