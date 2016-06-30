SET @CidadeId = UUID();
INSERT INTO `influuntdev`.`cidades` (`id`, `nome`, `data_criacao`, `data_atualizacao`) VALUES (@CidadeId, 'São Paulo', NOW(), NOW());
INSERT INTO `influuntdev`.`areas` (`id`, `localizacao`, `cidade_id`, `data_criacao`, `data_atualizacao`) VALUES (UUID(), 51, @CidadeId, NOW(), NOW());
SET @FabricanteId = UUID();
INSERT INTO `influuntdev`.`fabricantes` (`id`, `nome`, `data_criacao`, `data_atualizacao`) VALUES (@FabricanteId, 'Raro Labs', NOW(), NOW());
SET @ConfiguracaoId = UUID();
INSERT INTO `influuntdev`.`configuracao_controladores` (`id`, `localizacao`, `limite_estagio`, `limite_grupo_semaforico`, `limite_anel`, `limite_detector_pedestre`, `limite_detector_veicular`, `data_criacao`, `data_atualizacao`) VALUES (@ConfiguracaoId, 'DESC', '5', '5', '5', '5', '5', NOW(), NOW());
INSERT INTO `influuntdev`.`modelo_controladores` (`id`, `localizacao`, `fabricante_id`, `configuracao_id`, `data_criacao`, `data_atualizacao`) VALUES (UUID(), 'Desc modelo', @FabricanteId, @ConfiguracaoId, NOW(), NOW());
INSERT INTO `influuntdev`.`usuarios` (`login`,`senha`, `email`, `nome`, `root`, `data_criacao`, `data_atualizacao`) VALUES ('root', '$2a$10$EzudGIqkxquJjLGawuMrOu9K6S28yc/R/YSAVxsvb5bSryOYWd5eq', 'root@influunt.com.br','Administrador Geral', 'true', NOW(), NOW());