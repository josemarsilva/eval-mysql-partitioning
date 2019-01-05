SELECT           'TABELA'              AS ITEM, 'tab_venda'                 AS VALOR
UNION ALL SELECT 'DISTINCT_ID'         AS ITEM, COUNT(DISTINCT ID )         AS VALOR FROM tab_venda
UNION ALL SELECT 'MIN_ID'              AS ITEM, MIN(id)                     AS VALOR FROM tab_venda
UNION ALL SELECT 'MAX_ID'              AS ITEM, MAX(id)                     AS VALOR FROM tab_venda
UNION ALL SELECT 'DISTINCT_EMPRESA_ID' AS ITEM, COUNT(DISTINCT empresa_id ) AS VALOR FROM tab_venda
UNION ALL SELECT 'MIN_EMPRESA_ID'      AS ITEM, MIN(empresa_id)             AS VALOR FROM tab_venda
UNION ALL SELECT 'MAX_EMPRESA_ID'      AS ITEM, MAX(empresa_id)             AS VALOR FROM tab_venda
UNION ALL SELECT 'DISTINCT_CLIENTE_ID' AS ITEM, COUNT(DISTINCT cliente_id ) AS VALOR FROM tab_venda
UNION ALL SELECT 'MIN_CLIENTE_ID'      AS ITEM, MIN(cliente_id)             AS VALOR FROM tab_venda
UNION ALL SELECT 'MAX_CLIENTE_ID'      AS ITEM, MAX(cliente_id)             AS VALOR FROM tab_venda
UNION ALL SELECT 'DISTINCT_DT_EMISSAO' AS ITEM, COUNT(DISTINCT dt_emissao ) AS VALOR FROM tab_venda
UNION ALL SELECT 'MIN_DT_EMISSAO'      AS ITEM, MIN(dt_emissao)             AS VALOR FROM tab_venda
UNION ALL SELECT 'MAX_DT_EMISSAO'      AS ITEM, MAX(dt_emissao)             AS VALOR FROM tab_venda
UNION ALL SELECT 'DISTINCT_DT_PERIODO' AS ITEM, COUNT(DISTINCT dt_periodo ) AS VALOR FROM tab_venda
UNION ALL SELECT 'MIN_DT_PERIODO'      AS ITEM, MIN(dt_periodo)             AS VALOR FROM tab_venda
UNION ALL SELECT 'MAX_DT_PERIODO'      AS ITEM, MAX(dt_periodo)             AS VALOR FROM tab_venda
;
