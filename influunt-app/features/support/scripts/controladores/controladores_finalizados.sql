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
DELETE FROM `eventos`;
UPDATE `versoes_tabelas_horarias` SET tabela_horaria_origem_id = NULL;
DELETE FROM `tabela_horarios`;
DELETE FROM `versoes_tabelas_horarias`;
DELETE FROM `versoes_planos`;
DELETE FROM `agrupamentos_aneis`;
DELETE FROM `aneis`;
DELETE FROM `versoes_controladores`;
DELETE FROM `controladores_fisicos`;
DELETE FROM `controladores`;
DELETE FROM `agrupamentos`;
DELETE FROM `limite_area`;
UPDATE usuarios SET area_id=NULL WHERE login='mobilab';
DELETE FROM `subareas`;
DELETE FROM `areas`;
DELETE FROM `cidades`;
DELETE FROM `modelo_controladores`;
DELETE FROM `fabricantes`;
DELETE FROM `imagens`;
DELETE FROM `faixas_de_valores`;

SET @UsuarioId = (SELECT id FROM "usuarios" where login = 'mobilab');

SET @ModeloId = RANDOM_UUID();
SET @Controlador1Id = RANDOM_UUID();
SET @Controlador2Id = RANDOM_UUID();
SET @Controlador3Id = RANDOM_UUID();
SET @Controlador4Id = RANDOM_UUID();
SET @ControladorFisico1Id = RANDOM_UUID();
SET @ControladorFisico2Id = RANDOM_UUID();
SET @ControladorFisico3Id = RANDOM_UUID();
SET @ControladorFisico4Id = RANDOM_UUID();
SET @VersaoControlador1Id = RANDOM_UUID();
SET @VersaoControlador2Id = RANDOM_UUID();
SET @VersaoControlador3Id = RANDOM_UUID();
SET @VersaoControlador4Id = RANDOM_UUID();
SET @Croqui1Id = RANDOM_UUID();
SET @Croqui2Id = RANDOM_UUID();
SET @Croqui3Id = RANDOM_UUID();
SET @Croqui4Id = RANDOM_UUID();

SET @AnelID1 = RANDOM_UUID();
SET @AnelID1 = RANDOM_UUID();
SET @AnelID1 = RANDOM_UUID();
SET @AnelID1 = RANDOM_UUID();
SET @AnelID1 = RANDOM_UUID();
SET @AnelID1 = RANDOM_UUID();
SET @AnelID1 = RANDOM_UUID();
SET @AnelID1 = RANDOM_UUID();
SET @AnelID1 = RANDOM_UUID();
SET @AnelID1 = RANDOM_UUID();
SET @AnelID1 = RANDOM_UUID();

SET @CidadeId  = RANDOM_UUID();

INSERT INTO `cidades` (`id`, `id_json`, `nome`, `data_criacao`, `data_atualizacao`)
VALUES
  (@CidadeId,'0234b1e6-a5a3-11e6-b546-a174608784fe','São Paulo','2016-11-08 09:03:41.000000','2016-11-08 09:03:41.000000');

SET @Area1Id   = RANDOM_UUID();
SET @Area2Id   = RANDOM_UUID();
SET @Area3Id   = RANDOM_UUID();

INSERT INTO `areas` (`id`, `id_json`, `descricao`, `cidade_id`, `data_criacao`, `data_atualizacao`)
VALUES
  (@Area1Id,RANDOM_UUID(),1,@CidadeId, NOW(),NOW()),
  (@Area2Id,RANDOM_UUID(),2,@CidadeId, NOW(),NOW()),
  (@Area3Id,RANDOM_UUID(),3,@CidadeId, NOW(),NOW());

UPDATE usuarios SET area_id=@Area1Id WHERE login='mobilab';

SET @FaixaValoresId   = RANDOM_UUID();
INSERT INTO `faixas_de_valores` (`id`, `id_json`, `tempo_defasagem_min`, `tempo_defasagem_max`, `tempo_amarelo_min`, `tempo_amarelo_max`, `tempo_vermelho_intermitente_min`, `tempo_vermelho_intermitente_max`, `tempo_vermelho_limpeza_veicular_min`, `tempo_vermelho_limpeza_veicular_max`, `tempo_vermelho_limpeza_pedestre_min`, `tempo_vermelho_limpeza_pedestre_max`, `tempo_atraso_grupo_min`, `tempo_atraso_grupo_max`, `tempo_verde_seguranca_veicular_min`, `tempo_verde_seguranca_veicular_max`, `tempo_verde_seguranca_pedestre_min`, `tempo_verde_seguranca_pedestre_max`, `tempo_maximo_permanencia_estagio_min`, `tempo_maximo_permanencia_estagio_max`, `default_tempo_maximo_permanencia_estagio_veicular`, `tempo_ciclo_min`, `tempo_ciclo_max`, `tempo_verde_minimo_min`, `tempo_verde_minimo_max`, `tempo_verde_maximo_min`, `tempo_verde_maximo_max`, `tempo_verde_intermediario_min`, `tempo_verde_intermediario_max`, `tempo_extensao_verde_min`, `tempo_extensao_verde_max`, `tempo_verde_min`, `tempo_verde_max`, `tempo_ausencia_deteccao_min`, `tempo_ausencia_deteccao_max`, `tempo_deteccao_permanente_min`, `tempo_deteccao_permanente_max`, `data_criacao`, `data_atualizacao`)
VALUES
  (@FaixaValoresId,RANDOM_UUID(),0,255,3,5,3,32,0,7,0,5,0,20,10,30,4,10,60,255,127,30,255,10,255,10,255,10,255,1,10,1,255,0,4320,0,1440,NOW(),NOW());

SET @SubareaId   = RANDOM_UUID();
INSERT INTO `subareas` (`id`, `id_json`, `nome`, `numero`, `area_id`, `data_criacao`, `data_atualizacao`)
VALUES
  (@SubareaId,RANDOM_UUID(),'AREA SUL PAULISTA',3,@Area3Id,NOW(),NOW());

SET @FabricanteId = RANDOM_UUID();
INSERT INTO `fabricantes` (`id`, `id_json`, `nome`, `data_criacao`, `data_atualizacao`)
VALUES
  (@FabricanteId,RANDOM_UUID(),'Raro Labs',NOW(),NOW());

INSERT INTO `modelo_controladores` (`id`, `id_json`, `fabricante_id`, `descricao`, `limite_estagio`, `limite_grupo_semaforico`, `limite_anel`, `limite_detector_pedestre`, `limite_detector_veicular`, `limite_tabelas_entre_verdes`, `limite_planos`, `data_criacao`, `data_atualizacao`)
VALUES
  ('0244027c-a5a3-11e6-b546-a174608784fe','02440290-a5a3-11e6-b546-a174608784fe',@FabricanteId,'Modelo Básico',16,16,4,4,8,2,16,'2016-11-08 09:03:41.000000','2016-11-08 09:03:41.000000');

  INSERT INTO `imagens` (`id`, `id_json`, `filename`, `content_type`, `data_criacao`, `data_atualizacao`)
VALUES
  ('058fe586-0a37-4771-9c85-bf0c1f73362c','995b99bf-2ab4-4b20-8089-3145d0b432cd','anel2estagio1.jpeg','image/jpeg','2016-11-08 09:19:45.589000','2016-11-08 09:19:45.589000'),
  ('09b7de25-d15b-4e5b-a537-560aaaa05b13','55a8588e-d70a-4a81-9869-62341d0fcbfc','anel1estagio4.jpeg','image/jpeg','2016-11-08 09:54:07.057000','2016-11-08 09:54:07.057000'),
  ('107a2f46-fb3b-4a6c-addb-793bf60857e6','4b6860ec-ecd8-4957-b717-fc23105a8340','anel2estagio2.jpeg','image/jpeg','2016-11-08 09:50:08.305000','2016-11-08 09:50:08.305000'),
  ('13af6f44-b26b-4183-a625-94c3fea97f80','0f75fb9e-96b5-4f91-83c8-fe56b2f463d8','anel1estagio3.jpeg','image/jpeg','2016-11-08 09:19:19.423000','2016-11-08 09:19:19.423000'),
  ('1530387b-8896-4c25-841b-18431d8c9886','29a9af3e-63c1-4c8c-9a2b-b9fbbca67c99','anel2estagio2.jpeg','image/jpeg','2016-11-08 09:06:22.083000','2016-11-08 09:06:22.083000'),
  ('178ddea6-c78c-4f20-a448-9f68bbc2e746','270ba9d1-6ea1-4214-ac6e-b1c0ca7af037','anel1estagio3.jpeg','image/jpeg','2016-11-08 09:10:46.419000','2016-11-08 09:10:46.419000'),
  ('1d130042-3a38-421e-a271-4666b91c57c2','df603b4e-a1e1-4631-bde7-979837169315','anel2estagio2.jpeg','image/jpeg','2016-11-08 09:50:13.087000','2016-11-08 09:50:13.087000'),
  ('2c304945-0582-4bd3-8bb2-1063b58684ae','04cc29d3-21b5-45c9-927a-7f0d74c955f6','anel2estagio3.jpeg','image/jpeg','2016-11-08 09:05:26.836000','2016-11-08 09:05:26.836000'),
  ('2e791b3f-80a1-4e4b-9405-1a5383113bb6','7dbe59c3-262d-4740-8885-200de9b3cf4e','anel2estagio4.jpeg','image/jpeg','2016-11-08 09:19:45.596000','2016-11-08 09:19:45.596000'),
  ('2ebf5fdd-52e4-4aa0-9fb2-94b63d2bc87c','55a8588e-d70a-4a81-9869-62341d0fcbfc','anel1estagio4.jpeg','image/jpeg','2016-11-08 09:19:19.426000','2016-11-08 09:19:19.426000'),
  ('38361809-df71-41ec-9a5c-bb25df5ddb39','d6ac46b3-f8f2-4eab-840c-06903c270713','anel2estagio2.jpeg','image/jpeg','2016-11-08 10:21:45.964000','2016-11-08 10:21:45.964000'),
  ('3aa84dbb-b01e-47b1-8956-999dac3a2673','69d1e1b7-321a-40c7-b18f-4c57ed4b6ab9','anel2estagio2.jpeg','image/jpeg','2016-11-08 09:19:45.586000','2016-11-08 09:19:45.586000'),
  ('53364e61-7b9f-48c4-839a-56ddc00cee43','06d55c22-ff67-4f28-bfc7-a8679943babc','anel2estagio4.jpeg','image/jpeg','2016-11-08 10:21:45.964000','2016-11-08 10:21:45.964000'),
  ('76cca405-fce7-4fee-9db7-259103c9f666','5ca2edc6-b1b2-4a88-b279-c87bb3b9c18a','anel2estagio4.jpeg','image/jpeg','2016-11-08 09:06:22.084000','2016-11-08 09:06:22.084000'),
  ('82bf10f2-bc0a-4957-a628-f7ad6ed2120f','995b99bf-2ab4-4b20-8089-3145d0b432cd','anel2estagio1.jpeg','image/jpeg','2016-11-08 09:54:06.936000','2016-11-08 09:54:06.936000'),
  ('86e4cce7-2d66-4af6-8809-5e13e899554e','6d6c2ef3-3f92-4918-9123-bb0108bda1e2','anel2estagio4.jpeg','image/jpeg','2016-11-08 09:50:13.087000','2016-11-08 09:50:13.087000'),
  ('92cbcc7a-6825-41d2-a6f1-609553c6c066','0bb8abad-5305-470f-aefa-5d9fe6800062','anel1estagio4.jpeg','image/jpeg','2016-11-08 09:10:53.960000','2016-11-08 09:10:53.960000'),
  ('97091a81-95a4-4f4f-8bfb-5f3cc6ad861b','891dafa0-6a3d-4746-aca6-ab9808e7b86f','anel2estagio2.jpeg','image/jpeg','2016-11-08 10:21:51.776000','2016-11-08 10:21:51.776000'),
  ('977afcbf-9130-4e5b-ba17-e4c3c3449652','68a745af-9e20-4eb2-8e3e-f588b279fd45','anel2estagio3.jpeg','image/jpeg','2016-11-08 09:54:06.803000','2016-11-08 09:54:06.803000'),
  ('97aaa01a-ebbf-4144-bad3-67fa7bba8078','56885beb-0d60-440c-9d85-b3cbdca9a4ad','anel2estagio1.jpeg','image/jpeg','2016-11-08 09:10:53.949000','2016-11-08 09:10:53.949000'),
  ('9cad89fe-096e-4e21-b2f3-e98c00fb155d','69d1e1b7-321a-40c7-b18f-4c57ed4b6ab9','anel2estagio2.jpeg','image/jpeg','2016-11-08 09:54:06.725000','2016-11-08 09:54:06.725000'),
  ('a5bdf0c8-4676-4f27-8d51-753ebbf411bb','b9543030-04f3-4633-af66-eaad3c9250f9','anel1estagio2.jpeg','image/jpeg','2016-11-08 09:54:07.167000','2016-11-08 09:54:07.167000'),
  ('b04b8874-dd41-4da8-b981-5e7a7059e7f3','68a745af-9e20-4eb2-8e3e-f588b279fd45','anel2estagio3.jpeg','image/jpeg','2016-11-08 09:19:45.578000','2016-11-08 09:19:45.578000'),
  ('b31f5a13-48cc-4946-9551-cf9bd8421d6b','3d4937d6-1f15-4fb7-9eac-5dd2bd94681d','anel2estagio3.jpeg','image/jpeg','2016-11-08 10:21:51.775000','2016-11-08 10:21:51.775000'),
  ('ce3b6f75-7ce8-4258-b1b5-6552a271aa5d','b29ba77a-65e2-4315-96b4-1ec75884475e','anel2estagio4.jpeg','image/jpeg','2016-11-08 09:50:08.304000','2016-11-08 09:50:08.304000'),
  ('d088d448-d998-44f3-b04a-21a7f1901f4e','0f75fb9e-96b5-4f91-83c8-fe56b2f463d8','anel1estagio3.jpeg','image/jpeg','2016-11-08 09:54:07.112000','2016-11-08 09:54:07.112000'),
  ('d8bd88c8-ba62-4050-8380-c87a62cfbab3','b9543030-04f3-4633-af66-eaad3c9250f9','anel1estagio2.jpeg','image/jpeg','2016-11-08 09:19:19.423000','2016-11-08 09:19:19.423000'),
  ('e5af5ddd-d752-4912-9b58-c4ad197bbd46','ecb67bd8-5297-44fb-8048-c758a0327253','anel1estagio4.jpeg','image/jpeg','2016-11-08 09:54:06.995000','2016-11-08 09:54:06.995000'),
  ('ec4d0742-a53d-49e9-b167-d6d55231f7f4','ecb67bd8-5297-44fb-8048-c758a0327253','anel1estagio4.jpeg','image/jpeg','2016-11-08 09:19:45.595000','2016-11-08 09:19:45.595000'),
  ('ecfa4c5b-43f4-484a-9f30-5e92ba27fedd','81908621-f926-496d-8d23-aba332919f52','anel1estagio2.jpeg','image/jpeg','2016-11-08 09:10:46.422000','2016-11-08 09:10:46.422000'),
  ('f6b49750-eb6e-4e40-b1ea-e9d7126448d8','ad0f8a4b-4751-4ed1-9c6d-259bfd88de77','anel2estagio4.jpeg','image/jpeg','2016-11-08 09:05:26.836000','2016-11-08 09:05:26.836000'),
  ('f8826ec3-1f1b-4b88-a779-f5db793ce5c3','d5ab752d-7f38-48c0-9bb1-e1257d3cd98b','anel2estagio2.jpeg','image/jpeg','2016-11-08 09:05:26.836000','2016-11-08 09:05:26.836000'),
  ('fc1f166f-55a6-44c1-a817-07a8e33ac042','7dbe59c3-262d-4740-8885-200de9b3cf4e','anel2estagio4.jpeg','image/jpeg','2016-11-08 09:54:06.876000','2016-11-08 09:54:06.876000');

------------------- Controladores ----------------------------

INSERT INTO `controladores` (`id`, `id_json`, `nome_endereco`, `sequencia`, `numero_smee`, `numero_smeeconjugado1`, `numero_smeeconjugado2`, `numero_smeeconjugado3`, `firmware`, `croqui_id`, `modelo_id`, `area_id`, `subarea_id`, `bloqueado`, `planos_bloqueado`, `data_criacao`, `data_atualizacao`)
VALUES
  ('0f424143-383e-490d-96ef-145fed18bb29',NULL,'R. Maria Figueiredo, nº -4',1,'3','1','2','3','ffff',NULL,'0244027c-a5a3-11e6-b546-a174608784fe',@Area2Id,NULL,0,0,'2016-11-08 09:19:08.777000','2016-11-08 09:33:01.639000'),
  ('9dccd9b1-8837-43d0-8f5b-bb4b169fdc9e',NULL,'R. Maria Figueiredo, nº -4',1,'3','1','2','3','ffff',NULL,'0244027c-a5a3-11e6-b546-a174608784fe',@Area2Id,NULL,0,0,'2016-11-08 09:54:07.221000','2016-11-08 09:54:08.028000'),
  ('1dccd9b1-8837-43d0-8f5b-bb4b169fdc9d',NULL,'R. Maria Figueiredo, nº -4',1,'3','1','2','3','ffff',NULL,'0244027c-a5a3-11e6-b546-a174608784fe',@Area2Id,NULL,0,0,'2016-11-08 09:54:07.221000','2016-11-08 09:54:08.028000'),
  ('279d3e6e-b3ab-4e9f-8358-67e393e5ed0f',NULL,'Av. Paulista, nº 1000. ref.: AREA 1',2,'2','1','2','3',NULL,NULL,'0244027c-a5a3-11e6-b546-a174608784fe',@Area1Id,NULL,0,0,'2016-11-08 09:10:36.924000','2016-11-08 09:16:47.343000'),
  ('3d86335e-05e7-4921-8cdf-42ed03821f62',NULL,'R. Maria Figueiredo com Av. Paulista',3,'3',NULL,NULL,NULL,NULL,NULL,'0244027c-a5a3-11e6-b546-a174608784fe',@Area1Id,NULL,0,0,'2016-11-08 10:21:26.853000','2016-11-08 10:32:52.105000'),
  ('5d238555-8620-4841-a2bf-c77d497f6b03',NULL,'Av. Paulista com R. Pamplona',1,'123','1','2','3','FIRM',NULL,'0244027c-a5a3-11e6-b546-a174608784fe',@Area1Id,NULL,0,0,'2016-11-08 09:05:11.494000','2016-11-08 09:09:03.537000'),
  ('8d872244-c7c9-4ff6-9239-f207c2773787',NULL,'R. Maria Figueiredo com Av. Paulista',1,'4',NULL,NULL,NULL,NULL,NULL,'0244027c-a5a3-11e6-b546-a174608784fe',@Area3Id,@SubareaId,0,0,'2016-11-08 09:50:02.855000','2016-11-08 09:51:40.803000');

INSERT INTO `aneis` (`id`, `id_json`, `ativo`, `descricao`, `posicao`, `numero_smee`, `controlador_id`, `croqui_id`, `data_criacao`, `data_atualizacao`, `aceita_modo_manual`)
VALUES
  ('043007e5-ee02-4383-bde1-87346abdc895','98dadb0d-7b5f-44ec-b78b-f3eced6faa7e',1,NULL,2,NULL,'3d86335e-05e7-4921-8cdf-42ed03821f62',NULL,'2016-11-08 10:21:26.856000','2016-11-08 10:32:52.107000',1),
  ('1b53a2ea-fbdc-4696-b9cf-565ed2eafbfe','2d3c97ae-314d-4710-ad9e-4d0271788e19',0,NULL,4,NULL,'1dccd9b1-8837-43d0-8f5b-bb4b169fdc9d',NULL,'2016-11-08 09:54:07.239000','2016-11-08 09:54:07.239000',1),
  ('22eb55d2-c56f-4037-a9d7-166d829438a4','c796724f-96f5-4dca-b918-e2b02fbae526',1,NULL,2,NULL,'8d872244-c7c9-4ff6-9239-f207c2773787',NULL,'2016-11-08 09:50:02.859000','2016-11-08 09:51:40.817000',1),
  ('33e2bbf0-72ad-4d11-98d8-1bb440c370b0','c5df630e-bedb-4dc4-bc03-5b0d3719cc94',1,NULL,2,NULL,'5d238555-8620-4841-a2bf-c77d497f6b03',NULL,'2016-11-08 09:05:11.551000','2016-11-08 09:09:03.579000',1),
  ('4744f9d9-f9c3-4f3f-ab1c-17b7178453d5','a69ac428-e5d9-4afb-8170-43e48292cbff',1,NULL,1,'123','5d238555-8620-4841-a2bf-c77d497f6b03',NULL,'2016-11-08 09:05:11.550000','2016-11-08 09:09:03.539000',1),
  ('5033f1e1-3840-4a01-a69b-ea6815ac33fa','a95368c7-f1e8-4bd7-8050-9eb14f6e0ab6',1,NULL,1,'3','1dccd9b1-8837-43d0-8f5b-bb4b169fdc9d',NULL,'2016-11-08 09:54:07.233000','2016-11-08 09:54:07.233000',1),
  ('56f26b09-4bf1-4dfd-b014-eb39880ed45a','9ea990f7-51aa-4133-821a-e415a38cb50c',1,NULL,2,NULL,'0f424143-383e-490d-96ef-145fed18bb29',NULL,'2016-11-08 09:19:08.779000','2016-11-08 09:33:01.672000',1),
  ('5a49e2de-327d-4288-ad54-0f0cb07a0a86','63ea875e-da0b-443d-941f-329b6e3d43fc',0,NULL,4,NULL,'8d872244-c7c9-4ff6-9239-f207c2773787',NULL,'2016-11-08 09:50:02.861000','2016-11-08 09:51:40.832000',1),
  ('5b62e38d-4b08-4db5-ae2c-36deba45551d','00824261-c094-4088-9155-8e4952c74865',0,NULL,3,NULL,'279d3e6e-b3ab-4e9f-8358-67e393e5ed0f',NULL,'2016-11-08 09:10:36.928000','2016-11-08 09:16:47.390000',1),
  ('5e913606-1f79-42db-bafd-a86b14a5c64c','9ea990f7-51aa-4133-821a-e415a38cb50c',1,NULL,2,NULL,'1dccd9b1-8837-43d0-8f5b-bb4b169fdc9d',NULL,'2016-11-08 09:54:07.222000','2016-11-08 09:54:07.222000',1),
  ('6c709913-6812-41d9-94a6-e36ee55e3b9c','4cc5a517-cec3-4aa0-bb9d-709ab16e36a2',1,NULL,2,NULL,'279d3e6e-b3ab-4e9f-8358-67e393e5ed0f',NULL,'2016-11-08 09:10:36.928000','2016-11-08 09:16:47.370000',0),
  ('7012415b-6892-4498-b0bd-cb3fa2ad093c','57c1aa68-935d-4f63-a2f5-d98f12fe4662',1,NULL,1,'4','8d872244-c7c9-4ff6-9239-f207c2773787',NULL,'2016-11-08 09:50:02.858000','2016-11-08 09:51:40.805000',1),
  ('70d364b0-6f7c-4f04-96e8-853a49ccd7f2','5df4ff05-3d83-4831-bfad-831480576e40',1,NULL,1,'-','3d86335e-05e7-4921-8cdf-42ed03821f62',NULL,'2016-11-08 10:21:26.856000','2016-11-08 10:32:52.123000',0),
  ('750b3c0d-8247-4cc6-adbd-5a34f88092c3','a95368c7-f1e8-4bd7-8050-9eb14f6e0ab6',1,NULL,1,'3','0f424143-383e-490d-96ef-145fed18bb29',NULL,'2016-11-08 09:19:08.778000','2016-11-08 09:33:01.641000',1),
  ('80e0f6ef-a62d-4179-99cb-cf524997f363','47dd181e-9c45-48a9-b650-21753c77b44f',0,NULL,4,NULL,'5d238555-8620-4841-a2bf-c77d497f6b03',NULL,'2016-11-08 09:05:11.565000','2016-11-08 09:09:03.599000',1),
  ('9669f111-a7e8-42f0-828f-5ba84c06215c','2267ed8d-a86b-4def-9859-79ac8e22a7cb',0,NULL,3,NULL,'0f424143-383e-490d-96ef-145fed18bb29',NULL,'2016-11-08 09:19:08.780000','2016-11-08 09:33:02.113000',1),
  ('9678c887-0b15-445b-9a6f-b98a26485b91','c3488ac4-185e-4a23-93e7-3abc22cedcb1',0,NULL,3,NULL,'3d86335e-05e7-4921-8cdf-42ed03821f62',NULL,'2016-11-08 10:21:26.857000','2016-11-08 10:32:52.140000',1),
  ('97abf608-3626-4672-8e7a-c1b0d43a07d2','3d4baadf-52f9-4e3c-9f52-78f663890e70',0,NULL,4,NULL,'3d86335e-05e7-4921-8cdf-42ed03821f62',NULL,'2016-11-08 10:21:26.858000','2016-11-08 10:32:52.140000',1),
  ('9ce82983-8de5-439e-863a-88086fb8b705','a4a561c9-f545-4cd6-bca0-f496c6221f44',1,NULL,1,'2','279d3e6e-b3ab-4e9f-8358-67e393e5ed0f',NULL,'2016-11-08 09:10:36.927000','2016-11-08 09:16:47.345000',1),
  ('9d5d9329-4826-45e8-bb02-7486d0e5da6a','9e5e5d55-cd85-498e-9cec-f7fb2a5553f2',0,NULL,3,NULL,'5d238555-8620-4841-a2bf-c77d497f6b03',NULL,'2016-11-08 09:05:11.553000','2016-11-08 09:09:03.598000',1),
  ('a5b1e31c-90ca-4726-98f3-5cccc0c0c684','2267ed8d-a86b-4def-9859-79ac8e22a7cb',0,NULL,3,NULL,'1dccd9b1-8837-43d0-8f5b-bb4b169fdc9d',NULL,'2016-11-08 09:54:07.239000','2016-11-08 09:54:07.239000',1),
  ('bd3dc109-0911-4d5f-8356-7ac41f60bc5c','b14a135a-8fab-42b0-a190-2a74da58c3a4',0,NULL,4,NULL,'279d3e6e-b3ab-4e9f-8358-67e393e5ed0f',NULL,'2016-11-08 09:10:36.930000','2016-11-08 09:16:47.391000',1),
  ('c667d074-e702-4cf2-ab5c-87724a6b55e6','2d3c97ae-314d-4710-ad9e-4d0271788e19',0,NULL,4,NULL,'0f424143-383e-490d-96ef-145fed18bb29',NULL,'2016-11-08 09:19:08.781000','2016-11-08 09:33:02.114000',1),
  ('effd597d-3f8d-4fe6-85c8-abe1c1469f8e','05481835-4fe9-45d7-bd99-77034ceddb49',0,NULL,3,NULL,'8d872244-c7c9-4ff6-9239-f207c2773787',NULL,'2016-11-08 09:50:02.860000','2016-11-08 09:51:40.831000',1);

INSERT INTO `enderecos` (`id`, `id_json`, `controlador_id`, `anel_id`, `localizacao`, `latitude`, `longitude`, `localizacao2`, `altura_numerica`, `referencia`, `data_criacao`, `data_atualizacao`)
VALUES
  ('1b3f89d9-0564-451d-95c7-8b2c496acd9e','f49c1ecd-e7a1-45cf-a966-f06aa3ede022','279d3e6e-b3ab-4e9f-8358-67e393e5ed0f',NULL,'Av. Paulista',-23.5631141,-46.65439200000003,'',1000,'AREA 1','2016-11-08 09:10:36.925000','2016-11-08 09:16:47.344000'),
  ('3112c4c6-7a20-4bea-8cf7-07afbe15a0cc','0eb6ade6-530b-4b96-9be7-2dd350159ecb',NULL,'33e2bbf0-72ad-4d11-98d8-1bb440c370b0','Alameda Campinas',-23.5681006,-46.65531850000002,'Av. Paulista',NULL,NULL,'2016-11-08 09:06:31.611000','2016-11-08 09:09:03.580000'),
  ('33dfe845-51b9-423a-9cf8-216bd2f13372','9d6ab113-7556-4942-aa1b-018cb760dee4',NULL,'5e913606-1f79-42db-bafd-a86b14a5c64c','Av. Paulista',-23.5631141,-46.65439200000003,'',NULL,'2000','2016-11-08 09:54:07.223000','2016-11-08 09:54:07.223000'),
  ('46501c01-1949-4543-9b59-1b84224c3ab1','af8bb309-339f-4df1-bd27-b2b41d208750',NULL,'750b3c0d-8247-4cc6-adbd-5a34f88092c3','R. Maria Figueiredo',-23.56891359999999,-46.647362999999984,'',-4,NULL,'2016-11-08 09:19:55.027000','2016-11-08 09:33:01.641000'),
  ('49e089d6-1ee9-44f0-b8dc-e91af1bc4bc3','7f3bc819-4ccc-4085-9875-6b7d90d5fee7',NULL,'7012415b-6892-4498-b0bd-cb3fa2ad093c','R. Maria Figueiredo',-23.56891359999999,-46.647362999999984,'Av. Paulista',NULL,NULL,'2016-11-08 09:50:36.970000','2016-11-08 09:51:40.805000'),
  ('4e265d99-5dfb-4463-bedc-dbbf529e4916','22812828-60fd-4536-b3a6-7652501444e6',NULL,'9ce82983-8de5-439e-863a-88086fb8b705','Av. Paulista',-23.5631141,-46.65439200000003,'',1000,'AREA 1','2016-11-08 09:11:35.770000','2016-11-08 09:16:47.346000'),
  ('50419520-d9e4-491b-9d1e-2b4ff52f23fd','57de35a8-9617-42c1-8604-d96da286c54c',NULL,'4744f9d9-f9c3-4f3f-ab1c-17b7178453d5','Av. Paulista',-23.5631141,-46.65439200000003,'R. Pamplona',0,NULL,'2016-11-08 09:06:31.592000','2016-11-08 09:09:03.539000'),
  ('63815f0d-bf73-4cce-84af-eb12ada29e52','82abd475-3dfa-4b39-a7d0-efd507fedfe4',NULL,'043007e5-ee02-4383-bde1-87346abdc895','Av. Paulista',-23.5631141,-46.65439200000003,'',1500,'1500','2016-11-08 10:22:09.904000','2016-11-08 10:32:52.107000'),
  ('74932fc3-97b8-4a7e-beef-a49611bd78e5','d99504ac-e378-4a04-85a7-d56882883323','8d872244-c7c9-4ff6-9239-f207c2773787',NULL,'R. Maria Figueiredo',-23.56891359999999,-46.647362999999984,'Av. Paulista',NULL,NULL,'2016-11-08 09:50:02.856000','2016-11-08 09:51:40.804000'),
  ('7d63b11b-8fe9-4977-a2b1-a2fc3ab6245f','6eee537e-a2f6-4eb4-9bf7-6082249c9dfb','5d238555-8620-4841-a2bf-c77d497f6b03',NULL,'Av. Paulista',-23.5631141,-46.65439200000003,'R. Pamplona',0,NULL,'2016-11-08 09:05:11.515000','2016-11-08 09:09:03.538000'),
  ('83f841c0-cec9-471a-9f85-bf28e91e4d92','b9e66757-81a9-478e-ad34-8606ef1dd240','3d86335e-05e7-4921-8cdf-42ed03821f62',NULL,'R. Maria Figueiredo',-23.56891359999999,-46.647362999999984,'Av. Paulista',NULL,NULL,'2016-11-08 10:21:26.854000','2016-11-08 10:32:52.106000'),
  ('abe6678e-9326-4d21-8207-f7f63e7806b3','535ece1b-8059-400b-9a80-6494d32f5d85',NULL,'22eb55d2-c56f-4037-a9d7-166d829438a4','Av. Paulista',-23.5631141,-46.65439200000003,'',NULL,'2000','2016-11-08 09:50:36.973000','2016-11-08 09:51:40.818000'),
  ('b0cb8f24-4b44-42dc-bff4-fce562067a16','d44b00b2-97cf-455b-aec1-4dc476794ebc',NULL,'70d364b0-6f7c-4f04-96e8-853a49ccd7f2','R. Maria Figueiredo',-23.56891359999999,-46.647362999999984,'Av. Paulista',NULL,NULL,'2016-11-08 10:22:09.888000','2016-11-08 10:32:52.124000'),
  ('ba45d2a6-7347-41e8-ac9f-83b8202b4bc8','78ebe0b3-9dd4-434e-b535-b7a416eba05b',NULL,'6c709913-6812-41d9-94a6-e36ee55e3b9c','R. Pamplona',-23.5661164,-46.656092400000034,'Av. Paulista',NULL,NULL,'2016-11-08 09:11:35.776000','2016-11-08 09:16:47.371000'),
  ('c21aaa9d-8511-46aa-91d9-09af42c4e7b3','af8bb309-339f-4df1-bd27-b2b41d208750',NULL,'5033f1e1-3840-4a01-a69b-ea6815ac33fa','R. Maria Figueiredo',-23.56891359999999,-46.647362999999984,'',-4,NULL,'2016-11-08 09:54:07.234000','2016-11-08 09:54:07.234000'),
  ('d61a729f-3fb6-4db6-b68a-90cbfcd18046','ce2ca5a0-fe74-4977-8c92-315da74ba60c','0f424143-383e-490d-96ef-145fed18bb29',NULL,'R. Maria Figueiredo',-23.56891359999999,-46.647362999999984,'',-4,NULL,'2016-11-08 09:19:08.778000','2016-11-08 09:33:01.640000'),
  ('e1bb9546-df7f-4d98-8c02-47e0d0ab7d42','9d6ab113-7556-4942-aa1b-018cb760dee4',NULL,'56f26b09-4bf1-4dfd-b014-eb39880ed45a','Av. Paulista',-23.5631141,-46.65439200000003,'',NULL,'2000','2016-11-08 09:19:55.032000','2016-11-08 09:33:01.672000'),
  ('fc931751-dd76-453e-a7aa-e7dbd65a9f3f','ce2ca5a0-fe74-4977-8c92-315da74ba60c','1dccd9b1-8837-43d0-8f5b-bb4b169fdc9d',NULL,'R. Maria Figueiredo',-23.56891359999999,-46.647362999999984,'',-4,NULL,'2016-11-08 09:54:07.222000','2016-11-08 09:54:07.222000');

