# Módulos Terraform Reutilizáveis para AWS

Este repositório é um projeto de portfólio que demonstra a criação e utilização de módulos Terraform reutilizáveis para provisionar infraestrutura na Amazon Web Services (AWS). O objetivo é aplicar os conceitos de Infraestrutura como Código (IaC) para criar componentes padronizados, eficientes e seguros.

Este projeto foi desenvolvido como uma demonstração de habilidades para uma posição de DevOps Jr., focando em boas práticas de automação e gerenciamento de configuração.

## A Finalidade dos Módulos Terraform

Em ambientes de nuvem, é comum precisarmos criar os mesmos tipos de recursos (como redes VPC, grupos de segurança, balanceadores de carga) repetidamente para diferentes projetos ou ambientes (desenvolvimento, homologação, produção).

Escrever o código Terraform do zero a cada vez é ineficiente, propenso a erros e dificulta a padronização. Os **módulos** resolvem esse problema. Eles são como "funções" ou "classes" da Infraestrutura como Código: um bloco de código reutilizável que define um conjunto de recursos com uma interface clara (variáveis de entrada e valores de saída).

## Benefícios de Usar Módulos Reutilizáveis

Adotar uma abordagem modular com Terraform traz vantagens significativas para equipes de DevOps e engenharia:

- **Consistência:** Garante que a mesma infraestrutura seja implantada com as mesmas configurações em todos os ambientes, reduzindo problemas de paridade.
- **Eficiência:** Acelera drasticamente o tempo de provisionamento. Em vez de semanas, uma nova infraestrutura pode ser criada em minutos, simplesmente chamando os módulos necessários.
- **Manutenção Simplificada:** Se uma melhoria ou correção de segurança for necessária, basta atualizar o módulo central. Todas as infraestruturas que o utilizam podem herdar a atualização de forma controlada.
- **Boas Práticas Embarcadas:** Permite que especialistas em nuvem e segurança definam as melhores práticas (ex: regras de firewall, configurações de logging, tags) dentro do módulo, que são então consumidas pelo resto da equipe.
- **Redução de Erros:** Minimiza a chance de erros de configuração manual, que são uma causa comum de falhas e vulnerabilidades.
- **Colaboração:** Facilita o trabalho em equipe, onde diferentes membros podem consumir os mesmos módulos para construir seus ambientes de aplicação.

## Módulos Disponíveis neste Repositório

Atualmente, este projeto contém os seguintes módulos:

- **`./modules/vpc`**: Cria uma Virtual Private Cloud (VPC) completa, incluindo sub-redes públicas e privadas, Internet Gateway e NAT Gateway. É a base de rede para qualquer ambiente na AWS.
- **`./modules/security-group`**: Define regras de firewall para controlar o tráfego de entrada e saída para recursos como instâncias EC2 e bancos de dados.
- **`./modules/alb`**: Provisiona um Application Load Balancer (ALB) para distribuir o tráfego HTTP/HTTPS entre as aplicações, além de seus Target Groups e Listeners.
- **`./modules/autoscaling-group`**: Configura um Auto Scaling Group (ASG) com uma Launch Template para garantir que a aplicação tenha o número ideal de instâncias EC2 para atender à demanda, promovendo alta disponibilidade e elasticidade.

## Como Usar os Módulos

Para utilizar um dos módulos em seu projeto Terraform, você pode referenciá-lo localmente.

### Pré-requisitos

-   [Terraform](https://learn.hashicorp.com/tutorials/terraform/install-cli) instalado.
-   [AWS CLI](https://aws.amazon.com/cli/) instalado e configurado com suas credenciais.

### Exemplo: Criando uma Nova VPC

1.  Crie um novo diretório para seu projeto (ex: `meu-projeto-aws`).
2.  Dentro dele, crie um arquivo `main.tf`.
3.  No arquivo `main.tf`, chame o módulo `vpc` da seguinte forma:

```hcl
# Configura o provedor da AWS
provider "aws" {
  region = "us-east-1"
}

# Define as tags padrão para todos os recursos
locals {
  default_tags = {
    Project   = "MeuProjeto"
    ManagedBy = "Terraform"
  }
}

# Chama o módulo VPC para criar a rede
module "minha_vpc" {
  # O source aponta para o caminho do módulo neste repositório
  source = "git::https://github.com/vinicius3516/terraform-aws-modules.git//modules/vpc?ref=main"

  # Variáveis de entrada para configurar a VPC
  project_name = "MeuProjeto"
  vpc_cidr     = "10.0.0.0/16"
  public_subnets_cidr  = ["10.0.1.0/24", "10.0.2.0/24"]
  private_subnets_cidr = ["10.0.101.0/24", "10.0.102.0/24"]
  availability_zones   = ["us-east-1a", "us-east-1b"]

  tags = local.default_tags
}

# Exemplo de como usar uma saída do módulo
output "vpc_id" {
  description = "O ID da VPC criada"
  value       = module.minha_vpc.vpc_id
}
```

4.  Execute os comandos do Terraform:

```bash
# Inicia o diretório de trabalho e baixa os provedores
terraform init

# Mostra o plano de execução
terraform plan

# Aplica as mudanças e cria a infraestrutura
terraform apply
```

---

Este projeto representa um passo fundamental na jornada de um profissional DevOps, demonstrando a capacidade de pensar em automação, padronização e escala.