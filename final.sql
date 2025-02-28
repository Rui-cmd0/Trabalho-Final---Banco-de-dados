/*
 *   Copyright (c) 2025 
 *   All rights reserved.
 */

CREATE TABLE usuario (
    id_usuario SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    telefone VARCHAR(20) 
);

CREATE TABLE instituicao (
    id_instituicao SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    telefone VARCHAR(20),
    descricao TEXT,
    cnpj VARCHAR(18) UNIQUE NOT NULL,
    categoria VARCHAR(50),
    cep VARCHAR(10) NOT NULL,
    estado CHAR(2) NOT NULL,
    cidade VARCHAR(50) NOT NULL,
    bairro VARCHAR(50),
    rua VARCHAR(100) NOT NULL,
    numero VARCHAR(10),
    complemento VARCHAR(100),
    id_usuario INT NOT NULL,  -- Referência ao usuário responsável pela instituição
    FOREIGN KEY (id_usuario) REFERENCES usuario(id_usuario)
);

CREATE TABLE doador (
    id_doador SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    telefone VARCHAR(20),
    email VARCHAR(100) UNIQUE NOT NULL,
    classificacao VARCHAR(50) 
);

CREATE TABLE campanha (
    id_campanha SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    data_inicio DATE NOT NULL,
    data_fim DATE NOT NULL,
    progresso DECIMAL(5,2), 
    meta DECIMAL(10,2),      
    id_instituicao INT NOT NULL,  
    FOREIGN KEY (id_instituicao) REFERENCES instituicao(id_instituicao) ON DELETE CASCADE 
);

CREATE TABLE doacao (
    id_doacao SERIAL PRIMARY KEY,
    valor NUMERIC(10, 2) NOT NULL,  
    data_doacao DATE NOT NULL,       
    id_doador INT NOT NULL,          
    id_instituicao INT,             
    id_campanha INT,                 
    FOREIGN KEY (id_doador) REFERENCES doador(id_doador),
    FOREIGN KEY (id_instituicao) REFERENCES instituicao(id_instituicao),
    FOREIGN KEY (id_campanha) REFERENCES campanha(id_campanha),
    CHECK (id_instituicao IS NOT NULL OR id_campanha IS NOT NULL)  -- Garante que a doação está associada a uma instituição ou campanha
);

CREATE TABLE pagamento (
	id_pagamento SERIAL PRIMARY KEY,
    metodo VARCHAR(50) NOT NULL,
    status VARCHAR(50) NOT NULL,
    id_doacao INT UNIQUE NOT NULL,
    id_doador INT NOT NULL,
    FOREIGN KEY (id_doacao) REFERENCES doacao(id_doacao) ON DELETE CASCADE,
    FOREIGN KEY (id_doador) REFERENCES doador(id_doador) ON DELETE CASCADE
);


INSERT INTO usuario (nome, email, telefone)
VALUES ('João Silva', 'joao.silva@example.com', '(11) 98765-4321'),
       ('Eduardo Rui', 'eduardo.rui@example.com', '(11) 91234-5678'),
       ('Fabio', 'fabio@example.com', '(21) 92345-6789'),
       ('Ruanne Sousa', 'ruanne.sousa@example.com', '(31) 93456-7890'),
       ('Ana Paula', 'ana.paula@example.com', '(41) 94567-8901'),
       ('Pedro Henrique', 'pedro.henrique@example.com', '(51) 95678-9012'),
       ('Juliana Costa', 'juliana.costa@example.com', '(61) 96789-0123'),
       ('Lucas Mendes', 'lucas.mendes@example.com', '(71) 97890-1234'),
       ('Fernanda Lima', 'fernanda.lima@example.com', '(81) 98901-2345'),
       ('Roberto Alves', 'roberto.alves@example.com', '(91) 99012-3456');


