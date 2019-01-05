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
  id INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
  dt_periodo DATE NULL,
  empresa_id INTEGER UNSIGNED NOT NULL,
  cliente_id INTEGER UNSIGNED NOT NULL,
  dt_emissao DATE NOT NULL,
  vlr_venda DECIMAL(10,2) NOT NULL,
  PRIMARY KEY(id),
  INDEX fk_cliente_venda_part(cliente_id),
  INDEX fk_empresa_venda_part(empresa_id),
  INDEX idx_venda_part_emissao(dt_emissao),
  INDEX idx_venda_part_periodo(dt_periodo),
  FOREIGN KEY(cliente_id)
    REFERENCES tab_cliente(id)
      ON DELETE NO ACTION
      ON UPDATE NO ACTION,
  FOREIGN KEY(empresa_id)
    REFERENCES tab_empresa(id)
      ON DELETE NO ACTION
      ON UPDATE NO ACTION
);

SHOW TABLES;
