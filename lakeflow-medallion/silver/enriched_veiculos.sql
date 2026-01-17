CREATE OR REFRESH STREAMING TABLE silver.enriched_veiculos
(
    CONSTRAINT valid_id EXPECT(veiculo_id IS NOT NULL) ON VIOLATION DROP ROW,
    CONSTRAINT valid_marca EXPECT(marca IS NOT NULL) ON VIOLATION DROP ROW,
    CONSTRAINT valid_modelo EXPECT(modelo IS NOT NULL) ON VIOLATION DROP ROW
)
TBLPROPERTIES (
    quality = "silver"
)
AS
SELECT
   CAST(VeiculoID AS STRING) AS veiculo_id,
   INITCAP(Marca) AS marca,
   INITCAP(Modelo) AS modelo,
   CAST(Ano AS INTEGER) AS ano,
   CAST(PrecoBase AS DECIMAL(10,2)) AS preco_base,
   CURRENT_TIMESTAMP() AS ingestion_ts
FROM STREAM bronze.veiculos;
