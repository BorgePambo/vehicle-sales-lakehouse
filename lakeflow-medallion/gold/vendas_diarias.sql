CREATE OR REPLACE MATERIALIZED VIEW gold.vendas_diarias
COMMENT "Resumo diário das vendas com métricas de volume, clientes, vendedores, veículos e receita"
AS
SELECT 
    data_venda,
    YEAR(data_venda) AS ano_venda,
    MONTH(data_venda) AS mes_venda,
    data_venda_nome_mes,
    data_venda_dia,

    COUNT(*) AS total_vendas,
    COUNT(DISTINCT cliente_id)  AS total_clientes,
    COUNT(DISTINCT vendedor_id) AS total_vendedores,
    COUNT(DISTINCT veiculo_id)  AS total_veiculos,
    SUM(preco_final) AS total_receita,
    ROUND(AVG(preco_final), 2) AS media_receita
FROM silver.fato_vendas
GROUP BY 
    data_venda,
    YEAR(data_venda),
    MONTH(data_venda),
    data_venda_nome_mes,
    data_venda_dia;