INSERT INTO `grupos_semaforicos` (`id`, `id_json`, `tipo`, `descricao`, `anel_id`, `controlador_id`, `posicao`, `fase_vermelha_apagada_amarelo_intermitente`, `tempo_verde_seguranca`, `data_criacao`, `data_atualizacao`)
VALUES
  ('12cb4ead-c499-479b-99f1-810b47f4ae83','43b6952f-ce29-4b88-afe2-e1d590b3431f','VEICULAR',NULL,'750b3c0d-8247-4cc6-adbd-5a34f88092c3',NULL,2,1,10,'2016-11-08 09:20:30.790000','2016-11-08 09:33:01.644000'),
  ('155bd3c9-2fc8-4cca-9748-d6580f160dc2','0e8c994f-408e-46a5-a409-328a11d40b4d','PEDESTRE',NULL,'56f26b09-4bf1-4dfd-b014-eb39880ed45a',NULL,7,0,4,'2016-11-08 09:20:30.797000','2016-11-08 09:33:01.675000'),
  ('1aeadd03-ec04-4bea-a4c7-641125dda206','05ea9fb5-8d04-42aa-828c-a160b5d8982f','PEDESTRE',NULL,'5e913606-1f79-42db-bafd-a86b14a5c64c',NULL,7,0,4,'2016-11-08 09:54:07.223000','2016-11-08 09:54:07.627000'),
  ('3c8ce4de-70a1-44e8-9273-c07f705f130e','a79c41aa-d326-4196-9289-381574308cbd','VEICULAR',NULL,'5033f1e1-3840-4a01-a69b-ea6815ac33fa',NULL,2,1,10,'2016-11-08 09:54:07.234000','2016-11-08 09:54:07.811000'),
  ('438bea60-53f6-4a0c-ab26-d2c9ca061b23','ee5a60b2-e5f9-48fb-9830-54791b4be8d1','VEICULAR',NULL,'750b3c0d-8247-4cc6-adbd-5a34f88092c3',NULL,1,1,10,'2016-11-08 09:20:30.789000','2016-11-08 09:33:01.651000'),
  ('462dd6ae-acf9-4a1b-b266-b6a29b47c1fa','b31344d7-6f15-4faa-8c8a-4b4bdaf6811a','VEICULAR',NULL,'043007e5-ee02-4383-bde1-87346abdc895',NULL,4,1,10,'2016-11-08 10:22:31.461000','2016-11-08 10:32:52.109000'),
  ('4829f07e-2807-4054-b8e7-ddb2bcdcbcfa','e85e3fb1-9f8e-4ab4-9ea0-fab24794e5e1','VEICULAR',NULL,'6c709913-6812-41d9-94a6-e36ee55e3b9c',NULL,3,1,10,'2016-11-08 09:11:41.888000','2016-11-08 09:16:47.372000'),
  ('4bb4af54-cf60-4bf8-81f5-37ec0c82b5f3','2a93a8bd-d5b0-4d11-ac67-32bb91f06aeb','VEICULAR',NULL,'5e913606-1f79-42db-bafd-a86b14a5c64c',NULL,4,1,12,'2016-11-08 09:54:07.226000','2016-11-08 09:54:07.649000'),
  ('4c0b8351-28d6-4445-824a-48b6dece50e8','fbb9f18f-1b7d-44dc-ad3a-ee075f72af84','VEICULAR',NULL,'9ce82983-8de5-439e-863a-88086fb8b705',NULL,1,1,10,'2016-11-08 09:11:41.882000','2016-11-08 09:16:47.348000'),
  ('4d592444-7995-4146-a9a3-e491e5d695a6','1d681432-0f24-4620-b72e-0a2aa870f678','VEICULAR',NULL,'5033f1e1-3840-4a01-a69b-ea6815ac33fa',NULL,1,1,10,'2016-11-08 09:54:07.235000','2016-11-08 09:54:07.816000'),
  ('53b67934-ce51-4dd7-b4c6-e1abedcd4abb','836eeca3-62f1-4605-9220-f97e2e10b488','VEICULAR',NULL,'9ce82983-8de5-439e-863a-88086fb8b705',NULL,2,1,10,'2016-11-08 09:11:41.883000','2016-11-08 09:16:47.353000'),
  ('5d777b9c-5c6b-4de3-b4d1-a8ccbe92e88a','7f7a94fa-db97-4004-8589-e90718a7ecd5','VEICULAR',NULL,'5033f1e1-3840-4a01-a69b-ea6815ac33fa',NULL,3,1,10,'2016-11-08 09:54:07.236000','2016-11-08 09:54:07.821000'),
  ('682c4d0e-626a-4c3d-8ce3-b6421ea2341a','feacb0e9-d389-4b37-bbed-1fce62047a2a','VEICULAR',NULL,'56f26b09-4bf1-4dfd-b014-eb39880ed45a',NULL,6,1,12,'2016-11-08 09:20:30.797000','2016-11-08 09:33:01.687000'),
  ('7081b5d1-c597-4ba0-a232-453a6b1fc8e9','01f90f28-c239-42a2-8400-2663468df5d3','VEICULAR',NULL,'750b3c0d-8247-4cc6-adbd-5a34f88092c3',NULL,3,1,10,'2016-11-08 09:20:30.791000','2016-11-08 09:33:01.658000'),
  ('717c6bc5-9098-464c-b19a-e2f0c7e6d40f','547b2419-c54c-4d25-a719-83f7506714ba','VEICULAR',NULL,'4744f9d9-f9c3-4f3f-ab1c-17b7178453d5',NULL,2,1,10,'2016-11-08 09:06:42.935000','2016-11-08 09:09:03.542000'),
  ('72dab597-6715-40d6-abce-2724b5cff1f9','6e16e107-b106-491b-a0f9-884ed837f854','VEICULAR',NULL,'70d364b0-6f7c-4f04-96e8-853a49ccd7f2',NULL,1,1,10,'2016-11-08 10:22:31.457000','2016-11-08 10:32:52.125000'),
  ('73487232-6688-40a8-a068-86a7cffe6b69','3f86f381-0044-4ff4-b3de-7992091a3235','VEICULAR',NULL,'56f26b09-4bf1-4dfd-b014-eb39880ed45a',NULL,4,1,12,'2016-11-08 09:20:30.796000','2016-11-08 09:33:02.070000'),
  ('77347d0d-1425-4c98-9aa3-2a3678ececd4','25fb7e91-0d67-472d-9d13-4d878c00d42a','VEICULAR',NULL,'5e913606-1f79-42db-bafd-a86b14a5c64c',NULL,6,1,12,'2016-11-08 09:54:07.225000','2016-11-08 09:54:07.639000'),
  ('7ff271f4-81ef-4422-8461-b15c44051fd8','27745104-09ec-40e1-b2de-120a0972c111','VEICULAR',NULL,'22eb55d2-c56f-4037-a9d7-166d829438a4',NULL,4,1,10,'2016-11-08 09:50:42.306000','2016-11-08 09:51:40.820000'),
  ('84bcba8f-93c4-4fb2-9aac-457262312441','8131b0c0-a023-4eeb-b61d-30fe6c19b365','VEICULAR',NULL,'7012415b-6892-4498-b0bd-cb3fa2ad093c',NULL,2,1,10,'2016-11-08 09:50:42.303000','2016-11-08 09:51:40.807000'),
  ('b920567a-32ac-4233-81ec-858563409d9b','9344947a-446e-46de-9f8a-addf8c0276f1','VEICULAR',NULL,'6c709913-6812-41d9-94a6-e36ee55e3b9c',NULL,4,1,10,'2016-11-08 09:11:41.892000','2016-11-08 09:16:47.376000'),
  ('b9b212ff-5b33-4f55-a67a-45955d13a66f','24e455d8-a5d5-40e1-8e66-34ce6f30113a','VEICULAR',NULL,'043007e5-ee02-4383-bde1-87346abdc895',NULL,3,1,10,'2016-11-08 10:22:31.461000','2016-11-08 10:32:52.114000'),
  ('bf6524f8-9a7e-4be8-8e35-4fd4f909d1c4','dfd0af49-19b9-48fb-b321-32e23204ff8a','VEICULAR',NULL,'70d364b0-6f7c-4f04-96e8-853a49ccd7f2',NULL,2,1,10,'2016-11-08 10:22:31.458000','2016-11-08 10:32:52.129000'),
  ('c5dc4dbe-2d49-4e1d-b6c0-449b13e16240','5e72ea53-f2a3-4018-9c02-50b9bd81acbc','VEICULAR',NULL,'5e913606-1f79-42db-bafd-a86b14a5c64c',NULL,5,1,12,'2016-11-08 09:54:07.227000','2016-11-08 09:54:07.789000'),
  ('c9284008-54bc-438f-88cc-363e7752a148','3e5652bf-694c-45a2-b6c9-c032aa4d9586','VEICULAR',NULL,'7012415b-6892-4498-b0bd-cb3fa2ad093c',NULL,1,1,10,'2016-11-08 09:50:42.303000','2016-11-08 09:51:40.811000'),
  ('d0fe4320-ac2c-4623-ae92-49bc89f43438','b20d4c0c-6938-428d-a98b-cad3c729b950','VEICULAR',NULL,'22eb55d2-c56f-4037-a9d7-166d829438a4',NULL,3,1,10,'2016-11-08 09:50:42.306000','2016-11-08 09:51:40.826000'),
  ('d268b155-7b77-4dd0-af4a-d23376a8a15c','6d658a20-8ac9-4754-847f-b1bc6d5328f5','VEICULAR',NULL,'33e2bbf0-72ad-4d11-98d8-1bb440c370b0',NULL,4,1,10,'2016-11-08 09:06:42.944000','2016-11-08 09:09:03.582000'),
  ('d301c7f5-6b95-4eac-b4f1-fcb314cb5b9a','9b9d5fa8-f3b6-4939-a4b0-5e059989ddcf','PEDESTRE',NULL,'4744f9d9-f9c3-4f3f-ab1c-17b7178453d5',NULL,3,0,4,'2016-11-08 09:06:42.937000','2016-11-08 09:09:03.551000'),
  ('da7e4e08-e87b-4734-9f36-6ab8ab3a5893','5a9365b7-2c6f-4e86-abbb-ba9324e0d56f','PEDESTRE',NULL,'5e913606-1f79-42db-bafd-a86b14a5c64c',NULL,8,0,4,'2016-11-08 09:54:07.228000','2016-11-08 09:54:07.797000'),
  ('e307d4fc-95ff-45ce-a23d-baae9427599b','fe51aea9-aa5e-4a75-96dc-1514f5ace0ce','VEICULAR',NULL,'33e2bbf0-72ad-4d11-98d8-1bb440c370b0',NULL,5,1,10,'2016-11-08 09:06:42.946000','2016-11-08 09:09:03.587000'),
  ('e52ff58d-a44b-4c1d-aa5a-7d90a68d0816','ccc7388c-e556-474b-8279-1ded02d37933','VEICULAR',NULL,'56f26b09-4bf1-4dfd-b014-eb39880ed45a',NULL,5,1,12,'2016-11-08 09:20:30.796000','2016-11-08 09:33:02.081000'),
  ('e9f671a5-950c-4fc5-9cc7-45acbd53227f','63b68ac0-3220-440f-ba8f-781c336779f3','VEICULAR',NULL,'4744f9d9-f9c3-4f3f-ab1c-17b7178453d5',NULL,1,1,10,'2016-11-08 09:06:42.934000','2016-11-08 09:09:03.560000'),
  ('efd9bc6e-d318-4654-994c-3aafff5e3b66','d552098a-1f1d-4b40-a2a6-5d87bef1321c','PEDESTRE',NULL,'56f26b09-4bf1-4dfd-b014-eb39880ed45a',NULL,8,0,4,'2016-11-08 09:20:30.798000','2016-11-08 09:33:02.089000');

INSERT INTO `tabela_entre_verdes` (`id`, `id_json`, `descricao`, `grupo_semaforico_id`, `posicao`, `data_criacao`, `data_atualizacao`)
VALUES
  ('0d0b16db-801b-4191-a0f3-cc3390bbafdb','73c33b15-d818-4567-94b2-32c9712a452b','PADRÃO','c9284008-54bc-438f-88cc-363e7752a148',1,'2016-11-08 09:50:52.066000','2016-11-08 09:51:40.812000'),
  ('0ec22e53-adb3-4768-903e-8f8098f059c6','65d9951e-37d0-40ce-aac1-fe27cfa883ae','PADRÃO','155bd3c9-2fc8-4cca-9748-d6580f160dc2',1,'2016-11-08 09:21:21.597000','2016-11-08 09:33:01.677000'),
  ('12ce9d50-b346-4dba-8b16-bccdc80e1448','5824a673-5cce-4c36-9bc4-70721ff2aea2','PADRÃO','12cb4ead-c499-479b-99f1-810b47f4ae83',1,'2016-11-08 09:21:21.566000','2016-11-08 09:33:01.646000'),
  ('17b0cee1-9240-43c1-b55c-df83a6374a5e','bd6bed6c-e26f-4a27-8688-738ae37402be','PADRÃO','53b67934-ce51-4dd7-b4c6-e1abedcd4abb',1,'2016-11-08 09:11:53.009000','2016-11-08 09:16:47.354000'),
  ('20add881-33c9-4e86-b962-7cb01b3c83fe','20ed02b9-e287-4da6-97fc-31e69f109ba9','PADRÃO','7ff271f4-81ef-4422-8461-b15c44051fd8',1,'2016-11-08 09:50:52.074000','2016-11-08 09:51:40.823000'),
  ('2d142bec-7d46-48c9-b80f-1658b16eee68','e7e9ab6b-0869-4b86-a644-580e44308977','PADRÃO','d301c7f5-6b95-4eac-b4f1-fcb314cb5b9a',1,'2016-11-08 09:06:59.129000','2016-11-08 09:09:03.552000'),
  ('3134bb3f-3d75-4379-9970-054964c94c5f','c140a404-3d08-4537-853f-1dd8a786ede8','PADRÃO','5d777b9c-5c6b-4de3-b4d1-a8ccbe92e88a',1,'2016-11-08 09:54:07.581000','2016-11-08 09:54:07.822000'),
  ('4aeba7c8-92da-4a48-8f91-1b4db7c8bb3b','11a711cb-3b51-4944-afea-f2b3302e8c99','PADRÃO','d0fe4320-ac2c-4623-ae92-49bc89f43438',1,'2016-11-08 09:50:52.077000','2016-11-08 09:51:40.827000'),
  ('4b687789-caf1-488c-ab78-14329e31cd17','a3a9bef2-5507-460e-8b64-1531b6ce8c6c','PADRÃO','bf6524f8-9a7e-4be8-8e35-4fd4f909d1c4',1,'2016-11-08 10:22:42.724000','2016-11-08 10:32:52.130000'),
  ('4f6c6d58-ead3-4b42-a95a-687944676659','612ef894-3b4a-4181-8b9a-ceb1c9945f7d','PADRÃO','4c0b8351-28d6-4445-824a-48b6dece50e8',1,'2016-11-08 09:11:53.002000','2016-11-08 09:16:47.350000'),
  ('549c146c-b7c4-401f-b2b3-3dbdfd938143','2aa738f0-5a6c-438c-9867-165ad76c0ba7','PADRÃO','682c4d0e-626a-4c3d-8ce3-b6421ea2341a',1,'2016-11-08 09:21:21.619000','2016-11-08 09:33:01.689000'),
  ('5e3d2c03-731f-4082-9c6c-e2c0949201e4','cc354a87-8319-42aa-b9f0-651cd8df8c9c','PADRÃO','462dd6ae-acf9-4a1b-b266-b6a29b47c1fa',1,'2016-11-08 10:22:42.744000','2016-11-08 10:32:52.110000'),
  ('6a9a2ab0-7bf7-4f85-a882-808ac174e176','015c8a4c-cc57-418d-a2c4-74287dfaa9c1','PADRÃO','da7e4e08-e87b-4734-9f36-6ab8ab3a5893',1,'2016-11-08 09:54:07.424000','2016-11-08 09:54:07.798000'),
  ('6f2ccbbe-a8f6-4989-9258-9e13264d1390','dc38264d-8253-4d05-95c9-2c25af4dce95','PADRÃO','b9b212ff-5b33-4f55-a67a-45955d13a66f',1,'2016-11-08 10:22:42.749000','2016-11-08 10:32:52.115000'),
  ('6f417012-38ec-4ec3-8b30-a52d9a216531','72e5fe9b-661a-4be3-a8c2-e59d857b2409','PADRÃO','c5dc4dbe-2d49-4e1d-b6c0-449b13e16240',1,'2016-11-08 09:54:07.412000','2016-11-08 09:54:07.791000'),
  ('72149920-ab95-48c0-9dad-fe6bb7e328ba','8e352b9a-a09a-4d8e-9486-587250034273','PADRÃO','73487232-6688-40a8-a068-86a7cffe6b69',1,'2016-11-08 09:21:21.631000','2016-11-08 09:33:02.071000'),
  ('8e548067-239f-4df8-b3f4-96beee8b77d3','6ad8d581-7052-4584-9057-526482681034','PADRÃO','84bcba8f-93c4-4fb2-9aac-457262312441',1,'2016-11-08 09:50:52.061000','2016-11-08 09:51:40.808000'),
  ('95b91237-3228-45f1-a640-935b4c2514de','9e51cef8-b905-4d5b-9dad-282662d95b90','PADRÃO','77347d0d-1425-4c98-9aa3-2a3678ececd4',1,'2016-11-08 09:54:07.282000','2016-11-08 09:54:07.640000'),
  ('9bc0c803-4880-475e-8c94-3153715b8382','0eb35a4a-aadb-4533-9885-754655c3b199','PADRÃO','e307d4fc-95ff-45ce-a23d-baae9427599b',1,'2016-11-08 09:06:59.182000','2016-11-08 09:09:03.589000'),
  ('9ed66190-053c-407b-b2ba-eaadd2a094d3','912c078a-909e-4728-afa4-f091a3864142','PADRÃO','efd9bc6e-d318-4654-994c-3aafff5e3b66',1,'2016-11-08 09:21:21.807000','2016-11-08 09:33:02.090000'),
  ('b02b208b-ca63-4795-85b0-ff023718410a','cddb3193-88ed-41d9-9b16-61cae402420a','PADRÃO','4d592444-7995-4146-a9a3-e491e5d695a6',1,'2016-11-08 09:54:07.486000','2016-11-08 09:54:07.817000'),
  ('b0d0a2fd-9625-4864-bc15-4eab20074ea3','99d26050-8256-4fc9-95e1-270a03536683','PADRÃO','4bb4af54-cf60-4bf8-81f5-37ec0c82b5f3',1,'2016-11-08 09:54:07.293000','2016-11-08 09:54:07.650000'),
  ('b45407f9-8737-48ec-8bb3-9440731a7858','4111dc85-423c-4638-97d9-c6e32c34e2f3','PADRÃO','b920567a-32ac-4233-81ec-858563409d9b',1,'2016-11-08 09:11:53.024000','2016-11-08 09:16:47.377000'),
  ('b750ec72-5263-4a34-89db-debf1e6f8f93','ca3d6368-b96b-494a-b5c3-183b2d2bf93f','PADRÃO','e52ff58d-a44b-4c1d-aa5a-7d90a68d0816',1,'2016-11-08 09:21:21.796000','2016-11-08 09:33:02.082000'),
  ('bb3a11f4-bed8-4d35-b68a-0188243359ab','d97d3dc4-6053-4109-a55e-d92aa8f961f7','PADRÃO','d268b155-7b77-4dd0-af4a-d23376a8a15c',1,'2016-11-08 09:06:59.173000','2016-11-08 09:09:03.584000'),
  ('be4231f9-640b-4dc5-b2df-550683ca1576','419e2c22-2e82-4ca8-8edc-8abc445ffd0b','PADRÃO','7081b5d1-c597-4ba0-a232-453a6b1fc8e9',1,'2016-11-08 09:21:21.584000','2016-11-08 09:33:01.659000'),
  ('d68f3156-acc5-4de3-95aa-0c7f43f32037','088d3aa5-fd43-4e3c-9788-3f824982c02b','PADRÃO','4829f07e-2807-4054-b8e7-ddb2bcdcbcfa',1,'2016-11-08 09:11:53.017000','2016-11-08 09:16:47.373000'),
  ('da4b105e-6021-4127-8577-ce12069d4b83','65573740-e33a-4134-8035-30451f2f0816','PADRÃO','717c6bc5-9098-464c-b19a-e2f0c7e6d40f',1,'2016-11-08 09:06:59.110000','2016-11-08 09:09:03.545000'),
  ('e5f93688-4d11-4a34-bee9-0f554ad43647','3e956fdd-f290-4ddf-99e8-342be03fc00a','PADRÃO','1aeadd03-ec04-4bea-a4c7-641125dda206',1,'2016-11-08 09:54:07.271000','2016-11-08 09:54:07.629000'),
  ('e87857f3-2521-4230-b429-a22890e5d98d','e6c4324b-5fb8-4df7-8df6-202838879cc6','PADRÃO','e9f671a5-950c-4fc5-9cc7-45acbd53227f',1,'2016-11-08 09:06:59.153000','2016-11-08 09:09:03.562000'),
  ('e8c3bb21-b4a3-4c5d-98b0-8c34198c8f68','39baf9db-e0f9-464a-9f12-869e5fcfa3fe','PADRÃO','3c8ce4de-70a1-44e8-9273-c07f705f130e',1,'2016-11-08 09:54:07.481000','2016-11-08 09:54:07.812000'),
  ('ebcc652c-3282-46ff-b941-8f08f6b4e016','f6951fbe-86a2-4596-a705-20153bd7e5a7','PADRÃO','72dab597-6715-40d6-abce-2724b5cff1f9',1,'2016-11-08 10:22:42.717000','2016-11-08 10:32:52.127000'),
  ('f932dc41-31d5-4f04-981d-1652e0244a11','58aa1139-c057-4259-b8c6-37eb3f2b30b2','PADRÃO','438bea60-53f6-4a0c-ab26-d2c9ca061b23',1,'2016-11-08 09:21:21.576000','2016-11-08 09:33:01.653000');

INSERT INTO `estagios` (`id`, `id_json`, `imagem_id`, `descricao`, `tempo_maximo_permanencia`, `tempo_maximo_permanencia_ativado`, `posicao`, `demanda_prioritaria`, `tempo_verde_demanda_prioritaria`, `anel_id`, `controlador_id`, `data_criacao`, `data_atualizacao`)
VALUES
  ('02249237-5121-4a89-b95c-2ccdec19114b','9d045307-0c21-4cef-8e3c-f167d70d73d7','a5bdf0c8-4676-4f27-8d51-753ebbf411bb',NULL,127,1,2,0,1,'5033f1e1-3840-4a01-a69b-ea6815ac33fa',NULL,'2016-11-08 09:54:07.238000','2016-11-08 09:54:07.911000'),
  ('180caf55-d387-443b-ba54-5fb030f725e2','b6dc2eef-434c-4125-9db8-1ff211089fef','1530387b-8896-4c25-841b-18431d8c9886',NULL,127,1,1,0,1,'33e2bbf0-72ad-4d11-98d8-1bb440c370b0',NULL,'2016-11-08 09:06:31.613000','2016-11-08 09:09:03.593000'),
  ('25312c1e-f509-4740-baa2-adc910ce2473','a934708b-b2f3-44cb-a57d-adfb6bc76aae','97091a81-95a4-4f4f-8bfb-5f3cc6ad861b',NULL,127,1,1,0,1,'043007e5-ee02-4383-bde1-87346abdc895',NULL,'2016-11-08 10:22:09.905000','2016-11-08 10:32:52.117000'),
  ('37ef8d1b-f9c5-44d5-b7e8-f1fd523f1d8d','38547bfb-0531-45b3-9184-23d8d4082643','3aa84dbb-b01e-47b1-8956-999dac3a2673',NULL,60,1,4,0,1,'56f26b09-4bf1-4dfd-b014-eb39880ed45a',NULL,'2016-11-08 09:19:55.043000','2016-11-08 09:33:02.096000'),
  ('391dc5fc-ca18-4716-885e-2c75a3bb9ea5','ac4dd802-01d9-430e-b83b-6626a212fc03','82bf10f2-bc0a-4957-a628-f7ad6ed2120f',NULL,127,1,2,0,1,'5e913606-1f79-42db-bafd-a86b14a5c64c',NULL,'2016-11-08 09:54:07.231000','2016-11-08 09:54:07.805000'),
  ('4b411e49-2496-436b-b9cc-dd50dd79b021','68860abc-389f-4d29-bdb6-0a2d1a735054','92cbcc7a-6825-41d2-a6f1-609553c6c066',NULL,127,1,2,0,1,'6c709913-6812-41d9-94a6-e36ee55e3b9c',NULL,'2016-11-08 09:11:35.781000','2016-11-08 09:16:47.379000'),
  ('4e58dfc3-fa71-495a-883d-bc6b59efcd9d','2fe8a4d8-f106-4a5b-b02d-78652f6a56fd','d088d448-d998-44f3-b04a-21a7f1901f4e',NULL,127,1,1,0,1,'5033f1e1-3840-4a01-a69b-ea6815ac33fa',NULL,'2016-11-08 09:54:07.238000','2016-11-08 09:54:07.911000'),
  ('540f7370-b266-4d2a-b6d9-04187a333945','839f2004-617b-4e48-81dc-772997a6dc1e','2c304945-0582-4bd3-8bb2-1063b58684ae',NULL,127,1,2,0,1,'4744f9d9-f9c3-4f3f-ab1c-17b7178453d5',NULL,'2016-11-08 09:06:31.607000','2016-11-08 09:09:03.568000'),
  ('5ab242ec-8c7f-44d5-903c-0df019861685','3974f1fe-d05e-4246-8f28-bd3bc7990bba','b31f5a13-48cc-4946-9551-cf9bd8421d6b',NULL,127,1,2,0,1,'043007e5-ee02-4383-bde1-87346abdc895',NULL,'2016-11-08 10:22:09.906000','2016-11-08 10:32:52.118000'),
  ('5f2452f1-b034-43f9-bed8-39ab50e39192','c3cf679e-f2f3-465e-9d2a-4e2e64de0ab3','2ebf5fdd-52e4-4aa0-9fb2-94b63d2bc87c',NULL,127,1,3,0,1,'750b3c0d-8247-4cc6-adbd-5a34f88092c3',NULL,'2016-11-08 09:19:55.030000','2016-11-08 09:33:01.662000'),
  ('700b1104-11c1-4094-aacf-c0ee5bf9ce83','3564d369-a8db-473e-ba12-ca8526f0f1f6','b04b8874-dd41-4da8-b981-5e7a7059e7f3',NULL,127,1,1,1,1,'56f26b09-4bf1-4dfd-b014-eb39880ed45a',NULL,'2016-11-08 09:19:55.033000','2016-11-08 09:33:02.097000'),
  ('790dde51-8406-4ebe-9876-dfd67f5fa9d3','fbbc7d83-b572-46a5-9b05-0e4998205db0','ce3b6f75-7ce8-4258-b1b5-6552a271aa5d',NULL,127,1,1,0,1,'7012415b-6892-4498-b0bd-cb3fa2ad093c',NULL,'2016-11-08 09:50:36.971000','2016-11-08 09:51:40.815000'),
  ('8977c23d-d3de-46b0-99b4-4813b4e4bee6','fd0c865a-4b0a-4d13-b12b-c38040ccbfb2','178ddea6-c78c-4f20-a448-9f68bbc2e746',NULL,127,1,1,0,1,'9ce82983-8de5-439e-863a-88086fb8b705',NULL,'2016-11-08 09:11:35.771000','2016-11-08 09:16:47.357000'),
  ('89b9fbb7-4148-4b7b-b201-5c60100627f3','47791448-1c24-4b3d-8b92-5379c5955e72','e5af5ddd-d752-4912-9b58-c4ad197bbd46',NULL,127,1,3,0,1,'5e913606-1f79-42db-bafd-a86b14a5c64c',NULL,'2016-11-08 09:54:07.232000','2016-11-08 09:54:07.806000'),
  ('8ddf1f7e-4228-4eb3-8286-e6a73cbddea7','c2c49330-3c74-421a-a451-cf330566df2d','2e791b3f-80a1-4e4b-9405-1a5383113bb6',NULL,60,1,5,0,1,'56f26b09-4bf1-4dfd-b014-eb39880ed45a',NULL,'2016-11-08 09:19:55.046000','2016-11-08 09:33:02.098000'),
  ('9cbe2d7c-da23-4df6-b6cf-927d3163b31a','3d6ba7eb-f851-4181-8d98-035619a7c512','97aaa01a-ebbf-4144-bad3-67fa7bba8078',NULL,127,1,1,0,1,'6c709913-6812-41d9-94a6-e36ee55e3b9c',NULL,'2016-11-08 09:11:35.778000','2016-11-08 09:16:47.380000'),
  ('9f7fa835-1010-48ca-b282-218cf7b24ba7','d8f02e84-8817-4cfc-a9cd-8f8c7b6499ff','fc1f166f-55a6-44c1-a817-07a8e33ac042',NULL,60,1,5,0,1,'5e913606-1f79-42db-bafd-a86b14a5c64c',NULL,'2016-11-08 09:54:07.231000','2016-11-08 09:54:07.804000'),
  ('a7bc0cc5-95bb-46f5-9ebf-725f3d874082','940d8245-e0c8-49bd-a927-a86347bc238b','f8826ec3-1f1b-4b88-a779-f5db793ce5c3',NULL,127,1,1,0,1,'4744f9d9-f9c3-4f3f-ab1c-17b7178453d5',NULL,'2016-11-08 09:06:31.598000','2016-11-08 09:09:03.569000'),
  ('b4713f89-5fbd-4134-8b42-c6c473715f29','9dfa197c-778a-48d8-8d6b-71e9eb9edd82','f6b49750-eb6e-4e40-b1ea-e9d7126448d8',NULL,60,1,3,0,1,'4744f9d9-f9c3-4f3f-ab1c-17b7178453d5',NULL,'2016-11-08 09:06:31.609000','2016-11-08 09:09:03.569000'),
  ('b78ab5e1-8cbb-4971-8e8b-a47497d0664b','5964dc4b-4a4b-499b-9982-574aa4119990','09b7de25-d15b-4e5b-a537-560aaaa05b13',NULL,127,1,3,0,1,'5033f1e1-3840-4a01-a69b-ea6815ac33fa',NULL,'2016-11-08 09:54:07.237000','2016-11-08 09:54:07.910000'),
  ('c230a549-399a-4c93-adf9-91a2a3a06e1b','13df1d6f-0abb-4b55-b948-737f9c915220','13af6f44-b26b-4183-a625-94c3fea97f80',NULL,127,1,1,0,1,'750b3c0d-8247-4cc6-adbd-5a34f88092c3',NULL,'2016-11-08 09:19:55.028000','2016-11-08 09:33:01.663000'),
  ('caaebab1-8d69-44cb-aead-7bdb48dd444f','7bba27c5-23eb-49c8-a683-3f17ef1f2661','76cca405-fce7-4fee-9db7-259103c9f666',NULL,127,1,2,0,1,'33e2bbf0-72ad-4d11-98d8-1bb440c370b0',NULL,'2016-11-08 09:06:31.614000','2016-11-08 09:09:03.593000'),
  ('db44e2c6-bad3-4436-a19f-174121bb3815','635e76f8-d50f-43a2-a5ff-68bb43a15e96','38361809-df71-41ec-9a5c-bb25df5ddb39',NULL,127,1,2,0,1,'70d364b0-6f7c-4f04-96e8-853a49ccd7f2',NULL,'2016-11-08 10:22:09.900000','2016-11-08 10:32:52.133000'),
  ('dbe60c2b-e495-4363-9cce-7a83348800ee','b3e7b059-73ff-4935-be51-92286fc02799','9cad89fe-096e-4e21-b2f3-e98c00fb155d',NULL,60,1,4,0,1,'5e913606-1f79-42db-bafd-a86b14a5c64c',NULL,'2016-11-08 09:54:07.230000','2016-11-08 09:54:07.803000'),
  ('e091b797-de64-43ad-ab3b-7ed6a1122351','c6eb1c44-69fc-4d83-88e6-44911c64cc0e','53364e61-7b9f-48c4-839a-56ddc00cee43',NULL,127,1,1,0,1,'70d364b0-6f7c-4f04-96e8-853a49ccd7f2',NULL,'2016-11-08 10:22:09.889000','2016-11-08 10:32:52.134000'),
  ('e53b38b4-e2b1-495b-9970-dc9dd16b38a2','c71e1342-ce87-4b90-b2a3-1444eeb51b5d','107a2f46-fb3b-4a6c-addb-793bf60857e6',NULL,127,1,2,0,1,'7012415b-6892-4498-b0bd-cb3fa2ad093c',NULL,'2016-11-08 09:50:36.972000','2016-11-08 09:51:40.816000'),
  ('e7ae783c-a771-439d-b2ca-d25f305478d5','6bd63b93-e59d-435b-843e-0138e56a3d1a','058fe586-0a37-4771-9c85-bf0c1f73362c',NULL,127,1,2,0,1,'56f26b09-4bf1-4dfd-b014-eb39880ed45a',NULL,'2016-11-08 09:19:55.034000','2016-11-08 09:33:02.100000'),
  ('e90ddae4-99b2-4bef-96bd-3f6a515bee9b','70fb0756-cb08-43e1-9cc8-f8594c2cb7f4','1d130042-3a38-421e-a271-4666b91c57c2',NULL,127,1,1,0,1,'22eb55d2-c56f-4037-a9d7-166d829438a4',NULL,'2016-11-08 09:50:36.974000','2016-11-08 09:51:40.830000'),
  ('e924c0b9-e952-4ea5-9886-a6212ec475c2','eae2025e-1157-4943-b068-56b602798671','ecfa4c5b-43f4-484a-9f30-5e92ba27fedd',NULL,127,1,2,0,1,'9ce82983-8de5-439e-863a-88086fb8b705',NULL,'2016-11-08 09:11:35.772000','2016-11-08 09:16:47.357000'),
  ('e962d14b-b269-42fb-b5af-c727b16678bd','057fe68f-3e5d-413a-ac6d-5a4eaaa9f36a','ec4d0742-a53d-49e9-b167-d6d55231f7f4',NULL,127,1,3,0,1,'56f26b09-4bf1-4dfd-b014-eb39880ed45a',NULL,'2016-11-08 09:19:55.035000','2016-11-08 09:33:02.102000'),
  ('f023f642-bbd6-4350-a6d7-fcbd77322e82','43b432fc-19d9-4db8-9313-1a80f8d8f736','d8bd88c8-ba62-4050-8380-c87a62cfbab3',NULL,127,1,2,0,1,'750b3c0d-8247-4cc6-adbd-5a34f88092c3',NULL,'2016-11-08 09:19:55.029000','2016-11-08 09:33:01.663000'),
  ('f48789ba-bbeb-4e96-afe7-587abf7a72d7','87db0853-d6d9-406b-b27f-93762634a9cb','86e4cce7-2d66-4af6-8809-5e13e899554e',NULL,127,1,2,0,1,'22eb55d2-c56f-4037-a9d7-166d829438a4',NULL,'2016-11-08 09:50:36.975000','2016-11-08 09:51:40.831000'),
  ('fb7801a1-ed3b-48a7-af14-212f87da132b','f8e634f9-8f50-43e9-b6b6-098f0377458c','977afcbf-9130-4e5b-ba17-e4c3c3449652',NULL,127,1,1,1,1,'5e913606-1f79-42db-bafd-a86b14a5c64c',NULL,'2016-11-08 09:54:07.230000','2016-11-08 09:54:07.804000');

