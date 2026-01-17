CREATE OR REPLACE MATERIALIZED VIEW silver.fato_vendas
(
    CONSTRAINT regra_preco_final EXPECT(preco_final >= 0) ON VIOLATION DROP ROW,
    CONSTRAINT regra_preco EXPECT(preco > 0) ON VIOLATION DROP ROW,
    CONSTRAINT regra_desconto EXPECT(desconto >= 0) ON VIOLATION DROP ROW
)
TBLPROPERTIES (
    quality = "silver"
)
AS
SELECT
    v.venda_id,
    c.cliente_id,
    c.nome_completo AS cliente_nome,
 
    vdr.vendedor_id,
    vdr.nome_completo AS vendedor_nome,
    ve.veiculo_id,
    ve.marca AS veiculo_marca,
    ve.modelo AS veiculo_modelo,
    ve.ano AS veiculo_ano,

    v.preco,
    v.desconto,
    CASE 
      WHEN v.desconto > 0 THEN 'Sim'
      ELSE 'Não'
    END AS desconto_aplicado,
    v.preco_final,
    v.data_venda,
    year(v.data_venda) AS data_venda_ano,
    month(v.data_venda) AS data_venda_mes,
    
    CASE month(v.data_venda)
        WHEN 1 THEN 'January'
        WHEN 2 THEN 'February'
        WHEN 3 THEN 'March'
        WHEN 4 THEN 'April'
        WHEN 5 THEN 'May'
        WHEN 6 THEN 'June'
        WHEN 7 THEN 'July'
        WHEN 8 THEN 'August'
        WHEN 9 THEN 'September'
        WHEN 10 THEN 'October'
        WHEN 11 THEN 'November'
        WHEN 12 THEN 'December'
    END AS data_venda_nome_mes,
    
    CASE dayofweek(v.data_venda)
        WHEN 1 THEN 'Domingo'
        WHEN 2 THEN 'Segunda'
        WHEN 3 THEN 'Terça'
        WHEN 4 THEN 'Quarta'
        WHEN 5 THEN 'Quinta'
        WHEN 6 THEN 'Sexta'
        WHEN 7 THEN 'Sábado'
    END AS data_venda_dia_semana,
    
    day(v.data_venda) AS data_venda_dia,
    v.forma_pagamento,
    CURRENT_TIMESTAMP() AS ingestion_ts
FROM silver.enriched_vendas v
JOIN silver.enriched_clientes c ON v.cliente_id = c.cliente_id
JOIN silver.enriched_vendedores vdr ON v.vendedor_id = vdr.vendedor_id
JOIN silver.enriched_veiculos ve ON v.veiculo_id = ve.veiculo_id;
