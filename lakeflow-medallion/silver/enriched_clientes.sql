CREATE OR REFRESH STREAMING TABLE silver.enriched_clientes
(
    CONSTRAINT valid_id EXPECT(cliente_id IS NOT NULL) ON VIOLATION DROP ROW,
    CONSTRAINT valid_name EXPECT(nome_completo IS NOT NULL) ON VIOLATION DROP ROW
)
TBLPROPERTIES (
    quality = "silver"
)
AS
SELECT
    CAST(ClienteID AS STRING) AS cliente_id,
    INITCAP(TRIM(ClienteNome)) AS nome_completo,
    CAST(Telefone AS STRING) AS telefone,
    CASE
        WHEN Email LIKE '%@%.%' THEN Email
        ELSE NULL
    END AS email,
    CURRENT_TIMESTAMP() AS ingestion_ts
FROM STREAM bronze.clientes;
