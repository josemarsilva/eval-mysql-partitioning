CREATE TABLE tab_empresa (
  id INTEGER UNSIGNED NOT NULL,
  nome VARCHAR(100) NULL,
  PRIMARY KEY(id)
);

CREATE TABLE tab_cliente (
  id INTEGER UNSIGNED NOT NULL,
  nome VARCHAR(200) NULL,
  PRIMARY KEY(id)
);

CREATE TABLE tab_venda (
  id INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
  empresa_id INTEGER UNSIGNED NOT NULL,
  cliente_id INTEGER UNSIGNED NOT NULL,
  dt_emissao DATE NOT NULL,
  dt_periodo DATE NOT NULL,
  vlr_venda DECIMAL(10,2) NOT NULL,
  PRIMARY KEY(id),
  INDEX fk_clientes_vendas(cliente_id),
  INDEX fk_empresa_venda(empresa_id),
  INDEX idx_venda_emissao(dt_emissao),
  INDEX idx_venda_periodo(dt_periodo),
  FOREIGN KEY(cliente_id)
    REFERENCES tab_cliente(id)
      ON DELETE NO ACTION
      ON UPDATE NO ACTION,
  FOREIGN KEY(empresa_id)
    REFERENCES tab_empresa(id)
      ON DELETE NO ACTION
      ON UPDATE NO ACTION
);


CREATE TABLE tab_venda_part (
  id INTEGER UNSIGNED NOT NULL, -- LIMITATIONS: AUTO_INCREMENT CAN'T BE USED
  dt_periodo DATE NOT NULL,
  empresa_id INTEGER UNSIGNED NOT NULL,
  cliente_id INTEGER UNSIGNED NOT NULL,
  dt_emissao DATE NOT NULL,
  vlr_venda DECIMAL(10,2) NOT NULL,
  PRIMARY KEY(id,dt_periodo), -- LIMITATIONS: PRIMARY KEY MUST INCLUDE ALL PARTITIONS COLUMNS
  INDEX fk_cliente_venda_part(cliente_id),
  INDEX fk_empresa_venda_part(empresa_id),
  INDEX idx_venda_part_emissao(dt_emissao),
  INDEX idx_venda_part_periodo(dt_periodo)
  -- LIMITATIONS: FOREIGN KEY ARE NOT SUPPORTED
  -- FOREIGN KEY(cliente_id)
  --   REFERENCES tab_cliente(id)
  --     ON DELETE NO ACTION
  --     ON UPDATE NO ACTION,
  -- FOREIGN KEY(empresa_id)
  --   REFERENCES tab_empresa(id)
  --     ON DELETE NO ACTION
  --     ON UPDATE NO ACTION
)
PARTITION BY HASH( YEAR(dt_periodo) * 100 + MONTH(dt_periodo) )
PARTITIONS 120 -- 12 months x 10 years
;


CREATE TABLE tab_venda_part_cli (
  id INTEGER UNSIGNED NOT NULL, -- LIMITATIONS: AUTO_INCREMENT CAN'T BE USED
  dt_periodo DATE NOT NULL,
  empresa_id INTEGER UNSIGNED NOT NULL,
  cliente_id INTEGER UNSIGNED NOT NULL,
  dt_emissao DATE NOT NULL,
  vlr_venda DECIMAL(10,2) NOT NULL,
  PRIMARY KEY(id,cliente_id), -- LIMITATIONS: PRIMARY KEY MUST INCLUDE ALL PARTITIONS COLUMNS
  INDEX fk_cliente_venda_part(cliente_id),
  INDEX fk_empresa_venda_part(empresa_id),
  INDEX idx_venda_part_emissao(dt_emissao),
  INDEX idx_venda_part_periodo(dt_periodo)
  -- LIMITATIONS: FOREIGN KEY ARE NOT SUPPORTED
  -- FOREIGN KEY(cliente_id)
  --   REFERENCES tab_cliente(id)
  --     ON DELETE NO ACTION
  --     ON UPDATE NO ACTION,
  -- FOREIGN KEY(empresa_id)
  --   REFERENCES tab_empresa(id)
  --     ON DELETE NO ACTION
  --     ON UPDATE NO ACTION
)
PARTITION BY HASH( cliente_id )
PARTITIONS 2000
;



SHOW TABLES;
