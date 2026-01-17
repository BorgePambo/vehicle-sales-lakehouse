CREATE OR REFRESH STREAMING TABLE silver.enriched_vendedores
(
    CONSTRAINT valid_id EXPECT(vendedor_id IS NOT NULL) ON VIOLATION DROP ROW,
    CONSTRAINT valid_name EXPECT(nome_completo IS NOT NULL) ON VIOLATION DROP ROW
)
TBLPROPERTIES (
    quality = "silver"
)
AS
SELECT
    CAST(VendedorID AS STRING) AS vendedor_id,
    INITCAP(TRIM(VendedorNome)) AS nome_completo,
    CAST(Telefone AS STRING) AS telefone,
    CASE
        WHEN Email LIKE '%@%.%' THEN Email
        ELSE NULL
    END AS email,
    CURRENT_TIMESTAMP() AS ingestion_ts
FROM STREAM bronze.vendedores;