INSERT INTO `transicoes` (`id`, `id_json`, `tipo`, `grupo_semaforico_id`, `origem_id`, `destino_id`, `destroy`, `modo_intermitente_ou_apagado`, `data_criacao`, `data_atualizacao`)
VALUES
  ('01928987-097d-4595-a6c1-df6d70132e8e','8c295e94-e9b5-4c76-993d-7a7dc67439e9','GANHO_DE_PASSAGEM','e52ff58d-a44b-4c1d-aa5a-7d90a68d0816','37ef8d1b-f9c5-44d5-b7e8-f1fd523f1d8d','e7ae783c-a771-439d-b2ca-d25f305478d5',0,0,'2016-11-08 09:21:21.805000','2016-11-08 09:54:08.018000'),
  ('01b25f93-c61e-4b88-a7a7-dbc00885ac67','1e733fb0-3fbc-45b4-97b3-03746b9d2937','PERDA_DE_PASSAGEM','efd9bc6e-d318-4654-994c-3aafff5e3b66','8ddf1f7e-4228-4eb3-8286-e6a73cbddea7','37ef8d1b-f9c5-44d5-b7e8-f1fd523f1d8d',0,0,'2016-11-08 09:21:21.821000','2016-11-08 09:54:08.020000'),
  ('05aa78f6-ad59-4421-83cd-b14d06ec8cff','9a050104-8e67-4eec-9812-9d74499d77e3','PERDA_DE_PASSAGEM','e52ff58d-a44b-4c1d-aa5a-7d90a68d0816','e7ae783c-a771-439d-b2ca-d25f305478d5','700b1104-11c1-4094-aacf-c0ee5bf9ce83',0,0,'2016-11-08 09:21:21.799000','2016-11-08 09:54:08.018000'),
  ('06743491-6894-4b9d-9297-2b4bb7651503','554e1b20-e50e-4524-9bf1-31b1d3442528','GANHO_DE_PASSAGEM','7ff271f4-81ef-4422-8461-b15c44051fd8','e90ddae4-99b2-4bef-96bd-3f6a515bee9b','f48789ba-bbeb-4e96-afe7-587abf7a72d7',0,0,'2016-11-08 09:50:52.076000','2016-11-08 09:51:40.825000'),
  ('0a098226-368c-4ab3-9421-984ee5ca8ef4','1fcc3db8-0847-4879-a868-626f7cc5ebf7','PERDA_DE_PASSAGEM','53b67934-ce51-4dd7-b4c6-e1abedcd4abb','e924c0b9-e952-4ea5-9886-a6212ec475c2','8977c23d-d3de-46b0-99b4-4813b4e4bee6',0,1,'2016-11-08 09:11:53.011000','2016-11-08 09:17:01.398000'),
  ('0a1b64dc-7bb6-4a56-b2e4-ae910ea5a8be','48dafa24-34f3-4000-b578-4a3360d36b36','GANHO_DE_PASSAGEM','c5dc4dbe-2d49-4e1d-b6c0-449b13e16240','fb7801a1-ed3b-48a7-af14-212f87da132b','391dc5fc-ca18-4716-885e-2c75a3bb9ea5',0,0,'2016-11-08 09:54:07.423000','2016-11-08 09:54:08.111000'),
  ('0acaebad-5c94-4dd3-9a23-6c870d1ad862','6ae3ba29-4204-4a02-b7f2-17b6ebe01c97','PERDA_DE_PASSAGEM','84bcba8f-93c4-4fb2-9aac-457262312441','e53b38b4-e2b1-495b-9970-dc9dd16b38a2','790dde51-8406-4ebe-9876-dfd67f5fa9d3',0,1,'2016-11-08 09:50:52.062000','2016-11-08 09:51:40.809000'),
  ('0afeaf7a-a31a-428d-8fd8-57ebcf123df9','9669d211-b583-489b-9a92-acbbc06aa1c3','PERDA_DE_PASSAGEM','73487232-6688-40a8-a068-86a7cffe6b69','700b1104-11c1-4094-aacf-c0ee5bf9ce83','e7ae783c-a771-439d-b2ca-d25f305478d5',0,0,'2016-11-08 09:21:21.634000','2016-11-08 09:54:08.015000'),
  ('0e6ca9e5-1824-4651-a2b9-4477fbb5be91','7802c12e-b117-4bde-bfc6-cfba9fcece88','GANHO_DE_PASSAGEM','73487232-6688-40a8-a068-86a7cffe6b69','e7ae783c-a771-439d-b2ca-d25f305478d5','700b1104-11c1-4094-aacf-c0ee5bf9ce83',0,0,'2016-11-08 09:21:21.792000','2016-11-08 09:54:08.015000'),
  ('0ee81a02-0446-48f3-8c59-03d5be9f6d73','2302123b-b369-4f35-8191-637c95a2a6a1','GANHO_DE_PASSAGEM','53b67934-ce51-4dd7-b4c6-e1abedcd4abb','8977c23d-d3de-46b0-99b4-4813b4e4bee6','e924c0b9-e952-4ea5-9886-a6212ec475c2',0,0,'2016-11-08 09:11:53.013000','2016-11-08 09:17:01.398000'),
  ('101dea75-94cc-495a-b146-39eb635bcf7c','9e3bb8b2-5474-42e6-a583-0586f3a40fc4','PERDA_DE_PASSAGEM','4d592444-7995-4146-a9a3-e491e5d695a6','4e58dfc3-fa71-495a-883d-bc6b59efcd9d','02249237-5121-4a89-b95c-2ccdec19114b',0,0,'2016-11-08 09:54:07.488000','2016-11-08 09:54:08.115000'),
  ('1027dffe-9195-43e0-9931-5055704b7742','2f9b6c43-30d6-41c8-8fb0-40cc930cb2ec','GANHO_DE_PASSAGEM','155bd3c9-2fc8-4cca-9748-d6580f160dc2','e962d14b-b269-42fb-b5af-c727b16678bd','37ef8d1b-f9c5-44d5-b7e8-f1fd523f1d8d',0,0,'2016-11-08 09:21:21.616000','2016-11-08 09:54:08.009000'),
  ('1258b76c-09f7-4aa2-8b96-1020310b47d5','3077941c-b382-480e-9d69-e56162415b22','PERDA_DE_PASSAGEM','d301c7f5-6b95-4eac-b4f1-fcb314cb5b9a','b4713f89-5fbd-4134-8b42-c6c473715f29','a7bc0cc5-95bb-46f5-9ebf-725f3d874082',0,0,'2016-11-08 09:06:59.143000','2016-11-08 09:09:11.419000'),
  ('13d9faae-ba04-4238-98e7-e4a52f17a789','814739e3-fb7f-4b4f-bf1f-d28c2d944674','GANHO_DE_PASSAGEM','12cb4ead-c499-479b-99f1-810b47f4ae83','c230a549-399a-4c93-adf9-91a2a3a06e1b','f023f642-bbd6-4350-a6d7-fcbd77322e82',0,0,'2016-11-08 09:21:21.573000','2016-11-08 09:54:08.022000'),
  ('14cabbd3-3a2a-4bb9-9fd8-4136c7e3c7b9','58fa901c-aa9f-42a9-8326-3d2213f642ce','PERDA_DE_PASSAGEM','77347d0d-1425-4c98-9aa3-2a3678ececd4','89b9fbb7-4148-4b7b-b201-5c60100627f3','fb7801a1-ed3b-48a7-af14-212f87da132b',0,0,'2016-11-08 09:54:07.285000','2016-11-08 09:54:08.032000'),
  ('165b3138-2c5b-4dee-ba9f-a23376a237f9','a4d924be-b800-4d8d-90a6-56df495a6e8a','PERDA_DE_PASSAGEM','4bb4af54-cf60-4bf8-81f5-37ec0c82b5f3','fb7801a1-ed3b-48a7-af14-212f87da132b','89b9fbb7-4148-4b7b-b201-5c60100627f3',0,0,'2016-11-08 09:54:07.409000','2016-11-08 09:54:08.037000'),
  ('1735737b-6ece-41ec-a598-8c709a4e9547','72592647-fb8f-4b0d-8b85-fb05c16d24ff','GANHO_DE_PASSAGEM','3c8ce4de-70a1-44e8-9273-c07f705f130e','4e58dfc3-fa71-495a-883d-bc6b59efcd9d','02249237-5121-4a89-b95c-2ccdec19114b',0,0,'2016-11-08 09:54:07.482000','2016-11-08 09:54:08.113000'),
  ('17c46163-ec3f-4d2f-97c6-babc6e0a41a8','c29e935f-8d0f-4a88-a216-19ebfbce72b1','PERDA_DE_PASSAGEM','e9f671a5-950c-4fc5-9cc7-45acbd53227f','a7bc0cc5-95bb-46f5-9ebf-725f3d874082','540f7370-b266-4d2a-b6d9-04187a333945',0,0,'2016-11-08 09:06:59.156000','2016-11-08 09:09:11.426000'),
  ('18a76d11-d0ea-435d-8eb9-8dd566520ad1','83db3c11-8a5d-4b87-8dd2-163d12f2ee8a','PERDA_DE_PASSAGEM','da7e4e08-e87b-4734-9f36-6ab8ab3a5893','9f7fa835-1010-48ca-b282-218cf7b24ba7','fb7801a1-ed3b-48a7-af14-212f87da132b',0,0,'2016-11-08 09:54:07.432000','2016-11-08 09:54:08.113000'),
  ('18b5a0d9-3995-4d4f-ba12-c0fe77c4bdcc','970b1e86-9e7c-4079-97ed-d68c18328696','GANHO_DE_PASSAGEM','77347d0d-1425-4c98-9aa3-2a3678ececd4','dbe60c2b-e495-4363-9cce-7a83348800ee','89b9fbb7-4148-4b7b-b201-5c60100627f3',0,0,'2016-11-08 09:54:07.288000','2016-11-08 09:54:08.033000'),
  ('1e38cb17-1613-4269-9c3d-5e494e9c8996','6fb7b328-aa5b-443c-a446-f20580237a76','PERDA_DE_PASSAGEM','d268b155-7b77-4dd0-af4a-d23376a8a15c','180caf55-d387-443b-ba54-5fb030f725e2','caaebab1-8d69-44cb-aead-7bdb48dd444f',0,1,'2016-11-08 09:06:59.177000','2016-11-08 09:09:11.405000'),
  ('1f658b5e-dfe7-4da1-95fc-f70cb8611745','bdc0d709-4128-44e3-ade7-b4f88cc7a828','GANHO_DE_PASSAGEM','4829f07e-2807-4054-b8e7-ddb2bcdcbcfa','4b411e49-2496-436b-b9cc-dd50dd79b021','9cbe2d7c-da23-4df6-b6cf-927d3163b31a',0,0,'2016-11-08 09:11:53.020000','2016-11-08 09:17:01.394000'),
  ('22568d5c-42c8-4c9a-8c72-0676f97c1852','1d6f62fe-af66-441d-a31f-3fb8682150c9','PERDA_DE_PASSAGEM','77347d0d-1425-4c98-9aa3-2a3678ececd4','89b9fbb7-4148-4b7b-b201-5c60100627f3','391dc5fc-ca18-4716-885e-2c75a3bb9ea5',0,1,'2016-11-08 09:54:07.287000','2016-11-08 09:54:08.033000'),
  ('22577ed7-0935-4422-9f51-d6655919e045','63980e2e-2f7f-4137-aa54-9238ceececb8','PERDA_DE_PASSAGEM','c5dc4dbe-2d49-4e1d-b6c0-449b13e16240','391dc5fc-ca18-4716-885e-2c75a3bb9ea5','dbe60c2b-e495-4363-9cce-7a83348800ee',0,0,'2016-11-08 09:54:07.419000','2016-11-08 09:54:08.039000'),
  ('23494a61-a4da-4e57-8672-c575f18db312','e2d97ebc-d039-41ea-86ae-394a7a5ed8e4','GANHO_DE_PASSAGEM','efd9bc6e-d318-4654-994c-3aafff5e3b66','e962d14b-b269-42fb-b5af-c727b16678bd','8ddf1f7e-4228-4eb3-8286-e6a73cbddea7',0,0,'2016-11-08 09:21:21.823000','2016-11-08 09:54:08.021000'),
  ('23983aa1-b5a5-4eb7-a92a-0d3b0fd849e5','f51921a1-c11f-46aa-afce-323cb3771b9f','PERDA_DE_PASSAGEM','7ff271f4-81ef-4422-8461-b15c44051fd8','f48789ba-bbeb-4e96-afe7-587abf7a72d7','e90ddae4-99b2-4bef-96bd-3f6a515bee9b',0,1,'2016-11-08 09:50:52.075000','2016-11-08 09:51:40.824000'),
  ('2a62ed6d-ebdf-4dfc-ad22-27c4a3d8c5e2','d3960171-f0ce-469c-ba09-b7ec0c38d414','PERDA_DE_PASSAGEM','77347d0d-1425-4c98-9aa3-2a3678ececd4','89b9fbb7-4148-4b7b-b201-5c60100627f3','9f7fa835-1010-48ca-b282-218cf7b24ba7',0,0,'2016-11-08 09:54:07.289000','2016-11-08 09:54:08.033000'),
  ('2c5cb3a5-5502-4e9b-b643-a9c0a18f3dd3','886b26e8-6903-417f-bbf4-e2c5cbf971b1','GANHO_DE_PASSAGEM','4bb4af54-cf60-4bf8-81f5-37ec0c82b5f3','9f7fa835-1010-48ca-b282-218cf7b24ba7','fb7801a1-ed3b-48a7-af14-212f87da132b',0,0,'2016-11-08 09:54:07.410000','2016-11-08 09:54:08.037000'),
  ('2dc1321e-fe46-48bb-9bed-ae6e0f7582e7','53374471-742e-4549-a646-5235c29402b5','PERDA_DE_PASSAGEM','e52ff58d-a44b-4c1d-aa5a-7d90a68d0816','e7ae783c-a771-439d-b2ca-d25f305478d5','37ef8d1b-f9c5-44d5-b7e8-f1fd523f1d8d',0,0,'2016-11-08 09:21:21.802000','2016-11-08 09:54:08.019000'),
  ('3095c6e6-593c-4636-9df3-4fc468a269de','a819e3ca-22a2-4766-b02d-965fb2fac48f','GANHO_DE_PASSAGEM','1aeadd03-ec04-4bea-a4c7-641125dda206','89b9fbb7-4148-4b7b-b201-5c60100627f3','dbe60c2b-e495-4363-9cce-7a83348800ee',0,0,'2016-11-08 09:54:07.273000','2016-11-08 09:54:08.028000'),
  ('32e41f7c-3f19-4813-8180-c686b36f1524','48d0fca2-60fd-4177-a737-e0894fab900c','GANHO_DE_PASSAGEM','e307d4fc-95ff-45ce-a23d-baae9427599b','180caf55-d387-443b-ba54-5fb030f725e2','caaebab1-8d69-44cb-aead-7bdb48dd444f',0,0,'2016-11-08 09:06:59.189000','2016-11-08 09:09:11.408000'),
  ('3c567ca4-e55c-4ae0-8650-2ea38fba65ac','09896b06-684d-40e2-8930-15f214589b37','GANHO_DE_PASSAGEM','77347d0d-1425-4c98-9aa3-2a3678ececd4','391dc5fc-ca18-4716-885e-2c75a3bb9ea5','89b9fbb7-4148-4b7b-b201-5c60100627f3',0,0,'2016-11-08 09:54:07.284000','2016-11-08 09:54:08.031000'),
  ('3dd242d6-9f94-48ee-a345-a7d367f82e4f','92727a65-3e5a-4290-8361-30a3ed7e1ae6','GANHO_DE_PASSAGEM','73487232-6688-40a8-a068-86a7cffe6b69','e962d14b-b269-42fb-b5af-c727b16678bd','700b1104-11c1-4094-aacf-c0ee5bf9ce83',0,0,'2016-11-08 09:21:21.792000','2016-11-08 09:54:08.016000'),
  ('402a732f-ca50-48df-aa0b-0f5e72e3fabd','c8831689-e149-41b6-a176-673c1718438d','GANHO_DE_PASSAGEM','4c0b8351-28d6-4445-824a-48b6dece50e8','e924c0b9-e952-4ea5-9886-a6212ec475c2','8977c23d-d3de-46b0-99b4-4813b4e4bee6',0,0,'2016-11-08 09:11:53.006000','2016-11-08 09:17:01.397000'),
  ('4250788f-3f22-48d1-bd4f-598a28243964','d7f3ea1b-ac6f-404c-a2c3-b9cf96dcc04a','GANHO_DE_PASSAGEM','682c4d0e-626a-4c3d-8ce3-b6421ea2341a','e7ae783c-a771-439d-b2ca-d25f305478d5','e962d14b-b269-42fb-b5af-c727b16678bd',0,0,'2016-11-08 09:21:21.628000','2016-11-08 09:54:08.012000'),
  ('479120db-0c0b-4b27-bbaa-a05534294780','6e860bdf-fda7-4114-bd3f-36471d89ec42','GANHO_DE_PASSAGEM','c9284008-54bc-438f-88cc-363e7752a148','e53b38b4-e2b1-495b-9970-dc9dd16b38a2','790dde51-8406-4ebe-9876-dfd67f5fa9d3',0,0,'2016-11-08 09:50:52.069000','2016-11-08 09:51:40.814000'),
  ('4d0b3404-c079-4e46-894b-29611333b196','ed102f8b-ff91-407d-b6a5-12c30b596b4e','PERDA_DE_PASSAGEM','bf6524f8-9a7e-4be8-8e35-4fd4f909d1c4','db44e2c6-bad3-4436-a19f-174121bb3815','e091b797-de64-43ad-ab3b-7ed6a1122351',0,1,'2016-11-08 10:22:42.727000','2016-11-08 10:33:03.660000'),
  ('4eb14be7-c3a7-4654-8f2b-814a59450096','a4fca258-0765-4811-9cae-e2edf754254f','PERDA_DE_PASSAGEM','682c4d0e-626a-4c3d-8ce3-b6421ea2341a','e962d14b-b269-42fb-b5af-c727b16678bd','700b1104-11c1-4094-aacf-c0ee5bf9ce83',0,0,'2016-11-08 09:21:21.623000','2016-11-08 09:54:08.012000'),
  ('4fac9910-26d0-428a-bb24-8f42e34965e2','e55c3045-3cd5-4b8c-9ebf-f84981673482','GANHO_DE_PASSAGEM','da7e4e08-e87b-4734-9f36-6ab8ab3a5893','fb7801a1-ed3b-48a7-af14-212f87da132b','9f7fa835-1010-48ca-b282-218cf7b24ba7',0,0,'2016-11-08 09:54:07.431000','2016-11-08 09:54:08.112000'),
  ('4ffe07a1-e4a9-4d85-8c54-7857f806d23b','ea6914e5-9d46-48cb-90f2-2f1c182d9f21','GANHO_DE_PASSAGEM','84bcba8f-93c4-4fb2-9aac-457262312441','790dde51-8406-4ebe-9876-dfd67f5fa9d3','e53b38b4-e2b1-495b-9970-dc9dd16b38a2',0,0,'2016-11-08 09:50:52.064000','2016-11-08 09:51:40.810000'),
  ('50888535-a408-4e1e-a91f-c3a9508ff3c9','3c15bec2-e399-4aa4-b246-4c14ffcf873f','PERDA_DE_PASSAGEM','73487232-6688-40a8-a068-86a7cffe6b69','700b1104-11c1-4094-aacf-c0ee5bf9ce83','8ddf1f7e-4228-4eb3-8286-e6a73cbddea7',0,0,'2016-11-08 09:21:21.638000','2016-11-08 09:54:08.016000'),
  ('52cffbb9-8971-4248-947d-bbc8ae8b4420','c2a9f79e-d16d-4671-960e-5057a2ef1de5','GANHO_DE_PASSAGEM','5d777b9c-5c6b-4de3-b4d1-a8ccbe92e88a','4e58dfc3-fa71-495a-883d-bc6b59efcd9d','b78ab5e1-8cbb-4971-8e8b-a47497d0664b',0,0,'2016-11-08 09:54:07.582000','2016-11-08 09:54:08.116000'),
  ('53768de4-70cf-4969-b435-4283f54532d5','6865764e-6cf2-4a66-b285-25c149716cfe','GANHO_DE_PASSAGEM','d0fe4320-ac2c-4623-ae92-49bc89f43438','f48789ba-bbeb-4e96-afe7-587abf7a72d7','e90ddae4-99b2-4bef-96bd-3f6a515bee9b',0,0,'2016-11-08 09:50:52.097000','2016-11-08 09:51:40.829000'),
  ('544d5fd2-d9b7-437f-82b5-c6b30eb5414f','05923286-27c1-4298-970a-37f7c82b6240','PERDA_DE_PASSAGEM','438bea60-53f6-4a0c-ab26-d2c9ca061b23','c230a549-399a-4c93-adf9-91a2a3a06e1b','f023f642-bbd6-4350-a6d7-fcbd77322e82',0,0,'2016-11-08 09:21:21.578000','2016-11-08 09:54:08.023000'),
  ('544f4a1d-851b-45e7-9ffc-c75a82c907d6','fdf19355-e1fa-475e-9d33-efed9bf29394','GANHO_DE_PASSAGEM','1aeadd03-ec04-4bea-a4c7-641125dda206','391dc5fc-ca18-4716-885e-2c75a3bb9ea5','dbe60c2b-e495-4363-9cce-7a83348800ee',0,0,'2016-11-08 09:54:07.276000','2016-11-08 09:54:08.029000'),
  ('5470d81b-c1d4-4017-aa49-f9611d7a45ce','73cd3fba-19b0-4760-b97d-a537dd61099a','PERDA_DE_PASSAGEM','efd9bc6e-d318-4654-994c-3aafff5e3b66','8ddf1f7e-4228-4eb3-8286-e6a73cbddea7','e962d14b-b269-42fb-b5af-c727b16678bd',0,1,'2016-11-08 09:21:21.820000','2016-11-08 09:54:08.021000'),
  ('5480e50d-eed4-4ec8-a313-9992872956e4','e52145d4-ba76-46aa-a70e-c3ee56a92947','PERDA_DE_PASSAGEM','155bd3c9-2fc8-4cca-9748-d6580f160dc2','37ef8d1b-f9c5-44d5-b7e8-f1fd523f1d8d','700b1104-11c1-4094-aacf-c0ee5bf9ce83',0,0,'2016-11-08 09:21:21.603000','2016-11-08 09:54:08.009000'),
  ('5650dc81-2b49-4819-8caa-b6455ccd714d','7b0f72bd-848f-4749-8d8b-70dd9b02fc00','PERDA_DE_PASSAGEM','4bb4af54-cf60-4bf8-81f5-37ec0c82b5f3','fb7801a1-ed3b-48a7-af14-212f87da132b','9f7fa835-1010-48ca-b282-218cf7b24ba7',0,0,'2016-11-08 09:54:07.405000','2016-11-08 09:54:08.036000'),
  ('5a7ffad7-732a-4453-9e27-f4cecc8f19ad','7b77b211-5b07-4661-a66c-5238792e7dd9','GANHO_DE_PASSAGEM','c5dc4dbe-2d49-4e1d-b6c0-449b13e16240','89b9fbb7-4148-4b7b-b201-5c60100627f3','391dc5fc-ca18-4716-885e-2c75a3bb9ea5',0,0,'2016-11-08 09:54:07.422000','2016-11-08 09:54:08.110000'),
  ('5b73d628-6e3a-4426-a73b-a827817950ad','5e17519f-9aff-4616-8db2-8614a2fb4fc0','PERDA_DE_PASSAGEM','462dd6ae-acf9-4a1b-b266-b6a29b47c1fa','5ab242ec-8c7f-44d5-903c-0df019861685','25312c1e-f509-4740-baa2-adc910ce2473',0,1,'2016-11-08 10:22:42.745000','2016-11-08 10:33:03.654000'),
  ('60b216d5-e387-4c70-b3f2-d20201fa311d','bee27309-59c8-4dc3-93c2-ff0380b92f2f','GANHO_DE_PASSAGEM','4d592444-7995-4146-a9a3-e491e5d695a6','02249237-5121-4a89-b95c-2ccdec19114b','4e58dfc3-fa71-495a-883d-bc6b59efcd9d',0,0,'2016-11-08 09:54:07.489000','2016-11-08 09:54:08.115000'),
  ('623ffd0d-1136-4e7b-92f6-49564d45d9b4','d733c40b-606e-47a1-8086-24e4bc693a8e','PERDA_DE_PASSAGEM','1aeadd03-ec04-4bea-a4c7-641125dda206','dbe60c2b-e495-4363-9cce-7a83348800ee','391dc5fc-ca18-4716-885e-2c75a3bb9ea5',0,1,'2016-11-08 09:54:07.280000','2016-11-08 09:54:08.031000'),
  ('6a1666b3-0e30-4812-b335-6008b9f8ad27','87b907b0-7d40-4b48-91cd-6fdf0e5bf1d9','PERDA_DE_PASSAGEM','d301c7f5-6b95-4eac-b4f1-fcb314cb5b9a','b4713f89-5fbd-4134-8b42-c6c473715f29','540f7370-b266-4d2a-b6d9-04187a333945',0,1,'2016-11-08 09:06:59.146000','2016-11-08 09:09:11.420000'),
  ('6abf82a3-6d98-42b0-9624-72b950579965','90fc581f-1c56-4e54-be26-444afb89ae32','GANHO_DE_PASSAGEM','717c6bc5-9098-464c-b19a-e2f0c7e6d40f','a7bc0cc5-95bb-46f5-9ebf-725f3d874082','540f7370-b266-4d2a-b6d9-04187a333945',0,0,'2016-11-08 09:06:59.118000','2016-11-08 09:09:11.412000'),
  ('6aec776e-fd93-4d82-b067-0101c39cbd74','4237e787-b453-4bd9-a206-99a77ad62eaf','PERDA_DE_PASSAGEM','4c0b8351-28d6-4445-824a-48b6dece50e8','8977c23d-d3de-46b0-99b4-4813b4e4bee6','e924c0b9-e952-4ea5-9886-a6212ec475c2',0,1,'2016-11-08 09:11:53.005000','2016-11-08 09:17:01.397000'),
  ('73d95971-52c0-452c-9d44-c7f2719f1cb3','f1926ee5-08d1-43a6-92f7-c884555a4780','GANHO_DE_PASSAGEM','efd9bc6e-d318-4654-994c-3aafff5e3b66','700b1104-11c1-4094-aacf-c0ee5bf9ce83','8ddf1f7e-4228-4eb3-8286-e6a73cbddea7',0,0,'2016-11-08 09:21:21.822000','2016-11-08 09:54:08.022000'),
  ('73ef269d-9abc-418f-8158-b3a84aa3f109','32b570f0-b7cd-4170-be96-332b7f0ae3a0','PERDA_DE_PASSAGEM','efd9bc6e-d318-4654-994c-3aafff5e3b66','8ddf1f7e-4228-4eb3-8286-e6a73cbddea7','700b1104-11c1-4094-aacf-c0ee5bf9ce83',0,0,'2016-11-08 09:21:21.817000','2016-11-08 09:54:08.022000'),
  ('77616f9f-e295-49aa-bc42-dd77859362ac','2a94a5d6-8605-4982-82e5-0562fe6674c0','GANHO_DE_PASSAGEM','4bb4af54-cf60-4bf8-81f5-37ec0c82b5f3','dbe60c2b-e495-4363-9cce-7a83348800ee','fb7801a1-ed3b-48a7-af14-212f87da132b',0,0,'2016-11-08 09:54:07.408000','2016-11-08 09:54:08.036000'),
  ('7db5b291-f49c-4b5f-a52e-c306381b333c','5766f4ed-c1bf-4e3e-9f27-e5945e4ae4d6','GANHO_DE_PASSAGEM','e9f671a5-950c-4fc5-9cc7-45acbd53227f','b4713f89-5fbd-4134-8b42-c6c473715f29','a7bc0cc5-95bb-46f5-9ebf-725f3d874082',0,0,'2016-11-08 09:06:59.160000','2016-11-08 09:09:11.427000'),
  ('7ec6b9f1-b747-4f61-aab9-55aa1eed7cd2','7a50a9be-2985-473a-948c-ad1b56b47b8b','GANHO_DE_PASSAGEM','4bb4af54-cf60-4bf8-81f5-37ec0c82b5f3','391dc5fc-ca18-4716-885e-2c75a3bb9ea5','fb7801a1-ed3b-48a7-af14-212f87da132b',0,0,'2016-11-08 09:54:07.403000','2016-11-08 09:54:08.035000'),
  ('81659c75-b5a6-4a6b-819e-48c7c4832130','e2f9e246-6daf-408d-903b-4d64326a0b1a','PERDA_DE_PASSAGEM','e52ff58d-a44b-4c1d-aa5a-7d90a68d0816','e7ae783c-a771-439d-b2ca-d25f305478d5','e962d14b-b269-42fb-b5af-c727b16678bd',0,1,'2016-11-08 09:21:21.801000','2016-11-08 09:54:08.019000'),
  ('817ab2fb-defb-46f5-8c5a-bd03a68fde92','4f3de1ac-67dd-4182-ab76-d1a5b19feda9','GANHO_DE_PASSAGEM','3c8ce4de-70a1-44e8-9273-c07f705f130e','b78ab5e1-8cbb-4971-8e8b-a47497d0664b','02249237-5121-4a89-b95c-2ccdec19114b',0,0,'2016-11-08 09:54:07.483000','2016-11-08 09:54:08.114000'),
  ('82902646-67b4-46ef-94b4-94239b99cbf2','ac459740-fc24-46f1-8af3-287e07759b09','GANHO_DE_PASSAGEM','c5dc4dbe-2d49-4e1d-b6c0-449b13e16240','dbe60c2b-e495-4363-9cce-7a83348800ee','391dc5fc-ca18-4716-885e-2c75a3bb9ea5',0,0,'2016-11-08 09:54:07.416000','2016-11-08 09:54:08.038000'),
  ('83b213b4-c246-413d-893b-8881d3f9b8f8','6d247727-19df-4960-8e7c-260ccd21ea41','PERDA_DE_PASSAGEM','717c6bc5-9098-464c-b19a-e2f0c7e6d40f','540f7370-b266-4d2a-b6d9-04187a333945','b4713f89-5fbd-4134-8b42-c6c473715f29',0,1,'2016-11-08 09:06:59.115000','2016-11-08 09:09:11.415000'),
  ('8b15fdfc-3f2e-4ecb-a2ae-416648bfbab5','706cc812-cc66-4570-b1ad-5be6c12afac2','PERDA_DE_PASSAGEM','73487232-6688-40a8-a068-86a7cffe6b69','700b1104-11c1-4094-aacf-c0ee5bf9ce83','37ef8d1b-f9c5-44d5-b7e8-f1fd523f1d8d',0,1,'2016-11-08 09:21:21.636000','2016-11-08 09:54:08.016000'),
  ('8f4e5fae-2ed0-44d2-85f7-3f3e4704441c','259f0627-81ed-4970-891f-d9712d0cbe93','GANHO_DE_PASSAGEM','682c4d0e-626a-4c3d-8ce3-b6421ea2341a','700b1104-11c1-4094-aacf-c0ee5bf9ce83','e962d14b-b269-42fb-b5af-c727b16678bd',0,0,'2016-11-08 09:21:21.628000','2016-11-08 09:54:08.013000'),
  ('927c0b93-dbe3-4cbb-bcc9-13ae70c0790a','4dc0543a-4c45-4778-b877-47ec8fe74095','GANHO_DE_PASSAGEM','4bb4af54-cf60-4bf8-81f5-37ec0c82b5f3','89b9fbb7-4148-4b7b-b201-5c60100627f3','fb7801a1-ed3b-48a7-af14-212f87da132b',0,0,'2016-11-08 09:54:07.404000','2016-11-08 09:54:08.035000'),
  ('93742961-8390-480d-984f-f463b0527423','e01b3195-0873-49d9-b403-6670fa7eb712','GANHO_DE_PASSAGEM','e52ff58d-a44b-4c1d-aa5a-7d90a68d0816','e962d14b-b269-42fb-b5af-c727b16678bd','e7ae783c-a771-439d-b2ca-d25f305478d5',0,0,'2016-11-08 09:21:21.804000','2016-11-08 09:54:08.020000'),
  ('93ee86ed-7878-4031-ba53-79809bb9e6fd','324a74e2-45e3-42bf-bc46-efcc78f0ce70','PERDA_DE_PASSAGEM','c9284008-54bc-438f-88cc-363e7752a148','790dde51-8406-4ebe-9876-dfd67f5fa9d3','e53b38b4-e2b1-495b-9970-dc9dd16b38a2',0,1,'2016-11-08 09:50:52.067000','2016-11-08 09:51:40.813000'),
  ('95eaa96c-f4d2-4f5c-b824-406fe30a88d1','bb309050-8024-44d3-8e3b-602a7c2bd11d','PERDA_DE_PASSAGEM','1aeadd03-ec04-4bea-a4c7-641125dda206','dbe60c2b-e495-4363-9cce-7a83348800ee','89b9fbb7-4148-4b7b-b201-5c60100627f3',0,0,'2016-11-08 09:54:07.277000','2016-11-08 09:54:08.030000'),
  ('961c307d-37ee-4216-8a12-59cd712e32b4','1403373c-fc8f-4af1-bad2-814778ed3734','GANHO_DE_PASSAGEM','12cb4ead-c499-479b-99f1-810b47f4ae83','5f2452f1-b034-43f9-bed8-39ab50e39192','f023f642-bbd6-4350-a6d7-fcbd77322e82',0,0,'2016-11-08 09:21:21.573000','2016-11-08 09:54:08.023000'),
  ('97d7b0d5-490c-42ba-9041-969274152e83','b2e41f5f-afae-4d2d-91cb-cfde0779472e','PERDA_DE_PASSAGEM','682c4d0e-626a-4c3d-8ce3-b6421ea2341a','e962d14b-b269-42fb-b5af-c727b16678bd','e7ae783c-a771-439d-b2ca-d25f305478d5',0,1,'2016-11-08 09:21:21.624000','2016-11-08 09:54:08.013000'),
  ('981a2f3c-1f3b-47ad-ad5b-354bf525c2a8','962f6bca-c44c-454b-96e8-136b80317abb','GANHO_DE_PASSAGEM','155bd3c9-2fc8-4cca-9748-d6580f160dc2','e7ae783c-a771-439d-b2ca-d25f305478d5','37ef8d1b-f9c5-44d5-b7e8-f1fd523f1d8d',0,0,'2016-11-08 09:21:21.616000','2016-11-08 09:54:08.010000'),
  ('9a34aa53-1a0f-462d-85d8-a711e059ac42','529f72f7-778b-495e-bf73-b18d9fd5f1ab','GANHO_DE_PASSAGEM','73487232-6688-40a8-a068-86a7cffe6b69','37ef8d1b-f9c5-44d5-b7e8-f1fd523f1d8d','700b1104-11c1-4094-aacf-c0ee5bf9ce83',0,0,'2016-11-08 09:21:21.793000','2016-11-08 09:54:08.017000'),
  ('a03cb558-b939-45e2-9464-6f78828d2ebc','d6e0e38f-ef5f-4f6f-9137-e83f754b8588','PERDA_DE_PASSAGEM','e9f671a5-950c-4fc5-9cc7-45acbd53227f','a7bc0cc5-95bb-46f5-9ebf-725f3d874082','b4713f89-5fbd-4134-8b42-c6c473715f29',0,1,'2016-11-08 09:06:59.158000','2016-11-08 09:09:11.428000'),
  ('a0b2f42e-b168-412b-86be-6b75a4683ddd','c2a12c0d-c1fd-414b-bc31-ec52f602e832','GANHO_DE_PASSAGEM','1aeadd03-ec04-4bea-a4c7-641125dda206','fb7801a1-ed3b-48a7-af14-212f87da132b','dbe60c2b-e495-4363-9cce-7a83348800ee',0,0,'2016-11-08 09:54:07.280000','2016-11-08 09:54:08.031000'),
  ('a19adea8-2a0e-4210-8595-c9a802008bfe','a35246c4-90ba-47f4-9be0-59f473977ae3','PERDA_DE_PASSAGEM','73487232-6688-40a8-a068-86a7cffe6b69','700b1104-11c1-4094-aacf-c0ee5bf9ce83','e962d14b-b269-42fb-b5af-c727b16678bd',0,0,'2016-11-08 09:21:21.635000','2016-11-08 09:54:08.017000'),
  ('a2f3804a-619b-442d-aa5a-3455b7dc688d','557a4c2c-b25c-4397-a859-aed9bd6fbf02','PERDA_DE_PASSAGEM','d0fe4320-ac2c-4623-ae92-49bc89f43438','e90ddae4-99b2-4bef-96bd-3f6a515bee9b','f48789ba-bbeb-4e96-afe7-587abf7a72d7',0,1,'2016-11-08 09:50:52.096000','2016-11-08 09:51:40.828000'),
  ('a3f311e9-c956-49a0-b62b-acaa2e770757','7e9ae280-4b98-4724-ad9e-ca5ad7863f5c','GANHO_DE_PASSAGEM','462dd6ae-acf9-4a1b-b266-b6a29b47c1fa','25312c1e-f509-4740-baa2-adc910ce2473','5ab242ec-8c7f-44d5-903c-0df019861685',0,0,'2016-11-08 10:22:42.747000','2016-11-08 10:33:03.657000'),
  ('a4486873-63cd-4984-a5f8-1246dfa72198','85458e80-3217-4950-951a-0629ef4fc853','GANHO_DE_PASSAGEM','1aeadd03-ec04-4bea-a4c7-641125dda206','9f7fa835-1010-48ca-b282-218cf7b24ba7','dbe60c2b-e495-4363-9cce-7a83348800ee',0,0,'2016-11-08 09:54:07.279000','2016-11-08 09:54:08.030000'),
  ('a5893160-b3e6-45c8-b1c3-90eb7f9007d8','87930637-2099-49e7-863e-75848bb15ca6','PERDA_DE_PASSAGEM','da7e4e08-e87b-4734-9f36-6ab8ab3a5893','9f7fa835-1010-48ca-b282-218cf7b24ba7','89b9fbb7-4148-4b7b-b201-5c60100627f3',0,1,'2016-11-08 09:54:07.429000','2016-11-08 09:54:08.112000'),
  ('a61c1f6c-207a-43b4-962a-63a471ab2acc','dc539547-0623-4103-a61e-dd2210ea266d','GANHO_DE_PASSAGEM','682c4d0e-626a-4c3d-8ce3-b6421ea2341a','37ef8d1b-f9c5-44d5-b7e8-f1fd523f1d8d','e962d14b-b269-42fb-b5af-c727b16678bd',0,0,'2016-11-08 09:21:21.629000','2016-11-08 09:54:08.013000'),
  ('a91e0d26-85ff-4f2d-a5cf-e6a7718e0a44','280685e2-6078-4709-b9f2-8a820aab246d','PERDA_DE_PASSAGEM','155bd3c9-2fc8-4cca-9748-d6580f160dc2','37ef8d1b-f9c5-44d5-b7e8-f1fd523f1d8d','e962d14b-b269-42fb-b5af-c727b16678bd',0,0,'2016-11-08 09:21:21.609000','2016-11-08 09:54:08.010000'),
  ('aab48179-5ba9-4277-9107-6558d8be7022','eb4573b9-6798-4bb9-8e9a-82079e3f6820','GANHO_DE_PASSAGEM','717c6bc5-9098-464c-b19a-e2f0c7e6d40f','b4713f89-5fbd-4134-8b42-c6c473715f29','540f7370-b266-4d2a-b6d9-04187a333945',0,0,'2016-11-08 09:06:59.119000','2016-11-08 09:09:11.418000'),
  ('ab8ea174-02d5-4e57-a3e7-c5fff4e02443','60f2db52-afb4-4f63-8cae-dbaee8df671a','GANHO_DE_PASSAGEM','e9f671a5-950c-4fc5-9cc7-45acbd53227f','540f7370-b266-4d2a-b6d9-04187a333945','a7bc0cc5-95bb-46f5-9ebf-725f3d874082',0,0,'2016-11-08 09:06:59.159000','2016-11-08 09:09:11.428000'),
  ('ad40a3d6-ab97-4947-876f-0d9a3d0e96e3','e1467bec-4e9f-4678-9f16-d3f39d59f8e9','PERDA_DE_PASSAGEM','b920567a-32ac-4233-81ec-858563409d9b','4b411e49-2496-436b-b9cc-dd50dd79b021','9cbe2d7c-da23-4df6-b6cf-927d3163b31a',0,1,'2016-11-08 09:11:53.029000','2016-11-08 09:17:01.395000'),
  ('af6a4b31-8ca0-4263-b739-4fcde3f6451a','45e161f6-4226-4f36-8451-99dbea9bedb5','PERDA_DE_PASSAGEM','b9b212ff-5b33-4f55-a67a-45955d13a66f','25312c1e-f509-4740-baa2-adc910ce2473','5ab242ec-8c7f-44d5-903c-0df019861685',0,1,'2016-11-08 10:22:42.750000','2016-11-08 10:33:03.658000'),
  ('b005f4f2-9a71-4f01-b64c-551820fd9491','736e71cb-9890-4d2e-b7ce-ba28822ed0b2','PERDA_DE_PASSAGEM','c5dc4dbe-2d49-4e1d-b6c0-449b13e16240','391dc5fc-ca18-4716-885e-2c75a3bb9ea5','89b9fbb7-4148-4b7b-b201-5c60100627f3',0,1,'2016-11-08 09:54:07.420000','2016-11-08 09:54:08.109000'),
  ('b00e43b3-9052-4c8a-ae18-059bc3c95151','224d9b02-8b4d-4c1f-b592-957f8db80502','PERDA_DE_PASSAGEM','682c4d0e-626a-4c3d-8ce3-b6421ea2341a','e962d14b-b269-42fb-b5af-c727b16678bd','8ddf1f7e-4228-4eb3-8286-e6a73cbddea7',0,0,'2016-11-08 09:21:21.626000','2016-11-08 09:54:08.014000'),
  ('b5b56a10-010c-4f23-9dd5-b713f1be3663','d9329657-99fb-4cd7-bc52-75660957d053','PERDA_DE_PASSAGEM','77347d0d-1425-4c98-9aa3-2a3678ececd4','89b9fbb7-4148-4b7b-b201-5c60100627f3','dbe60c2b-e495-4363-9cce-7a83348800ee',0,0,'2016-11-08 09:54:07.291000','2016-11-08 09:54:08.034000'),
  ('b870bbd7-4af8-4f0c-944c-1290615eacc9','8cbc73e2-5823-47dd-8082-f9a8de874250','GANHO_DE_PASSAGEM','155bd3c9-2fc8-4cca-9748-d6580f160dc2','8ddf1f7e-4228-4eb3-8286-e6a73cbddea7','37ef8d1b-f9c5-44d5-b7e8-f1fd523f1d8d',0,0,'2016-11-08 09:21:21.617000','2016-11-08 09:54:08.011000'),
  ('b88bfa99-303f-4974-ad51-835afe470663','2126e4f4-bb62-42c3-8bcf-b9faa58861e1','GANHO_DE_PASSAGEM','682c4d0e-626a-4c3d-8ce3-b6421ea2341a','8ddf1f7e-4228-4eb3-8286-e6a73cbddea7','e962d14b-b269-42fb-b5af-c727b16678bd',0,0,'2016-11-08 09:21:21.629000','2016-11-08 09:54:08.014000'),
  ('ba5c9460-d7ce-4e65-9011-95e75e6588cc','da6e3a09-25e1-4bae-8d03-8e66bbe01f8b','GANHO_DE_PASSAGEM','bf6524f8-9a7e-4be8-8e35-4fd4f909d1c4','e091b797-de64-43ad-ab3b-7ed6a1122351','db44e2c6-bad3-4436-a19f-174121bb3815',0,0,'2016-11-08 10:22:42.731000','2016-11-08 10:33:03.660000'),
  ('bab53e13-8648-4a74-8dff-d3e761672ac8','479f332f-0aa9-403c-aa06-dced2d2497ed','PERDA_DE_PASSAGEM','da7e4e08-e87b-4734-9f36-6ab8ab3a5893','9f7fa835-1010-48ca-b282-218cf7b24ba7','dbe60c2b-e495-4363-9cce-7a83348800ee',0,0,'2016-11-08 09:54:07.426000','2016-11-08 09:54:08.111000'),
  ('bce6b953-bf80-4bb3-b809-bd2203f5c60b','ba44b122-81a5-411a-9cc8-6b32229dd3de','GANHO_DE_PASSAGEM','77347d0d-1425-4c98-9aa3-2a3678ececd4','9f7fa835-1010-48ca-b282-218cf7b24ba7','89b9fbb7-4148-4b7b-b201-5c60100627f3',0,0,'2016-11-08 09:54:07.290000','2016-11-08 09:54:08.034000'),
  ('bf15cf36-5afb-432f-8144-e31ef355977c','55d25e3f-f783-4113-825c-240530ded9ed','GANHO_DE_PASSAGEM','d301c7f5-6b95-4eac-b4f1-fcb314cb5b9a','540f7370-b266-4d2a-b6d9-04187a333945','b4713f89-5fbd-4134-8b42-c6c473715f29',0,0,'2016-11-08 09:06:59.149000','2016-11-08 09:09:11.424000'),
  ('bf293a4b-9c5f-40a4-bc1d-4a41e991a383','d88b2313-ffc4-40a6-8227-d5d6427e6bdf','GANHO_DE_PASSAGEM','155bd3c9-2fc8-4cca-9748-d6580f160dc2','700b1104-11c1-4094-aacf-c0ee5bf9ce83','37ef8d1b-f9c5-44d5-b7e8-f1fd523f1d8d',0,0,'2016-11-08 09:21:21.615000','2016-11-08 09:54:08.011000'),
  ('bfbb8d3b-528e-4092-b7e9-62e109472935','ed23eef4-1e17-4ca1-bba1-2dfd74b0a830','PERDA_DE_PASSAGEM','155bd3c9-2fc8-4cca-9748-d6580f160dc2','37ef8d1b-f9c5-44d5-b7e8-f1fd523f1d8d','e7ae783c-a771-439d-b2ca-d25f305478d5',0,1,'2016-11-08 09:21:21.606000','2016-11-08 09:54:08.011000'),
  ('c114efef-9404-451e-945d-17a65d760c25','5443aebf-6314-4457-9025-1d816c4d3788','PERDA_DE_PASSAGEM','1aeadd03-ec04-4bea-a4c7-641125dda206','dbe60c2b-e495-4363-9cce-7a83348800ee','fb7801a1-ed3b-48a7-af14-212f87da132b',0,0,'2016-11-08 09:54:07.275000','2016-11-08 09:54:08.029000'),
  ('c1bea530-c953-4c63-ae93-f45969486f6a','01d0a636-6eb0-49bf-a16d-8a80ae7aa911','GANHO_DE_PASSAGEM','d268b155-7b77-4dd0-af4a-d23376a8a15c','caaebab1-8d69-44cb-aead-7bdb48dd444f','180caf55-d387-443b-ba54-5fb030f725e2',0,0,'2016-11-08 09:06:59.179000','2016-11-08 09:09:11.407000'),
  ('c274d0d9-cfee-401d-9d67-722750ae43c6','da281a29-320a-46d6-966c-ec2c84cf87d7','GANHO_DE_PASSAGEM','73487232-6688-40a8-a068-86a7cffe6b69','8ddf1f7e-4228-4eb3-8286-e6a73cbddea7','700b1104-11c1-4094-aacf-c0ee5bf9ce83',0,0,'2016-11-08 09:21:21.794000','2016-11-08 09:54:08.018000'),
  ('c3917213-922a-4968-beac-13e6fb135633','d348f911-47f4-46e6-b341-4bc20ecba62b','GANHO_DE_PASSAGEM','7081b5d1-c597-4ba0-a232-453a6b1fc8e9','c230a549-399a-4c93-adf9-91a2a3a06e1b','5f2452f1-b034-43f9-bed8-39ab50e39192',0,0,'2016-11-08 09:21:21.591000','2016-11-08 09:54:08.025000'),
  ('c4a02b33-36d4-4c20-bbd7-617e0dd17118','af16a64b-01b4-4555-9047-a3c2ae7f298c','GANHO_DE_PASSAGEM','77347d0d-1425-4c98-9aa3-2a3678ececd4','fb7801a1-ed3b-48a7-af14-212f87da132b','89b9fbb7-4148-4b7b-b201-5c60100627f3',0,0,'2016-11-08 09:54:07.286000','2016-11-08 09:54:08.032000'),
  ('c4ac5ab6-d121-4665-8fc8-f1f556dfe26b','046c0e39-2082-4c41-936d-0fccffe9a5f3','GANHO_DE_PASSAGEM','e52ff58d-a44b-4c1d-aa5a-7d90a68d0816','700b1104-11c1-4094-aacf-c0ee5bf9ce83','e7ae783c-a771-439d-b2ca-d25f305478d5',0,0,'2016-11-08 09:21:21.804000','2016-11-08 09:54:08.020000'),
  ('c7c85148-0af2-4eda-adaa-f043ba6dc3f5','4133176c-26fc-43c1-bacd-250d0c46745d','GANHO_DE_PASSAGEM','da7e4e08-e87b-4734-9f36-6ab8ab3a5893','89b9fbb7-4148-4b7b-b201-5c60100627f3','9f7fa835-1010-48ca-b282-218cf7b24ba7',0,0,'2016-11-08 09:54:07.428000','2016-11-08 09:54:08.112000'),
  ('c86e3be1-0061-4b72-9769-0f7feffe577b','169f668d-378d-4bfa-86c1-93d38c5c1ab1','PERDA_DE_PASSAGEM','5d777b9c-5c6b-4de3-b4d1-a8ccbe92e88a','b78ab5e1-8cbb-4971-8e8b-a47497d0664b','4e58dfc3-fa71-495a-883d-bc6b59efcd9d',0,0,'2016-11-08 09:54:07.583000','2016-11-08 09:54:08.117000'),
  ('cb56cd9f-4ebc-4438-96b5-038d83e1f234','8b5f25b1-dc15-4843-af11-b06b1a200897','GANHO_DE_PASSAGEM','438bea60-53f6-4a0c-ab26-d2c9ca061b23','f023f642-bbd6-4350-a6d7-fcbd77322e82','c230a549-399a-4c93-adf9-91a2a3a06e1b',0,0,'2016-11-08 09:21:21.582000','2016-11-08 09:54:08.024000'),
  ('cf4d2b55-c9f7-45d2-9350-ae71bb09c248','cc2b67f0-3531-46d3-8465-9ff0460213e0','PERDA_DE_PASSAGEM','717c6bc5-9098-464c-b19a-e2f0c7e6d40f','540f7370-b266-4d2a-b6d9-04187a333945','a7bc0cc5-95bb-46f5-9ebf-725f3d874082',0,0,'2016-11-08 09:06:59.113000','2016-11-08 09:09:11.419000'),
  ('d3f654f5-1458-47ac-b4a7-e9f22a9275df','63405c12-04a9-47b9-be49-41e8d25d15d2','PERDA_DE_PASSAGEM','682c4d0e-626a-4c3d-8ce3-b6421ea2341a','e962d14b-b269-42fb-b5af-c727b16678bd','37ef8d1b-f9c5-44d5-b7e8-f1fd523f1d8d',0,0,'2016-11-08 09:21:21.625000','2016-11-08 09:54:08.014000'),
  ('d4683884-2f84-4976-af96-2cb6fb43c701','1d024662-e187-4b8e-9f64-d5c1d5ddc6dc','PERDA_DE_PASSAGEM','12cb4ead-c499-479b-99f1-810b47f4ae83','f023f642-bbd6-4350-a6d7-fcbd77322e82','c230a549-399a-4c93-adf9-91a2a3a06e1b',0,1,'2016-11-08 09:21:21.568000','2016-11-08 09:54:08.023000'),
  ('d779c445-7932-446f-98c7-a0139edd6041','0344f3c0-5f86-45b9-9788-2a56f0e6e675','GANHO_DE_PASSAGEM','b9b212ff-5b33-4f55-a67a-45955d13a66f','5ab242ec-8c7f-44d5-903c-0df019861685','25312c1e-f509-4740-baa2-adc910ce2473',0,0,'2016-11-08 10:22:42.751000','2016-11-08 10:33:03.658000'),
  ('db11c178-122d-449e-ad06-0fd07816286d','066d1a7c-ec83-45cb-a99b-fde72e909fde','PERDA_DE_PASSAGEM','4bb4af54-cf60-4bf8-81f5-37ec0c82b5f3','fb7801a1-ed3b-48a7-af14-212f87da132b','391dc5fc-ca18-4716-885e-2c75a3bb9ea5',0,0,'2016-11-08 09:54:07.401000','2016-11-08 09:54:08.034000'),
  ('ddb3e27d-c0fc-4111-9ecb-a00a2fd45b88','641a87e4-59dd-43ef-9628-7fc9fe226044','GANHO_DE_PASSAGEM','d301c7f5-6b95-4eac-b4f1-fcb314cb5b9a','a7bc0cc5-95bb-46f5-9ebf-725f3d874082','b4713f89-5fbd-4134-8b42-c6c473715f29',0,0,'2016-11-08 09:06:59.149000','2016-11-08 09:09:11.426000'),
  ('e49c3d35-25af-4d08-b69c-4afa78eab3ad','69261970-db6a-42e5-8391-5ef7010829f0','PERDA_DE_PASSAGEM','4829f07e-2807-4054-b8e7-ddb2bcdcbcfa','9cbe2d7c-da23-4df6-b6cf-927d3163b31a','4b411e49-2496-436b-b9cc-dd50dd79b021',0,1,'2016-11-08 09:11:53.018000','2016-11-08 09:17:01.395000'),
  ('e7ec9ea9-d043-4f38-8da5-6274d0ae5192','0dc10536-105f-4b9d-a9eb-70f5b85817fd','PERDA_DE_PASSAGEM','3c8ce4de-70a1-44e8-9273-c07f705f130e','02249237-5121-4a89-b95c-2ccdec19114b','4e58dfc3-fa71-495a-883d-bc6b59efcd9d',0,1,'2016-11-08 09:54:07.484000','2016-11-08 09:54:08.114000'),
  ('e910732b-b6fb-48e4-804e-cb04b27d8fd2','02c0d584-4516-47c3-bea0-0890980706a5','PERDA_DE_PASSAGEM','7081b5d1-c597-4ba0-a232-453a6b1fc8e9','5f2452f1-b034-43f9-bed8-39ab50e39192','c230a549-399a-4c93-adf9-91a2a3a06e1b',0,0,'2016-11-08 09:21:21.588000','2016-11-08 09:54:08.025000'),
  ('e925e8b3-b102-4560-9ead-79f91eae745b','6bad2652-006e-4def-a0f7-455e6b35d5b9','PERDA_DE_PASSAGEM','e307d4fc-95ff-45ce-a23d-baae9427599b','caaebab1-8d69-44cb-aead-7bdb48dd444f','180caf55-d387-443b-ba54-5fb030f725e2',0,1,'2016-11-08 09:06:59.184000','2016-11-08 09:09:11.409000'),
  ('eb5e6d66-96dd-4b9a-b479-d26d4af74928','c2acc1a5-2ebb-4e9b-a7a3-a7cf6cebfe8c','GANHO_DE_PASSAGEM','72dab597-6715-40d6-abce-2724b5cff1f9','db44e2c6-bad3-4436-a19f-174121bb3815','e091b797-de64-43ad-ab3b-7ed6a1122351',0,0,'2016-11-08 10:22:42.720000','2016-11-08 10:33:03.659000'),
  ('eb7ed6ff-d8ce-42f6-87fc-e12a5b24b11b','5325992d-d7f3-4dae-a114-bfac3b718341','PERDA_DE_PASSAGEM','72dab597-6715-40d6-abce-2724b5cff1f9','e091b797-de64-43ad-ab3b-7ed6a1122351','db44e2c6-bad3-4436-a19f-174121bb3815',0,1,'2016-11-08 10:22:42.719000','2016-11-08 10:33:03.660000'),
  ('ec5d3027-6ba1-417e-b491-2a766900809e','ad9bf7d6-5e79-48ea-b9b4-792d04f3d153','GANHO_DE_PASSAGEM','b920567a-32ac-4233-81ec-858563409d9b','9cbe2d7c-da23-4df6-b6cf-927d3163b31a','4b411e49-2496-436b-b9cc-dd50dd79b021',0,0,'2016-11-08 09:11:53.031000','2016-11-08 09:17:01.396000'),
  ('ed8f5459-0075-4172-8d8a-e5fe1b66aa0d','80c3df5b-ac8a-4dec-9aea-c9dd7f7c36fb','PERDA_DE_PASSAGEM','c5dc4dbe-2d49-4e1d-b6c0-449b13e16240','391dc5fc-ca18-4716-885e-2c75a3bb9ea5','fb7801a1-ed3b-48a7-af14-212f87da132b',0,0,'2016-11-08 09:54:07.417000','2016-11-08 09:54:08.038000'),
  ('ed9ca7e0-2f4c-42a4-b89c-2358278f717a','8a48496e-74f9-43c9-8f17-bd0493843ea9','GANHO_DE_PASSAGEM','438bea60-53f6-4a0c-ab26-d2c9ca061b23','5f2452f1-b034-43f9-bed8-39ab50e39192','c230a549-399a-4c93-adf9-91a2a3a06e1b',0,0,'2016-11-08 09:21:21.582000','2016-11-08 09:54:08.024000'),
  ('f0596885-a211-498e-99fc-f238c64e1936','d0b19ec9-2af1-4bed-b3d9-c97e1f131fcf','PERDA_DE_PASSAGEM','438bea60-53f6-4a0c-ab26-d2c9ca061b23','c230a549-399a-4c93-adf9-91a2a3a06e1b','5f2452f1-b034-43f9-bed8-39ab50e39192',0,1,'2016-11-08 09:21:21.580000','2016-11-08 09:54:08.024000'),
  ('f3a658eb-07d1-4774-bd83-a6eaa376bb04','cf0846e3-e8db-4d82-a2d6-001982f4c38f','PERDA_DE_PASSAGEM','4bb4af54-cf60-4bf8-81f5-37ec0c82b5f3','fb7801a1-ed3b-48a7-af14-212f87da132b','dbe60c2b-e495-4363-9cce-7a83348800ee',0,1,'2016-11-08 09:54:07.407000','2016-11-08 09:54:08.036000'),
  ('f7862840-e11b-42e3-9c27-5eeaa8d1d293','303b6e0e-ce08-4937-b233-6b718552656e','PERDA_DE_PASSAGEM','4d592444-7995-4146-a9a3-e491e5d695a6','4e58dfc3-fa71-495a-883d-bc6b59efcd9d','b78ab5e1-8cbb-4971-8e8b-a47497d0664b',0,1,'2016-11-08 09:54:07.579000','2016-11-08 09:54:08.116000'),
  ('f7a82221-5c2a-4fd6-a375-83ff252e8394','f16f45be-9642-4b33-ba82-93ba72f41f9a','GANHO_DE_PASSAGEM','4d592444-7995-4146-a9a3-e491e5d695a6','b78ab5e1-8cbb-4971-8e8b-a47497d0664b','4e58dfc3-fa71-495a-883d-bc6b59efcd9d',0,0,'2016-11-08 09:54:07.578000','2016-11-08 09:54:08.115000'),
  ('f833bf51-9b9e-4ed6-97f1-6dbbf8d7368d','33fe6a0f-1a14-4964-a418-3310ced537b3','PERDA_DE_PASSAGEM','5d777b9c-5c6b-4de3-b4d1-a8ccbe92e88a','b78ab5e1-8cbb-4971-8e8b-a47497d0664b','02249237-5121-4a89-b95c-2ccdec19114b',0,1,'2016-11-08 09:54:07.585000','2016-11-08 09:54:08.117000'),
  ('f88e3498-f9ed-4d0b-bb9d-ccd09fd75bf9','b9f711e9-abde-4042-aa15-495ebdaa1354','PERDA_DE_PASSAGEM','7081b5d1-c597-4ba0-a232-453a6b1fc8e9','5f2452f1-b034-43f9-bed8-39ab50e39192','f023f642-bbd6-4350-a6d7-fcbd77322e82',0,1,'2016-11-08 09:21:21.589000','2016-11-08 09:54:08.026000');

