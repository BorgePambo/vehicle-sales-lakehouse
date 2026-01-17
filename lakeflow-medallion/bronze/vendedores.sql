CREATE OR REFRESH STREAMING TABLE bronze.vendedores
COMMENT "Dados da camada Bronze - Vendedores"
TBLPROPERTIES (
    quality = "bronze",
    enabledChangeCapture = true
)
AS
SELECT 
    *,
     _metadata.file_modification_time AS file_mod_ts,
    current_timestamp() AS ingestion_ts
FROM STREAM READ_FILES(
    "/Volumes/autoprime/default/raw/datasets/vendedores/",
    FORMAT => "csv",
    HEADER => true
);