INSERT INTO instituicao (nome, telefone, descricao, cnpj, categoria, cep, estado, cidade, bairro, rua, numero, complemento, id_usuario)
VALUES
    ('Casa da Esperança', '(11) 1234-5678', 'Ajuda a comunidades carentes.', '12.345.678/0001-99', 'Assistência Social', '12345-678', 'SP', 'São Paulo', 'Centro', 'Rua das Flores', '123', 'Sala 101', 1),
    ('Educar para o Futuro', '(21) 2345-6789', 'Promove educação infantil.', '23.456.789/0001-88', 'Educação', '23456-789', 'RJ', 'Rio de Janeiro', 'Copacabana', 'Avenida Atlântica', '456', 'Bloco B', 2),
    ('Vida Plena para Idosos', '(31) 3456-7890', 'Oferece suporte a idosos.', '34.567.890/0001-77', 'Saúde', '34567-890', 'MG', 'Belo Horizonte', 'Savassi', 'Rua da Paz', '789', 'Andar 3', 3),
    ('Alimentando Vidas', '(41) 4567-8901', 'Combate a fome e desnutrição.', '45.678.901/0001-66', 'Alimentação', '45678-901', 'PR', 'Curitiba', 'Batel', 'Rua das Árvores', '101', 'Sala 202', 4),
    ('Incluir para Transformar', '(51) 5678-9012', 'Apoio a pessoas com deficiência.', '56.789.012/0001-55', 'Inclusão Social', '56789-012', 'RS', 'Porto Alegre', 'Moinhos de Vento', 'Rua da Esperança', '202', 'Andar 4', 5),
    ('Proteção Animal Brasil', '(61) 6789-0123', 'Proteção aos animais.', '67.890.123/0001-44', 'Proteção Animal', '67890-123', 'DF', 'Brasília', 'Asa Sul', 'Quadra 303', '303', 'Bloco C', 6),
    ('Cultura e Arte para Todos', '(71) 7890-1234', 'Promove cultura e arte.', '78.901.234/0001-33', 'Cultura', '78901-234', 'BA', 'Salvador', 'Barra', 'Avenida Oceânica', '404', 'Sala 303', 7),
    ('SOS Desastres Naturais', '(81) 8901-2345', 'Ajuda a vítimas de desastres.', '89.012.345/0001-22', 'Emergência', '89012-345', 'PE', 'Recife', 'Boa Viagem', 'Rua do Sol', '505', 'Andar 5', 8),
    ('Esporte e Cidadania', '(91) 9012-3456', 'Promove esportes para jovens.', '90.123.456/0001-11', 'Esporte', '90123-456', 'CE', 'Fortaleza', 'Meireles', 'Avenida Beira Mar', '606', 'Bloco D', 9),
    ('Mulheres Fortes', '(01) 0123-4567', 'Apoio a mulheres em situação de risco.', '01.234.567/0001-00', 'Direitos Humanos', '01234-567', 'AM', 'Manaus', 'Centro', 'Rua da Liberdade', '707', 'Sala 404', 10);





INSERT INTO doador (nome, telefone, email, classificacao) 
VALUES
    ('Carlos Souza', '(11) 98765-4321', 'carlos.souza@email.com', 'Ouro'),
    ('Mariana Lima', '(21) 97654-3210', 'mariana.lima@email.com', 'Prata'),
    ('Fernanda Alves', '(31) 96543-2109', 'fernanda.alves@email.com', 'Bronze'),
    ('Ricardo Mendes', '(41) 95432-1098', 'ricardo.mendes@email.com', 'Ouro'),
    ('João Pereira', '(51) 94321-0987', 'joao.pereira@email.com', 'Prata'),
    ('Ana Beatriz', '(61) 93210-9876', 'ana.beatriz@email.com', 'Bronze'),
    ('Gustavo Henrique', '(71) 92109-8765', 'gustavo.henrique@email.com', 'Ouro'),
    ('Larissa Gomes', '(81) 91098-7654', 'larissa.gomes@email.com', 'Prata'),
    ('Roberto Silva', '(91) 90987-6543', 'roberto.silva@email.com', 'Bronze'),
    ('Camila Fernandes', '(95) 89876-5432', 'camila.fernandes@email.com', 'Ouro');



