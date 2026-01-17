CREATE OR REFRESH STREAMING TABLE bronze.clientes
COMMENT "Dados da camada Bronze"
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
    "/Volumes/autoprime/default/raw/datasets/clientes/",
    FORMAT => "csv",
    HEADER => true
);
