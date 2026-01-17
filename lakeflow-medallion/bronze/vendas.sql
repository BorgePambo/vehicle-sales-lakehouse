CREATE STREAMING TABLE bronze.vendas
COMMENT "Dados de venda"
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
    "/Volumes/autoprime/default/raw/datasets/vendas/",
    FORMAT => "csv",
    HEADER => true
);
