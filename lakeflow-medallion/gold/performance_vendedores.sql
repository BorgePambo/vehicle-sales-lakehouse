-- Please edit the sample below

CREATE MATERIALIZED VIEW gold.performance_vendedores
COMMENT "Tabela agregada com o desempenho de vendas por vendedor, incluindo total de vendas, valor total vendido e ticket médio."
AS
SELECT
    vendedor_id,
    vendedor_nome,
    COUNT(venda_id) AS total_vendas,
    SUM(preco_final) AS total_vendas_valor,
    ROUND(AVG(preco_final), 2) AS ticket_medio,
    RANK() OVER (ORDER BY SUM(preco_final) DESC) AS rank_vendedor
FROM silver.fato_vendas
GROUP BY
     vendedor_id, vendedor_nome
ORDER BY total_vendas_valor DESC;