INSERT INTO `transicoes_proibidas` (`id`, `id_json`, `origem_id`, `destino_id`, `alternativo_id`, `data_criacao`, `data_atualizacao`)
VALUES
  ('00a81cb4-1007-4d8f-825b-6836f7246d16','fb1ae559-372d-4557-919e-a915b5086851','f023f642-bbd6-4350-a6d7-fcbd77322e82','5f2452f1-b034-43f9-bed8-39ab50e39192','c230a549-399a-4c93-adf9-91a2a3a06e1b','2016-11-08 09:22:06.713000','2016-11-08 09:33:01.664000'),
  ('1064fa4c-11a0-468b-82b1-990193ad63a8','3bcb9955-6fa5-4d5d-ba78-36f296c5b546','9f7fa835-1010-48ca-b282-218cf7b24ba7','391dc5fc-ca18-4716-885e-2c75a3bb9ea5','89b9fbb7-4148-4b7b-b201-5c60100627f3','2016-11-08 09:54:07.437000','2016-11-08 09:54:07.805000'),
  ('270bf923-8405-4a34-9903-40acd9cf7771','3c427792-2a6a-48f1-b37e-efcdf968657c','8ddf1f7e-4228-4eb3-8286-e6a73cbddea7','e7ae783c-a771-439d-b2ca-d25f305478d5','e962d14b-b269-42fb-b5af-c727b16678bd','2016-11-08 09:22:06.898000','2016-11-08 09:33:02.099000'),
  ('2948233b-1fc4-41a3-8ecd-1c8bcf545946','64046b8c-4349-413e-8515-3fe9bad198f4','37ef8d1b-f9c5-44d5-b7e8-f1fd523f1d8d','8ddf1f7e-4228-4eb3-8286-e6a73cbddea7','e7ae783c-a771-439d-b2ca-d25f305478d5','2016-11-08 09:22:06.897000','2016-11-08 09:33:02.097000'),
  ('2db685f0-efb0-4263-90a0-634182a90332','6b94b43f-fbdb-4c94-8c52-2f40c2492a50','e7ae783c-a771-439d-b2ca-d25f305478d5','8ddf1f7e-4228-4eb3-8286-e6a73cbddea7','e7ae783c-a771-439d-b2ca-d25f305478d5','2016-11-08 09:22:06.892000','2016-11-08 09:33:02.101000'),
  ('43af7b7e-b4b5-44f2-a304-c4a1fe357369','8d360dbd-cd1f-4cb6-8d2b-a728903bbc81','391dc5fc-ca18-4716-885e-2c75a3bb9ea5','9f7fa835-1010-48ca-b282-218cf7b24ba7','391dc5fc-ca18-4716-885e-2c75a3bb9ea5','2016-11-08 09:54:07.464000','2016-11-08 09:54:07.805000'),
  ('c7a72f88-a40c-4d20-8d11-61488308e0bc','7c3364e0-8e40-4cd7-a949-c77169cf62cc','02249237-5121-4a89-b95c-2ccdec19114b','b78ab5e1-8cbb-4971-8e8b-a47497d0664b','4e58dfc3-fa71-495a-883d-bc6b59efcd9d','2016-11-08 09:54:07.589000','2016-11-08 09:54:07.912000'),
  ('d4e48329-838a-465a-a750-3909d31d7864','94e5bc7f-5549-43a8-8c5b-d35a8f729f28','dbe60c2b-e495-4363-9cce-7a83348800ee','9f7fa835-1010-48ca-b282-218cf7b24ba7','391dc5fc-ca18-4716-885e-2c75a3bb9ea5','2016-11-08 09:54:07.435000','2016-11-08 09:54:07.803000');

INSERT INTO `tabela_entre_verdes_transicao` (`id`, `id_json`, `tabela_entre_verdes_id`, `transicao_id`, `tempo_amarelo`, `tempo_vermelho_intermitente`, `tempo_vermelho_limpeza`, `data_criacao`, `data_atualizacao`)
VALUES
  ('00aa230e-6736-4567-9a1b-714eefffa00e','f7752894-0ef0-45a9-bd60-7666fea334bd','9ed66190-053c-407b-b2ba-eaadd2a094d3','01b25f93-c61e-4b88-a7a7-dbc00885ac67',NULL,3,0,'2016-11-08 09:21:21.809000','2016-11-08 09:33:02.090000'),
  ('0c467b2c-68b0-4993-a171-0ed24e1c7b36','37c1f284-363c-40bd-8b8d-bc144f590272','6f417012-38ec-4ec3-8b30-a52d9a216531','22577ed7-0935-4422-9f51-d6655919e045',3,NULL,0,'2016-11-08 09:54:07.415000','2016-11-08 09:54:07.791000'),
  ('102e8afe-e068-4271-b4e1-6d1cf79a0471','3b326c7e-b1c0-4b1a-8d3a-21b9293b921c','6f417012-38ec-4ec3-8b30-a52d9a216531','b005f4f2-9a71-4f01-b64c-551820fd9491',3,NULL,0,'2016-11-08 09:54:07.415000','2016-11-08 09:54:07.792000'),
  ('13f6e573-65bc-4ff4-a1af-90dade09cc6c','117c8f9a-ac33-4fc3-aa2b-81479c596653','e5f93688-4d11-4a34-bee9-0f554ad43647','623ffd0d-1136-4e7b-92f6-49564d45d9b4',NULL,3,0,'2016-11-08 09:54:07.273000','2016-11-08 09:54:07.630000'),
  ('15880fc9-e3ee-4722-8d9b-f20f3d794b84','7df5c846-fef5-473e-8d9d-e45541e3991d','72149920-ab95-48c0-9dad-fe6bb7e328ba','a19adea8-2a0e-4210-8595-c9a802008bfe',3,NULL,0,'2016-11-08 09:21:21.632000','2016-11-08 09:33:02.072000'),
  ('17e15fce-f1d4-4a78-aac1-0cfe238fd5da','66528ff4-f778-4b9a-8d88-8ab922269e58','d68f3156-acc5-4de3-95aa-0c7f43f32037','e49c3d35-25af-4d08-b69c-4afa78eab3ad',3,NULL,0,'2016-11-08 09:11:53.018000','2016-11-08 09:16:47.374000'),
  ('1ac6566f-ecc7-4a76-beee-0e7d420635cf','017a7528-f092-48d7-b20a-f1d7e831d732','e8c3bb21-b4a3-4c5d-98b0-8c34198c8f68','e7ec9ea9-d043-4f38-8da5-6274d0ae5192',3,NULL,0,'2016-11-08 09:54:07.482000','2016-11-08 09:54:07.813000'),
  ('1afcd877-efad-41cd-bc6d-b9dae056aa54','86067a24-114c-4a45-b25d-47c6b6f9b1e2','b750ec72-5263-4a34-89db-debf1e6f8f93','81659c75-b5a6-4a6b-819e-48c7c4832130',3,NULL,0,'2016-11-08 09:21:21.797000','2016-11-08 09:33:02.082000'),
  ('1caab0ad-c2b3-4815-b365-2bac0f2bef49','4da62872-54a9-4ee7-ab27-a2482dc4190f','6f417012-38ec-4ec3-8b30-a52d9a216531','ed8f5459-0075-4172-8d8a-e5fe1b66aa0d',3,NULL,0,'2016-11-08 09:54:07.414000','2016-11-08 09:54:07.791000'),
  ('1ce2c5b4-7b74-4608-bd27-cd2744201b0a','cefca2cf-e1c3-4948-9787-a6f7fca12680','da4b105e-6021-4127-8577-ce12069d4b83','83b213b4-c246-413d-893b-8881d3f9b8f8',3,NULL,0,'2016-11-08 09:06:59.112000','2016-11-08 09:09:03.545000'),
  ('2516de7e-171e-4023-9434-0d153a22b69d','5d476e7c-e8e1-452a-98f4-330f441e9921','0ec22e53-adb3-4768-903e-8f8098f059c6','a91e0d26-85ff-4f2d-a5cf-e6a7718e0a44',NULL,3,0,'2016-11-08 09:21:21.600000','2016-11-08 09:33:01.677000'),
  ('28a70023-fb28-4328-9103-fc7dacee5525','6be4b6bd-b588-4368-946d-d48cb7f98a31','b0d0a2fd-9625-4864-bc15-4eab20074ea3','165b3138-2c5b-4dee-ba9f-a23376a237f9',3,NULL,0,'2016-11-08 09:54:07.400000','2016-11-08 09:54:07.652000'),
  ('2baaaf0b-4280-4340-be30-3f0536599681','de9c0c7e-562f-4602-ae4e-f8eed71cc6ae','b750ec72-5263-4a34-89db-debf1e6f8f93','05aa78f6-ad59-4421-83cd-b14d06ec8cff',3,NULL,0,'2016-11-08 09:21:21.797000','2016-11-08 09:33:02.082000'),
  ('2d77682f-b5b7-48ec-a2cd-ab4c2dbeda72','62f8a829-fc0d-4aa9-8ae5-9b632b4ba297','95b91237-3228-45f1-a640-935b4c2514de','2a62ed6d-ebdf-4dfc-ad22-27c4a3d8c5e2',3,NULL,0,'2016-11-08 09:54:07.283000','2016-11-08 09:54:07.642000'),
  ('2ee014f8-d203-49ea-b8d0-54f4d9d4d8a2','8613591d-29eb-4c37-b95c-62feeaa36d4d','b0d0a2fd-9625-4864-bc15-4eab20074ea3','5650dc81-2b49-4819-8caa-b6455ccd714d',3,NULL,0,'2016-11-08 09:54:07.294000','2016-11-08 09:54:07.651000'),
  ('2f42bfb9-33e0-46a3-8ee2-6ae5a153ab90','f2201c8f-534a-4b14-ab9b-ffca9d43a839','9ed66190-053c-407b-b2ba-eaadd2a094d3','5470d81b-c1d4-4017-aa49-f9611d7a45ce',NULL,3,0,'2016-11-08 09:21:21.808000','2016-11-08 09:33:02.091000'),
  ('310ef936-f23a-442d-8e41-cf25135dff31','914046d6-e5fb-4b15-9af6-caf6c5840cb6','72149920-ab95-48c0-9dad-fe6bb7e328ba','0afeaf7a-a31a-428d-8fd8-57ebcf123df9',3,NULL,0,'2016-11-08 09:21:21.631000','2016-11-08 09:33:02.072000'),
  ('36ec9aed-785a-46fb-93ac-80d264f3cb9b','326de52e-6d3a-4e15-867a-784d2a415cc8','4f6c6d58-ead3-4b42-a95a-687944676659','6aec776e-fd93-4d82-b067-0101c39cbd74',3,NULL,0,'2016-11-08 09:11:53.004000','2016-11-08 09:16:47.350000'),
  ('389e2e87-6ea6-4d18-9a50-4667b221e222','8f917da7-2009-4dbb-a275-7f1d623b14f3','95b91237-3228-45f1-a640-935b4c2514de','22568d5c-42c8-4c9a-8c72-0676f97c1852',3,NULL,0,'2016-11-08 09:54:07.283000','2016-11-08 09:54:07.641000'),
  ('3b25f7ff-9d4d-414d-b695-df17e2ebfb9d','a0ee9ea0-bcb7-493b-b798-21e2b19a7104','549c146c-b7c4-401f-b2b3-3dbdfd938143','d3f654f5-1458-47ac-b4a7-e9f22a9275df',3,NULL,0,'2016-11-08 09:21:21.621000','2016-11-08 09:33:01.689000'),
  ('40183bfb-ae3e-48d6-898c-07d3a7af34a1','dde2f1b8-5ca7-44bf-bed8-a8b786cd20a2','b02b208b-ca63-4795-85b0-ff023718410a','f7862840-e11b-42e3-9c27-5eeaa8d1d293',3,NULL,0,'2016-11-08 09:54:07.487000','2016-11-08 09:54:07.818000'),
  ('491bee05-ede5-4432-9ae2-d1e10b1feb10','a69000d3-9a04-4fd9-9376-ee2c5a3ffbbd','12ce9d50-b346-4dba-8b16-bccdc80e1448','d4683884-2f84-4976-af96-2cb6fb43c701',3,NULL,0,'2016-11-08 09:21:21.566000','2016-11-08 09:33:01.647000'),
  ('4e4e9b1b-e5d6-4cda-8031-adcd79ddde1f','96a80017-d711-49d6-83f8-cc286d74f656','b45407f9-8737-48ec-8bb3-9440731a7858','ad40a3d6-ab97-4947-876f-0d9a3d0e96e3',3,NULL,0,'2016-11-08 09:11:53.026000','2016-11-08 09:16:47.377000'),
  ('51954468-b2e1-49ab-a000-5ba499bc3fea','c5d83c4e-e2e8-48ca-972b-43c83d4027dd','6a9a2ab0-7bf7-4f85-a882-808ac174e176','bab53e13-8648-4a74-8dff-d3e761672ac8',NULL,3,0,'2016-11-08 09:54:07.424000','2016-11-08 09:54:07.798000'),
  ('59593986-77dc-496e-96b3-3500a41b529e','dcab9fd6-d323-4944-83bf-71d3d587c30e','9ed66190-053c-407b-b2ba-eaadd2a094d3','73ef269d-9abc-418f-8158-b3a84aa3f109',NULL,3,0,'2016-11-08 09:21:21.807000','2016-11-08 09:33:02.091000'),
  ('5a8c4f59-e466-44ee-a71a-216b2ed56076','453bd278-9510-411f-b962-f6bbfff3bc0a','72149920-ab95-48c0-9dad-fe6bb7e328ba','8b15fdfc-3f2e-4ecb-a2ae-416648bfbab5',3,NULL,0,'2016-11-08 09:21:21.633000','2016-11-08 09:33:02.073000'),
  ('6273287b-92cc-4ed0-be9e-8b2640baad01','6e9721be-fc68-4b19-8386-54007c3e2483','3134bb3f-3d75-4379-9970-054964c94c5f','f833bf51-9b9e-4ed6-97f1-6dbbf8d7368d',3,NULL,0,'2016-11-08 09:54:07.582000','2016-11-08 09:54:07.823000'),
  ('63bee133-e7b1-460f-ab9d-a96a25b07421','07d98e82-27cc-4c8b-b730-13e1254a29ae','b02b208b-ca63-4795-85b0-ff023718410a','101dea75-94cc-495a-b146-39eb635bcf7c',3,NULL,0,'2016-11-08 09:54:07.487000','2016-11-08 09:54:07.817000'),
  ('686025a0-8410-4332-90c8-a6586a1b312d','2ecdd0cc-0658-4dd9-b49e-a3399a483078','2d142bec-7d46-48c9-b80f-1658b16eee68','6a1666b3-0e30-4812-b335-6008b9f8ad27',NULL,3,0,'2016-11-08 09:06:59.142000','2016-11-08 09:09:03.553000'),
  ('6919ac18-6493-4636-9ded-cd2f8db8d10e','848975c1-d446-4a93-b2cf-13e4f17d662f','9bc0c803-4880-475e-8c94-3153715b8382','e925e8b3-b102-4560-9ead-79f91eae745b',3,NULL,0,'2016-11-08 09:06:59.183000','2016-11-08 09:09:03.590000'),
  ('77c7741c-c850-4f7a-84cb-31b099f19751','db59a3ff-211d-4cad-8fa4-9d3f44d00b52','b0d0a2fd-9625-4864-bc15-4eab20074ea3','f3a658eb-07d1-4774-bd83-a6eaa376bb04',3,NULL,0,'2016-11-08 09:54:07.294000','2016-11-08 09:54:07.652000'),
  ('79e7a35f-edb8-4bcb-945c-cc36ba4c0437','484b902d-65c1-4260-a2c5-496174487de8','f932dc41-31d5-4f04-981d-1652e0244a11','544d5fd2-d9b7-437f-82b5-c6b30eb5414f',3,NULL,0,'2016-11-08 09:21:21.577000','2016-11-08 09:33:01.653000'),
  ('7aafcafa-8ca5-453b-a1f5-d689bb0e0f53','f3a268db-2824-4c44-bcd7-f392b09eca4a','4aeba7c8-92da-4a48-8f91-1b4db7c8bb3b','a2f3804a-619b-442d-aa5a-3455b7dc688d',3,NULL,0,'2016-11-08 09:50:52.078000','2016-11-08 09:51:40.827000'),
  ('7fe8631c-b4d1-4154-b46b-14feb6c63d15','c6552d7a-cd1c-482e-9f6e-f11be105a1b6','95b91237-3228-45f1-a640-935b4c2514de','14cabbd3-3a2a-4bb9-9fd8-4136c7e3c7b9',3,NULL,0,'2016-11-08 09:54:07.282000','2016-11-08 09:54:07.641000'),
  ('88f9b5c9-50ce-4e5f-aafb-fa7775ee01db','4b96526a-72f5-4830-abeb-a1f1b66a1ff8','da4b105e-6021-4127-8577-ce12069d4b83','cf4d2b55-c9f7-45d2-9350-ae71bb09c248',3,NULL,0,'2016-11-08 09:06:59.110000','2016-11-08 09:09:03.546000'),
  ('89477ec3-51ce-4386-804e-5a8daa7630be','b5136142-cfb8-4d48-9973-579e2a8ab97d','6a9a2ab0-7bf7-4f85-a882-808ac174e176','18a76d11-d0ea-435d-8eb9-8dd566520ad1',NULL,3,0,'2016-11-08 09:54:07.425000','2016-11-08 09:54:07.799000'),
  ('8fda7700-16aa-456b-ad90-03221327d4aa','420fe09f-cc3f-4f44-a92d-239c742ad6b8','549c146c-b7c4-401f-b2b3-3dbdfd938143','97d7b0d5-490c-42ba-9041-969274152e83',3,NULL,0,'2016-11-08 09:21:21.621000','2016-11-08 09:33:01.690000'),
  ('9370fba6-69a3-4a8b-b0e4-af5f78f04646','124a1b66-cb28-4410-9138-0907d30ef0ff','b0d0a2fd-9625-4864-bc15-4eab20074ea3','db11c178-122d-449e-ad06-0fd07816286d',3,NULL,0,'2016-11-08 09:54:07.293000','2016-11-08 09:54:07.651000'),
  ('9f1d35c6-49fc-4ae4-b6f7-19d3c430ae9b','fc1e275f-6b45-4aaa-99bf-feabd668a994','0d0b16db-801b-4191-a0f3-cc3390bbafdb','93ee86ed-7878-4031-ba53-79809bb9e6fd',3,NULL,0,'2016-11-08 09:50:52.067000','2016-11-08 09:51:40.813000'),
  ('9f6a69eb-496b-43ba-95fb-b4102920f0db','1b96ee86-7b6a-4ada-9b54-caf23281ca23','e5f93688-4d11-4a34-bee9-0f554ad43647','c114efef-9404-451e-945d-17a65d760c25',NULL,3,0,'2016-11-08 09:54:07.272000','2016-11-08 09:54:07.629000'),
  ('a364178a-651e-4c28-8bcc-571236e8b01f','546c2f6d-9c04-4829-a6bb-cf0157b3eb16','0ec22e53-adb3-4768-903e-8f8098f059c6','5480e50d-eed4-4ec8-a313-9992872956e4',NULL,3,0,'2016-11-08 09:21:21.598000','2016-11-08 09:33:01.678000'),
  ('a36ed861-de83-4fd4-adc0-eb7ce37154c4','ec7c3f6a-9cf6-45c9-b0ad-71df46227fa4','5e3d2c03-731f-4082-9c6c-e2c0949201e4','5b73d628-6e3a-4426-a73b-a827817950ad',3,NULL,0,'2016-11-08 10:22:42.744000','2016-11-08 10:32:52.111000'),
  ('a37f48df-027d-4a8e-904e-42205d097eec','2912c18c-94f8-4888-a556-3456ec86f827','8e548067-239f-4df8-b3f4-96beee8b77d3','0acaebad-5c94-4dd3-9a23-6c870d1ad862',3,NULL,0,'2016-11-08 09:50:52.062000','2016-11-08 09:51:40.809000'),
  ('b41d779f-4e1a-4ed3-8f5b-eefbe34c84ba','c42ac89b-7687-4a97-ba9c-bb6aeceff2fa','6a9a2ab0-7bf7-4f85-a882-808ac174e176','a5893160-b3e6-45c8-b1c3-90eb7f9007d8',NULL,3,0,'2016-11-08 09:54:07.425000','2016-11-08 09:54:07.798000'),
  ('b53f9ee7-5c2c-4e32-8811-89a4be55f284','cae47338-35c2-4d9c-90e8-f70403c283f8','4b687789-caf1-488c-ab78-14329e31cd17','4d0b3404-c079-4e46-894b-29611333b196',3,NULL,0,'2016-11-08 10:22:42.725000','2016-11-08 10:32:52.131000'),
  ('b7769118-34be-40a5-897d-2c3e0bf442f8','db7a8fbb-efaa-49ec-9ebf-3a830af38c44','be4231f9-640b-4dc5-b2df-550683ca1576','f88e3498-f9ed-4d0b-bb9d-ccd09fd75bf9',3,NULL,0,'2016-11-08 09:21:21.587000','2016-11-08 09:33:01.659000'),
  ('bf87bfb9-0d67-423f-9b96-ee3bd8e52fcf','c8324962-cc49-4b22-bd7c-1de7d8a9ec2c','e87857f3-2521-4230-b429-a22890e5d98d','17c46163-ec3f-4d2f-97c6-babc6e0a41a8',3,NULL,0,'2016-11-08 09:06:59.154000','2016-11-08 09:09:03.562000'),
  ('c8c71a87-3c6f-4657-be13-d5f1833bec23','850b15fa-0559-4c62-b3ea-ff5f4ab65da5','e5f93688-4d11-4a34-bee9-0f554ad43647','95eaa96c-f4d2-4f5c-b824-406fe30a88d1',NULL,3,0,'2016-11-08 09:54:07.272000','2016-11-08 09:54:07.630000'),
  ('d32ae8a7-a922-4c78-9b78-aff456be7b6e','d868e9c3-6eea-45af-95b5-d00c6af06f5c','17b0cee1-9240-43c1-b55c-df83a6374a5e','0a098226-368c-4ab3-9421-984ee5ca8ef4',3,NULL,0,'2016-11-08 09:11:53.010000','2016-11-08 09:16:47.354000'),
  ('d8c77f87-44d9-47ee-87bb-9f33d7d7f10a','ad726514-971f-4a77-9080-c17e7feb5a76','f932dc41-31d5-4f04-981d-1652e0244a11','f0596885-a211-498e-99fc-f238c64e1936',3,NULL,0,'2016-11-08 09:21:21.577000','2016-11-08 09:33:01.654000'),
  ('d8ce6991-74f5-4657-834d-c85660795769','d8549f7b-d6bd-4ba1-93b5-3f9af7df4786','ebcc652c-3282-46ff-b941-8f08f6b4e016','eb7ed6ff-d8ce-42f6-87fc-e12a5b24b11b',3,NULL,0,'2016-11-08 10:22:42.718000','2016-11-08 10:32:52.127000'),
  ('d8ddf9d3-a85f-4548-b843-f20d91df85a0','f7c9c2f6-2b55-4ae4-8228-17d95ea9401d','be4231f9-640b-4dc5-b2df-550683ca1576','e910732b-b6fb-48e4-804e-cb04b27d8fd2',3,NULL,0,'2016-11-08 09:21:21.585000','2016-11-08 09:33:01.659000'),
  ('dd8c20a6-fd32-442b-8a09-a3eb8fcb62ff','37b78615-2a7d-435b-ba89-42e1ac63597d','bb3a11f4-bed8-4d35-b68a-0188243359ab','1e38cb17-1613-4269-9c3d-5e494e9c8996',3,NULL,0,'2016-11-08 09:06:59.175000','2016-11-08 09:09:03.584000'),
  ('e05ac3f3-9e99-4249-b05d-8b3c614b26ca','db6d3700-9cd3-44bb-8d36-c5fb7817c300','0ec22e53-adb3-4768-903e-8f8098f059c6','bfbb8d3b-528e-4092-b7e9-62e109472935',NULL,3,0,'2016-11-08 09:21:21.599000','2016-11-08 09:33:01.678000'),
  ('e0e91e7c-b33c-461e-8c17-83af8b4a494a','a86a8c3b-0d99-47c4-aa3c-9f9791bf718e','95b91237-3228-45f1-a640-935b4c2514de','b5b56a10-010c-4f23-9dd5-b713f1be3663',3,NULL,0,'2016-11-08 09:54:07.284000','2016-11-08 09:54:07.642000'),
  ('e2804959-1b95-4e41-8e50-270d787a8ff2','3a07c84c-f333-4cc0-bcff-f94c0f231dfc','b750ec72-5263-4a34-89db-debf1e6f8f93','2dc1321e-fe46-48bb-9bed-ae6e0f7582e7',3,NULL,0,'2016-11-08 09:21:21.798000','2016-11-08 09:33:02.083000'),
  ('e44dd52d-0dc6-4d6a-9fc4-11fdd6ac971b','3bfc423f-873a-4b2a-815f-99957fe03bb4','3134bb3f-3d75-4379-9970-054964c94c5f','c86e3be1-0061-4b72-9769-0f7feffe577b',3,NULL,0,'2016-11-08 09:54:07.581000','2016-11-08 09:54:07.822000'),
  ('ebed2e3f-8d9e-4d82-ae59-2a82980d45ea','1aafd1c7-f44c-4543-8d20-f3ee29afa01e','20add881-33c9-4e86-b962-7cb01b3c83fe','23983aa1-b5a5-4eb7-a92a-0d3b0fd849e5',3,NULL,0,'2016-11-08 09:50:52.074000','2016-11-08 09:51:40.824000'),
  ('ec9eb517-91c8-48a2-85ae-5b889630ae5f','4dcc6bd0-368c-461a-9355-12114a603b01','e87857f3-2521-4230-b429-a22890e5d98d','a03cb558-b939-45e2-9464-6f78828d2ebc',3,NULL,0,'2016-11-08 09:06:59.155000','2016-11-08 09:09:03.563000'),
  ('f4f048de-7422-4a02-bfab-6a32a43b1131','10d2757a-9e4f-4056-807f-e58eafae55d1','72149920-ab95-48c0-9dad-fe6bb7e328ba','50888535-a408-4e1e-a91f-c3a9508ff3c9',3,NULL,0,'2016-11-08 09:21:21.633000','2016-11-08 09:33:02.073000'),
  ('f84b667d-6b8f-4556-9ed2-49394cb83ea7','ff34d90a-ed40-41fe-9257-cb138995c7fd','6f2ccbbe-a8f6-4989-9258-9e13264d1390','af6a4b31-8ca0-4263-b739-4fcde3f6451a',3,NULL,0,'2016-11-08 10:22:42.749000','2016-11-08 10:32:52.115000'),
  ('f91e549d-ab79-4a95-9754-1c20f8c4369e','986dd7b1-ea93-4fd2-8096-cd359a2d6651','549c146c-b7c4-401f-b2b3-3dbdfd938143','4eb14be7-c3a7-4654-8f2b-814a59450096',3,NULL,0,'2016-11-08 09:21:21.620000','2016-11-08 09:33:01.690000'),
  ('f9208968-564d-47f7-8fea-4202e7995d7a','2d23f736-7529-439a-b63d-2233959193e0','549c146c-b7c4-401f-b2b3-3dbdfd938143','b00e43b3-9052-4c8a-ae18-059bc3c95151',3,NULL,0,'2016-11-08 09:21:21.622000','2016-11-08 09:33:01.691000'),
  ('fe2bdafe-b811-45d5-86c8-fcc7754ae37c','36600456-226a-4bb3-9da6-a9b3f07c4acb','2d142bec-7d46-48c9-b80f-1658b16eee68','1258b76c-09f7-4aa2-8b96-1020310b47d5',NULL,3,0,'2016-11-08 09:06:59.141000','2016-11-08 09:09:03.553000');

