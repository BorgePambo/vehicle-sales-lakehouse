-- Please edit the sample below

CREATE OR REPLACE MATERIALIZED VIEW gold.perfomance_veiculos
COMMENT "Desempenho de vendas por marca, modelo e ano do veículo, incluindo volume de vendas, faturamento e ticket médio."
AS
SELECT
    veiculo_marca,
    veiculo_modelo,
    veiculo_ano,
    COUNT(venda_id) AS total_vendas,
    SUM(preco_final) AS total_faturamento,
    ROUND(AVG(preco_final), 2) AS ticket_medio
FROM silver.fato_vendas
GROUP BY veiculo_marca, veiculo_modelo, veiculo_ano
ORDER BY total_faturamento DESC;
