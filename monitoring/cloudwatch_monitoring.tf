resource "aws_cloudwatch_metric_alarm" "cpu_utilization_alarm" {
  alarm_name          = "HighCPUUtilization"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = var.evaluation_periods //2
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = var.period  // 300
  statistic           = var.statistic //Average 
  threshold           = var.cpu_alarm_threshold // 80%

  alarm_description = "High CPU utilization alarm for EC2 instances"
  dimensions = {
    AutoScalingGroupName = var.autoscaling_group_name
  }

  actions_enabled = true
  alarm_actions   = [aws_autoscaling_policy.scale_out_policy.arn]
  ok_actions      = [aws_autoscaling_policy.scale_in_policy.arn]
}

resource "aws_cloudwatch_metric_alarm" "rds_cpu_utilization_alarm" {
  alarm_name          = "HighRDSCPUUtilization"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = var.evaluation_periods
  metric_name         = "CPUUtilization"
  namespace           = "AWS/RDS"
  period              = var.period
  statistic           = var.statistic
  threshold           = var.cpu_alarm_threshold

  alarm_description = "High CPU utilization alarm for RDS instances"
  dimensions = {
    DBInstanceIdentifier = var.rds_instance_identifier
  }

  actions_enabled = true
  alarm_actions   = [] 
}

resource "aws_cloudwatch_metric_alarm" "memcached_memory_utilization_alarm" {
  alarm_name          = "HighMemcachedMemoryUtilization"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = var.evaluation_periods //2
  metric_name         = "FreeableMemory"
  namespace           = "AWS/ElastiCache"
  period              = var.period //300
  statistic           = var.statistic //Average 
  threshold           = var.elasticache_memory_threshold // 10000000

  alarm_description = "Low available memory alarm for ElastiCache"
  dimensions = {
    CacheClusterId = var.elasticache_cluster_id
  }

  actions_enabled = true
  alarm_actions    = [] 
}

resource "aws_cloudwatch_metric_alarm" "docker_ec2_instance_alarm" {
  alarm_name          = "DockerInstanceAvailability"
  comparison_operator = "LessThanThreshold"
  evaluation_periods  = var.evaluation_periods
  metric_name         = "StatusCheckFailed"
  namespace           = "AWS/EC2"
  period              = var.period
  statistic           = "Maximum"
  threshold           = 1

  alarm_description = "Availability alarm for private EC2 instance running Docker"
  dimensions = {
    InstanceId = var.instance_id_docker
  }

  actions_enabled = true
  alarm_actions   = [] # Notification for unavailability
}

resource "aws_autoscaling_policy" "scale_out_policy" {
  name                   = "scale-out"
  scaling_adjustment     = 1
  adjustment_type        = "ChangeInCapacity"
  autoscaling_group_name = var.autoscaling_group_name
  cooldown               = 300
}

resource "aws_autoscaling_policy" "scale_in_policy" {
  name                   = "scale-in"
  scaling_adjustment     = -1
  adjustment_type        = "ChangeInCapacity"
  autoscaling_group_name = var.autoscaling_group_name
  cooldown               = 300
}