INSERT INTO `verdes_conflitantes` (`id`, `id_json`, `origem_id`, `destino_id`, `data_criacao`, `data_atualizacao`)
VALUES
  ('01f6964f-b509-4066-881d-f8288ceb19d3','89dce056-d304-4c3d-abae-ad9747ff0377','d268b155-7b77-4dd0-af4a-d23376a8a15c','e307d4fc-95ff-45ce-a23d-baae9427599b','2016-11-08 09:06:50.075000','2016-11-08 09:09:03.583000'),
  ('03fda3c6-e83c-489d-a1c2-d83e6ddaef3e','53daf2e3-a12d-4b3a-8478-a13981f3db03','4c0b8351-28d6-4445-824a-48b6dece50e8','53b67934-ce51-4dd7-b4c6-e1abedcd4abb','2016-11-08 09:11:46.834000','2016-11-08 09:16:47.349000'),
  ('0796d821-b234-444a-aea1-0b9a4ea3080f','d61c003e-b104-428f-b59d-78021273cd8d','d0fe4320-ac2c-4623-ae92-49bc89f43438','7ff271f4-81ef-4422-8461-b15c44051fd8','2016-11-08 09:50:45.831000','2016-11-08 09:51:40.822000'),
  ('0a5eaf9a-39ca-444c-8a6e-7c9ad502a4db','0a9af180-0c3c-4029-b880-7b04aab78bf4','c9284008-54bc-438f-88cc-363e7752a148','84bcba8f-93c4-4fb2-9aac-457262312441','2016-11-08 09:50:45.827000','2016-11-08 09:51:40.808000'),
  ('21c9b2fe-3705-45f9-b137-692553cfe27e','4b2b24f0-775a-4895-bfec-205e6ca2f5e3','438bea60-53f6-4a0c-ab26-d2c9ca061b23','12cb4ead-c499-479b-99f1-810b47f4ae83','2016-11-08 09:20:58.192000','2016-11-08 09:33:01.646000'),
  ('242e5e2e-efdd-46ef-b577-ad9c2f95c3e3','03c6f4dc-d3be-4d9e-a7f8-2ef40e89b06b','1aeadd03-ec04-4bea-a4c7-641125dda206','da7e4e08-e87b-4734-9f36-6ab8ab3a5893','2016-11-08 09:54:07.225000','2016-11-08 09:54:07.628000'),
  ('2fd2fd1f-19a5-4cbe-a626-a53829e03752','ab52786b-fb00-4ccf-a606-5b83fce0ba65','4829f07e-2807-4054-b8e7-ddb2bcdcbcfa','b920567a-32ac-4233-81ec-858563409d9b','2016-11-08 09:11:46.841000','2016-11-08 09:16:47.373000'),
  ('37f02b25-dd60-4066-bf82-0e32d0ff7810','de5a770e-a4bb-401c-8ae9-100f8058b153','73487232-6688-40a8-a068-86a7cffe6b69','682c4d0e-626a-4c3d-8ce3-b6421ea2341a','2016-11-08 09:20:58.199000','2016-11-08 09:33:01.688000'),
  ('50509dc9-c90c-4ed7-b605-8db1ae88ded0','98a1b4ba-8d52-470e-b65a-a96cc4076f9c','e9f671a5-950c-4fc5-9cc7-45acbd53227f','717c6bc5-9098-464c-b19a-e2f0c7e6d40f','2016-11-08 09:06:50.066000','2016-11-08 09:09:03.544000'),
  ('58dd693a-2e11-4dc2-94c6-a96021dfb219','d4594f92-8510-431f-9fad-405794fc435c','c5dc4dbe-2d49-4e1d-b6c0-449b13e16240','77347d0d-1425-4c98-9aa3-2a3678ececd4','2016-11-08 09:54:07.227000','2016-11-08 09:54:07.790000'),
  ('5fad3aaf-d2b7-4163-a705-718b7437a8d6','8342084d-52a4-45c6-a90f-f68aec0efc41','e52ff58d-a44b-4c1d-aa5a-7d90a68d0816','682c4d0e-626a-4c3d-8ce3-b6421ea2341a','2016-11-08 09:20:58.200000','2016-11-08 09:33:01.689000'),
  ('6e1bce90-454a-47fc-bced-4e90d7a5ebc8','ef7aab5a-0c41-48a9-aa06-0fc805fc8eec','72dab597-6715-40d6-abce-2724b5cff1f9','bf6524f8-9a7e-4be8-8e35-4fd4f909d1c4','2016-11-08 10:22:36.617000','2016-11-08 10:32:52.126000'),
  ('6f88b757-2b34-44fb-af79-c1c24978d78f','845c8983-3fcd-49b7-89e8-737b1b45d972','12cb4ead-c499-479b-99f1-810b47f4ae83','7081b5d1-c597-4ba0-a232-453a6b1fc8e9','2016-11-08 09:20:58.192000','2016-11-08 09:33:01.645000'),
  ('7385e9c7-d9c9-47d8-8dca-8658b915d391','e8c44788-9820-434d-8b9d-baca75bd1a53','4d592444-7995-4146-a9a3-e491e5d695a6','3c8ce4de-70a1-44e8-9273-c07f705f130e','2016-11-08 09:54:07.236000','2016-11-08 09:54:07.816000'),
  ('7ba321d1-93e0-4fbf-91b9-005810519cc4','efd902cd-d4b2-4928-baf3-b4c05ed4d76f','b9b212ff-5b33-4f55-a67a-45955d13a66f','462dd6ae-acf9-4a1b-b266-b6a29b47c1fa','2016-11-08 10:22:36.621000','2016-11-08 10:32:52.110000'),
  ('95f5d023-2b19-4eff-bacb-145675a15aa2','2d72a82c-fa96-4a9c-bb62-1aeadceb46a7','682c4d0e-626a-4c3d-8ce3-b6421ea2341a','155bd3c9-2fc8-4cca-9748-d6580f160dc2','2016-11-08 09:20:58.199000','2016-11-08 09:33:01.677000'),
  ('b46686a4-0b5b-4a7f-9e50-39d3b972eb8b','8eaed8b1-356a-437d-a450-ad374eead511','717c6bc5-9098-464c-b19a-e2f0c7e6d40f','d301c7f5-6b95-4eac-b4f1-fcb314cb5b9a','2016-11-08 09:06:50.065000','2016-11-08 09:09:03.543000'),
  ('b523a253-09d0-4d84-845c-3aa1a673f3b2','f6166b72-5ed5-42e1-9420-47981b02b7d8','3c8ce4de-70a1-44e8-9273-c07f705f130e','5d777b9c-5c6b-4de3-b4d1-a8ccbe92e88a','2016-11-08 09:54:07.235000','2016-11-08 09:54:07.812000'),
  ('b52c70c4-995d-4d04-b81c-2bc918dda193','9dae79a9-2fe5-405a-8b89-df6984bf7d75','4bb4af54-cf60-4bf8-81f5-37ec0c82b5f3','77347d0d-1425-4c98-9aa3-2a3678ececd4','2016-11-08 09:54:07.226000','2016-11-08 09:54:07.650000'),
  ('db375910-8816-4f50-824e-7cdb12cbb2c2','c00aebbe-3c4d-4eab-bfc5-5a4699f761d4','155bd3c9-2fc8-4cca-9748-d6580f160dc2','efd9bc6e-d318-4654-994c-3aafff5e3b66','2016-11-08 09:20:58.198000','2016-11-08 09:33:01.676000'),
  ('edf89168-766d-4b02-8574-8637eb0f7cae','4bed4883-6ba5-46c5-bf78-aab61b051814','77347d0d-1425-4c98-9aa3-2a3678ececd4','1aeadd03-ec04-4bea-a4c7-641125dda206','2016-11-08 09:54:07.225000','2016-11-08 09:54:07.640000');

INSERT INTO `atrasos_de_grupos` (`id`, `id_json`, `transicao_id`, `atraso_de_grupo`, `data_criacao`, `data_atualizacao`)
VALUES
  ('085b5d99-917c-4bf4-8d76-c96322e1b8c9','16d465a9-67bc-4879-b0b8-10f9e9aedefe','927c0b93-dbe3-4cbb-bcc9-13ae70c0790a',0,'2016-11-08 09:54:07.405000','2016-11-08 09:54:07.785000'),
  ('089777b4-b5d6-4f39-b1fc-bbb5d5cb3c81','91ab2e48-0a5c-4806-ba5f-15aaa013ad8b','0acaebad-5c94-4dd3-9a23-6c870d1ad862',0,'2016-11-08 09:51:24.036000','2016-11-08 09:51:40.810000'),
  ('0a205708-17c9-49b6-ab2e-864a478aadd5','fb66b0a1-9d53-4b7a-a260-906a702fcdf7','ec5d3027-6ba1-417e-b491-2a766900809e',0,'2016-11-08 09:12:22.462000','2016-11-08 09:16:47.379000'),
  ('103c29a0-ad45-48bf-8565-e75f563b03cb','1406dc6c-c4c5-42a2-bc4e-e7f544c6e5dc','8f4e5fae-2ed0-44d2-85f7-3f3e4704441c',0,'2016-11-08 09:22:50.196000','2016-11-08 09:33:02.068000'),
  ('153bcae0-d29c-41b8-8997-9bab961ebc59','0c5b38f3-ad3f-475d-b0e6-24f869a45823','60b216d5-e387-4c70-b3f2-d20201fa311d',0,'2016-11-08 09:54:07.577000','2016-11-08 09:54:07.819000'),
  ('156ba92a-eac9-453d-ae57-1d3fe823275f','01d6594e-fba0-4b49-bf77-bafc9f634dda','d3f654f5-1458-47ac-b4a7-e9f22a9275df',0,'2016-11-08 09:22:50.191000','2016-11-08 09:33:02.067000'),
  ('1685e00c-df6c-4c12-86b9-0d32cf009857','90d163ab-ed88-49fb-87fd-e062b1db8f5c','4250788f-3f22-48d1-bd4f-598a28243964',0,'2016-11-08 09:22:50.195000','2016-11-08 09:33:02.067000'),
  ('19d81579-4d29-4d4a-9fb4-4d52ff811976','ce9d3277-b838-417e-89fb-2b68e00b36c8','1f658b5e-dfe7-4da1-95fc-f70cb8611745',0,'2016-11-08 09:12:22.457000','2016-11-08 09:16:47.376000'),
  ('1a966c41-32fb-4185-94bf-99cfd5d16d95','1e763f84-025d-4154-821b-be411434b331','9a34aa53-1a0f-462d-85d8-a711e059ac42',0,'2016-11-08 09:22:49.978000','2016-11-08 09:33:02.079000'),
  ('1c989d3c-66f1-456e-8f97-a145625fe7d7','628d98d0-3f3c-4afd-8e72-ed609e1c1013','f3a658eb-07d1-4774-bd83-a6eaa376bb04',0,'2016-11-08 09:54:07.408000','2016-11-08 09:54:07.787000'),
  ('1d2aebe0-bb2d-4deb-a654-c2ca91d00428','df5f1cce-10c2-4e1e-a9f2-39adbbf6276c','18b5a0d9-3995-4d4f-ba12-c0fe77c4bdcc',0,'2016-11-08 09:54:07.288000','2016-11-08 09:54:07.646000'),
  ('217aab02-e0dd-48d8-ba55-44b63211a610','58b9d02b-eb96-424a-85fc-dbce8f9841a2','eb7ed6ff-d8ce-42f6-87fc-e12a5b24b11b',0,'2016-11-08 10:23:15.726000','2016-11-08 10:32:52.128000'),
  ('218c38d4-97db-4f83-bde0-0636ebf7297a','40e5faaa-87a9-4fb6-b238-1528e8804f13','c86e3be1-0061-4b72-9769-0f7feffe577b',0,'2016-11-08 09:54:07.584000','2016-11-08 09:54:07.909000'),
  ('23150542-7fae-4e2e-a709-b5f2f67b329d','3ece33bf-ef08-4ba0-b0dd-9dce58946feb','479120db-0c0b-4b27-bbaa-a05534294780',0,'2016-11-08 09:51:24.033000','2016-11-08 09:51:40.815000'),
  ('24812bae-06bc-41df-8708-ece3bd8b32d7','569373e1-38b7-4d50-b49f-384d10a6e96b','c274d0d9-cfee-401d-9d67-722750ae43c6',0,'2016-11-08 09:22:49.981000','2016-11-08 09:33:02.080000'),
  ('24feee47-f250-41cb-ae9b-a048eb3828bf','b240541f-9dfd-46a3-a6a9-5fdcda813019','b00e43b3-9052-4c8a-ae18-059bc3c95151',0,'2016-11-08 09:22:50.189000','2016-11-08 09:33:02.066000'),
  ('26b55787-e61c-48ab-996b-9f35e6782189','84a6894b-f560-4170-aa14-8628a58ff182','a19adea8-2a0e-4210-8595-c9a802008bfe',0,'2016-11-08 09:22:49.974000','2016-11-08 09:33:02.077000'),
  ('29822e57-c016-42fe-85ef-f397c47f9676','429e45e6-98d2-4d10-86c0-a10e3bd9e0d3','ed9ca7e0-2f4c-42a4-b89c-2358278f717a',0,'2016-11-08 09:22:49.900000','2016-11-08 09:33:01.657000'),
  ('2e44324f-9515-4463-8ece-eb0894e67b32','a90af943-a602-4be9-b575-f4b108220604','a2f3804a-619b-442d-aa5a-3455b7dc688d',0,'2016-11-08 09:51:24.044000','2016-11-08 09:51:40.828000'),
  ('2fa2059d-87f9-4151-a0fb-f075f37719d1','a26fc5a9-cb96-4040-a4a2-39ca0d2827b5','a03cb558-b939-45e2-9464-6f78828d2ebc',0,'2016-11-08 09:07:35.622000','2016-11-08 09:09:03.565000'),
  ('2fc07703-3bf1-47d5-97fd-f7c154618f69','57b79474-7558-4ff9-b53c-59b848c48ea9','18a76d11-d0ea-435d-8eb9-8dd566520ad1',0,'2016-11-08 09:54:07.433000','2016-11-08 09:54:07.802000'),
  ('301f69d1-acbf-4ec1-b961-58cc73a910cd','7dc6fd01-de43-4faf-adf5-d9e9e64ce6cc','ab8ea174-02d5-4e57-a3e7-c5fff4e02443',0,'2016-11-08 09:07:35.631000','2016-11-08 09:09:03.568000'),
  ('304b0481-f19e-4f8a-af41-e9ad45f03445','b2893ba8-5654-4c69-b334-6320d0f34112','06743491-6894-4b9d-9297-2b4bb7651503',0,'2016-11-08 09:51:24.050000','2016-11-08 09:51:40.826000'),
  ('30951627-b4ac-4424-8c75-8a6c428327c0','47dba6a5-012f-4da2-9f4b-21c539376edc','f88e3498-f9ed-4d0b-bb9d-ccd09fd75bf9',0,'2016-11-08 09:22:49.957000','2016-11-08 09:33:01.661000'),
  ('345ddc9f-067a-4e81-90d8-c40b84cd9b71','27d8d08a-8ab0-494c-9c3e-e2987c3fb08b','3095c6e6-593c-4636-9df3-4fc468a269de',0,'2016-11-08 09:54:07.274000','2016-11-08 09:54:07.631000'),
  ('358e27a2-0379-4c55-b503-4a430e2d65e3','b623a2a1-093f-44d6-a762-5a468ade4013','817ab2fb-defb-46f5-8c5a-bd03a68fde92',0,'2016-11-08 09:54:07.484000','2016-11-08 09:54:07.814000'),
  ('35991bbd-c51a-451a-bcb2-fc7eabce1837','e946f45a-f769-4c00-b6a3-c2954f10cf27','bce6b953-bf80-4bb3-b809-bd2203f5c60b',0,'2016-11-08 09:54:07.290000','2016-11-08 09:54:07.648000'),
  ('36cfb99a-3e72-4a15-9cca-5725903c8b4e','62d1b268-5ca0-4252-95b8-f34e34edc1cf','7ec6b9f1-b747-4f61-aab9-55aa1eed7cd2',0,'2016-11-08 09:54:07.404000','2016-11-08 09:54:07.654000'),
  ('37ac851a-7144-4925-a22f-9bac31759202','f89fa453-16e1-4f2d-b131-29f8191285c5','165b3138-2c5b-4dee-ba9f-a23376a237f9',0,'2016-11-08 09:54:07.410000','2016-11-08 09:54:07.788000'),
  ('3f505356-879b-4fb5-802d-1f0f5cceadc2','2895ae99-2ad0-4785-9b22-c01a5b5418c5','e910732b-b6fb-48e4-804e-cb04b27d8fd2',0,'2016-11-08 09:22:49.956000','2016-11-08 09:33:01.660000'),
  ('414c7d4a-b4ff-47b7-932c-b826d78aeded','862dedff-b441-4076-8261-3faf8cab1f65','bf15cf36-5afb-432f-8144-e31ef355977c',0,'2016-11-08 09:07:35.729000','2016-11-08 09:09:03.558000'),
  ('416776b3-5ad0-46d4-8cc1-b62e71278145','b5cc7f9c-3bf8-464c-a9c5-847ec76adcaf','97d7b0d5-490c-42ba-9041-969274152e83',0,'2016-11-08 09:22:50.187000','2016-11-08 09:33:02.065000'),
  ('43b9ffe7-1cb8-4d31-8faf-8b4ba865f23f','4a0263d5-5810-4d5a-9998-af7c2dd73996','93742961-8390-480d-984f-f463b0527423',0,'2016-11-08 09:22:50.002000','2016-11-08 09:33:02.087000'),
  ('43c61394-2343-48e8-a83a-f6099881114f','d8613baf-dedd-4bee-9e57-48f25cf3eba2','ddb3e27d-c0fc-4111-9ecb-a00a2fd45b88',0,'2016-11-08 09:07:35.738000','2016-11-08 09:09:03.560000'),
  ('4402ec5c-2ac1-4ff7-8f98-1a5d76955baf','bddad863-92f7-4024-b594-75acbaff531f','c114efef-9404-451e-945d-17a65d760c25',0,'2016-11-08 09:54:07.276000','2016-11-08 09:54:07.632000'),
  ('45af9ec3-55ac-4c7d-a82a-4cbea95e724c','d693040e-4abc-4dc7-8d90-7ebde23e0498','32e41f7c-3f19-4813-8180-c686b36f1524',0,'2016-11-08 09:07:35.785000','2016-11-08 09:09:03.592000'),
  ('4796de0f-6381-405b-846f-408f887779a3','bfabf915-9f54-4eaa-9248-eb15c1989a97','01928987-097d-4595-a6c1-df6d70132e8e',0,'2016-11-08 09:22:49.999000','2016-11-08 09:33:02.087000'),
  ('4d96de5e-6736-4541-9eaf-cd43b5554e0a','cfc4c597-2298-4f9d-8d8f-d5b678036cbb','1735737b-6ece-41ec-a598-8c709a4e9547',0,'2016-11-08 09:54:07.483000','2016-11-08 09:54:07.813000'),
  ('51051e24-72ee-46d4-931b-5cb3f429c795','0a1b8721-974c-4a6b-ad74-2f1ddd829e02','6abf82a3-6d98-42b0-9624-72b950579965',0,'2016-11-08 09:07:35.663000','2016-11-08 09:09:03.549000'),
  ('51c91a75-7774-4da7-8642-60352263bbd3','80e46bf6-0671-4012-9cf6-e618ce774725','e49c3d35-25af-4d08-b69c-4afa78eab3ad',0,'2016-11-08 09:12:22.455000','2016-11-08 09:16:47.375000'),
  ('52c76e83-73fe-427c-a9cb-fe8e4dea188e','2f79f6f7-cf0c-4ab9-8920-a4a46eb123d3','77616f9f-e295-49aa-bc42-dd77859362ac',0,'2016-11-08 09:54:07.409000','2016-11-08 09:54:07.787000'),
  ('57c3df93-aada-4a4d-90c9-0abe4c18312c','7f439cb5-b985-48f7-9e9f-b1fe62c784c0','3c567ca4-e55c-4ae0-8650-2ea38fba65ac',0,'2016-11-08 09:54:07.284000','2016-11-08 09:54:07.643000'),
  ('593a6586-377c-443d-85dd-02f568765027','a51730fe-1eb3-4ada-b9cc-0b357bb3409e','23983aa1-b5a5-4eb7-a92a-0d3b0fd849e5',0,'2016-11-08 09:51:24.049000','2016-11-08 09:51:40.825000'),
  ('59c5d66b-815b-4ca0-95e5-9e92cfa0c6d2','6412ed2c-700f-4487-92cb-7437d75cae5b','0e6ca9e5-1824-4651-a2b9-4477fbb5be91',0,'2016-11-08 09:22:49.976000','2016-11-08 09:33:02.078000'),
  ('59f9c813-21ef-4276-8e20-0f917f84d6e6','cded7cd7-8a84-4445-b46d-a3e0558b1019','2c5cb3a5-5502-4e9b-b643-a9c0a18f3dd3',0,'2016-11-08 09:54:07.411000','2016-11-08 09:54:07.789000'),
  ('5aecc9a5-74c8-40cb-ba56-5a105e810bf3','073809c0-dfd4-409b-8f16-365dcddd2a2d','a5893160-b3e6-45c8-b1c3-90eb7f9007d8',0,'2016-11-08 09:54:07.430000','2016-11-08 09:54:07.801000'),
  ('5b5acc4a-2edd-4258-9714-29bfb3099a53','8a47ae29-3a06-43c9-8a61-6fe3cbf88c20','5480e50d-eed4-4ec8-a313-9992872956e4',0,'2016-11-08 09:22:50.209000','2016-11-08 09:33:01.679000'),
  ('5c69158c-19ff-4bf9-8794-d0fb87cf787d','de592d19-f559-4686-a4b5-13c04138c67b','e7ec9ea9-d043-4f38-8da5-6274d0ae5192',0,'2016-11-08 09:54:07.485000','2016-11-08 09:54:07.815000'),
  ('5d32dc67-269c-4a3b-86ee-273395623f12','c869c61f-5468-4cc8-b314-02d93527bff3','981a2f3c-1f3b-47ad-ad5b-354bf525c2a8',0,'2016-11-08 09:22:50.218000','2016-11-08 09:33:01.684000'),
  ('5ea1db27-24ae-4f02-970d-ae3b97e089a4','298bf697-4b43-43a0-b09e-e04c1f438986','3dd242d6-9f94-48ee-a345-a7d367f82e4f',0,'2016-11-08 09:22:49.977000','2016-11-08 09:33:02.078000'),
  ('60f3ca0e-cbfc-484d-a0ec-b7f5681ccb0c','880a42ae-9fdb-4d6e-b0c4-09cbf7c1f92f','f7a82221-5c2a-4fd6-a375-83ff252e8394',0,'2016-11-08 09:54:07.578000','2016-11-08 09:54:07.820000'),
  ('628749bb-4d3e-4968-be2c-01854ed9ff5e','27d19f9b-96fa-428d-a389-10247391711f','ed8f5459-0075-4172-8d8a-e5fe1b66aa0d',0,'2016-11-08 09:54:07.418000','2016-11-08 09:54:07.793000'),
  ('667404d2-2885-4458-a305-c914de83606c','fe53ad64-a3f7-4b7d-924c-1025407c3fc2','c7c85148-0af2-4eda-adaa-f043ba6dc3f5',0,'2016-11-08 09:54:07.428000','2016-11-08 09:54:07.800000'),
  ('6b6e8fa2-415f-4cc3-adca-a92952a81b93','94ce7e97-ae22-40f9-900c-d9f0d7c00794','22568d5c-42c8-4c9a-8c72-0676f97c1852',0,'2016-11-08 09:54:07.288000','2016-11-08 09:54:07.646000'),
  ('6e6a6107-b8d5-4a8a-ab55-d87c66d2cc4f','fd7ce57d-1601-49e3-b134-b212516005b0','eb5e6d66-96dd-4b9a-b479-d26d4af74928',0,'2016-11-08 10:23:15.727000','2016-11-08 10:32:52.129000'),
  ('6f2985b6-013f-4362-9c86-065c051a989b','1a248405-bbac-4856-8725-8092a3f118fe','e925e8b3-b102-4560-9ead-79f91eae745b',0,'2016-11-08 09:07:35.783000','2016-11-08 09:09:03.591000'),
  ('70dda9d3-d38b-4986-a410-a6b19d6bf193','fe4568d2-195e-4615-98f3-2a93b136ebdc','4d0b3404-c079-4e46-894b-29611333b196',0,'2016-11-08 10:23:15.732000','2016-11-08 10:32:52.132000'),
  ('72fdd1d9-911b-46f7-870f-8473fac99f62','29e00ba9-7f9e-4cfa-91d3-8fe61ba3d241','95eaa96c-f4d2-4f5c-b824-406fe30a88d1',0,'2016-11-08 09:54:07.278000','2016-11-08 09:54:07.634000'),
  ('740e3c51-ff7c-46d3-832f-ee72ce647ef2','e1f7c49d-80bf-41b1-a994-96f397126de5','c4ac5ab6-d121-4665-8fc8-f1f556dfe26b',0,'2016-11-08 09:22:50.005000','2016-11-08 09:33:02.088000'),
  ('743f0a3a-0eca-4c65-9c1b-4ca7ea448045','300c4fdc-f865-4a19-a3ae-3686b3ed15d0','101dea75-94cc-495a-b146-39eb635bcf7c',0,'2016-11-08 09:54:07.489000','2016-11-08 09:54:07.818000'),
  ('745d7462-5b6c-45d0-884d-9bb6cb2690a0','02ade6eb-42da-404d-ba6b-0ae8af125826','23494a61-a4da-4e57-8672-c575f18db312',0,'2016-11-08 09:22:50.227000','2016-11-08 09:33:02.095000'),
  ('750ea0fd-3f31-402c-8eab-f0396b3076b7','7fd65e58-2c8d-44b5-b615-9aee9e89a91c','bab53e13-8648-4a74-8dff-d3e761672ac8',0,'2016-11-08 09:54:07.427000','2016-11-08 09:54:07.799000'),
  ('7753652b-ae2c-4a30-997f-fd29acf68214','489663a3-288e-49c7-9933-c1dc7a3ae25e','623ffd0d-1136-4e7b-92f6-49564d45d9b4',0,'2016-11-08 09:54:07.281000','2016-11-08 09:54:07.639000'),
  ('778442fd-4220-425a-b001-95765cf93433','b21a4379-86ec-4df2-9649-d1474febc325','cb56cd9f-4ebc-4438-96b5-038d83e1f234',0,'2016-11-08 09:22:49.899000','2016-11-08 09:33:01.656000'),
  ('7e46eb57-bb55-4b3f-880f-ae10ab51b1ea','330a70f4-a902-4a07-a27a-09671e412044','5470d81b-c1d4-4017-aa49-f9611d7a45ce',0,'2016-11-08 09:22:50.225000','2016-11-08 09:33:02.093000'),
  ('7e6c551e-d045-4eb3-947f-ebc8d7d0b0e7','b3341769-39e4-46da-9c2c-9613c4230c31','14cabbd3-3a2a-4bb9-9fd8-4136c7e3c7b9',0,'2016-11-08 09:54:07.286000','2016-11-08 09:54:07.644000'),
  ('7fbffea3-6abb-4846-9fde-493c62db18b7','07cd57be-4137-4243-9e35-e61c3d37d5b1','b870bbd7-4af8-4f0c-944c-1290615eacc9',0,'2016-11-08 09:22:50.219000','2016-11-08 09:33:01.685000'),
  ('803d5135-f69c-4cd0-a271-4eb118e9c9bd','fc8257f5-8924-49ca-9917-f2c1ed642867','d779c445-7932-446f-98c7-a0139edd6041',0,'2016-11-08 10:23:15.742000','2016-11-08 10:32:52.117000'),
  ('8181102e-ff9c-4174-bbd3-ee8ddf1bd9fd','058c26ce-8eac-4650-b286-67899b1d7a8d','961c307d-37ee-4216-8a12-59cd712e32b4',0,'2016-11-08 09:22:49.952000','2016-11-08 09:33:01.651000'),
  ('82c1950d-7eea-4204-83c7-9b4a7664060d','674586c2-dead-4a6f-9ee1-10594aa9c83b','82902646-67b4-46ef-94b4-94239b99cbf2',0,'2016-11-08 09:54:07.417000','2016-11-08 09:54:07.793000'),
  ('82d14e14-63ea-4b6d-af9a-98a2492fdedf','bc4f627a-a189-4547-be44-66f495f1141d','c3917213-922a-4968-beac-13e6fb135633',0,'2016-11-08 09:22:49.958000','2016-11-08 09:33:01.662000'),
  ('82daa533-8f66-4ce7-a76c-7f9121143a09','d7e1d145-3ae2-4dc4-b73c-47ce7d307c16','a4486873-63cd-4984-a5f8-1246dfa72198',0,'2016-11-08 09:54:07.279000','2016-11-08 09:54:07.637000'),
  ('8594f332-6b03-440b-8330-7ea3cece8f7f','81216951-7676-4a50-8419-c168b380f9ad','5b73d628-6e3a-4426-a73b-a827817950ad',0,'2016-11-08 10:23:15.746000','2016-11-08 10:32:52.112000'),
  ('874a30d8-8efd-44e5-9f47-20f44f748c90','769a2f8e-5e19-45b6-a83d-b57a1e36a964','1e38cb17-1613-4269-9c3d-5e494e9c8996',0,'2016-11-08 09:07:35.772000','2016-11-08 09:09:03.585000'),
  ('8b3305e0-a4a9-43c4-a2a7-11e53ce6253e','cefa0636-9b79-45d1-8bce-4358ff676f8b','81659c75-b5a6-4a6b-819e-48c7c4832130',0,'2016-11-08 09:22:49.997000','2016-11-08 09:33:02.086000'),
  ('8c931517-4d50-41c6-b5d6-a8a377ca1edb','112c9701-5902-4122-bc8a-8943bc582a89','bfbb8d3b-528e-4092-b7e9-62e109472935',0,'2016-11-08 09:22:50.213000','2016-11-08 09:33:01.681000'),
  ('8d1aff7b-a6b3-44f9-ad4e-22ee71f0d3eb','27357223-c2b4-4238-b42a-b03ad18d7ea5','17c46163-ec3f-4d2f-97c6-babc6e0a41a8',0,'2016-11-08 09:07:35.620000','2016-11-08 09:09:03.564000'),
  ('8f711e67-c58c-482d-b255-d9298b159c0a','9d993516-90e8-488e-8bd6-ad8ec89dd56c','a0b2f42e-b168-412b-86be-6b75a4683ddd',0,'2016-11-08 09:54:07.280000','2016-11-08 09:54:07.638000'),
  ('90d30ae5-92a1-4d3d-88ef-d3548d7b0977','0a32cd9a-77ce-4695-9d71-907a7b699f10','1258b76c-09f7-4aa2-8b96-1020310b47d5',0,'2016-11-08 09:07:35.714000','2016-11-08 09:09:03.555000'),
  ('92b16be0-f6c0-4ea1-a8ad-151f33aae53f','2ee4b509-f666-456e-9911-55779e05d974','05aa78f6-ad59-4421-83cd-b14d06ec8cff',0,'2016-11-08 09:22:49.994000','2016-11-08 09:33:02.084000'),
  ('97911416-e0a7-49c0-8d46-3a3f68818e52','1c16ed47-ff42-43f7-a566-3da02990df24','0afeaf7a-a31a-428d-8fd8-57ebcf123df9',0,'2016-11-08 09:22:49.970000','2016-11-08 09:33:02.074000'),
  ('9b4bca5d-b9ed-4bf3-b5c8-8f9c143f15ca','d133ec97-cdce-4a83-8c36-8fc622b9a72b','aab48179-5ba9-4277-9107-6558d8be7022',0,'2016-11-08 09:07:35.674000','2016-11-08 09:09:03.550000'),
  ('9d208b7a-e5c8-4686-aa9a-eb331870915c','1be17c2d-9055-45a9-a10e-02aaa474a3d4','f0596885-a211-498e-99fc-f238c64e1936',0,'2016-11-08 09:22:49.897000','2016-11-08 09:33:01.655000'),
  ('9f97e24a-8f5a-40f1-82a7-e9b26a480b33','13ffdf90-d8be-4ba4-ac15-2f2f565548aa','73d95971-52c0-452c-9d44-c7f2719f1cb3',0,'2016-11-08 09:22:50.228000','2016-11-08 09:33:02.096000'),
  ('a1a400d1-af5b-40bf-b343-c88671cdab64','c22f26aa-c0ad-4339-8f20-3499af3825d8','83b213b4-c246-413d-893b-8881d3f9b8f8',0,'2016-11-08 09:07:35.641000','2016-11-08 09:09:03.547000'),
  ('a4160ff5-b95c-4743-a6ee-e8ad843f761b','c6b76120-7ccd-496f-9ba8-e74af3f97102','2dc1321e-fe46-48bb-9bed-ae6e0f7582e7',0,'2016-11-08 09:22:49.996000','2016-11-08 09:33:02.085000'),
  ('a49af2ed-081f-4881-bd3e-71922dcf0319','3973cd59-9197-45fc-bb41-4d2b360e2264','a61c1f6c-207a-43b4-962a-63a471ab2acc',0,'2016-11-08 09:22:50.198000','2016-11-08 09:33:02.069000'),
  ('a4cc2109-8929-4aba-a73e-1365bcb01a6c','e8109f1d-01f6-429c-8517-07a7f887b0eb','22577ed7-0935-4422-9f51-d6655919e045',0,'2016-11-08 09:54:07.420000','2016-11-08 09:54:07.794000'),
  ('a569ceb2-7c08-4d14-8a59-3137fbb2f8e6','66e29247-f862-4f66-b27d-e04699c55ec4','bf293a4b-9c5f-40a4-bc1d-4a41e991a383',0,'2016-11-08 09:22:50.220000','2016-11-08 09:33:01.687000'),
  ('a57b7daf-b25a-4a8c-bdd7-fe652be2c6b3','b231b216-5e38-4ea4-a998-20ffbf32ad9c','f833bf51-9b9e-4ed6-97f1-6dbbf8d7368d',0,'2016-11-08 09:54:07.586000','2016-11-08 09:54:07.910000'),
  ('a77a4c6c-8b58-4974-88e0-94dc74c3d39f','11bc836e-ecd4-457a-b6a0-301ed43a2556','402a732f-ca50-48df-aa0b-0f5e72e3fabd',0,'2016-11-08 09:12:22.441000','2016-11-08 09:16:47.353000'),
  ('a79ea780-005b-4f3b-9212-a4b00d5da990','2da4b34a-9254-45b1-827b-0bf1276bed3d','4fac9910-26d0-428a-bb24-8f42e34965e2',0,'2016-11-08 09:54:07.431000','2016-11-08 09:54:07.801000'),
  ('aa816371-0fae-43fb-b958-6b32f606d752','eeec4876-ac75-4b3e-8fa8-a5f4a5c61e9d','f7862840-e11b-42e3-9c27-5eeaa8d1d293',0,'2016-11-08 09:54:07.580000','2016-11-08 09:54:07.821000'),
  ('b29a79e7-b8dc-4ce0-939f-635f70d7dd9b','c4a6ad00-45e9-4ff8-9d4c-b0f802500832','4eb14be7-c3a7-4654-8f2b-814a59450096',0,'2016-11-08 09:22:50.017000','2016-11-08 09:33:02.064000'),
  ('b6ab7a95-eccd-4a0a-98f0-a5d62f1aceba','d164ce40-02e0-46c8-a59a-4eb56f6bce92','5650dc81-2b49-4819-8caa-b6455ccd714d',0,'2016-11-08 09:54:07.406000','2016-11-08 09:54:07.786000'),
  ('b6ed81ee-5c55-47fa-9a14-fb0c627ef060','dd2c1536-6b1d-4ce3-b64c-91eb69dd9215','cf4d2b55-c9f7-45d2-9350-ae71bb09c248',0,'2016-11-08 09:07:35.656000','2016-11-08 09:09:03.548000'),
  ('b7f67fca-b7e2-4721-8cb5-5f33ecdf7f5f','9afa6a27-327a-47ec-9438-56ee08a69e58','c4a02b33-36d4-4c20-bbd7-617e0dd17118',0,'2016-11-08 09:54:07.286000','2016-11-08 09:54:07.645000'),
  ('ba2930b0-a1a6-4ae5-b3ac-e88f4cd5ee3d','eb15a694-9b97-4753-a5e1-42fb2fba539b','13d9faae-ba04-4238-98e7-e4a52f17a789',0,'2016-11-08 09:22:49.949000','2016-11-08 09:33:01.649000'),
  ('bb8c887c-8322-42b4-899c-2281993856e4','f7a7a357-5c65-42c5-8864-12f175256b4d','5a7ffad7-732a-4453-9e27-f4cecc8f19ad',0,'2016-11-08 09:54:07.422000','2016-11-08 09:54:07.796000'),
  ('bbb1cf78-da4c-4ae8-837d-613da1b5be31','c20b66c7-c388-4605-a986-ef1a17f4d42e','db11c178-122d-449e-ad06-0fd07816286d',0,'2016-11-08 09:54:07.402000','2016-11-08 09:54:07.653000'),
  ('bc6d2ab4-4e64-44c6-acd0-e93208db67f6','62bc9f4b-4440-45ee-8fdd-b1bba9f6e95d','01b25f93-c61e-4b88-a7a7-dbc00885ac67',0,'2016-11-08 09:22:50.224000','2016-11-08 09:33:02.092000'),
  ('bfa9e23e-1da9-40e5-b952-903ec5e4df33','255e6620-eb92-42ef-bda0-f83bb7acfbfa','c1bea530-c953-4c63-ae93-f45969486f6a',0,'2016-11-08 09:07:35.774000','2016-11-08 09:09:03.587000'),
  ('c37a4f02-bd96-4ff9-a2c0-112506be1ca7','e8f163c7-77b3-4e17-85f4-e3f3b30c10c8','a3f311e9-c956-49a0-b62b-acaa2e770757',0,'2016-11-08 10:23:15.747000','2016-11-08 10:32:52.113000'),
  ('c477d810-a044-4bb7-aa99-6d4bc33cdf49','f9446ed8-1fb9-47ee-920f-846d8ad3a994','50888535-a408-4e1e-a91f-c3a9508ff3c9',0,'2016-11-08 09:22:49.971000','2016-11-08 09:33:02.075000'),
  ('c5f21bee-88fc-43f4-b2f6-37a4af4a08df','edb48234-7db8-404b-b0c8-f1316b70838b','2a62ed6d-ebdf-4dfc-ad22-27c4a3d8c5e2',0,'2016-11-08 09:54:07.290000','2016-11-08 09:54:07.647000'),
  ('c64149ae-0380-4e77-a263-6819606da3e9','108f7d8d-673a-4ad9-9eb6-7f7873834774','52cffbb9-8971-4248-947d-bbc8ae8b4420',0,'2016-11-08 09:54:07.583000','2016-11-08 09:54:07.823000'),
  ('c7a63548-7f82-4966-bac0-7d80724ee216','d1c63353-9e35-4a41-a3d6-403158ad3036','0a098226-368c-4ab3-9421-984ee5ca8ef4',0,'2016-11-08 09:12:22.445000','2016-11-08 09:16:47.355000'),
  ('c87af6af-2de1-4a0f-81b5-04ef30399ab0','b6345411-a40e-4656-8d2a-f331efc9d255','d4683884-2f84-4976-af96-2cb6fb43c701',0,'2016-11-08 09:22:49.948000','2016-11-08 09:33:01.648000'),
  ('ca8b77e6-4fd0-402b-8a35-9dc4848a2590','a47bbdcc-6f7a-46af-be95-e94d3aa6d1ce','53768de4-70cf-4969-b435-4283f54532d5',0,'2016-11-08 09:51:24.046000','2016-11-08 09:51:40.829000'),
  ('cba557c9-9f48-451b-b14b-a7c74c6d7c03','20543f72-7d65-40ba-a3be-344e823aac4d','ad40a3d6-ab97-4947-876f-0d9a3d0e96e3',0,'2016-11-08 09:12:22.461000','2016-11-08 09:16:47.378000'),
  ('ceb02999-c297-4485-96ef-e06b69c94bc2','bf816e4e-5a02-4941-a442-d03ef3e6d411','73ef269d-9abc-418f-8158-b3a84aa3f109',0,'2016-11-08 09:22:50.226000','2016-11-08 09:33:02.094000'),
  ('d072dfa3-5324-49a7-96a9-458c9b138654','ca6918f6-3ec1-4ec3-8735-c4fdb2076fd9','8b15fdfc-3f2e-4ecb-a2ae-416648bfbab5',0,'2016-11-08 09:22:49.973000','2016-11-08 09:33:02.076000'),
  ('d0da72c3-cbbe-4de4-a264-44242caab0c5','1c041382-cc0e-44a9-a148-102ffe8f831f','ba5c9460-d7ce-4e65-9011-95e75e6588cc',0,'2016-11-08 10:23:15.733000','2016-11-08 10:32:52.133000'),
  ('d1e950e1-57ff-41b2-acd1-04066a551c83','4ad41c6e-1ddf-402c-af49-369425693ccf','544d5fd2-d9b7-437f-82b5-c6b30eb5414f',0,'2016-11-08 09:22:49.895000','2016-11-08 09:33:01.655000'),
  ('d262854c-3d82-4a1f-987f-8612cd0ab054','2c7ccb11-8d62-43b8-834d-139b819f996a','af6a4b31-8ca0-4263-b739-4fcde3f6451a',0,'2016-11-08 10:23:15.741000','2016-11-08 10:32:52.116000'),
  ('d41945eb-f9fa-4e90-92d9-227b4dbd2db6','c8775adc-b36d-4fa5-ad5c-cf38828f1aca','1027dffe-9195-43e0-9931-5055704b7742',0,'2016-11-08 09:22:50.217000','2016-11-08 09:33:01.682000'),
  ('d4513460-d341-463c-873b-de033ed7d305','31b08146-6ca5-4ccb-a52b-dfe6ff7a6569','a91e0d26-85ff-4f2d-a5cf-e6a7718e0a44',0,'2016-11-08 09:22:50.211000','2016-11-08 09:33:01.680000'),
  ('d62dc5ff-57a9-4097-9f60-e9406f850a52','f7ed2f60-54c8-496f-8868-416cbab27f33','7db5b291-f49c-4b5f-a52e-c306381b333c',0,'2016-11-08 09:07:35.629000','2016-11-08 09:09:03.567000'),
  ('d6791443-16f7-40f3-8f82-2b1f8fdf172e','51e19609-b48b-4f94-a8f2-a308cdc78b41','6aec776e-fd93-4d82-b067-0101c39cbd74',0,'2016-11-08 09:12:22.439000','2016-11-08 09:16:47.351000'),
  ('dfcb57f8-4fee-4407-9951-3fb7ca17af89','68e42308-a90f-4012-9bef-d7fd39e4e9bd','b88bfa99-303f-4974-ad51-835afe470663',0,'2016-11-08 09:22:50.200000','2016-11-08 09:33:02.070000'),
  ('e25cf9e9-3035-4ffc-bf84-5b10be193805','782d9c1f-bb57-4c9d-afe8-fc3ab8c8cabe','b5b56a10-010c-4f23-9dd5-b713f1be3663',0,'2016-11-08 09:54:07.292000','2016-11-08 09:54:07.649000'),
  ('ee841dfd-dfa6-4a8b-8b84-460e650789fa','2bc631df-f5f1-4383-828a-9c9952671341','0a1b64dc-7bb6-4a56-b2e4-ae910ea5a8be',0,'2016-11-08 09:54:07.423000','2016-11-08 09:54:07.796000'),
  ('f0a92b3f-3179-4b84-a604-e3f22c76cea2','88620b1e-26ab-4956-8dfa-d950edd9e1f8','0ee81a02-0446-48f3-8c59-03d5be9f6d73',0,'2016-11-08 09:12:22.447000','2016-11-08 09:16:47.356000'),
  ('f659a7b6-c4d6-47c1-a600-e8ee4c0fd290','7e33a743-f626-4ae1-91c4-44b30d25a28f','b005f4f2-9a71-4f01-b64c-551820fd9491',0,'2016-11-08 09:54:07.421000','2016-11-08 09:54:07.795000'),
  ('f732d513-a0ab-45e2-bd5b-1300bee59ba5','7e66839a-6aac-452e-b0d3-e62b95c26d13','544f4a1d-851b-45e7-9ffc-c75a82c907d6',0,'2016-11-08 09:54:07.277000','2016-11-08 09:54:07.633000'),
  ('f7d375d6-cfee-4299-86ab-d1a87d486ae9','8fd2ec54-0b4e-4bd5-9faa-3f156beeb908','93ee86ed-7878-4031-ba53-79809bb9e6fd',0,'2016-11-08 09:51:24.032000','2016-11-08 09:51:40.814000'),
  ('f800c598-94a6-4c0d-8dd3-5120fbc46093','3b8ae128-1c59-4009-8b25-549ea58da435','6a1666b3-0e30-4812-b335-6008b9f8ad27',0,'2016-11-08 09:07:35.723000','2016-11-08 09:09:03.557000'),
  ('f881d481-147a-48a5-b5c6-c81650e94e19','33b55a27-c8b8-4d8d-abba-09e9d4147940','4ffe07a1-e4a9-4d85-8c54-7857f806d23b',0,'2016-11-08 09:51:24.038000','2016-11-08 09:51:40.811000');

