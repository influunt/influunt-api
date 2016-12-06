# Introdução
O protocolo de baixo nível especifica um protocolo serial para controladores que utilizem o 72c. Esse protocolo constitui em uma serie de mensagem binárias que são enviadas do 72c para o hardware ou do hardware para o 72c. Os mensagem são empacotados de forma padrão na estrutura chamada mensagem e são transmitidas em formato binário.

## Mensagem

| Campo| Tamanho| Descrição |
| ------------ | ------------- | ------------ |
| Tamanho      | 8 bits        | Tamanho em bytes da mensagem que esta sendo enviada|
|Tipo de Mensagem| 8 bits | Descreve o tipo de mensagem que esta sendo enviada conforme a tabela de tipo de mensagem|
|Sequencia | 16 bits | Número sequencia da mensagem. Deve ser incrementado a cada nova mensagem enviada |
|Mensagem | Variável | Conteúdo da mensagem a ser enviada | 
|Checksum | 8 bits   | Checksum de toda a mensagem utilizando o algorítmo LRC | 

### Mensagem de Início
O 72c envia a mensagem de íncio para o hardware para informar que está pronto para começar a envio de estágios.

| Campo| Tamanho| Descrição |
| ------------ | ------------- | ------------ |
| Anel G1 | 4 bits | Indica qual anel pertence o grupo semafórico G1|
| Anel G2 | 4 bits | Indica qual anel pertence o grupo semafórico G2|
| Anel G3 | 4 bits | Indica qual anel pertence o grupo semafórico G3|
| Anel G4 | 4 bits | Indica qual anel pertence o grupo semafórico G4|
| Anel G5 | 4 bits | Indica qual anel pertence o grupo semafórico G5|
| Anel G6 | 4 bits | Indica qual anel pertence o grupo semafórico G6|
| Anel G7 | 4 bits | Indica qual anel pertence o grupo semafórico G7|
| Anel G8 | 4 bits | Indica qual anel pertence o grupo semafórico G8|
| Anel G9 | 4 bits | Indica qual anel pertence o grupo semafórico G9|
| Anel G10 | 4 bits | Indica qual anel pertence o grupo semafórico G10|
| Anel G11 | 4 bits | Indica qual anel pertence o grupo semafórico G11|
| Anel G12 | 4 bits | Indica qual anel pertence o grupo semafórico G12|
| Anel G13 | 4 bits | Indica qual anel pertence o grupo semafórico G13|
| Anel G14 | 4 bits | Indica qual anel pertence o grupo semafórico G14|
| Anel G15 | 4 bits | Indica qual anel pertence o grupo semafórico G15|
| Anel G16 | 4 bits | Indica qual anel pertence o grupo semafórico G16|

###  Estágio
O 72c informa a configuração dos grupos semafóricos de um determinado anel. Essa configuração deve ser seguida pela hardware até que uma nova
configuração seja enviada.

| Campo| Tamanho| Descrição |
| ------------ | ------------- | ------------ |
| Flag 1| 1 bit | Reservado para uso futuro|
| Flag 2| 1 bit | Reservado para uso futuro|
| Flag 3| 1 bit | Reservado para uso futuro|
| Quantidade de Grupos Semafóricos| 5 bits | Quantidade de grupos semaforicos que fazem parte dessa configuração de estágio|
| Configuração do Grupo Semafórico| 9 bytes por grupo semafórico | Configuração dos tempos de cada grupo semafórico | 

### Grupo semafórico

Descreve como um grupo semafórico deve se comportar nesse estágio:

| Campo| Tamanho| Descrição |
| ------------ | ------------- | ------------ |
|Flag pedestre/veicular | 1 bit | Se verdadeiro esse é um grupo semafórico de pedestre|
|Flag composição dos tempos| 2 bits| Ver tabela de de flag composição dos tempos  |
|Grupo | 5 bits | Número do grupo semafórico|
|Tempo De Atraso de Grupo ou Entreverde | 16 bits| Tempo de atraso de grupo para perde do direito de passagem ou tempo de vermelho no periodo de entreverde para o grupo com ganho do direito passagem.|
|Tempo Amarelo| 16 bits| Tempo de amarelho para veícular ou vermelho intermitente para pedestre|
|Tempo Vermelho Limpeza| 16 bits| Tempo de vermelho limpeza|
|Tempo do Estágio | 16 bits| Verde para quem tem direito de passagem e vermelho para quem não tem.|

#### Flag de composição de tempo

| Valor| Descrição |
| -----|-----------|
|0     | O grupo semafórico estará desligado durante o tempo de estágio |
|1     | O grupo semafórico estará verde durante o tempo de estágio | 
|2     | O grupo semafórico estará vermelho durante o tempo de estágio |
|3     | O grupo semafórico estará em amarelo intermitente para veícular ou desligado para pedestre durante o tempo de estágio |


### Detector
O hardware informa ao 72c que um detector foi acionado.

| Campo| Tamanho| Descrição |
| ------------ | ------------- | ------------ |
| Flag 1| 1 bit | Reservado para uso futuro|
| Flag 2| 1 bit | Reservado para uso futuro|
| Flag 3| 1 bit | Verdadeiro se o detector for de pedestre|
| Posição| 5 bits | Posição do grupo semafórico|

### Falha Anel
O hardware informa ao 72c uma falha em um anel

| Campo| Tamanho| Descrição |
| ------------ | ------------- | ------------ |
| anel| 8 bits | Número do anel|
| Código da falha| 8 bits | Código da falha|

### Falha Anel
O hardware informa ao 72c uma falha em um grupo semafórico

| Campo| Tamanho| Descrição |
| ------------ | ------------- | ------------ |
| grupo | 8 bits | Número do grupo semafórico|
| Código da falha| 8 bits | Código da falha|


### Falha Genérica
O hardware informa ao 72c uma falha genérica

| Campo| Tamanho| Descrição |
| ------------ | ------------- | ------------ |
| Código da falha| 8 bits | Código da falha|

### Falha Detector
O hardware informa ao 72c uma falha genérica

| Campo| Tamanho| Descrição |
| ------------ | ------------- | ------------ |
| Flag 1| 1 bit | Reservado para uso futuro|
| Flag 2| 1 bit | Reservado para uso futuro|
| Flag 3| 1 bit | Verdadeiro se o detector for de pedestre|
| Posição| 5 bits | Posição do grupo detector|
| Código da Falha| 8 bits | Código da falha|

### Alarme
O hardware informa ao 72c um alarme

| Campo| Tamanho| Descrição |
| ------------ | ------------- | ------------ |
| Código do alarme| 8 bits | Código do alarme|

### Retorno
Mensagem de confirmação de recebimento

| Campo| Tamanho| Descrição |
| ------------ | ------------- | ------------ |
| Tipo de retorno| 8 bits | Tipo do retorno|


### Tabela de Tipos de Mensagem
|Codigo| Descrição|
|------|----------|
|0|	retorno |
|1|	inicio |
|2|	estagio |
|3|	detector |
|4|	falha anel |
|5|	falha detector |
|6|	falha grupo semaforico |
|7|	falha generica |
|8|	alarme |
|9|	Remocao de falha |
|10|	Inserção de plug |
|11|	remoção de plug |
|12|	troca de estágio modo manual |
|13|	modo manual ativado |
|14|	modo manual desativado |

### Tabela de Tipos de Retorno
|Codigo| Descrição|
|------|----------|
|0|	OK|
|1|	INVALID_CHECKSUM|
|2|	Tipo de Mensagem Invalido|

  