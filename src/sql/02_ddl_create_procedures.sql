DROP PROCEDURE IF EXISTS carga_inicial_dados_tabela;

DELIMITER $$
CREATE PROCEDURE carga_inicial_dados_tabela ()
BEGIN
  --
  -- Declare ...
  --
  DECLARE v_index               INT UNSIGNED DEFAULT 0;
  DECLARE v_empresa_id          INT UNSIGNED DEFAULT 1;
  DECLARE v_cliente_id          INT UNSIGNED DEFAULT 1;
  DECLARE v_max_cliente         INT UNSIGNED DEFAULT 1000;
  DECLARE v_max_venda           INT UNSIGNED DEFAULT 10000000; -- 10.000.000
  DECLARE v_max_commit_interval INT UNSIGNED DEFAULT 1000; -- 1.000
  DECLARE v_min_dt_emissao      DATE;
  DECLARE v_max_dias_dt_emissao INT UNSIGNED DEFAULT 1; 
  DECLARE v_dt_emissao          DATE;
  DECLARE v_dt_periodo          DATE;
  --
  -- Initialize ...
  --
  SELECT STR_TO_DATE('1,1,2010','%d,%m,%Y') INTO v_min_dt_emissao; -- dt_emissao starts with 2010-01-01 ...
  SELECT DATEDIFF( CURDATE(), v_min_dt_emissao) INTO v_max_dias_dt_emissao;
  --
  -- 1. Truncate/Delete all ...
  --
  TRUNCATE TABLE tab_venda;
  --
  DELETE FROM tab_empresa;
  --
  DELETE FROM tab_cliente;
  --
  COMMIT;
  --
  -- 2. tab_empresa 
  --
  INSERT INTO tab_empresa( id, nome )
  VALUES ( 1, 'Empresa 1' );
  --
  INSERT INTO tab_empresa( id, nome )
  VALUES ( 2, 'Empresa 2' );
  --
  COMMIT;
  --
  -- 3. tab_cliente
  --
  SET v_index=0;
  cliente_loop: LOOP
    --
    SET v_index=v_index+1;
    IF v_index > v_max_cliente THEN
      LEAVE cliente_loop;
    END IF;
    --
    INSERT INTO tab_cliente( id, nome )
    VALUES ( v_index, CONCAT('Cliente ', v_index) );
    --
  END LOOP cliente_loop;
  --
  COMMIT;
  --
  -- 4. tab_venda
  --
  SET v_index=0;
  venda_loop: LOOP
    --
    SET v_index=v_index+1;
    IF v_index > v_max_venda THEN
      LEAVE venda_loop;
    END IF;
    --
	-- 95% dos registros para empresa_id = 1; 5% dos registros para empresa_id = 2;
	--
    SET v_empresa_id = 1; -- 95%
	IF (v_index % 100) = 5 THEN
       SET v_empresa_id = 2; -- 5%
    END IF;
	--
	-- Distribuicao (normal) das vendas entre todos os clientes
	--
	SET v_cliente_id = (v_index % v_max_cliente) + 1 ;
	--
	-- Distribuicao (normal) das vendas entre todos as datas de emissao
	--
    SELECT DATE_ADD( v_min_dt_emissao, INTERVAL ( v_index % v_max_dias_dt_emissao) DAY) INTO v_dt_emissao;
	SELECT DATE_ADD(v_dt_emissao,interval -DAY(v_dt_emissao)+1 DAY) INTO v_dt_periodo;
    --
	-- SELECT 'DEBUG', v_empresa_id, v_cliente_id, v_dt_emissao, v_dt_emissao, v_dt_periodo, 1 ;
	--
    INSERT INTO tab_venda( empresa_id, cliente_id, dt_emissao, dt_periodo, vlr_venda )
    VALUES ( v_empresa_id, v_cliente_id, v_dt_emissao, v_dt_periodo, 1 );
    --
    -- Commit interval  ...
    --
    IF ( v_index % v_max_commit_interval ) = 0 THEN
      COMMIT;
    END IF;
    --
  END LOOP venda_loop;
  --
  COMMIT;
  --  
END $$
DELIMITER ;