INSERT INTO `controladores_fisicos` (`id`, `id_json`, `area_id`, `data_criacao`, `data_atualizacao`)
VALUES
  ('3438f178-ecb4-4833-b6e7-e58d2812e35b',NULL,@Area2Id,NOW(),NOW()),
  ('4f960382-ef6d-4b47-8b1b-7d4a5aa9b7ee',NULL,@Area3Id,NOW(),NOW()),
  ('66f6865f-6963-4ff5-b160-7c6febb68c03',NULL,@Area1Id,NOW(),NOW()),
  ('c64b8f57-0f74-4e56-9bea-614882beeaa2',NULL,@Area1Id,NOW(),NOW()),
  ('ebaa3115-e64a-45ca-9ec6-afb85a39b89c',NULL,@Area1Id,NOW(),NOW());

INSERT INTO `versoes_controladores` (`id`, `id_json`, `controlador_origem_id`, `controlador_id`, `controlador_fisico_id`, `usuario_id`, `descricao`, `status_versao`, `data_criacao`, `data_atualizacao`)
VALUES
  ('0f2e142f-01eb-4276-87d2-2d0234ef27b2',NULL,NULL,'8d872244-c7c9-4ff6-9239-f207c2773787','4f960382-ef6d-4b47-8b1b-7d4a5aa9b7ee',@UsuarioId,'Controlador criado pelo usuário: Mobilab','EM_CONFIGURACAO',NOW(), NOW()),
  ('7c996199-ed02-4272-b53c-b297c4e69d20',NULL,NULL,'5d238555-8620-4841-a2bf-c77d497f6b03','c64b8f57-0f74-4e56-9bea-614882beeaa2',@UsuarioId,'Controlador 1','CONFIGURADO',NOW(), NOW()),
  ('9501b28f-f508-4573-92a7-20c932313e95',NULL,NULL,'3d86335e-05e7-4921-8cdf-42ed03821f62','ebaa3115-e64a-45ca-9ec6-afb85a39b89c',@UsuarioId,'Controlador 4','CONFIGURADO',NOW(), NOW()),
  ('9d3ec495-96da-453a-8512-fc458221eb00',NULL,NULL,'279d3e6e-b3ab-4e9f-8358-67e393e5ed0f','66f6865f-6963-4ff5-b160-7c6febb68c03',@UsuarioId,'CONTROLADOR 2','CONFIGURADO',NOW(), NOW()),
  (RANDOM_UUID(),NULL,NULL,'0f424143-383e-490d-96ef-145fed18bb29','3438f178-ecb4-4833-b6e7-e58d2812e35b',@UsuarioId,'Alteração 1','ARQUIVADO','2016-11-08 09:23:35.616000','2016-11-08 09:33:01.673000'),
  (RANDOM_UUID(),NULL,'0f424143-383e-490d-96ef-145fed18bb29','9dccd9b1-8837-43d0-8f5b-bb4b169fdc9e','3438f178-ecb4-4833-b6e7-e58d2812e35b',@UsuarioId,'Alteração 2','ARQUIVADO','2016-11-08 09:23:35.616000','2016-11-012 09:33:01.673000'),
  ('b95d6fe4-84c9-4d5d-94a4-401b915294d1',NULL,'9dccd9b1-8837-43d0-8f5b-bb4b169fdc9e','1dccd9b1-8837-43d0-8f5b-bb4b169fdc9d','3438f178-ecb4-4833-b6e7-e58d2812e35b',@UsuarioId,'Controlador clonado pelo usuário: Mobilab','EDITANDO','2016-11-08 09:23:35.616000','2016-11-13 09:33:01.673000');

INSERT INTO `detectores` (`id`, `id_json`, `tipo`, `anel_id`, `estagio_id`, `controlador_id`, `posicao`, `descricao`, `monitorado`, `tempo_ausencia_deteccao`, `tempo_deteccao_permanente`, `data_criacao`, `data_atualizacao`)
VALUES
  ('0b352148-22cd-4c57-be3e-464457207585','4b750a1f-33ff-43dc-a7df-e96eab01e8d1','VEICULAR','9ce82983-8de5-439e-863a-88086fb8b705','8977c23d-d3de-46b0-99b4-4813b4e4bee6',NULL,1,NULL,1,0,0,'2016-11-08 09:12:38.297000','2016-11-08 09:16:47.347000'),
  ('16f02b8a-10c3-4b0d-8d0f-2788b744e319','04359526-4f56-4cdd-8581-6891a57cdbf4','VEICULAR','5e913606-1f79-42db-bafd-a86b14a5c64c','89b9fbb7-4148-4b7b-b201-5c60100627f3','1dccd9b1-8837-43d0-8f5b-bb4b169fdc9d',6,NULL,1,0,0,'2016-11-08 09:54:07.269000','2016-11-08 09:54:07.627000'),
  ('19297373-ae9c-420f-9ffc-787a330aeefe','0c8c0c8c-0665-42a2-bb98-e3f2a52f1e88','VEICULAR','56f26b09-4bf1-4dfd-b014-eb39880ed45a','700b1104-11c1-4094-aacf-c0ee5bf9ce83',NULL,4,NULL,1,0,0,'2016-11-08 09:23:35.616000','2016-11-08 09:33:01.673000'),
  ('1b36b5bd-d675-4cd0-beef-ac6879cfc0d5','5193d861-c6e7-415f-9e18-17e5ff51d430','PEDESTRE','56f26b09-4bf1-4dfd-b014-eb39880ed45a','8ddf1f7e-4228-4eb3-8286-e6a73cbddea7',NULL,2,NULL,0,0,0,'2016-11-08 09:23:35.615000','2016-11-08 09:33:01.673000'),
  ('2e0456d2-8fe1-4ebd-8659-51e04fe039e7','eb12493c-8da0-4dee-b796-dfb9dedc7841','VEICULAR','750b3c0d-8247-4cc6-adbd-5a34f88092c3','f023f642-bbd6-4350-a6d7-fcbd77322e82',NULL,2,NULL,0,0,0,'2016-11-08 09:23:35.589000','2016-11-08 09:33:01.642000'),
  ('3b3777e6-a9a6-43ea-8515-5809bf5d107d','ba6e6128-8909-4be4-820c-a203cf4a6f7b','PEDESTRE','56f26b09-4bf1-4dfd-b014-eb39880ed45a','37ef8d1b-f9c5-44d5-b7e8-f1fd523f1d8d',NULL,1,NULL,0,0,0,'2016-11-08 09:23:35.614000','2016-11-08 09:33:01.674000'),
  ('5c412f08-d5ee-40a6-97fc-ee59fa5fe6fc','3d1d525e-2022-4c30-9e0b-2742c93c3d5b','VEICULAR','7012415b-6892-4498-b0bd-cb3fa2ad093c','e53b38b4-e2b1-495b-9970-dc9dd16b38a2',NULL,2,NULL,1,0,0,'2016-11-08 09:51:40.806000','2016-11-08 09:51:40.806000'),
  ('63066418-0d50-4feb-b6d6-7f05dc6eabe5','b17b41f7-41d6-4842-90d8-fabd37851b0f','VEICULAR','22eb55d2-c56f-4037-a9d7-166d829438a4','f48789ba-bbeb-4e96-afe7-587abf7a72d7',NULL,4,NULL,1,0,0,'2016-11-08 09:51:40.820000','2016-11-08 09:51:40.820000'),
  ('63a21913-5eab-44dc-a7d4-1f70a72d000a','6a096770-3793-4137-bb6c-bd9681884494','VEICULAR','70d364b0-6f7c-4f04-96e8-853a49ccd7f2','e091b797-de64-43ad-ab3b-7ed6a1122351',NULL,1,NULL,1,0,0,'2016-11-08 10:24:44.409000','2016-11-08 10:32:52.124000'),
  ('68673ab2-1245-435a-9313-aae8b88cb7d4','5a78014a-10bc-4944-b513-3622d2658dc8','VEICULAR','9ce82983-8de5-439e-863a-88086fb8b705','e924c0b9-e952-4ea5-9886-a6212ec475c2',NULL,2,NULL,1,0,0,'2016-11-08 09:12:38.298000','2016-11-08 09:16:47.348000'),
  ('6a4f2a06-1124-4bf5-b883-05a1c9a62fb5','94e2b824-b9fb-4fd4-827b-6f65a117d5bc','VEICULAR','750b3c0d-8247-4cc6-adbd-5a34f88092c3','5f2452f1-b034-43f9-bed8-39ab50e39192',NULL,3,NULL,0,0,0,'2016-11-08 09:23:35.589000','2016-11-08 09:33:01.643000'),
  ('75a981eb-2f11-4e48-a5e2-0ab273249893','217131dd-19d7-4ae9-969f-93a9941d9ece','VEICULAR','70d364b0-6f7c-4f04-96e8-853a49ccd7f2','db44e2c6-bad3-4436-a19f-174121bb3815',NULL,2,NULL,1,0,0,'2016-11-08 10:24:44.410000','2016-11-08 10:32:52.125000'),
  ('7c6bac38-4600-4939-909c-f7334ca72076','db7ba364-6b2e-4c49-a83b-784e398efa99','VEICULAR','043007e5-ee02-4383-bde1-87346abdc895','5ab242ec-8c7f-44d5-903c-0df019861685',NULL,4,NULL,1,0,0,'2016-11-08 10:24:44.423000','2016-11-08 10:32:52.108000'),
  ('84ad5fd2-fe8d-4e32-ac51-81571d72cbe4','49aaed10-475e-45c9-a3b3-9a22f1376826','PEDESTRE','4744f9d9-f9c3-4f3f-ab1c-17b7178453d5','b4713f89-5fbd-4134-8b42-c6c473715f29',NULL,1,NULL,1,0,0,'2016-11-08 09:08:00.116000','2016-11-08 09:09:03.540000'),
  ('9cb2a3fa-389f-4301-9ce8-27d177a852a6','6e896ad4-77b1-40c5-a877-942180c28135','VEICULAR','56f26b09-4bf1-4dfd-b014-eb39880ed45a','e962d14b-b269-42fb-b5af-c727b16678bd',NULL,6,NULL,1,0,0,'2016-11-08 09:23:35.617000','2016-11-08 09:33:01.674000'),
  ('9fd69386-fb2a-4364-ab4e-6f3ee6036700','406e0db2-68ec-406c-8c65-da2dccf84166','VEICULAR','750b3c0d-8247-4cc6-adbd-5a34f88092c3','c230a549-399a-4c93-adf9-91a2a3a06e1b',NULL,1,NULL,0,0,0,'2016-11-08 09:23:35.588000','2016-11-08 09:33:01.643000'),
  ('a23cd9b5-e5e6-4a86-809f-5c5b1622856d','24e6a318-4e39-4a1d-8d1f-2b2a490de5cc','VEICULAR','5033f1e1-3840-4a01-a69b-ea6815ac33fa','b78ab5e1-8cbb-4971-8e8b-a47497d0664b','1dccd9b1-8837-43d0-8f5b-bb4b169fdc9d',3,NULL,0,0,0,'2016-11-08 09:54:07.479000','2016-11-08 09:54:07.810000'),
  ('a31416d4-8962-4316-becd-4b815c5d3300','25a3ad7a-e5cd-4bb2-9d73-af6d9d9012b8','VEICULAR','5033f1e1-3840-4a01-a69b-ea6815ac33fa','4e58dfc3-fa71-495a-883d-bc6b59efcd9d','1dccd9b1-8837-43d0-8f5b-bb4b169fdc9d',1,NULL,0,0,0,'2016-11-08 09:54:07.479000','2016-11-08 09:54:07.811000'),
  ('ae58fa1e-8349-4852-ba76-6eae2e5e1fdb','40915ee0-c886-419b-8219-2b7c7e99cfb9','VEICULAR','5e913606-1f79-42db-bafd-a86b14a5c64c','fb7801a1-ed3b-48a7-af14-212f87da132b','1dccd9b1-8837-43d0-8f5b-bb4b169fdc9d',4,NULL,1,0,0,'2016-11-08 09:54:07.267000','2016-11-08 09:54:07.625000'),
  ('b244e54b-14cb-4c64-ba58-28778167f4e9','148a6f79-638d-4cfe-b02a-d6f6efeabe96','VEICULAR','22eb55d2-c56f-4037-a9d7-166d829438a4','e90ddae4-99b2-4bef-96bd-3f6a515bee9b',NULL,3,NULL,1,0,0,'2016-11-08 09:51:40.819000','2016-11-08 09:51:40.819000'),
  ('b95f255d-6c01-490e-b18f-230f898e9132','db589dc0-e9f8-448b-af72-f58428c07cf5','PEDESTRE','5e913606-1f79-42db-bafd-a86b14a5c64c','dbe60c2b-e495-4363-9cce-7a83348800ee','1dccd9b1-8837-43d0-8f5b-bb4b169fdc9d',1,NULL,0,0,0,'2016-11-08 09:54:07.268000','2016-11-08 09:54:07.626000'),
  ('beef48e6-011c-41c2-a583-b6f02624fc77','4a553013-3a80-4bc7-8d62-68dffb1f94fa','VEICULAR','4744f9d9-f9c3-4f3f-ab1c-17b7178453d5','540f7370-b266-4d2a-b6d9-04187a333945',NULL,2,NULL,1,0,0,'2016-11-08 09:08:00.117000','2016-11-08 09:09:03.541000'),
  ('c1cf6bba-f06b-48ad-ac31-37b590a2f7c9','d8ecba89-2fae-488b-92c7-5bcc4d65d7bb','VEICULAR','043007e5-ee02-4383-bde1-87346abdc895','25312c1e-f509-4740-baa2-adc910ce2473',NULL,3,NULL,1,0,0,'2016-11-08 10:24:44.423000','2016-11-08 10:32:52.108000'),
  ('c4895863-0613-45b0-8719-1d289dabeb43','baac6ad6-8f30-45c5-bf9d-872f354134e6','VEICULAR','4744f9d9-f9c3-4f3f-ab1c-17b7178453d5','a7bc0cc5-95bb-46f5-9ebf-725f3d874082',NULL,1,NULL,1,0,0,'2016-11-08 09:08:00.117000','2016-11-08 09:09:03.541000'),
  ('c84ae8dd-87bf-4e5a-adea-0ff1a2934cc9','02caadca-6043-4ef2-8267-a4fae9c5d846','VEICULAR','56f26b09-4bf1-4dfd-b014-eb39880ed45a','e7ae783c-a771-439d-b2ca-d25f305478d5',NULL,5,NULL,1,0,0,'2016-11-08 09:23:35.616000','2016-11-08 09:33:01.675000'),
  ('ca8b67c1-5176-4455-b4b0-2ed5a6bccf2b','f10a4fed-2262-4edf-8a06-f546c9296718','PEDESTRE','5e913606-1f79-42db-bafd-a86b14a5c64c','9f7fa835-1010-48ca-b282-218cf7b24ba7','1dccd9b1-8837-43d0-8f5b-bb4b169fdc9d',2,NULL,0,0,0,'2016-11-08 09:54:07.267000','2016-11-08 09:54:07.626000'),
  ('cd51f479-ec38-40d4-886a-685b83d79e77','d742dad8-87e7-40d7-aae5-c3baaf5617d0','VEICULAR','33e2bbf0-72ad-4d11-98d8-1bb440c370b0','caaebab1-8d69-44cb-aead-7bdb48dd444f',NULL,4,NULL,1,0,0,'2016-11-08 09:08:00.145000','2016-11-08 09:09:03.581000'),
  ('d03f0918-bdaf-45b4-87e9-04e3a72cd38c','cf9a5410-827c-443c-9d5f-9971106aa39b','VEICULAR','5e913606-1f79-42db-bafd-a86b14a5c64c','391dc5fc-ca18-4716-885e-2c75a3bb9ea5','1dccd9b1-8837-43d0-8f5b-bb4b169fdc9d',5,NULL,1,0,0,'2016-11-08 09:54:07.269000','2016-11-08 09:54:07.627000'),
  ('d7f3947d-7f08-4bdd-b8d3-e3633abdf4db','f4647deb-e33a-4ae7-963f-10b5c43e4933','VEICULAR','33e2bbf0-72ad-4d11-98d8-1bb440c370b0','180caf55-d387-443b-ba54-5fb030f725e2',NULL,3,NULL,1,0,0,'2016-11-08 09:08:00.144000','2016-11-08 09:09:03.581000'),
  ('e43fe234-fd03-49ab-abc3-43b6b6adc0be','dd5ce7c9-d9f7-40bb-828f-d6f894114f4d','VEICULAR','6c709913-6812-41d9-94a6-e36ee55e3b9c','4b411e49-2496-436b-b9cc-dd50dd79b021',NULL,4,NULL,1,0,0,'2016-11-08 09:12:38.317000','2016-11-08 09:16:47.371000'),
  ('e686550f-c8ca-4ab4-9dfe-f6b841459bae','6ce3303d-1b90-469a-b012-a608e7ed7299','VEICULAR','6c709913-6812-41d9-94a6-e36ee55e3b9c','9cbe2d7c-da23-4df6-b6cf-927d3163b31a',NULL,3,NULL,1,0,0,'2016-11-08 09:12:38.316000','2016-11-08 09:16:47.372000'),
  ('f3ff55e0-b55a-428c-a83e-df911c5291c6','0b7ab214-fbad-4f69-aacf-34179abadd5d','VEICULAR','7012415b-6892-4498-b0bd-cb3fa2ad093c','790dde51-8406-4ebe-9876-dfd67f5fa9d3',NULL,1,NULL,1,0,0,'2016-11-08 09:51:40.806000','2016-11-08 09:51:40.806000'),
  ('faa3f60b-7d42-4fb3-a0bf-871e83243a32','ee863d80-ebfd-4ecc-95e2-764447094864','VEICULAR','5033f1e1-3840-4a01-a69b-ea6815ac33fa','02249237-5121-4a89-b95c-2ccdec19114b','1dccd9b1-8837-43d0-8f5b-bb4b169fdc9d',2,NULL,0,0,0,'2016-11-08 09:54:07.478000','2016-11-08 09:54:07.810000');