INSERT INTO campanha (nome, data_inicio, data_fim, progresso, meta, id_instituicao)
VALUES

    ('Natal Solidário 2023', '2023-11-01', '2023-12-20', 45.50, 10000.00, 1),  -- Casa da Esperança
    ('Material Escolar 2024', '2024-01-15', '2024-02-28', 30.00, 15000.00, 2),  -- Educar para o Futuro
    ('Cuidando dos Idosos', '2023-10-01', '2023-12-31', 60.75, 20000.00, 3),    -- Vida Plena para Idosos
    ('Combate à Fome', '2023-09-01', '2023-11-30', 80.00, 25000.00, 4),        -- Alimentando Vidas
    ('Inclusão Social', '2023-08-01', '2023-10-31', 50.25, 12000.00, 5),       -- Incluir para Transformar
    ('Proteção Animal', '2023-07-01', '2023-09-30', 90.00, 18000.00, 6),       -- Proteção Animal Brasil
    ('Cultura para Todos', '2023-06-01', '2023-08-31', 40.00, 8000.00, 7),     -- Cultura e Arte para Todos
    ('SOS Desastres Naturais', '2023-05-01', '2023-07-31', 75.50, 22000.00, 8),-- SOS Desastres Naturais
    ('Esporte e Cidadania', '2023-04-01', '2023-06-30', 65.00, 15000.00, 9),   -- Esporte e Cidadania
    ('Apoio às Mulheres', '2023-03-01', '2023-05-31', 55.25, 10000.00, 10);    -- Mulheres Fortes

-- TABELA - DOACAO 

INSERT INTO doacao (valor, data_doacao, id_doador, id_instituicao)
VALUES
    (150.00, '2023-10-01', 1, 1),  -- Doação de R$ 150,00 para a instituição 1 (Casa da Esperança)
    (200.00, '2023-10-02', 2, 2),  -- Doação de R$ 200,00 para a instituição 2 (Educar para o Futuro)
    (100.00, '2023-10-03', 3, 3),  -- Doação de R$ 100,00 para a instituição 3 (Vida Plena para Idosos)
    (250.00, '2023-10-04', 4, 4),  -- Doação de R$ 250,00 para a instituição 4 (Alimentando Vidas)
    (300.00, '2023-10-05', 5, 5);  -- Doação de R$ 300,00 para a instituição 5 (Incluir para Transformar)

INSERT INTO doacao (valor, data_doacao, id_doador, id_campanha)
VALUES
    (50.00, '2023-10-06', 6, 1),   -- Doação de R$ 50,00 para a campanha 1 (Natal Solidário 2023)
    (75.00, '2023-10-07', 7, 2),    -- Doação de R$ 75,00 para a campanha 2 (Material Escolar 2024)
    (120.00, '2023-10-08', 8, 3),   -- Doação de R$ 120,00 para a campanha 3 (Cuidando dos Idosos)
    (180.00, '2023-10-09', 9, 4),   -- Doação de R$ 180,00 para a campanha 4 (Combate à Fome)
    (90.00, '2023-10-10', 10, 5);   -- Doação de R$ 90,00 para a campanha 5 (Inclusão Social)

INSERT INTO pagamento (metodo, status, id_doacao, id_doador)
VALUES
    ('Cartão de Crédito', 'Aprovado', 1, 1),
    ('Boleto', 'Pendente', 2, 2),
    ('PIX', 'Aprovado', 3, 3),
    ('Cartão de Débito', 'Recusado', 4, 4),
    ('Transferência Bancária', 'Aprovado', 5, 5),
    ('PIX', 'Aprovado', 6, 6),
    ('Cartão de Crédito', 'Pendente', 7, 7),
    ('Boleto', 'Aprovado', 8, 8),
    ('Transferência Bancária', 'Recusado', 9, 9),
    ('PIX', 'Aprovado', 10, 10);
