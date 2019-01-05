INSERT INTO tab_venda_part 
(id, empresa_id, cliente_id, dt_emissao, dt_periodo, vlr_venda )
SELECT id, empresa_id, cliente_id, dt_emissao, dt_periodo, vlr_venda 
FROM   tab_venda ;
