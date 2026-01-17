CREATE OR REPLACE MATERIALIZED VIEW gold.performance_forma_pagamento
COMMENT 'Resumo de performance de vendas por forma de pagamento, incluindo volume, faturamento, ticket médio e valores máximo e mínimo.'
AS
SELECT
    forma_pagamento,
    COUNT(venda_id) AS total_vendas,
    SUM(preco_final) AS total_faturamento,
    ROUND(AVG(preco_final), 2) AS ticket_medio,
    MAX(preco_final) AS max_preco,
    MIN(preco_final) AS min_preco
FROM silver.fato_vendas
GROUP BY forma_pagamento;
