DELETE FROM `verdes_conflitantes`;
DELETE FROM `tabela_entre_verdes_transicao`;
DELETE FROM `atrasos_de_grupos`;
DELETE FROM `transicoes`;
DELETE FROM `transicoes_proibidas`;
DELETE FROM `detectores`;
DELETE FROM `grupos_semaforicos_planos`;
DELETE FROM `estagios_grupos_semaforicos`;
DELETE FROM `estagios_planos`;
DELETE FROM `planos`;
DELETE FROM `estagios`;
DELETE FROM `tabela_entre_verdes`;
DELETE FROM `grupos_semaforicos`;
DELETE FROM `enderecos`;
DELETE FROM `versoes_planos`;
DELETE FROM `agrupamentos_aneis`;
DELETE FROM `aneis`;
DELETE FROM `versoes_controladores`;
DELETE FROM `controladores_fisicos`;
DELETE FROM `controladores`;
DELETE FROM `agrupamentos`;
DELETE FROM `limite_area`;
DELETE FROM `areas`;
DELETE FROM `cidades`;
DELETE FROM `modelo_controladores`;
DELETE FROM `fabricantes`;
DELETE FROM `imagens`;
DELETE FROM `faixas_de_valores`;

SET @CidadeId = RANDOM_UUID();
INSERT INTO `cidades` (`id`, `nome`, `data_criacao`, `data_atualizacao`) VALUES (@CidadeId, 'São Paulo', NOW(), NOW());
INSERT INTO `cidades` (`id`, `nome`, `data_criacao`, `data_atualizacao`) VALUES (RANDOM_UUID(), 'Belo Horizonte', NOW(), NOW());
INSERT INTO `areas` (`id`, `id_json`, `descricao`, `cidade_id`, `data_criacao`, `data_atualizacao`) VALUES (RANDOM_UUID(), RANDOM_UUID(), 51, @CidadeId, NOW(), NOW());