INSERT INTO `estagios_grupos_semaforicos` (`id`, `id_json`, `estagio_id`, `grupo_semaforico_id`, `data_criacao`, `data_atualizacao`)
VALUES
  ('03e6fd0e-5ce4-40f8-b902-3141a201d596','cb0380ba-f3a6-426a-9809-72f1c5446e6f','b78ab5e1-8cbb-4971-8e8b-a47497d0664b','5d777b9c-5c6b-4de3-b4d1-a8ccbe92e88a','2016-11-08 09:54:07.580000','2016-11-08 09:54:07.821000'),
  ('0977347f-d3b8-42f9-b06b-6b98716dfdfb','e2803efe-0e4b-4298-9c48-f7925478bffc','4b411e49-2496-436b-b9cc-dd50dd79b021','b920567a-32ac-4233-81ec-858563409d9b','2016-11-08 09:11:53.023000','2016-11-08 09:16:47.376000'),
  ('0a43da32-1700-4581-9988-69995c560b3e','c3a3c9e9-573b-44ed-83bb-3f9167f7d564','e962d14b-b269-42fb-b5af-c727b16678bd','682c4d0e-626a-4c3d-8ce3-b6421ea2341a','2016-11-08 09:21:21.618000','2016-11-08 09:33:01.688000'),
  ('1401393f-e37c-491c-852a-34bbb8beee31','abf36d6d-b5ad-42eb-bcc6-4418fc55bfd7','db44e2c6-bad3-4436-a19f-174121bb3815','bf6524f8-9a7e-4be8-8e35-4fd4f909d1c4','2016-11-08 10:22:42.723000','2016-11-08 10:32:52.130000'),
  ('23cf24f3-b849-4858-8784-c67e14ae1617','b10d60f4-4688-4770-94e9-8e135ed19aee','b4713f89-5fbd-4134-8b42-c6c473715f29','d301c7f5-6b95-4eac-b4f1-fcb314cb5b9a','2016-11-08 09:06:59.122000','2016-11-08 09:09:03.552000'),
  ('2a47b006-34ba-46b9-b409-46813979ab90','5d4ba900-d4b4-42d3-9499-f81fc6c81ed8','540f7370-b266-4d2a-b6d9-04187a333945','717c6bc5-9098-464c-b19a-e2f0c7e6d40f','2016-11-08 09:06:59.107000','2016-11-08 09:09:03.543000'),
  ('2cd14387-c2b0-4dec-a721-3f9b60db9366','371faa13-6ef7-43c9-9bf5-5da5819b01e6','700b1104-11c1-4094-aacf-c0ee5bf9ce83','73487232-6688-40a8-a068-86a7cffe6b69','2016-11-08 09:21:21.630000','2016-11-08 09:33:02.071000'),
  ('45e856ee-71b2-4bd4-a967-3f5345e864d1','acc24f1e-d6ac-4f98-889b-6a5c81337aef','8977c23d-d3de-46b0-99b4-4813b4e4bee6','4c0b8351-28d6-4445-824a-48b6dece50e8','2016-11-08 09:11:53.000000','2016-11-08 09:16:47.349000'),
  ('47268539-8f66-4b69-a846-d1bee98b55ef','019e93b4-5db2-4eb4-b174-6b3c40b8c709','37ef8d1b-f9c5-44d5-b7e8-f1fd523f1d8d','155bd3c9-2fc8-4cca-9748-d6580f160dc2','2016-11-08 09:21:21.595000','2016-11-08 09:33:01.676000'),
  ('4781e521-eadf-4a5c-982f-5b1069cc1bcb','d0dd634f-4b68-4fd2-a7df-c8091c158334','391dc5fc-ca18-4716-885e-2c75a3bb9ea5','c5dc4dbe-2d49-4e1d-b6c0-449b13e16240','2016-11-08 09:54:07.411000','2016-11-08 09:54:07.790000'),
  ('485d719a-9981-4628-92c1-6d5495d2dfb7','4888f3d2-47df-4d14-a4f4-50109d46e81b','5f2452f1-b034-43f9-bed8-39ab50e39192','7081b5d1-c597-4ba0-a232-453a6b1fc8e9','2016-11-08 09:21:21.584000','2016-11-08 09:33:01.658000'),
  ('4d4383de-ed21-4a49-a42b-0d57d07db5fe','a4288ab6-e97a-46b5-94c6-1bd381e6c58f','25312c1e-f509-4740-baa2-adc910ce2473','b9b212ff-5b33-4f55-a67a-45955d13a66f','2016-11-08 10:22:42.748000','2016-11-08 10:32:52.114000'),
  ('5229c0f3-3ee4-4cc8-913e-77ed84975e49','affcef07-c7f8-4284-89b0-25b0d481bac8','9f7fa835-1010-48ca-b282-218cf7b24ba7','da7e4e08-e87b-4734-9f36-6ab8ab3a5893','2016-11-08 09:54:07.424000','2016-11-08 09:54:07.797000'),
  ('53704fc1-40cb-4840-a0dd-dce754636d39','6dfd0062-8cee-4b58-9ffb-fc0b80d858e1','f48789ba-bbeb-4e96-afe7-587abf7a72d7','7ff271f4-81ef-4422-8461-b15c44051fd8','2016-11-08 09:50:52.073000','2016-11-08 09:51:40.822000'),
  ('62ff3663-24dd-4d4f-acea-4aff68920d29','b6280441-7885-42f0-bed2-e0b5937452b3','fb7801a1-ed3b-48a7-af14-212f87da132b','4bb4af54-cf60-4bf8-81f5-37ec0c82b5f3','2016-11-08 09:54:07.292000','2016-11-08 09:54:07.650000'),
  ('643dab33-d18e-413a-8cfa-fc242b44ae36','c3153a96-4628-4642-850f-c6f90dbabc98','4e58dfc3-fa71-495a-883d-bc6b59efcd9d','4d592444-7995-4146-a9a3-e491e5d695a6','2016-11-08 09:54:07.486000','2016-11-08 09:54:07.816000'),
  ('7010377c-0aaf-4220-a24b-4da7fff0b4e7','1e3c6590-b9f2-4f80-bf64-c055d5299bd5','e7ae783c-a771-439d-b2ca-d25f305478d5','e52ff58d-a44b-4c1d-aa5a-7d90a68d0816','2016-11-08 09:21:21.795000','2016-11-08 09:33:02.081000'),
  ('70f1a985-5bc7-4463-adf5-f356fbd1fd51','07e297ae-256c-4fdf-abb0-e41be22f73d4','c230a549-399a-4c93-adf9-91a2a3a06e1b','438bea60-53f6-4a0c-ab26-d2c9ca061b23','2016-11-08 09:21:21.575000','2016-11-08 09:33:01.652000'),
  ('7252b1bb-a84c-4a3e-91e1-e97e4547a502','e7084134-8cc6-4788-b0d0-58e4b89a1932','a7bc0cc5-95bb-46f5-9ebf-725f3d874082','e9f671a5-950c-4fc5-9cc7-45acbd53227f','2016-11-08 09:06:59.152000','2016-11-08 09:09:03.561000'),
  ('7302188e-c946-4542-9548-c8101f349ffd','702f3e4d-d2c2-4699-91b5-bfcebd48bdeb','f023f642-bbd6-4350-a6d7-fcbd77322e82','12cb4ead-c499-479b-99f1-810b47f4ae83','2016-11-08 09:21:21.564000','2016-11-08 09:33:01.644000'),
  ('737494cf-4c0e-482a-921f-55bbaeb36a1c','ab2dff6f-9551-41f5-8959-379f7b3a58e4','02249237-5121-4a89-b95c-2ccdec19114b','3c8ce4de-70a1-44e8-9273-c07f705f130e','2016-11-08 09:54:07.481000','2016-11-08 09:54:07.812000'),
  ('7ec31a21-4d10-4816-a53b-fda218559d17','18f3673a-ada4-49d9-aa91-9cdebeda89d8','5ab242ec-8c7f-44d5-903c-0df019861685','462dd6ae-acf9-4a1b-b266-b6a29b47c1fa','2016-11-08 10:22:42.742000','2016-11-08 10:32:52.110000'),
  ('86aa413c-873c-4af4-bdeb-991b588506d6','87150995-92d7-4ed6-81a9-7f6af133c0d0','89b9fbb7-4148-4b7b-b201-5c60100627f3','77347d0d-1425-4c98-9aa3-2a3678ececd4','2016-11-08 09:54:07.282000','2016-11-08 09:54:07.639000'),
  ('8c226894-223a-4f14-9a4f-038da4ad9237','22354b1c-b939-415b-a8fe-ef00f613f936','e924c0b9-e952-4ea5-9886-a6212ec475c2','53b67934-ce51-4dd7-b4c6-e1abedcd4abb','2016-11-08 09:11:53.008000','2016-11-08 09:16:47.354000'),
  ('8cbe3e56-6c13-45cb-9b89-cc31faa47c4d','cec5b00f-a33d-418a-88b8-7acc669b78cf','caaebab1-8d69-44cb-aead-7bdb48dd444f','e307d4fc-95ff-45ce-a23d-baae9427599b','2016-11-08 09:06:59.181000','2016-11-08 09:09:03.588000'),
  ('a72f348e-cce2-4407-a162-6921c8e47d41','fbb4d639-c882-4ada-b489-41c4eaf9ce87','dbe60c2b-e495-4363-9cce-7a83348800ee','1aeadd03-ec04-4bea-a4c7-641125dda206','2016-11-08 09:54:07.271000','2016-11-08 09:54:07.628000'),
  ('aa16ccda-3e9d-4920-9862-81168c39319b','8e3060c8-40aa-41f3-bdca-6a17d54fb7be','e53b38b4-e2b1-495b-9970-dc9dd16b38a2','84bcba8f-93c4-4fb2-9aac-457262312441','2016-11-08 09:50:52.060000','2016-11-08 09:51:40.807000'),
  ('af41472b-47d8-4d98-871d-69b296fe440b','8128b605-0f86-47b3-9994-b517b065ee2c','9cbe2d7c-da23-4df6-b6cf-927d3163b31a','4829f07e-2807-4054-b8e7-ddb2bcdcbcfa','2016-11-08 09:11:53.016000','2016-11-08 09:16:47.372000'),
  ('d0a48817-ee8d-41b5-a6ad-d1232e22e1f0','9f6a382a-f9b1-4fd2-a69c-3baf793bcbc7','180caf55-d387-443b-ba54-5fb030f725e2','d268b155-7b77-4dd0-af4a-d23376a8a15c','2016-11-08 09:06:59.171000','2016-11-08 09:09:03.582000'),
  ('d7c22c13-9dde-42db-9590-1df269b6e371','831f8e2f-7138-4b02-83f6-4aedd61d127f','8ddf1f7e-4228-4eb3-8286-e6a73cbddea7','efd9bc6e-d318-4654-994c-3aafff5e3b66','2016-11-08 09:21:21.806000','2016-11-08 09:33:02.089000'),
  ('dfe3fecc-3867-4a82-9a59-2d2b18d05781','e4947e3e-0a9e-4a21-9e3d-9c140738885c','e90ddae4-99b2-4bef-96bd-3f6a515bee9b','d0fe4320-ac2c-4623-ae92-49bc89f43438','2016-11-08 09:50:52.077000','2016-11-08 09:51:40.826000'),
  ('e3097f3d-5c48-402f-9ffa-d06450188028','5d9e744f-f6e2-4394-b49d-68d0763c30a1','e091b797-de64-43ad-ab3b-7ed6a1122351','72dab597-6715-40d6-abce-2724b5cff1f9','2016-11-08 10:22:42.716000','2016-11-08 10:32:52.126000'),
  ('ed70efaa-9167-4d63-a438-a1c449b9c864','b8679255-6b19-4a82-a441-30bd6186468f','790dde51-8406-4ebe-9876-dfd67f5fa9d3','c9284008-54bc-438f-88cc-363e7752a148','2016-11-08 09:50:52.066000','2016-11-08 09:51:40.812000');


---------------------------- PLANOS --------------------------

INSERT INTO `versoes_planos` (`id`, `id_json`, `versao_anterior_id`, `anel_id`, `usuario_id`, `descricao`, `status_versao`, `data_criacao`, `data_atualizacao`)
VALUES
  ('0668760a-3ea5-4122-8e28-2bbdf85ee83c','1b3108b4-2b95-4593-9469-25fa1e502c41',NULL,'4744f9d9-f9c3-4f3f-ab1c-17b7178453d5',NULL,'Planos criado','CONFIGURADO',NOW(),NOW()),
  ('234a6aca-2ea8-4657-8bf6-26a64a4e2b8c','950aa37a-195c-4ed4-bbdd-ede73e78fe82',NULL,'6c709913-6812-41d9-94a6-e36ee55e3b9c',NULL,'Planos criado','CONFIGURADO',NOW(),NOW()),
  ('4db9bb39-7794-4eb1-97d5-2ec6a991c26e','9bd223a2-5145-403d-872a-f1e2d9842999',NULL,'043007e5-ee02-4383-bde1-87346abdc895',NULL,'Planos criado','CONFIGURADO',NOW(),NOW()),
  ('7c53c166-bcca-4ff1-9340-75cdf53db9f3','2eb6394f-c563-4200-aaaf-644997552497',NULL,'56f26b09-4bf1-4dfd-b014-eb39880ed45a',NULL,'Planos criado','ARQUIVADO',NOW(),NOW()),
  ('a3a0d6fa-9845-4c7c-8a52-2dc51fb8a52a','aca19256-0135-4d06-a032-8e48a7326e06',NULL,'9ce82983-8de5-439e-863a-88086fb8b705',NULL,'Planos criado','CONFIGURADO',NOW(),NOW()),
  ('bb3f1e93-cb4e-43bc-b634-9ac5a10755a4','a6b8d1f8-ff6f-4c81-86ec-9672c56d934c','7c53c166-bcca-4ff1-9340-75cdf53db9f3','5e913606-1f79-42db-bafd-a86b14a5c64c',@UsuarioId,'Planos criado pelo usuário:Mobilab','EDITANDO',NOW(),NOW()),
  ('beaed461-4c9c-4a5e-9f6b-0b2ee020af7f','086f197f-c597-468c-a993-fee040067f9b',NULL,'70d364b0-6f7c-4f04-96e8-853a49ccd7f2',NULL,'Planos criado','CONFIGURADO',NOW(),NOW()),
  ('ce66c466-750f-4116-97ed-926c01d8d43e','a4cb50af-9cf0-4163-a73e-f0a15ee03dfc',NULL,'750b3c0d-8247-4cc6-adbd-5a34f88092c3',NULL,'Planos criado','ARQUIVADO',NOW(),NOW()),
  ('d5c842c1-9cd1-489f-8071-816ef50d1044','2cab46a5-1e55-48af-b897-a14dd0083eca','ce66c466-750f-4116-97ed-926c01d8d43e','5033f1e1-3840-4a01-a69b-ea6815ac33fa',@UsuarioId,'Planos criado pelo usuário:Mobilab','EDITANDO',NOW(),NOW()),
  ('ebb8691f-4ae0-42cc-b9b7-3023a4ffc004','e653df46-8897-4ad0-900c-4cd7b25d3567',NULL,'33e2bbf0-72ad-4d11-98d8-1bb440c370b0',NULL,'Planos criado','CONFIGURADO',NOW(),NOW());


INSERT INTO `planos` (`id`, `id_json`, `posicao`, `descricao`, `tempo_ciclo`, `defasagem`, `versao_plano_id`, `modo_operacao`, `posicao_tabela_entre_verde`, `data_criacao`, `data_atualizacao`)
VALUES
  ('0850accf-f810-4ef6-b8c2-3d32dc0680ae','a7ff5822-460e-498b-a264-2a886dfbdb62',3,'PLANO 3',50,0,'a3a0d6fa-9845-4c7c-8a52-2dc51fb8a52a',0,1,'2016-11-08 09:15:35.771000','2016-11-08 09:16:47.366000'),
  ('11691ae8-30d7-45d6-b85c-4fac69e398cf','4e4f196b-cf04-456f-9fd1-4468f97c8da0',1,'PLANO 1',30,0,'234a6aca-2ea8-4657-8bf6-26a64a4e2b8c',1,1,'2016-11-08 09:15:35.815000','2016-11-08 09:16:47.381000'),
  ('147c6a1f-5647-4ad0-ae2a-7ebf4e3e8292','65d0d234-035b-418c-86f7-9446e7001ef0',1,'PLANO 1',60,0,'bb3f1e93-cb4e-43bc-b634-9ac5a10755a4',0,1,'2016-11-08 09:54:07.467000','2016-11-08 09:54:07.806000'),
  ('1d5e7d25-42a9-45aa-bb1b-6ae66969960d','9edbceec-70a7-4e21-8275-cfa736f01ace',1,'PLANO 1',60,10,'d5c842c1-9cd1-489f-8071-816ef50d1044',1,1,'2016-11-08 09:54:07.591000','2016-11-08 09:54:07.912000'),
  ('25e91add-1d58-46b1-a07a-55178c9315cc','bd24e30f-5be1-43b7-b84a-46119888f1ed',0,'Exclusivo',30,0,'d5c842c1-9cd1-489f-8071-816ef50d1044',5,1,'2016-11-08 09:54:07.598000','2016-11-08 09:54:07.915000'),
  ('3014a5b3-0cc7-46e9-8817-9175f7b0ece1','b2a5188f-1b7d-4405-a5a1-38e8bcf3358f',2,'PLANO 2',30,0,'4db9bb39-7794-4eb1-97d5-2ec6a991c26e',3,1,'2016-11-08 10:26:13.332000','2016-11-08 10:32:52.119000'),
  ('3f5a5ac9-6eab-42f5-af55-a3f3e03a3913','2f3ae4c4-1332-44a2-be6d-c868169d36d1',4,'PLANO 4',30,0,'a3a0d6fa-9845-4c7c-8a52-2dc51fb8a52a',4,1,'2016-11-08 09:15:35.778000','2016-11-08 09:16:47.368000'),
  ('3fb01df7-cf0d-4d54-b4f5-86004b617fca','5cadb954-478a-44a9-b2d0-ee1ab830c1cd',4,'PLANO 4',30,0,'234a6aca-2ea8-4657-8bf6-26a64a4e2b8c',3,1,'2016-11-08 09:15:35.837000','2016-11-08 09:16:47.388000'),
  ('4ad0906e-9e0d-4ea2-8584-7664d01799cc','b3894067-86cd-4b6f-876e-845982b6ed90',3,'PLANO 3',30,0,'234a6aca-2ea8-4657-8bf6-26a64a4e2b8c',0,1,'2016-11-08 09:15:35.830000','2016-11-08 09:16:47.385000'),
  ('5a6591a5-a88c-4d5d-b5b4-fe6f6908e189','8d87324d-6f4e-420c-bc15-df387fbac599',1,'PLANO 1',30,0,'4db9bb39-7794-4eb1-97d5-2ec6a991c26e',0,1,'2016-11-08 10:26:13.326000','2016-11-08 10:32:52.121000'),
  ('70233ca6-3623-4a85-baec-98c2e504617a','dfb94e4b-50af-4662-b789-4c5da47038a8',1,'PLANO 1',30,0,'a3a0d6fa-9845-4c7c-8a52-2dc51fb8a52a',1,1,'2016-11-08 09:15:35.740000','2016-11-08 09:16:47.361000'),
  ('877b53b5-7649-4cb9-a9bc-9049fbddbc96','6653e6c8-9951-4c3d-a5fa-5549e2ad429c',2,'PLANO 2',30,0,'beaed461-4c9c-4a5e-9f6b-0b2ee020af7f',1,1,'2016-11-08 10:26:13.236000','2016-11-08 10:32:52.135000'),
  ('94d4ac4a-92f0-4f70-96ec-5385d3301c02','9746e624-d145-4026-901e-f302f30c7b38',1,'PLANO 1',60,10,'ce66c466-750f-4116-97ed-926c01d8d43e',1,1,'2016-11-08 09:32:26.069000','2016-11-08 09:33:01.668000'),
  ('a7375bff-22d8-4ce3-ad0b-335cb6a19a81','a1af881f-13de-4d55-8a31-999a9697c302',1,'PLANO 1',40,0,'0668760a-3ea5-4122-8e28-2bbdf85ee83c',1,1,'2016-11-08 09:08:42.261000','2016-11-08 09:09:03.575000'),
  ('bd19def4-a247-48e7-abdb-4202665c05fa','8ca69694-4ebb-4be3-9140-31bcf2f8b71d',2,'PLANO 2',30,0,'234a6aca-2ea8-4657-8bf6-26a64a4e2b8c',3,1,'2016-11-08 09:15:35.823000','2016-11-08 09:16:47.383000'),
  ('c9b21230-d527-487a-a8b4-19b311b4fa4e','2411cfed-a454-46fb-9451-297ca91ffaec',0,'Exclusivo',30,0,'0668760a-3ea5-4122-8e28-2bbdf85ee83c',5,1,'2016-11-08 09:08:42.253000','2016-11-08 09:09:03.571000'),
  ('ccf0063f-73fd-4b5b-94ff-d2e3eede68d3','d5adda80-69b6-46c9-ac34-ebc47c9f05d4',1,'PLANO 1',30,0,'ebb8691f-4ae0-42cc-b9b7-3023a4ffc004',1,1,'2016-11-08 09:08:42.285000','2016-11-08 09:09:03.595000'),
  ('e90c7f38-4e75-466a-a60f-488fa9b897c8','7c313092-2ce8-416e-9aa2-9d31f37912b2',1,'PLANO 1',60,0,'7c53c166-bcca-4ff1-9340-75cdf53db9f3',0,1,'2016-11-08 09:32:26.416000','2016-11-08 09:33:02.104000'),
  ('ed454ab4-59bc-44f2-9db1-79385a3271cf','71833821-4f65-4728-80f1-f6171ff9d98a',1,'PLANO 1',30,0,'beaed461-4c9c-4a5e-9f6b-0b2ee020af7f',0,1,'2016-11-08 10:26:13.234000','2016-11-08 10:32:52.137000'),
  ('ef91e51d-4ca8-4cd9-87b9-0340d53b9666','b032d5a7-e297-4b94-916d-71f02db49a70',0,'Exclusivo',30,0,'a3a0d6fa-9845-4c7c-8a52-2dc51fb8a52a',5,1,'2016-11-08 09:15:35.734000','2016-11-08 09:16:47.358000'),
  ('f68b57e6-8122-4b93-b6cc-a5f174bc1772','39b266d4-9746-4406-8ab6-8ad2566980c5',2,'PLANO 2',30,0,'a3a0d6fa-9845-4c7c-8a52-2dc51fb8a52a',3,1,'2016-11-08 09:15:35.764000','2016-11-08 09:16:47.363000'),
  ('fbdf7407-6465-44f8-aca5-489bd7f6f53f','808deb4a-b77f-4494-b426-3c7c1108d861',0,'Exclusivo',30,0,'ce66c466-750f-4116-97ed-926c01d8d43e',5,1,'2016-11-08 09:32:26.063000','2016-11-08 09:33:01.664000');

INSERT INTO `estagios_planos` (`id`, `id_json`, `estagio_id`, `plano_id`, `posicao`, `tempo_verde`, `tempo_verde_minimo`, `tempo_verde_maximo`, `tempo_verde_intermediario`, `tempo_extensao_verde`, `dispensavel`, `estagio_que_recebe_estagio_dispensavel_id`, `data_criacao`, `data_atualizacao`)
VALUES
  ('08c9c8b5-e977-472f-8632-5ae15f49764b','a5e6eb3f-3edb-4c6a-a512-ad9da413d461','8977c23d-d3de-46b0-99b4-4813b4e4bee6','f68b57e6-8122-4b93-b6cc-a5f174bc1772',1,10,0,0,0,0,0,NULL,'2016-11-08 09:15:35.764000','2016-11-08 09:16:47.363000'),
  ('09b258ff-038c-4b23-8c82-b1d45c8189c1','5aa05e4c-9594-4d68-aeb0-392cdea2f6e8','9cbe2d7c-da23-4df6-b6cf-927d3163b31a','bd19def4-a247-48e7-abdb-4202665c05fa',1,10,0,0,0,0,0,NULL,'2016-11-08 09:15:35.826000','2016-11-08 09:16:47.384000'),
  ('09eeddb3-7b17-454e-8edd-c2477aaefafc','677deb63-8af6-47bc-a808-6a395925ca60','37ef8d1b-f9c5-44d5-b7e8-f1fd523f1d8d','e90c7f38-4e75-466a-a60f-488fa9b897c8',4,13,0,0,0,0,0,NULL,'2016-11-08 09:32:26.429000','2016-11-08 09:33:02.105000'),
  ('0dffca38-c5dc-4055-a3bb-0c486c7b687b','e17a872a-b308-4408-ae5e-dca49504385b','9cbe2d7c-da23-4df6-b6cf-927d3163b31a','4ad0906e-9e0d-4ea2-8584-7664d01799cc',1,12,0,0,0,0,0,NULL,'2016-11-08 09:15:35.831000','2016-11-08 09:16:47.386000'),
  ('1377da59-b0c8-4927-809a-0b46f31bcdcc','45e1b1ba-dd7d-4b6a-87ef-e1ab6ef51744','b78ab5e1-8cbb-4971-8e8b-a47497d0664b','25e91add-1d58-46b1-a07a-55178c9315cc',3,10,NULL,NULL,NULL,NULL,0,NULL,'2016-11-08 09:54:07.602000','2016-11-08 09:54:07.917000'),
  ('15ec6dc8-847d-45d0-a37b-9ea935e2cd17','36ea5a97-ea7f-4413-ac3e-47d855f9a9f8','e924c0b9-e952-4ea5-9886-a6212ec475c2','3f5a5ac9-6eab-42f5-af55-a3f3e03a3913',2,10,0,0,0,0,0,NULL,'2016-11-08 09:15:35.780000','2016-11-08 09:16:47.368000'),
  ('216c6798-019c-414d-881a-52f075d61566','05f4b2e8-30e1-4f59-8775-46912519ff29','8977c23d-d3de-46b0-99b4-4813b4e4bee6','ef91e51d-4ca8-4cd9-87b9-0340d53b9666',1,10,NULL,NULL,NULL,NULL,0,NULL,'2016-11-08 09:15:35.735000','2016-11-08 09:16:47.359000'),
  ('22b457c6-714e-4dec-a579-17234ef881a7','c4821061-a5a4-4f39-ae71-110767df263a','391dc5fc-ca18-4716-885e-2c75a3bb9ea5','147c6a1f-5647-4ad0-ae2a-7ebf4e3e8292',1,14,0,0,0,0,0,NULL,'2016-11-08 09:54:07.469000','2016-11-08 09:54:07.808000'),
  ('239d6a89-b981-4a30-a782-cdc80328291d','2dfa7ab8-f449-4131-9ab0-159d49562e27','540f7370-b266-4d2a-b6d9-04187a333945','a7375bff-22d8-4ce3-ad0b-335cb6a19a81',2,14,NULL,NULL,NULL,NULL,0,NULL,'2016-11-08 09:08:42.262000','2016-11-08 09:09:03.575000'),
  ('300d53a3-de17-47a6-905e-513154c53cad','ea02511c-c860-46f2-bd60-3a0eae293a55','4b411e49-2496-436b-b9cc-dd50dd79b021','bd19def4-a247-48e7-abdb-4202665c05fa',2,10,0,0,0,0,0,NULL,'2016-11-08 09:15:35.824000','2016-11-08 09:16:47.384000'),
  ('389fcb41-8f6f-4ad2-b2b1-e818d16d30f3','9d968e99-7832-4301-8450-fbc5b9147dfe','c230a549-399a-4c93-adf9-91a2a3a06e1b','fbdf7407-6465-44f8-aca5-489bd7f6f53f',2,10,NULL,NULL,NULL,NULL,0,NULL,'2016-11-08 09:32:26.064000','2016-11-08 09:33:01.665000'),
  ('39c6e52e-adcd-4300-b535-20242a7bd14e','6babda7a-9e57-49fc-b761-0152c72a623f','4e58dfc3-fa71-495a-883d-bc6b59efcd9d','25e91add-1d58-46b1-a07a-55178c9315cc',2,10,NULL,NULL,NULL,NULL,0,NULL,'2016-11-08 09:54:07.599000','2016-11-08 09:54:07.916000'),
  ('3b3d63b1-b160-4f51-be21-0d857a3b6d8e','177055f3-d61a-4228-a70b-ab41991762aa','e924c0b9-e952-4ea5-9886-a6212ec475c2','0850accf-f810-4ef6-b8c2-3d32dc0680ae',2,22,0,0,0,0,0,NULL,'2016-11-08 09:15:35.774000','2016-11-08 09:16:47.366000'),
  ('3bb12c3b-60e1-4766-96da-0dd1a380b463','6e1874c6-8823-4c38-ba30-8a862d8dd8c9','4b411e49-2496-436b-b9cc-dd50dd79b021','4ad0906e-9e0d-4ea2-8584-7664d01799cc',2,12,0,0,0,0,0,NULL,'2016-11-08 09:15:35.834000','2016-11-08 09:16:47.386000'),
  ('403f1b69-80fe-465f-9286-e58e4c41c39c','de3a52bb-5d38-4525-ad9e-afb23ff1583b','db44e2c6-bad3-4436-a19f-174121bb3815','877b53b5-7649-4cb9-a9bc-9049fbddbc96',2,12,NULL,NULL,NULL,NULL,0,NULL,'2016-11-08 10:26:13.238000','2016-11-08 10:32:52.135000'),
  ('46571559-ed18-4892-8211-7194986ca0b5','710ecea6-f274-4fca-b660-c370f412ea40','02249237-5121-4a89-b95c-2ccdec19114b','1d5e7d25-42a9-45aa-bb1b-6ae66969960d',1,15,0,0,0,0,0,NULL,'2016-11-08 09:54:07.595000','2016-11-08 09:54:07.913000'),
  ('4b02a38b-f6b1-461f-9186-b687d4dee031','6e91fc39-62e4-4c4e-b786-d43a791160a4','db44e2c6-bad3-4436-a19f-174121bb3815','ed454ab4-59bc-44f2-9db1-79385a3271cf',2,12,0,0,0,0,0,NULL,'2016-11-08 10:26:13.235000','2016-11-08 10:32:52.138000'),
  ('504e961d-8c4e-4337-997f-0966bc130c7a','380b1264-6f69-42ce-ab39-8abf9e551705','540f7370-b266-4d2a-b6d9-04187a333945','c9b21230-d527-487a-a8b4-19b311b4fa4e',2,10,NULL,NULL,NULL,NULL,0,NULL,'2016-11-08 09:08:42.254000','2016-11-08 09:09:03.571000'),
  ('5497396c-f5e9-4814-b0c2-70723edc8b87','293d5888-55f7-4b99-b2a9-921a91a3e796','e091b797-de64-43ad-ab3b-7ed6a1122351','877b53b5-7649-4cb9-a9bc-9049fbddbc96',1,12,NULL,NULL,NULL,NULL,0,NULL,'2016-11-08 10:26:13.237000','2016-11-08 10:32:52.136000'),
  ('578cea14-ff8c-4d92-bfb4-280e42fbf729','8600cd77-b393-43c7-a8cb-a2f69d27c789','5ab242ec-8c7f-44d5-903c-0df019861685','5a6591a5-a88c-4d5d-b5b4-fe6f6908e189',2,12,0,0,0,0,0,NULL,'2016-11-08 10:26:13.329000','2016-11-08 10:32:52.121000'),
  ('5962d55a-38a2-474f-887d-a90a73081079','7c6c5378-b40d-42b2-9d96-e3f9a11a8dde','8ddf1f7e-4228-4eb3-8286-e6a73cbddea7','e90c7f38-4e75-466a-a60f-488fa9b897c8',3,6,0,0,0,0,1,NULL,'2016-11-08 09:32:26.428000','2016-11-08 09:33:02.106000'),
  ('5995b30f-242d-413f-b5c0-f26563376dc9','7566e3d7-d104-43c2-b474-70dec3ac9644','8977c23d-d3de-46b0-99b4-4813b4e4bee6','70233ca6-3623-4a85-baec-98c2e504617a',1,12,NULL,NULL,NULL,NULL,0,NULL,'2016-11-08 09:15:35.741000','2016-11-08 09:16:47.361000'),
  ('5fd1b16d-8637-4284-9da2-1e7ba3c099b9','86531ffa-e5e6-412d-a38e-abca36485e23','9f7fa835-1010-48ca-b282-218cf7b24ba7','147c6a1f-5647-4ad0-ae2a-7ebf4e3e8292',3,6,0,0,0,0,1,NULL,'2016-11-08 09:54:07.468000','2016-11-08 09:54:07.807000'),
  ('60537180-1c95-472f-a2be-78630e10038b','34e9f630-0ecb-4330-a598-f6facbc5f4e6','b4713f89-5fbd-4134-8b42-c6c473715f29','c9b21230-d527-487a-a8b4-19b311b4fa4e',3,4,NULL,NULL,NULL,NULL,0,NULL,'2016-11-08 09:08:42.256000','2016-11-08 09:09:03.572000'),
  ('69566846-e867-4baa-b53e-728efeeca9c6','f5d8dea6-17be-4203-983f-86f1a83bacaf','4b411e49-2496-436b-b9cc-dd50dd79b021','3fb01df7-cf0d-4d54-b4f5-86004b617fca',2,10,0,0,0,0,0,NULL,'2016-11-08 09:15:35.838000','2016-11-08 09:16:47.388000'),
  ('75d0a281-69d4-43ad-816f-02663c294b90','ebce35bd-5143-47d0-996c-976a162b5be6','5f2452f1-b034-43f9-bed8-39ab50e39192','94d4ac4a-92f0-4f70-96ec-5385d3301c02',3,22,0,0,0,0,0,NULL,'2016-11-08 09:32:26.071000','2016-11-08 09:33:01.669000'),
  ('7e681de9-fd9a-4384-975e-8add07a09221','38c05061-6d23-4b12-8924-4d2cf5cf8687','b78ab5e1-8cbb-4971-8e8b-a47497d0664b','1d5e7d25-42a9-45aa-bb1b-6ae66969960d',3,22,0,0,0,0,0,NULL,'2016-11-08 09:54:07.594000','2016-11-08 09:54:07.913000'),
  ('82c8b87f-07a3-4793-a8db-c794d8f5424e','93db9454-cf18-472b-8291-5bff44a0b03c','8977c23d-d3de-46b0-99b4-4813b4e4bee6','3f5a5ac9-6eab-42f5-af55-a3f3e03a3913',1,10,0,0,0,0,0,NULL,'2016-11-08 09:15:35.779000','2016-11-08 09:16:47.369000'),
  ('876ab58a-9d0d-4887-9858-66cc0b92d62e','454d7e6d-f61f-4f94-b3cb-02d33e1365ef','25312c1e-f509-4740-baa2-adc910ce2473','5a6591a5-a88c-4d5d-b5b4-fe6f6908e189',1,12,0,0,0,0,0,NULL,'2016-11-08 10:26:13.328000','2016-11-08 10:32:52.122000'),
  ('8ab0cb53-5276-463c-b775-dcdd98a94ac8','384749b8-28d9-49f6-93c1-cb9c0a20a1ad','4e58dfc3-fa71-495a-883d-bc6b59efcd9d','1d5e7d25-42a9-45aa-bb1b-6ae66969960d',2,14,0,0,0,0,0,NULL,'2016-11-08 09:54:07.595000','2016-11-08 09:54:07.914000'),
  ('8c8e78c0-26c9-46c8-8b80-4c1f19c516be','fb6866a8-f058-4267-b817-aa030885d9ac','f023f642-bbd6-4350-a6d7-fcbd77322e82','fbdf7407-6465-44f8-aca5-489bd7f6f53f',1,10,NULL,NULL,NULL,NULL,0,NULL,'2016-11-08 09:32:26.065000','2016-11-08 09:33:01.665000'),
  ('8eba701c-e134-455e-b9f2-b9701679b8ad','85bd55fe-8be9-4552-9037-8610e9b8cae1','b4713f89-5fbd-4134-8b42-c6c473715f29','a7375bff-22d8-4ce3-ad0b-335cb6a19a81',3,4,NULL,NULL,NULL,NULL,0,NULL,'2016-11-08 09:08:42.263000','2016-11-08 09:09:03.576000'),
  ('911e0e6f-ac88-44a6-8b5b-fff9d0d752ed','627fdd61-537c-4569-9561-86bd8b7debb8','f023f642-bbd6-4350-a6d7-fcbd77322e82','94d4ac4a-92f0-4f70-96ec-5385d3301c02',1,15,0,0,0,0,0,NULL,'2016-11-08 09:32:26.069000','2016-11-08 09:33:01.669000'),
  ('95d99f60-7692-45fd-a321-37bf93fff142','bd56548c-d310-4919-84a7-f5a899c6002d','4b411e49-2496-436b-b9cc-dd50dd79b021','11691ae8-30d7-45d6-b85c-4fac69e398cf',2,12,NULL,NULL,NULL,NULL,0,NULL,'2016-11-08 09:15:35.818000','2016-11-08 09:16:47.381000'),
  ('9eb8e696-0b75-4388-bf68-74c165a62870','01db4691-c6c5-4756-bfd5-986b3f2d71c5','e962d14b-b269-42fb-b5af-c727b16678bd','e90c7f38-4e75-466a-a60f-488fa9b897c8',2,15,0,0,0,0,0,NULL,'2016-11-08 09:32:26.427000','2016-11-08 09:33:02.107000'),
  ('a19ff3d6-3824-4b49-b987-50790d0849c2','a6442f34-988d-4276-a301-5e44ca122ba7','dbe60c2b-e495-4363-9cce-7a83348800ee','147c6a1f-5647-4ad0-ae2a-7ebf4e3e8292',4,13,0,0,0,0,0,NULL,'2016-11-08 09:54:07.468000','2016-11-08 09:54:07.807000'),
  ('a465942f-6fe4-4740-88be-5b6f2ae2442a','22e89fb1-ab57-4ee0-acc7-5564512bbb3c','a7bc0cc5-95bb-46f5-9ebf-725f3d874082','a7375bff-22d8-4ce3-ad0b-335cb6a19a81',1,13,NULL,NULL,NULL,NULL,0,NULL,'2016-11-08 09:08:42.262000','2016-11-08 09:09:03.577000'),
  ('adb786df-1b2a-4334-8146-5e717e3350a7','183ceef3-e063-4490-bcfb-42a05dd06497','c230a549-399a-4c93-adf9-91a2a3a06e1b','94d4ac4a-92f0-4f70-96ec-5385d3301c02',2,14,0,0,0,0,0,NULL,'2016-11-08 09:32:26.070000','2016-11-08 09:33:01.670000'),
  ('ae9ea3d2-2df5-47f0-8882-e1142511409d','41df7513-e32f-4a3e-ad0e-c7fb29ad72d4','e7ae783c-a771-439d-b2ca-d25f305478d5','e90c7f38-4e75-466a-a60f-488fa9b897c8',1,14,0,0,0,0,0,NULL,'2016-11-08 09:32:26.426000','2016-11-08 09:33:02.108000'),
  ('bbb3c4d7-f0b3-47a6-9df0-5684aa6006c1','0962c6ea-c39b-4d64-b726-9f80c145fb00','25312c1e-f509-4740-baa2-adc910ce2473','3014a5b3-0cc7-46e9-8817-9175f7b0ece1',1,10,0,0,0,0,0,NULL,'2016-11-08 10:26:13.333000','2016-11-08 10:32:52.119000'),
  ('c3c2a9f0-0dd6-4a84-bf4b-1d83512ce320','9291f339-19c7-4f50-bca8-6fef9a2d149f','02249237-5121-4a89-b95c-2ccdec19114b','25e91add-1d58-46b1-a07a-55178c9315cc',1,10,NULL,NULL,NULL,NULL,0,NULL,'2016-11-08 09:54:07.601000','2016-11-08 09:54:07.916000'),
  ('c650405c-0bed-4dfd-995d-de20d5d6afbe','7ee3c811-9b0b-4a36-b938-a497d3f04176','e924c0b9-e952-4ea5-9886-a6212ec475c2','f68b57e6-8122-4b93-b6cc-a5f174bc1772',2,10,0,0,0,0,0,NULL,'2016-11-08 09:15:35.765000','2016-11-08 09:16:47.364000'),
  ('ca32b30c-3bff-422f-ac0a-e6993bec9aae','0f7ae894-a4da-4e4b-aba1-fb71b51799bd','89b9fbb7-4148-4b7b-b201-5c60100627f3','147c6a1f-5647-4ad0-ae2a-7ebf4e3e8292',2,15,0,0,0,0,0,NULL,'2016-11-08 09:54:07.469000','2016-11-08 09:54:07.807000'),
  ('d127982f-5cd0-49e2-b88d-aa59a0663877','ca24230a-486e-4dc6-8ca8-e31e5c0fce64','a7bc0cc5-95bb-46f5-9ebf-725f3d874082','c9b21230-d527-487a-a8b4-19b311b4fa4e',1,10,NULL,NULL,NULL,NULL,0,NULL,'2016-11-08 09:08:42.255000','2016-11-08 09:09:03.572000'),
  ('d18b861b-46a9-4868-b468-0884ff85d2f8','b2dc130e-6648-4115-b397-67c2664086e3','9cbe2d7c-da23-4df6-b6cf-927d3163b31a','3fb01df7-cf0d-4d54-b4f5-86004b617fca',1,10,0,0,0,0,0,NULL,'2016-11-08 09:15:35.838000','2016-11-08 09:16:47.389000'),
  ('db5ebbfb-7dff-45b4-8b12-e955933191c5','41a9fbc3-d186-42f0-81a4-0ede3308b782','180caf55-d387-443b-ba54-5fb030f725e2','ccf0063f-73fd-4b5b-94ff-d2e3eede68d3',1,12,NULL,NULL,NULL,NULL,0,NULL,'2016-11-08 09:08:42.286000','2016-11-08 09:09:03.595000'),
  ('e181a02e-74b3-42c4-919b-9283e5d7d122','4856214a-3035-44cd-a8d8-0fb586f268df','e924c0b9-e952-4ea5-9886-a6212ec475c2','ef91e51d-4ca8-4cd9-87b9-0340d53b9666',2,10,NULL,NULL,NULL,NULL,0,NULL,'2016-11-08 09:15:35.736000','2016-11-08 09:16:47.359000'),
  ('e4a73745-b59f-42ba-acb8-f75263006038','5444d074-ea83-4e3a-9e98-f5db922e0fa6','e924c0b9-e952-4ea5-9886-a6212ec475c2','70233ca6-3623-4a85-baec-98c2e504617a',2,12,NULL,NULL,NULL,NULL,0,NULL,'2016-11-08 09:15:35.747000','2016-11-08 09:16:47.362000'),
  ('e7cb69a5-5a62-423d-9a28-c102e1c454e7','e40a046a-fdcd-439f-a37a-14694a92720a','caaebab1-8d69-44cb-aead-7bdb48dd444f','ccf0063f-73fd-4b5b-94ff-d2e3eede68d3',2,12,NULL,NULL,NULL,NULL,0,NULL,'2016-11-08 09:08:42.287000','2016-11-08 09:09:03.596000'),
  ('ea0f349c-a56f-4593-a923-3bf1d9de6799','d3a0cd62-ff86-4dc7-a63d-db2bb0a34207','9cbe2d7c-da23-4df6-b6cf-927d3163b31a','11691ae8-30d7-45d6-b85c-4fac69e398cf',1,12,NULL,NULL,NULL,NULL,0,NULL,'2016-11-08 09:15:35.816000','2016-11-08 09:16:47.382000'),
  ('ef6e42dc-4c46-464a-9692-24f3a2ec4d80','cdcefc1c-da9d-4f85-aba0-1f56fd3c701d','e091b797-de64-43ad-ab3b-7ed6a1122351','ed454ab4-59bc-44f2-9db1-79385a3271cf',1,12,0,0,0,0,0,NULL,'2016-11-08 10:26:13.234000','2016-11-08 10:32:52.138000'),
  ('f2c1d34a-4bc0-462a-9f80-337f1501ac6b','e6e5a5fe-9e97-4951-ac71-cf9f28b3d43c','5ab242ec-8c7f-44d5-903c-0df019861685','3014a5b3-0cc7-46e9-8817-9175f7b0ece1',2,10,0,0,0,0,0,NULL,'2016-11-08 10:26:13.338000','2016-11-08 10:32:52.120000'),
  ('f46ff3d5-8c03-4d97-bbe9-accc036fcdba','02c344ad-31b4-4151-9d26-0dc9481b07e4','8977c23d-d3de-46b0-99b4-4813b4e4bee6','0850accf-f810-4ef6-b8c2-3d32dc0680ae',1,22,0,0,0,0,0,NULL,'2016-11-08 09:15:35.772000','2016-11-08 09:16:47.367000'),
  ('ff1fa15b-33d9-4273-8f1b-f7a14513d92f','be45f046-70b7-4196-af70-52c65218936a','5f2452f1-b034-43f9-bed8-39ab50e39192','fbdf7407-6465-44f8-aca5-489bd7f6f53f',3,10,NULL,NULL,NULL,NULL,0,NULL,'2016-11-08 09:32:26.063000','2016-11-08 09:33:01.666000');

  INSERT INTO `grupos_semaforicos_planos` (`id`, `id_json`, `grupo_semaforico_id`, `plano_id`, `ativado`, `data_criacao`, `data_atualizacao`)
