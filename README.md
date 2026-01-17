# vehicle-sales-lakehouse

# 🚗 Autoprime Car Lakehouse

### Projeto de Engenharia de Dados com Databricks (Lakehouse + Medallion)

## 📌 Visão Geral

Este projeto implementa uma **arquitetura Lakehouse com padrão Medallion (Bronze, Silver e Gold)** utilizando **Databricks (Free Edition)**, com foco em **engenharia de dados, qualidade, regras de negócio e análises analíticas**.

O objetivo é transformar dados brutos de vendas de veículos em **dados confiáveis, modelados e prontos para consumo analítico**, culminando em **dashboards no Power BI**.

---

## 🏗️ Arquitetura do Projeto

```
Bronze (dados brutos)
   ↓
Silver (dados limpos + regras técnicas)
   ↓
Silver (dados enriquecidos + regras de negócio)
   ↓
Gold (tabelas agregadas e analíticas)
   ↓
Power BI (dashboards)
```

---

## 🥉 Camada Bronze – Dados Brutos

A camada **Bronze** contém os dados exatamente como chegam à plataforma, sem transformações complexas.

### Características:

* Ingestão via **Streaming Tables**
* Dados sem regras de negócio
* Tipagem mínima
* Fonte única da verdade

### Tabelas:

* `bronze.clientes`
* `bronze.vendedores`
* `bronze.veiculos`
* `bronze.vendas`

---

## 🥈 Camada Silver – Limpeza e Padronização (1ª Etapa)

Nesta etapa são aplicadas **regras técnicas e de qualidade**, sem cruzamento entre tabelas.

### Principais transformações:

* Padronização de tipos (`CAST`)
* Limpeza de strings (`TRIM`, `INITCAP`)
* Validações com `CONSTRAINT`
* Tratamento de e-mails inválidos
* Inclusão de `ingestion_ts`

### Tabelas Silver:

* `silver.enriched_clientes`
* `silver.enriched_vendedores`
* `silver.enriched_veiculos`
* `silver.enriched_vendas`

> Não foi utilizado CDC ou janelas por se tratar de dados simples e append-only, além das limitações da Free Edition.

---

## 🥈 Camada Silver – Regras de Negócio e Integração (2ª Etapa)

Criação da **tabela fato consolidada**, integrando todas as entidades do domínio.

### 📊 `silver.fato_vendas`

Aplicações:

* Join entre vendas, clientes, vendedores e veículos
* Criação de atributos temporais (ano, mês, dia, nome do mês, dia da semana)
* Indicador de desconto aplicado
* Validações de negócio:

  * `preco_final >= 0`
  * `desconto >= 0`

Modelo baseado em **modelagem multidimensional (estrela)**.

---

## 🥇 Camada Gold – Dados Analíticos

Camada otimizada para consumo analítico, dashboards e KPIs.

### 📅 `gold.vendas_diarias`

* Total de vendas
* Clientes, vendedores e veículos distintos
* Receita total
* Ticket médio

### 📆 `gold.faturamento_mensal`

* Faturamento mensal
* Total de descontos
* Total de vendas

### 🧑‍💼 Performance de Vendedores

* Total de vendas
* Valor vendido
* Ticket médio
* Ranking

### 🚘 Performance de Veículos

* Análises por marca, modelo e ano

### 💳 Performance por Forma de Pagamento

* Total de vendas
* Faturamento
* Ticket médio
* Maior e menor valor de venda

---

## 📊 Dashboard (Power BI)

Os dados da camada **Gold** foram consumidos no Power BI para criação de um dashboard com:

* Evolução de vendas
* Faturamento
* Performance de vendedores
* Análise de veículos
* Formas de pagamento

**Título do Dashboard:**

> *Dashboard de Vendas e Faturamento – Autoprime*

---

## 🧠 Conceitos Aplicados

* Arquitetura Lakehouse
* Medallion Architecture
* Modelagem Multidimensional
* Data Quality com Constraints
* Materialized Views
* Engenharia de Dados orientada a negócio

---

## 🚀 Tecnologias Utilizadas

* Databricks (Free Edition)
* Delta Lake
* SQL
* Lakeflow / Streaming Tables
* Power BI
* GitHub

---

## 🎯 Conclusão

Este projeto demonstra a construção de um **pipeline de dados completo**, desde a ingestão até a visualização, seguindo boas práticas de engenharia de dados e analytics.

Ideal para portfólio profissional e demonstração de competências em ambientes analíticos modernos.