/*

provider "aws" {
  region = var.region # Define a região AWS a ser usada. Exemplo: "us-east-1". Pode ser ajustada para outra região como "eu-west-1".
}

resource "aws_cloudwatch_metric_alarm" "cpu_utilization_alarm" {
  alarm_name          = "HighCPUUtilization" # Nome do alarme para facilitar a identificação no console.
  comparison_operator = "GreaterThanThreshold" # Operador de comparação. Outras opções:
  # - "LessThanThreshold"
  # - "LessThanOrEqualToThreshold"
  # - "GreaterThanOrEqualToThreshold"

  evaluation_periods  = var.evaluation_periods # Número de períodos consecutivos a serem avaliados antes de disparar o alarme.
  metric_name         = "CPUUtilization" # Nome da métrica monitorada. No EC2, pode ser "CPUUtilization", "NetworkIn", "NetworkOut", etc.
  namespace           = "AWS/EC2" # Categoria da métrica. Exemplo: "AWS/EC2", "AWS/RDS", "AWS/ElastiCache".
  period              = var.period # Intervalo de tempo, em segundos, entre pontos de dados. Exemplo: 300 (5 minutos).
  statistic           = var.statistic # Estatística da métrica. Outras opções:
  # - "SampleCount"
  # - "Sum"
  # - "Minimum"
  # - "Maximum"

  threshold           = var.cpu_alarm_threshold # Valor limite para disparar o alarme. Ajuste conforme sua necessidade.

  alarm_description = "High CPU utilization alarm for EC2 instances" # Descrição para documentar o propósito do alarme.
  dimensions = {
    AutoScalingGroupName = var.autoscaling_group_name # Nome do grupo de Auto Scaling associado. Define a instância ou recurso monitorado.
  }

  actions_enabled = true # Define se o alarme executa ações quando ativado.
  alarm_actions    = [var.scale_out_policy_arn] # Ação executada quando o alarme é ativado. Exemplo: escala para mais instâncias.
  ok_actions       = [var.scale_in_policy_arn] # Ação executada quando o estado retorna ao normal. Exemplo: escala para menos instâncias.
}

resource "aws_cloudwatch_metric_alarm" "rds_cpu_utilization_alarm" {
  alarm_name          = "HighRDSCPUUtilization" # Nome do alarme para monitorar CPU no RDS.
  comparison_operator = "GreaterThanThreshold" # Operador de comparação para detectar alta CPU.
  evaluation_periods  = var.evaluation_periods # Períodos consecutivos avaliados.
  metric_name         = "CPUUtilization" # Métrica monitorada no RDS.
  namespace           = "AWS/RDS" # Categoria específica para métricas do RDS.
  period              = var.period # Intervalo entre pontos de dados.
  statistic           = var.statistic # Estatística usada para calcular os valores da métrica.
  threshold           = var.cpu_alarm_threshold # Limite de CPU para disparo.

  alarm_description = "High CPU utilization alarm for RDS instances" # Descrição do propósito.
  dimensions = {
    DBInstanceIdentifier = var.rds_instance_identifier # Identificador do banco monitorado.
  }

  actions_enabled = true # Define se o alarme executa ações.
  alarm_actions    = [] # Nenhuma ação configurada, mas pode incluir notificações SNS.
}

/*
resource "aws_cloudwatch_metric_alarm" "memcached_memory_utilization_alarm" {
  alarm_name          = "HighMemcachedMemoryUtilization" # Nome do alarme para monitorar memória no ElastiCache.
  comparison_operator = "GreaterThanThreshold" # Operador de comparação para detectar baixa memória.
  evaluation_periods  = var.evaluation_periods # Períodos consecutivos avaliados.
  metric_name         = "FreeableMemory" # Métrica monitorada.
  namespace           = "AWS/ElastiCache" # Categoria específica para métricas do ElastiCache.
  period              = var.period # Intervalo entre pontos de dados.
  statistic           = var.statistic # Estatística usada para calcular os valores da métrica.
  threshold           = var.elasticache_memory_threshold # Limite para disparo.

  alarm_description = "Low available memory alarm for ElastiCache" # Descrição do alarme.
  dimensions = {
    CacheClusterId = var.elasticache_cluster_id # Identificador do cluster monitorado.
  }

  actions_enabled = true # Define se o alarme executa ações.
  alarm_actions    = [] # Nenhuma ação configurada, mas pode incluir notificações SNS.
}

resource "aws_cloudwatch_metric_alarm" "docker_ec2_instance_alarm" {
  alarm_name          = "DockerInstanceAvailability" # Nome do alarme para monitorar disponibilidade da instância EC2.
  comparison_operator = "LessThanThreshold" # Detecta quando o valor está abaixo do limite.
  evaluation_periods  = var.evaluation_periods # Períodos consecutivos avaliados.
  metric_name         = "StatusCheckFailed" # Métrica para verificar falhas de status.
  namespace           = "AWS/EC2" # Categoria específica para métricas de EC2.
  period              = var.period # Intervalo entre pontos de dados.
  statistic           = "Maximum" # Usa o valor máximo da métrica no período.
  threshold           = 1 # Limite para disparar o alarme.

  alarm_description = "Availability alarm for private EC2 instance running Docker" # Descrição do propósito.
  dimensions = {
    InstanceId = var.docker_instance_id # ID da instância monitorada.
  }

  actions_enabled = true # Define se o alarme executa ações.
  alarm_actions    = [] # Nenhuma ação configurada, mas pode incluir notificações SNS.
}

resource "aws_autoscaling_policy" "scale_out_policy" {
  name                   = "scale-out" # Nome da política para escalar para mais instâncias.
  scaling_adjustment     = 1 # Aumenta uma instância ao escalar.
  adjustment_type        = "ChangeInCapacity" # Define o tipo de ajuste. Outras opções:
  # - "ExactCapacity": Ajusta para um número exato de instâncias.
  # - "PercentChangeInCapacity": Ajusta com base em porcentagem.
  autoscaling_group_name = var.autoscaling_group_name # Nome do Auto Scaling Group associado.
  cooldown               = 300 # Tempo de espera entre ajustes de escalonamento.
}

resource "aws_autoscaling_policy" "scale_in_policy" {
  name                   = "scale-in" # Nome da política para reduzir instâncias.
  scaling_adjustment     = -1 # Reduz uma instância ao escalar.
  adjustment_type        = "ChangeInCapacity" # Tipo de ajuste (mesmas opções do anterior).
  autoscaling_group_name = var.autoscaling_group_name # Nome do Auto Scaling Group associado.
  cooldown               = 300 # Tempo de espera entre ajustes de escalonamento.
}



/*

provider "aws" {
  region = var.region # Define a região AWS a ser usada. Exemplo: "us-east-1". Pode ser ajustada para outra região como "eu-west-1".
}

resource "aws_cloudwatch_metric_alarm" "cpu_utilization_alarm" {
  alarm_name          = "HighCPUUtilization" # Nome do alarme para facilitar a identificação no console.
  comparison_operator = "GreaterThanThreshold" # Operador de comparação. Outras opções:
  # - "LessThanThreshold"
  # - "LessThanOrEqualToThreshold"
  # - "GreaterThanOrEqualToThreshold"

  evaluation_periods  = var.evaluation_periods # Número de períodos consecutivos a serem avaliados antes de disparar o alarme.
  metric_name         = "CPUUtilization" # Nome da métrica monitorada. No EC2, pode ser "CPUUtilization", "NetworkIn", "NetworkOut", etc.
  namespace           = "AWS/EC2" # Categoria da métrica. Exemplo: "AWS/EC2", "AWS/RDS", "AWS/ElastiCache".
  period              = var.period # Intervalo de tempo, em segundos, entre pontos de dados. Exemplo: 300 (5 minutos).
  statistic           = var.statistic # Estatística da métrica. Outras opções:
  # - "SampleCount"
  # - "Sum"
  # - "Minimum"
  # - "Maximum"

  threshold           = var.cpu_alarm_threshold # Valor limite para disparar o alarme. Ajuste conforme sua necessidade.

  alarm_description = "High CPU utilization alarm for EC2 instances" # Descrição para documentar o propósito do alarme.
  dimensions = {
    AutoScalingGroupName = var.autoscaling_group_name # Nome do grupo de Auto Scaling associado. Define a instância ou recurso monitorado.
  }

  actions_enabled = true # Define se o alarme executa ações quando ativado.
  alarm_actions    = [var.scale_out_policy_arn] # Ação executada quando o alarme é ativado. Exemplo: escala para mais instâncias.
  ok_actions       = [var.scale_in_policy_arn] # Ação executada quando o estado retorna ao normal. Exemplo: escala para menos instâncias.
}

resource "aws_cloudwatch_metric_alarm" "rds_cpu_utilization_alarm" {
  alarm_name          = "HighRDSCPUUtilization" # Nome do alarme para monitorar CPU no RDS.
  comparison_operator = "GreaterThanThreshold" # Operador de comparação para detectar alta CPU.
  evaluation_periods  = var.evaluation_periods # Períodos consecutivos avaliados.
  metric_name         = "CPUUtilization" # Métrica monitorada no RDS.
  namespace           = "AWS/RDS" # Categoria específica para métricas do RDS.
  period              = var.period # Intervalo entre pontos de dados.
  statistic           = var.statistic # Estatística usada para calcular os valores da métrica.
  threshold           = var.cpu_alarm_threshold # Limite de CPU para disparo.

  alarm_description = "High CPU utilization alarm for RDS instances" # Descrição do propósito.
  dimensions = {
    DBInstanceIdentifier = var.rds_instance_identifier # Identificador do banco monitorado.
  }

  actions_enabled = true # Define se o alarme executa ações.
  alarm_actions    = [] # Nenhuma ação configurada, mas pode incluir notificações SNS.
}

/*
resource "aws_cloudwatch_metric_alarm" "memcached_memory_utilization_alarm" {
  alarm_name          = "HighMemcachedMemoryUtilization" # Nome do alarme para monitorar memória no ElastiCache.
  comparison_operator = "GreaterThanThreshold" # Operador de comparação para detectar baixa memória.
  evaluation_periods  = var.evaluation_periods # Períodos consecutivos avaliados.
  metric_name         = "FreeableMemory" # Métrica monitorada.
  namespace           = "AWS/ElastiCache" # Categoria específica para métricas do ElastiCache.
  period              = var.period # Intervalo entre pontos de dados.
  statistic           = var.statistic # Estatística usada para calcular os valores da métrica.
  threshold           = var.elasticache_memory_threshold # Limite para disparo.

  alarm_description = "Low available memory alarm for ElastiCache" # Descrição do alarme.
  dimensions = {
    CacheClusterId = var.elasticache_cluster_id # Identificador do cluster monitorado.
  }

  actions_enabled = true # Define se o alarme executa ações.
  alarm_actions    = [] # Nenhuma ação configurada, mas pode incluir notificações SNS.
}


resource "aws_cloudwatch_metric_alarm" "docker_ec2_instance_alarm" {
  alarm_name          = "DockerInstanceAvailability" # Nome do alarme para monitorar disponibilidade da instância EC2.
  comparison_operator = "LessThanThreshold" # Detecta quando o valor está abaixo do limite.
  evaluation_periods  = var.evaluation_periods # Períodos consecutivos avaliados.
  metric_name         = "StatusCheckFailed" # Métrica para verificar falhas de status.
  namespace           = "AWS/EC2" # Categoria específica para métricas de EC2.
  period              = var.period # Intervalo entre pontos de dados.
  statistic           = "Maximum" # Usa o valor máximo da métrica no período.
  threshold           = 1 # Limite para disparar o alarme.

  alarm_description = "Availability alarm for private EC2 instance running Docker" # Descrição do propósito.
  dimensions = {
    InstanceId = var.docker_instance_id # ID da instância monitorada.
  }

  actions_enabled = true # Define se o alarme executa ações.
  alarm_actions    = [] # Nenhuma ação configurada, mas pode incluir notificações SNS.
}

resource "aws_autoscaling_policy" "scale_out_policy" {
  name                   = "scale-out" # Nome da política para escalar para mais instâncias.
  scaling_adjustment     = 1 # Aumenta uma instância ao escalar.
  adjustment_type        = "ChangeInCapacity" # Define o tipo de ajuste. Outras opções:
  # - "ExactCapacity": Ajusta para um número exato de instâncias.
  # - "PercentChangeInCapacity": Ajusta com base em porcentagem.
  autoscaling_group_name = var.autoscaling_group_name # Nome do Auto Scaling Group associado.
  cooldown               = 300 # Tempo de espera entre ajustes de escalonamento.
}

resource "aws_autoscaling_policy" "scale_in_policy" {
  name                   = "scale-in" # Nome da política para reduzir instâncias.
  scaling_adjustment     = -1 # Reduz uma instância ao escalar.
  adjustment_type        = "ChangeInCapacity" # Tipo de ajuste (mesmas opções do anterior).
  autoscaling_group_name = var.autoscaling_group_name # Nome do Auto Scaling Group associado.
  cooldown               = 300 # Tempo de espera entre ajustes de escalonamento.
}

1. "LessThanThreshold":
Descrição: Este operador é usado para acionar um alarme quando a métrica monitorada é menor do que o valor especificado no threshold.
Uso Comum: É frequentemente utilizado para monitorar condições que devem permanecer abaixo de um certo limite, como a utilização de memória ou a latência de um serviço.
"LessThanOrEqualToThreshold":
Descrição: Este operador aciona um alarme quando a métrica monitorada é menor ou igual ao valor especificado no threshold.
Uso Comum: É útil em situações onde você deseja incluir o limite em si como uma condição de alarme, como quando a utilização de um recurso deve ser mantida abaixo de um certo nível, incluindo o próprio nível.
3. "GreaterThanOrEqualToThreshold":
Descrição: Este operador é utilizado para acionar um alarme quando a métrica monitorada é maior ou igual ao valor especificado no threshold.
Uso Comum: É frequentemente usado para monitorar condições que devem ser mantidas acima de um certo limite, como a utilização de CPU ou a contagem de erros em um serviço.
Resumo
LessThanThreshold: Aciona quando a métrica é menor que o limite.
LessThanOrEqualToThreshold: Aciona quando a métrica é menor ou igual ao limite.
GreaterThanOrEqualToThreshold: Aciona quando a métrica é maior ou igual ao limite.
Esses operadores ajudam a definir as condições sob as quais os alarmes devem ser acionados, permitindo um monitoramento mais preciso e eficaz dos recursos.



*/