VALUES
  ('03ee6954-f8ac-4abc-b90c-7cfb78b7360a','499337e8-1bb4-442d-b10a-ed61d846ffa8','3c8ce4de-70a1-44e8-9273-c07f705f130e','25e91add-1d58-46b1-a07a-55178c9315cc',1,'2016-11-08 09:54:07.604000','2016-11-08 09:54:07.918000'),
  ('04351849-b1f3-4b3c-b84d-418e9c135352','b7a53e15-4ded-4130-9b2f-eae97167a9cf','53b67934-ce51-4dd7-b4c6-e1abedcd4abb','70233ca6-3623-4a85-baec-98c2e504617a',1,'2016-11-08 09:15:35.763000','2016-11-08 09:16:47.362000'),
  ('044c1398-636e-4359-9c20-8d68061fb9eb','ae9c14ea-f0fb-4804-9ef0-2313058fa373','b920567a-32ac-4233-81ec-858563409d9b','4ad0906e-9e0d-4ea2-8584-7664d01799cc',1,'2016-11-08 09:15:35.836000','2016-11-08 09:16:47.387000'),
  ('089716a1-bed2-4ea3-8bc3-e426f466362f','fa6db7bd-7b31-43a1-9459-164d8b07f375','b920567a-32ac-4233-81ec-858563409d9b','bd19def4-a247-48e7-abdb-4202665c05fa',1,'2016-11-08 09:15:35.828000','2016-11-08 09:16:47.385000'),
  ('14f3bf90-0170-4369-96d2-9e8974e69108','de509abf-5ea2-4afb-b09c-e56a903974ea','53b67934-ce51-4dd7-b4c6-e1abedcd4abb','0850accf-f810-4ef6-b8c2-3d32dc0680ae',1,'2016-11-08 09:15:35.777000','2016-11-08 09:16:47.367000'),
  ('26629fbb-4d0d-4705-b58d-782203dd8c65','f7423f74-7f13-4db0-8e49-5bd5708f20b1','e9f671a5-950c-4fc5-9cc7-45acbd53227f','c9b21230-d527-487a-a8b4-19b311b4fa4e',1,'2016-11-08 09:08:42.259000','2016-11-08 09:09:03.573000'),
  ('2c454516-e59e-48e3-aa2e-82bb3b3e8563','33f9e321-b733-4080-bcbf-eff9c95f449d','4829f07e-2807-4054-b8e7-ddb2bcdcbcfa','3fb01df7-cf0d-4d54-b4f5-86004b617fca',1,'2016-11-08 09:15:35.839000','2016-11-08 09:16:47.389000'),
  ('2ea9a4e6-f319-494e-8de5-d235cd11d60e','700055fb-7613-4f41-b9b9-3b3b0828262b','155bd3c9-2fc8-4cca-9748-d6580f160dc2','e90c7f38-4e75-466a-a60f-488fa9b897c8',1,'2016-11-08 09:32:26.429000','2016-11-08 09:33:02.109000'),
  ('31cb867d-7396-4ecf-bed5-780952a8f0fb','80068c31-0885-44c8-8768-4b3d8808ea48','4829f07e-2807-4054-b8e7-ddb2bcdcbcfa','11691ae8-30d7-45d6-b85c-4fac69e398cf',1,'2016-11-08 09:15:35.820000','2016-11-08 09:16:47.382000'),
  ('33c1ab2d-9419-4c00-8e74-d60f0400c053','50640a14-8a25-451a-8651-f517f7b1938b','7081b5d1-c597-4ba0-a232-453a6b1fc8e9','94d4ac4a-92f0-4f70-96ec-5385d3301c02',1,'2016-11-08 09:32:26.074000','2016-11-08 09:33:01.670000'),
  ('401292c8-789c-4e7c-9969-0c204a0885b6','14110bea-e93e-40b0-93c3-c13b52ec4ace','682c4d0e-626a-4c3d-8ce3-b6421ea2341a','e90c7f38-4e75-466a-a60f-488fa9b897c8',1,'2016-11-08 09:32:26.430000','2016-11-08 09:33:02.111000'),
  ('4089c70f-ef59-48a9-bef8-8967255ae882','dd6fd0b3-cb98-425a-a1a6-52fa66330414','4bb4af54-cf60-4bf8-81f5-37ec0c82b5f3','147c6a1f-5647-4ad0-ae2a-7ebf4e3e8292',1,'2016-11-08 09:54:07.472000','2016-11-08 09:54:07.810000'),
  ('462485dd-a36d-4bcd-9f6f-fe1d69c5f149','1b1eb831-e7ee-425f-a491-af9249c5699e','b920567a-32ac-4233-81ec-858563409d9b','3fb01df7-cf0d-4d54-b4f5-86004b617fca',1,'2016-11-08 09:15:35.840000','2016-11-08 09:16:47.390000'),
  ('53e5c255-8b89-4cce-a013-cd3faba0046a','84e12204-9d63-4e0f-99a4-af6f06931549','e52ff58d-a44b-4c1d-aa5a-7d90a68d0816','e90c7f38-4e75-466a-a60f-488fa9b897c8',1,'2016-11-08 09:32:26.431000','2016-11-08 09:33:02.112000'),
  ('58e93f3d-758c-49fc-83fb-745368bb0b28','bc779953-b45b-4a26-b289-c902c6796f0c','c5dc4dbe-2d49-4e1d-b6c0-449b13e16240','147c6a1f-5647-4ad0-ae2a-7ebf4e3e8292',1,'2016-11-08 09:54:07.471000','2016-11-08 09:54:07.809000'),
  ('5fd7c752-a6b5-42a9-b22b-ede567460577','f79c61c3-5f1a-49c6-8bd5-35c36404b47e','d301c7f5-6b95-4eac-b4f1-fcb314cb5b9a','a7375bff-22d8-4ce3-ad0b-335cb6a19a81',1,'2016-11-08 09:08:42.265000','2016-11-08 09:09:03.578000'),
  ('61c056df-e5cc-43ac-ab16-89e314a45a2a','f1b2e2cf-d893-423f-95b1-3da693e8786d','12cb4ead-c499-479b-99f1-810b47f4ae83','94d4ac4a-92f0-4f70-96ec-5385d3301c02',1,'2016-11-08 09:32:26.072000','2016-11-08 09:33:01.671000'),
  ('6819bef4-cc8f-40dd-bacf-bcf2a0657b3e','a8f79a0d-c180-495f-a153-07f31a80623f','462dd6ae-acf9-4a1b-b266-b6a29b47c1fa','3014a5b3-0cc7-46e9-8817-9175f7b0ece1',1,'2016-11-08 10:26:13.339000','2016-11-08 10:32:52.120000'),
  ('68cafe10-3b70-4d36-ba49-402b82079f89','72b69c86-8901-4a5e-b6be-e2aff10e9efc','5d777b9c-5c6b-4de3-b4d1-a8ccbe92e88a','1d5e7d25-42a9-45aa-bb1b-6ae66969960d',1,'2016-11-08 09:54:07.596000','2016-11-08 09:54:07.914000'),
  ('697073d1-3797-4f8d-8434-3f3b54e6c318','29e64098-39cd-4a9a-9098-432f86a37ac4','bf6524f8-9a7e-4be8-8e35-4fd4f909d1c4','ed454ab4-59bc-44f2-9db1-79385a3271cf',1,'2016-11-08 10:26:13.236000','2016-11-08 10:32:52.139000'),
  ('697e00a2-e532-44ee-92b7-c8ac3bdb59cf','bb055375-33da-4868-be2f-b22af5ffb336','efd9bc6e-d318-4654-994c-3aafff5e3b66','e90c7f38-4e75-466a-a60f-488fa9b897c8',1,'2016-11-08 09:32:26.432000','2016-11-08 09:33:02.112000'),
  ('6a69f51d-6f1d-4373-adc1-65ced14cf092','a09d7043-bd01-4959-a6fb-15c2b2eadf62','d268b155-7b77-4dd0-af4a-d23376a8a15c','ccf0063f-73fd-4b5b-94ff-d2e3eede68d3',1,'2016-11-08 09:08:42.288000','2016-11-08 09:09:03.597000'),
  ('6c7bc8f9-6c97-4c40-ae82-e03a2ae51aa2','c1c9eaed-541c-4f4d-b8a3-05bf8b1deb98','b9b212ff-5b33-4f55-a67a-45955d13a66f','5a6591a5-a88c-4d5d-b5b4-fe6f6908e189',1,'2016-11-08 10:26:13.332000','2016-11-08 10:32:52.122000'),
  ('6ee66909-b3f4-4887-97db-1d8494bf9f3a','8ffbdebd-7e28-4432-bac9-b45e1f4ffcf5','4d592444-7995-4146-a9a3-e491e5d695a6','25e91add-1d58-46b1-a07a-55178c9315cc',1,'2016-11-08 09:54:07.603000','2016-11-08 09:54:07.917000'),
  ('70c99dfc-69af-42dc-870e-1d0cee24a34d','0c0d2f82-da5d-4c39-8f0b-3e00d8f02f96','b920567a-32ac-4233-81ec-858563409d9b','11691ae8-30d7-45d6-b85c-4fac69e398cf',1,'2016-11-08 09:15:35.822000','2016-11-08 09:16:47.383000'),
  ('76d590ec-1193-4741-ba7f-d47506100dfe','168ae5c9-dbb0-4263-aef1-eb47b507b51f','77347d0d-1425-4c98-9aa3-2a3678ececd4','147c6a1f-5647-4ad0-ae2a-7ebf4e3e8292',1,'2016-11-08 09:54:07.470000','2016-11-08 09:54:07.809000'),
  ('7c4e2280-cb90-4801-83be-ae145ffa5ed2','923c1a14-1741-4989-907c-e1dceed8ae79','438bea60-53f6-4a0c-ab26-d2c9ca061b23','94d4ac4a-92f0-4f70-96ec-5385d3301c02',1,'2016-11-08 09:32:26.073000','2016-11-08 09:33:01.671000'),
  ('7e1985a4-753e-4522-8bf6-218de55b4c2d','9366edf2-b916-4094-97a2-78531f7a8fa9','4c0b8351-28d6-4445-824a-48b6dece50e8','0850accf-f810-4ef6-b8c2-3d32dc0680ae',1,'2016-11-08 09:15:35.776000','2016-11-08 09:16:47.367000'),
  ('83aaea9d-ff4f-4819-aed5-b9e6e19da1e6','b80a0e88-65c8-4694-bc0a-8fa0f84f10d4','4c0b8351-28d6-4445-824a-48b6dece50e8','3f5a5ac9-6eab-42f5-af55-a3f3e03a3913',1,'2016-11-08 09:15:35.780000','2016-11-08 09:16:47.369000'),
  ('8765036e-87ce-4ecd-88e7-307ce25b59c7','2ddda19a-65eb-4af0-8fe1-1b90840544be','73487232-6688-40a8-a068-86a7cffe6b69','e90c7f38-4e75-466a-a60f-488fa9b897c8',1,'2016-11-08 09:32:26.430000','2016-11-08 09:33:02.113000'),
  ('899dff7b-dee4-4c67-87fa-b93501f7e49b','423a9bc2-e90d-4f3a-9d0e-d872cd9330d6','53b67934-ce51-4dd7-b4c6-e1abedcd4abb','3f5a5ac9-6eab-42f5-af55-a3f3e03a3913',1,'2016-11-08 09:15:35.781000','2016-11-08 09:16:47.370000'),
  ('8a0f9c3a-2a2d-44df-a849-558c14c242d5','f54b127a-85fa-4b59-86a5-8a90860b1bf2','5d777b9c-5c6b-4de3-b4d1-a8ccbe92e88a','25e91add-1d58-46b1-a07a-55178c9315cc',1,'2016-11-08 09:54:07.603000','2016-11-08 09:54:07.918000'),
  ('9aa44b05-e987-4f95-826e-6fc30e7e21a7','af1ff139-3e7e-4923-bc8b-0ead71bd62ac','53b67934-ce51-4dd7-b4c6-e1abedcd4abb','ef91e51d-4ca8-4cd9-87b9-0340d53b9666',1,'2016-11-08 09:15:35.737000','2016-11-08 09:16:47.360000'),
  ('9b226ba1-da82-4419-9d6b-59283b4ac58b','fc4c48ec-7c6d-4da1-a3bf-3721aa7ba8e3','1aeadd03-ec04-4bea-a4c7-641125dda206','147c6a1f-5647-4ad0-ae2a-7ebf4e3e8292',1,'2016-11-08 09:54:07.470000','2016-11-08 09:54:07.808000'),
  ('a3705c56-c274-4a0d-9b20-ed3a832660b9','6cfef349-c676-4426-b0f4-2f577a6a9644','438bea60-53f6-4a0c-ab26-d2c9ca061b23','fbdf7407-6465-44f8-aca5-489bd7f6f53f',1,'2016-11-08 09:32:26.067000','2016-11-08 09:33:01.666000'),
  ('a471dcb4-3909-4773-b0af-d996f8d2c200','72dd9d2c-b9bd-4de7-b633-d9f3d0001d63','72dab597-6715-40d6-abce-2724b5cff1f9','ed454ab4-59bc-44f2-9db1-79385a3271cf',1,'2016-11-08 10:26:13.235000','2016-11-08 10:32:52.139000'),
  ('a80b3342-c797-41b6-820d-b9fa79b84c53','d4e3abde-6907-4bae-ba55-15474422b093','bf6524f8-9a7e-4be8-8e35-4fd4f909d1c4','877b53b5-7649-4cb9-a9bc-9049fbddbc96',1,'2016-11-08 10:26:13.260000','2016-11-08 10:32:52.136000'),
  ('aaf7cbfe-744e-4962-bd51-90975e3f07a7','597b67ea-d949-41d7-966e-732667f64e33','4c0b8351-28d6-4445-824a-48b6dece50e8','f68b57e6-8122-4b93-b6cc-a5f174bc1772',1,'2016-11-08 09:15:35.767000','2016-11-08 09:16:47.365000'),
  ('b79b5f31-f8ba-4688-9b28-4abedab33f86','c1c1a7a2-7f73-4fec-91cd-358bcc01b405','717c6bc5-9098-464c-b19a-e2f0c7e6d40f','a7375bff-22d8-4ce3-ad0b-335cb6a19a81',1,'2016-11-08 09:08:42.264000','2016-11-08 09:09:03.578000'),
  ('bb5e6f43-96c5-454c-99bd-add3285a6dcd','ba235f7a-6a70-420e-b83d-73f81856fb10','53b67934-ce51-4dd7-b4c6-e1abedcd4abb','f68b57e6-8122-4b93-b6cc-a5f174bc1772',1,'2016-11-08 09:15:35.768000','2016-11-08 09:16:47.365000'),
  ('bbe40930-263a-4ddc-a84a-52bf3f552a8a','250900e1-f177-4712-beef-1fdb2624e77c','d301c7f5-6b95-4eac-b4f1-fcb314cb5b9a','c9b21230-d527-487a-a8b4-19b311b4fa4e',1,'2016-11-08 09:08:42.259000','2016-11-08 09:09:03.574000'),
  ('c2936dfd-f903-440c-a146-653ea8fba6fc','9c5d13ca-1310-4b57-bb8a-722bc963d396','3c8ce4de-70a1-44e8-9273-c07f705f130e','1d5e7d25-42a9-45aa-bb1b-6ae66969960d',1,'2016-11-08 09:54:07.597000','2016-11-08 09:54:07.914000'),
  ('c5f81dcb-cd33-403d-9738-69e6f69438f5','5f923420-f275-40e0-a68e-6278d4e967fc','4c0b8351-28d6-4445-824a-48b6dece50e8','ef91e51d-4ca8-4cd9-87b9-0340d53b9666',1,'2016-11-08 09:15:35.737000','2016-11-08 09:16:47.360000'),
  ('c67e6cc7-258c-40dc-829f-93cfe2f7581a','e7d4c1ee-bbc3-449f-9031-b9683a98a345','717c6bc5-9098-464c-b19a-e2f0c7e6d40f','c9b21230-d527-487a-a8b4-19b311b4fa4e',1,'2016-11-08 09:08:42.258000','2016-11-08 09:09:03.574000'),
  ('c9c0cd75-87d5-4783-abc8-2e86f87bdf90','38d58acc-3e6a-437c-966b-23a64f580690','4829f07e-2807-4054-b8e7-ddb2bcdcbcfa','4ad0906e-9e0d-4ea2-8584-7664d01799cc',1,'2016-11-08 09:15:35.835000','2016-11-08 09:16:47.387000'),
  ('d44b0c9d-e3d9-4340-b740-d6927a3e1be0','169ee0f9-1a0d-4e9e-9207-b48b40613f36','4829f07e-2807-4054-b8e7-ddb2bcdcbcfa','bd19def4-a247-48e7-abdb-4202665c05fa',1,'2016-11-08 09:15:35.827000','2016-11-08 09:16:47.385000'),
  ('d9a3b406-bf23-43fb-bbde-37844acf4d76','cc1a8452-e1a3-407e-9032-e1f3a1519b7d','da7e4e08-e87b-4734-9f36-6ab8ab3a5893','147c6a1f-5647-4ad0-ae2a-7ebf4e3e8292',1,'2016-11-08 09:54:07.472000','2016-11-08 09:54:07.809000'),
  ('dafc4300-4c54-43dc-b68d-9f44f4929acb','4fe7358b-35ff-46f2-9b27-f84d2ed8d4df','4d592444-7995-4146-a9a3-e491e5d695a6','1d5e7d25-42a9-45aa-bb1b-6ae66969960d',1,'2016-11-08 09:54:07.598000','2016-11-08 09:54:07.915000'),
  ('e2112fb8-7cd6-4873-814d-c0baa54daba3','93e84ebd-e487-4bbe-a1ca-8da977b68d6f','72dab597-6715-40d6-abce-2724b5cff1f9','877b53b5-7649-4cb9-a9bc-9049fbddbc96',1,'2016-11-08 10:26:13.250000','2016-11-08 10:32:52.137000'),
  ('eb0bfebd-fa87-45d7-b573-0ce86d22cf5b','285eed8c-1765-4c29-a7b5-d51ad2599147','7081b5d1-c597-4ba0-a232-453a6b1fc8e9','fbdf7407-6465-44f8-aca5-489bd7f6f53f',1,'2016-11-08 09:32:26.068000','2016-11-08 09:33:01.667000'),
  ('f2f7be8c-348b-4af4-bebf-ae90b3bf7510','b2a3d752-2802-490b-a5e6-f574e87da550','b9b212ff-5b33-4f55-a67a-45955d13a66f','3014a5b3-0cc7-46e9-8817-9175f7b0ece1',1,'2016-11-08 10:26:13.340000','2016-11-08 10:32:52.121000'),
  ('f320b8f5-7d70-4391-af79-e45e02942873','251bdbf1-afbb-4f57-94ad-aa59e1ccba1a','12cb4ead-c499-479b-99f1-810b47f4ae83','fbdf7407-6465-44f8-aca5-489bd7f6f53f',1,'2016-11-08 09:32:26.066000','2016-11-08 09:33:01.668000'),
  ('f7e52a0d-7b8a-4627-925d-2dbdc34d8214','1427bf66-7fc9-4818-b804-8295e7dbe9e1','462dd6ae-acf9-4a1b-b266-b6a29b47c1fa','5a6591a5-a88c-4d5d-b5b4-fe6f6908e189',1,'2016-11-08 10:26:13.331000','2016-11-08 10:32:52.123000'),
  ('f833d4b1-ae40-4b02-bb39-cd58421e382f','4db82993-0f1e-42a3-a8a1-a7ecbbb473c6','4c0b8351-28d6-4445-824a-48b6dece50e8','70233ca6-3623-4a85-baec-98c2e504617a',1,'2016-11-08 09:15:35.761000','2016-11-08 09:16:47.363000'),
  ('fd911c7b-6a63-47a5-a8c1-5b94b7422e0c','d7ba43f4-def8-41ab-bfb8-30dd50f1d450','e307d4fc-95ff-45ce-a23d-baae9427599b','ccf0063f-73fd-4b5b-94ff-d2e3eede68d3',1,'2016-11-08 09:08:42.289000','2016-11-08 09:09:03.597000'),
  ('ff652e66-a898-4882-b6aa-9eec68a476f6','087c07bc-69b8-450c-ad1d-2fee3ad106bb','e9f671a5-950c-4fc5-9cc7-45acbd53227f','a7375bff-22d8-4ce3-ad0b-335cb6a19a81',1,'2016-11-08 09:08:42.266000','2016-11-08 09:09:03.579000');


--------------------------------------- TABELA HORARIAS ------------------------------------------


INSERT INTO `versoes_tabelas_horarias` (`id`, `id_json`, `controlador_id`, `tabela_horaria_origem_id`, `usuario_id`, `descricao`, `status_versao`, `data_criacao`, `data_atualizacao`)
VALUES
  ('06e58963-0e85-46f6-8a16-2703a543d573','522ce223-637d-4556-a1f0-9e2627dfeb0b','0f424143-383e-490d-96ef-145fed18bb29',NULL,NULL,NULL,'ARQUIVADO',NOW(), NOW()),
  ('125f19f1-a544-4019-b62a-4160f3db3f81','15e331ba-3a7d-4f67-b7ab-df02393f847f','279d3e6e-b3ab-4e9f-8358-67e393e5ed0f',NULL,NULL,NULL,'CONFIGURADO',NOW(), NOW()),
  ('38ad2b48-85cc-48bf-bc30-6ec6e5976551','3f520e9d-2651-4a6a-ba0e-f1ca0618605a','5d238555-8620-4841-a2bf-c77d497f6b03',NULL,NULL,NULL,'CONFIGURADO',NOW(), NOW()),
  ('69abb281-91e3-4073-9ba2-1a59817e5f74','1d274495-e924-4e9f-9a8e-9c59181a5d9c','1dccd9b1-8837-43d0-8f5b-bb4b169fdc9d',NULL,@UsuarioId,'Tabela Horaria criado pelo usuário:Mobilab','EDITANDO',NOW(), NOW()),
  ('f4c67a91-013c-49fa-9e87-44398ac56403','d8d9e1f1-75fb-46ff-bc06-df1ffbb611b9','3d86335e-05e7-4921-8cdf-42ed03821f62',NULL,NULL,NULL,'CONFIGURADO',NOW(), NOW());

INSERT INTO `tabela_horarios` (`id`, `id_json`, `versao_tabela_horaria_id`, `data_criacao`, `data_atualizacao`)
VALUES
  ('2bbb53ba-c4e2-44b6-843a-f64f9e8c1832','2924fdc4-4643-4437-902a-2f5d6c8a6d61','125f19f1-a544-4019-b62a-4160f3db3f81','2016-11-08 09:16:47.393000','2016-11-08 09:16:47.393000'),
  ('419ca4ea-b018-4d7d-85b1-f01e50e89151','c1e796f9-2245-403c-9857-47dda0fab3eb','06e58963-0e85-46f6-8a16-2703a543d573','2016-11-08 09:33:02.116000','2016-11-08 09:33:02.116000'),
  ('4dab5371-854b-4e06-9c4d-f1095392b715','29642726-2a42-413f-9313-3aad22a11825','38ad2b48-85cc-48bf-bc30-6ec6e5976551','2016-11-08 09:09:03.601000','2016-11-08 09:09:03.601000'),
  ('a9cdfa75-e94b-4c8a-b86e-8e33bcce126a','432b9492-52ee-431a-9a6f-9c86a9d04db9','f4c67a91-013c-49fa-9e87-44398ac56403','2016-11-08 10:32:14.028000','2016-11-08 10:32:52.142000'),
  ('fb59acb2-e62f-4ca2-bbe1-63dab2801ece','3c9763da-bb00-4295-840d-8562855fb1a9','69abb281-91e3-4073-9ba2-1a59817e5f74','2016-11-08 09:54:07.920000','2016-11-08 09:54:07.920000');

INSERT INTO  `agrupamentos` (`id`, `id_json`, `nome`, `numero`, `descricao`, `tipo`, `posicao_plano`, `dia_da_semana`, `horario`, `data_criacao`, `data_atualizacao`)
VALUES
  ('6da8d307-f1dd-4a5a-b2d6-11b66272a40b', RANDOM_UUID(), 'Corredor da Paulista', NULL, 'Agrupamento perto da paulista', 'CORREDOR', 1, 'DOMINGO', '01:00:00', NOW(), NOW());

INSERT INTO `agrupamentos_aneis` (`agrupamento_id`, `anel_id`)
VALUES
  ('6da8d307-f1dd-4a5a-b2d6-11b66272a40b', '9ce82983-8de5-439e-863a-88086fb8b705'),
  ('6da8d307-f1dd-4a5a-b2d6-11b66272a40b', '043007e5-ee02-4383-bde1-87346abdc895'),
  ('6da8d307-f1dd-4a5a-b2d6-11b66272a40b', '6c709913-6812-41d9-94a6-e36ee55e3b9c'),
  ('6da8d307-f1dd-4a5a-b2d6-11b66272a40b', '70d364b0-6f7c-4f04-96e8-853a49ccd7f2');

INSERT INTO `eventos` (`id`, `id_json`, `posicao`, `dia_da_semana`, `horario`, `data`, `nome`, `posicao_plano`, `tipo`, `tabela_horario_id`, `agrupamento_id`, `data_criacao`, `data_atualizacao`)
VALUES
  ('03ce86ec-0414-454e-a66c-5339132926f0','bfc24ca8-770f-42c0-b29c-9e62dad5f9e8',2,'SEXTA','03:01:00','2016-11-08 00:00:00.000000',NULL,3,'NORMAL','2bbb53ba-c4e2-44b6-843a-f64f9e8c1832',NULL,'2016-11-08 09:16:47.548000','2016-11-08 09:16:47.548000'),
  ('1a4799a3-e836-4039-b59d-4d2c9cd6304d','eed24efd-79da-409f-bbae-54d3d09192f2',1,'DOMINGO','08:00:00','2016-11-08 00:00:00.000000',NULL,1,'NORMAL','419ca4ea-b018-4d7d-85b1-f01e50e89151',NULL,'2016-11-08 09:33:02.117000','2016-11-08 09:33:02.117000'),
  ('4957fa35-e349-4291-a72f-4df16df4dd44','f8ad0f38-284e-4b1d-9bbd-b15145b1d6a0',2,'SABADO','10:00:00','2016-11-08 00:00:00.000000',NULL,1,'NORMAL','fb59acb2-e62f-4ca2-bbe1-63dab2801ece',NULL,'2016-11-08 09:54:07.979000','2016-11-08 09:54:07.979000'),
  ('52b3886d-1a17-44c9-bb3e-0ad4c8a1d530','7cc04f56-d689-42f8-8d06-5342b9cf4bf6',1,'DOMINGO','08:00:00','2016-11-08 00:00:00.000000',NULL,1,'NORMAL','fb59acb2-e62f-4ca2-bbe1-63dab2801ece',NULL,'2016-11-08 09:54:07.978000','2016-11-08 09:54:07.978000'),
  ('544c8768-a64e-4eaa-a9fb-e1b0013eaefc','b6b50997-564a-4ac6-97d1-42568c2f46b9',3,'SEXTA','19:10:00','2016-11-08 00:00:00.000000',NULL,1,'NORMAL','fb59acb2-e62f-4ca2-bbe1-63dab2801ece',NULL,'2016-11-08 09:54:07.978000','2016-11-08 09:54:07.978000'),
  ('587d8ee8-8a5f-41bd-840b-6eb8ad412fba','6b31f2ca-d604-4356-ba8a-21a57bca35dd',2,'SEGUNDA','10:00:00','2016-11-08 00:00:00.000000',NULL,1,'NORMAL','4dab5371-854b-4e06-9c4d-f1095392b715',NULL,'2016-11-08 09:09:03.778000','2016-11-08 09:09:03.778000'),
  ('686df7f2-0bd8-4631-bdaa-9956625fc981','8a7f3cbe-c536-40f7-bbff-bc0006199053',1,'DOMINGO','00:00:00','2016-11-08 00:00:00.000000',NULL,1,'NORMAL','4dab5371-854b-4e06-9c4d-f1095392b715',NULL,'2016-11-08 09:09:03.602000','2016-11-08 09:09:03.602000'),
  ('6c6efddc-adf0-4882-849e-8887c14035b7','b4c0ed33-ce1f-4e58-a0a5-e219eaf32978',1,NULL,'00:00:00','2016-11-08 00:00:00.000000','PLANO DE FERIADO',4,'ESPECIAL_RECORRENTE','2bbb53ba-c4e2-44b6-843a-f64f9e8c1832',NULL,'2016-11-08 09:16:47.545000','2016-11-08 09:16:47.545000'),
  ('7b5b25c9-7dc3-4945-9f9b-7bbe262c71c0','eea6a3fc-a0b8-4964-8192-edfeb0afba59',3,'TERCA','00:00:00','2016-11-08 00:00:00.000000',NULL,2,'NORMAL','a9cdfa75-e94b-4c8a-b86e-8e33bcce126a',NULL,'2016-11-08 10:32:14.030000','2016-11-08 10:32:52.143000'),
  ('91a735c6-d8ea-4578-b4b3-9abbabdf4589','70ca6a18-b0fe-4657-899d-09c365eb636e',3,'SEXTA','12:01:00','2016-11-08 00:00:00.000000',NULL,2,'NORMAL','2bbb53ba-c4e2-44b6-843a-f64f9e8c1832',NULL,'2016-11-08 09:16:47.576000','2016-11-08 09:16:47.576000'),
  ('af561887-6295-495a-bdb0-cae7711afb87','a644f01f-a246-426e-8c64-d4b51c55a0ec',4,'SEGUNDA_A_SEXTA','01:00:00','2016-11-08 00:00:00.000000',NULL,4,'NORMAL','2bbb53ba-c4e2-44b6-843a-f64f9e8c1832',NULL,'2016-11-08 09:16:47.577000','2016-11-08 09:16:47.577000'),
  ('cef34e7b-a92d-4145-afdc-4fbda8b01408','7428cff9-fcdf-419f-88ef-aefd76296ca6',3,'SEXTA','19:10:00','2016-11-08 00:00:00.000000',NULL,1,'NORMAL','419ca4ea-b018-4d7d-85b1-f01e50e89151',NULL,'2016-11-08 09:33:02.118000','2016-11-08 09:33:02.118000'),
  ('d8fa7625-3b25-4cca-abda-9a40b050962e','1e7d0d43-1241-458f-b6c3-a56f30fb52dc',1,'SEXTA','14:01:00','2016-11-08 00:00:00.000000',NULL,1,'NORMAL','a9cdfa75-e94b-4c8a-b86e-8e33bcce126a',NULL,'2016-11-08 10:32:14.029000','2016-11-08 10:32:52.143000'),
  ('e7842b29-874e-433c-8611-de4d5c1dd90d','21a9e808-0734-4675-ae89-ce2e35acb83f',2,'SEGUNDA_A_SABADO','22:00:00','2016-11-08 00:00:00.000000',NULL,1,'NORMAL','a9cdfa75-e94b-4c8a-b86e-8e33bcce126a',NULL,'2016-11-08 10:32:14.030000','2016-11-08 10:32:52.144000'),
  ('fba76da9-d87d-4ad3-a094-fa44d50a7e7b','724bd0f6-122a-44f2-8bc3-d100a972f0dd',2,'SABADO','10:00:00','2016-11-08 00:00:00.000000',NULL,1,'NORMAL','419ca4ea-b018-4d7d-85b1-f01e50e89151',NULL,'2016-11-08 09:33:02.117000','2016-11-08 09:33:02.117000'),
  ('fc726a26-15a9-4229-b5d6-cf504acf5678','5c1b5e76-9028-4d1e-ad9f-2c0978afd78b',1,'DOMINGO','07:00:00','2016-11-08 00:00:00.000000',NULL,1,'NORMAL','2bbb53ba-c4e2-44b6-843a-f64f9e8c1832',NULL,'2016-11-08 09:16:47.394000','2016-11-08 09:16:47.394000'),
  ('feded080-479f-4284-a734-4c70ddf02396', '989ec2c5-1f88-49bb-82a6-1ce75e81bc27', 4, 'DOMINGO', TIME '01:00:00', NULL, NULL, 1, 'NORMAL', 'a9cdfa75-e94b-4c8a-b86e-8e33bcce126a', '6da8d307-f1dd-4a5a-b2d6-11b66272a40b', TIMESTAMP '2016-11-08 17:52:29.98', TIMESTAMP '2016-11-08 17:52:29.98'),
  ('a0b251ec-114e-41f0-b9c9-1bbee7a0f282', '8138906d-7205-4991-a422-291001d4c295', 5, 'DOMINGO', TIME '01:00:00', NULL, NULL, 1, 'NORMAL', '2bbb53ba-c4e2-44b6-843a-f64f9e8c1832', '6da8d307-f1dd-4a5a-b2d6-11b66272a40b', TIMESTAMP '2016-11-08 17:52:29.981', TIMESTAMP '2016-11-08 17:52:29.981'),
  ('81254d20-ba1e-4fcd-bbb5-560c38b23e4b', '97c34b47-1afc-45a9-94b3-3cde255d0798', 5, 'DOMINGO', TIME '01:00:00', NULL, NULL, 1, 'NORMAL', 'a9cdfa75-e94b-4c8a-b86e-8e33bcce126a', '6da8d307-f1dd-4a5a-b2d6-11b66272a40b', TIMESTAMP '2016-11-08 17:52:29.981', TIMESTAMP '2016-11-08 17:52:29.981'),
  ('c96cb340-1463-49b0-bf56-d5398d63b4c1', 'cef0e30f-d03f-4690-a2ad-942cbc2ab8fe', 6, 'DOMINGO', TIME '01:00:00', NULL, NULL, 1, 'NORMAL', '2bbb53ba-c4e2-44b6-843a-f64f9e8c1832', '6da8d307-f1dd-4a5a-b2d6-11b66272a40b', TIMESTAMP '2016-11-08 17:52:29.982', TIMESTAMP '2016-11-08 17:52:29.982');

----- Setar versão editando
UPDATE versoes_tabelas_horarias SET tabela_horaria_origem_id='419ca4ea-b018-4d7d-85b1-f01e50e89151' WHERE id='69abb281-91e3-4073-9ba2-1a59817e5f74';
