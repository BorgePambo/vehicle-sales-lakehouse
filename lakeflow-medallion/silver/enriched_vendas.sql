CREATE OR REFRESH STREAMING TABLE silver.enriched_vendas
(
    CONSTRAINT valid_id EXPECT(venda_id IS NOT NULL) ON VIOLATION DROP ROW,
    CONSTRAINT valid_cliente EXPECT(cliente_id IS NOT NULL) ON VIOLATION DROP ROW,
    CONSTRAINT valid_vendedor EXPECT(vendedor_id IS NOT NULL) ON VIOLATION DROP ROW,
    CONSTRAINT valid_veiculo EXPECT(veiculo_id IS NOT NULL) ON VIOLATION DROP ROW
)
TBLPROPERTIES (
    quality = "silver"
)
AS
SELECT
    CAST(VendaID AS STRING) AS venda_id,
    CAST(ClienteID AS STRING) AS cliente_id,
    CAST(VeiculoID AS STRING) AS veiculo_id,
    CAST(VendedorID AS STRING) AS vendedor_id,
    CAST(DataVenda AS DATE) AS data_venda,
    CAST(Preco AS DECIMAL(10,2)) AS preco,
    CAST(Desconto AS DECIMAL(10,2)) AS desconto,
    CAST(PrecoFinal AS DECIMAL(10,2)) AS preco_final,
    INITCAP(FormaPagamento) AS forma_pagamento,
    CURRENT_TIMESTAMP() AS ingestion_ts
FROM STREAM bronze.vendas;
