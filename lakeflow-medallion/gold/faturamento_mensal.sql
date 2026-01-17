-- Please edit the sample below

CREATE OR REPLACE MATERIALIZED VIEW gold.faturamento_mensal
COMMENT "Faturamento mensal consolidado da concessionária"
AS
SELECT
    data_venda_ano,
    data_venda_mes,
    data_venda_nome_mes,
    SUM(preco_final) AS total_faturamento,
    SUM(desconto) AS total_desconto,
    COUNT(venda_id) AS total_vendas
FROM silver.fato_vendas
GROUP BY 
    data_venda_ano,
    data_venda_mes,
    data_venda_nome_mes
ORDER BY 
    data_venda_ano,
    data_venda_mes;