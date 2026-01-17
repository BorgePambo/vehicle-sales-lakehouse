CREATE STREAMING TABLE bronze.veiculos
COMMENT "Dados da camada Bronze - Veículos"
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
    "/Volumes/autoprime/default/raw/datasets/veiculos/",
    FORMAT => "csv",
    HEADER => true
);
