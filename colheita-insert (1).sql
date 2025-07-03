-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

DROP DATABASE IF EXISTS `mydb`;

CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
USE `mydb` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Estabelecimentos` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(45) NULL,
  `id_usuario` INT NULL,
  `Telefone` VARCHAR(45) NULL,
  `endereco` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


CREATE TABLE IF NOT EXISTS `mydb`.`Usuarios` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `Nome` VARCHAR(100) NOT NULL,
  `Email` VARCHAR(100) NOT NULL,
  `Senha` VARCHAR(200) NOT NULL,
  `Tipo` VARCHAR(45) NOT NULL,
  `Data_cadastro` DATETIME(6) NOT NULL,
  `Estabelecimentos_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `Email_UNIQUE` (`Email` ASC) VISIBLE,
  INDEX `fk_Usuarios_Estabelecimentos_idx` (`Estabelecimentos_id` ASC) VISIBLE,
  CONSTRAINT `fk_Usuarios_Estabelecimentos`
    FOREIGN KEY (`Estabelecimentos_id`)
    REFERENCES `mydb`.`Estabelecimentos` (`id`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE)
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `mydb`.`categorias` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(45) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `mydb`.`produtos` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(45) NOT NULL,
  `descricao` TEXT NOT NULL,
  `preco` DECIMAL(10,2) NOT NULL,
  `validade` DATE NOT NULL,
  `quantidade` INT NOT NULL,
  `imagem_url` VARCHAR(200) NOT NULL,
  `valor` DECIMAL(5,2) NOT NULL,
  `categorias_id` INT NOT NULL,
  `Estabelecimentos_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_produtos_categorias1_idx` (`categorias_id` ASC) VISIBLE,
  INDEX `fk_produtos_Estabelecimentos1_idx` (`Estabelecimentos_id` ASC) VISIBLE,
  CONSTRAINT `fk_produtos_categorias1`
    FOREIGN KEY (`categorias_id`)
    REFERENCES `mydb`.`categorias` (`id`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE,
  CONSTRAINT `fk_produtos_Estabelecimentos1`
    FOREIGN KEY (`Estabelecimentos_id`)
    REFERENCES `mydb`.`Estabelecimentos` (`id`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE)
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `mydb`.`enderecos` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `rua` VARCHAR(45) NOT NULL,
  `numero` VARCHAR(45) NOT NULL,
  `bairro` VARCHAR(45) NOT NULL,
  `cidade` VARCHAR(45) NOT NULL,
  `estado` VARCHAR(45) NOT NULL,
  `cep` VARCHAR(45) NOT NULL,
  `complemento` VARCHAR(45) NULL,
  `Usuarios_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_enderecos_Usuarios1_idx` (`Usuarios_id` ASC) VISIBLE,
  CONSTRAINT `fk_enderecos_Usuarios1`
    FOREIGN KEY (`Usuarios_id`)
    REFERENCES `mydb`.`Usuarios` (`id`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE)
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `mydb`.`pedidos` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `data_pedido` DATETIME NOT NULL,
  `status` VARCHAR(45) NOT NULL,
  `total` DECIMAL(10,2) NOT NULL,
  `pedido` VARCHAR(45) NOT NULL,
  `id_estabelecimento` INT NULL,
  `id_usuario` INT NOT NULL,
  `id_endereco` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `id_endereco_idx` (`id_endereco` ASC) VISIBLE,
  INDEX `id_pedidos_usuarios_idx` (`id_usuario` ASC) VISIBLE,
  INDEX `id_pedidos_estabelecimentos_idx` (`id_estabelecimento` ASC) VISIBLE,
  CONSTRAINT `id_endereco`
    FOREIGN KEY (`id_endereco`)
    REFERENCES `mydb`.`enderecos` (`id`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE,
  CONSTRAINT `id_pedidos_usuarios`
    FOREIGN KEY (`id_usuario`)
    REFERENCES `mydb`.`Usuarios` (`id`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE,
  CONSTRAINT `id_pedidos_estabelecimentos`
    FOREIGN KEY (`id_estabelecimento`)
    REFERENCES `mydb`.`Estabelecimentos` (`id`)
    ON DELETE SET NULL
    ON UPDATE CASCADE)
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `mydb`.`itens_pedido` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `quantidade` INT NOT NULL,
  `preco_unitario` DECIMAL(10,2) NOT NULL,
  `valor` DECIMAL(10,2) NOT NULL,
  `id_produto` INT NOT NULL,
  `id_pedido` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_itenspedido_pedidos_idx` (`id_pedido` ASC) VISIBLE,
  INDEX `fk_itenspedido_produtos_idx` (`id_produto` ASC) VISIBLE,
  CONSTRAINT `fk_itenspedido_pedidos`
    FOREIGN KEY (`id_pedido`)
    REFERENCES `mydb`.`pedidos` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_itenspedido_produtos`
    FOREIGN KEY (`id_produto`)
    REFERENCES `mydb`.`produtos` (`id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
ENGINE = InnoDB;

ALTER TABLE `mydb`.`Estabelecimentos` AUTO_INCREMENT = 1;
ALTER TABLE `mydb`.`Usuarios` AUTO_INCREMENT = 1;
ALTER TABLE `mydb`.`categorias` AUTO_INCREMENT = 1;
ALTER TABLE `mydb`.`produtos` AUTO_INCREMENT = 1;
ALTER TABLE `mydb`.`enderecos` AUTO_INCREMENT = 1;
ALTER TABLE `mydb`.`pedidos` AUTO_INCREMENT = 1;
ALTER TABLE `mydb`.`itens_pedido` AUTO_INCREMENT = 1;

INSERT INTO categorias (nome) VALUES
('Bebidas'),
('Hortifruti'),
('Padaria'),
('Laticínios'),
('Congelados'),
('Carnes'),
('Grãos e Cereais'),
('Produtos de Limpeza'),
('Higiene Pessoal'),
('Pet Shop'),
('Mercearia'),
('Produtos Naturais'),
('Biscoitos e Snacks'),
('Bolos e Doces'),
('Bebidas Alcoólicas'),
('Temperos e Condimentos'),
('Utilidades Domésticas'),
('Produtos para Bebê'),
('Congelados Prontos');


INSERT INTO estabelecimentos (nome, id_usuario, endereco, Telefone)
VALUES
("Atacarejo", 1, "Rua alameda,20", "(81) 95785-3654"),
("Supermercado Boa Vista", 2, "Rua das Flores, 200", "(11) 99999-1234"),
("Padaria Pão Quente", 3, "Av. Brasil, 500", "(21) 98888-4321"),
("Loja Natural", 4, "Rua das Palmeiras, 800", "(31) 97777-5555"),
("Mercado do Bairro", 5, "Rua das Acácias, 150", "(11) 97777-4444"),
("Padaria Doce Sabor", 6, "Rua das Laranjeiras, 250", "(21) 96666-3333"),
("Loja Orgânica", 7, "Av. das Palmeiras, 900", "(31) 95555-2222"),
("Mercadinho Central", 8, "Rua das Flores, 180", "(11) 94444-1111"),
("Padaria Pão da Casa", 9, "Av. Brasil, 520", "(21) 93333-0000"),
("Loja Verde Vida", 10, "Rua das Palmeiras, 850", "(31) 92222-9999"),
("Mercado Popular", 11, "Rua das Acácias, 170", "(11) 91111-8888"),
("Empório Saúde & Vida", 12, "Rua Saúde, 123", "(41) 91111-2222"),
("Supermercado Econômico", 13, "Av. Central, 300", "(21) 98888-7777"),
("Armazém do Campo", 14, "Rua Rural, 45", "(31) 96666-5555"),
("SuperMix", 15, "Rua do Comércio, 678", "(11) 91234-5678"),
("Mercado Bom Preço", 16, "Av. Boa Vista, 700", "(71) 93456-7890"),
("Loja Eco Produtos", 17, "Rua Verdejante, 88", "(31) 99887-6543"),
("Mini Mercado Familiar", 18, "Rua da Paz, 234", "(62) 90123-4567"),
("Padaria Trigo & Mel", 19, "Rua das Rosas, 17", "(85) 95432-1234"),
("Feira Local Econômica", 20, "Praça Central, 1", "(47) 92345-6789"),
("Hortifruti Natural", 21, "Av. das Frutas, 456", "(92) 97890-1234");

INSERT INTO usuarios (id, Nome, Email, Senha, Tipo, Data_cadastro, Estabelecimentos_id)
VALUES
(1, 'João Silva', 'joao.silva1@gmail.com', 'senha123', 'cliente', '2025-07-02 09:00:00', 1),
(2, 'Maria Oliveira', 'maria.oliveira1@yahoo.com', 'minhasenha', 'cliente', '2025-07-02 09:01:00', 2),
(3, 'Pedro Santos', 'pedro.santos1@outlook.com', '123456', 'admin', '2025-07-02 09:02:00', 3),
(4, 'Ana Costa', 'ana.costa1@hotmail.com', 'ana123', 'cliente', '2025-07-02 09:03:00', 4),
(5, 'Lucas Lima', 'lucas.lima1@gmail.com', 'lucas2023', 'fornecedor', '2025-07-02 09:04:00', 5),
(6, 'Juliana Rocha', 'juliana.rocha1@empresa.com', 'senhaSegura', 'cliente', '2025-07-02 09:05:00', 6),
(7, 'Fernando Souza', 'fernando.souza1@gmail.com', 'fsouza', 'admin', '2025-07-02 09:06:00', 7),
(8, 'Camila Martins', 'camila.martins1@gmail.com', 'cm123', 'cliente', '2025-07-02 09:07:00', 8),
(9, 'Bruno Teixeira', 'bruno.t1@gmail.com', 'brunot123', 'fornecedor', '2025-07-02 09:08:00', 9),
(10, 'Larissa Mendes', 'larissa.mendes1@yahoo.com', 'larissa321', 'cliente', '2025-07-02 09:09:00', 10),
(11, 'Carlos Andrade', 'carlos.andrade1@gmail.com', 'senha123', 'fornecedor', '2025-07-02 09:10:00', 11),
(12, 'Fernanda Lima', 'fernanda.lima1@yahoo.com', 'flima123', 'admin', '2025-07-02 09:11:00', 12),
(13, 'Roberto Nunes', 'roberto.nunes1@outlook.com', 'rnunes321', 'cliente', '2025-07-02 09:12:00', 13),
(14, 'Aline Ferreira', 'aline.ferreira1@gmail.com', 'aline2024', 'fornecedor', '2025-07-02 09:13:00', 14),
(15, 'Daniel Souza', 'daniel.souza1@hotmail.com', 'dso123', 'cliente', '2025-07-02 09:14:00', 15),
(16, 'Patrícia Mendes', 'patricia.mendes1@empresa.com', 'pmendes@1', 'admin', '2025-07-02 09:15:00', 16),
(17, 'Gustavo Teixeira', 'gustavo.t1@gmail.com', 'gt123456', 'cliente', '2025-07-02 09:16:00', 17),
(18, 'Elaine Rocha', 'elaine.rocha1@gmail.com', 'elaine!23', 'fornecedor', '2025-07-02 09:17:00', 18),
(19, 'Sérgio Martins', 'sergio.martins1@gmail.com', 'sm@456', 'admin', '2025-07-02 09:18:00', 19),
(20, 'Tatiane Barbosa', 'tatiane.barbosa1@gmail.com', 'tatib@123', 'cliente', '2025-07-02 09:19:00', 20);


INSERT INTO enderecos (rua, numero, bairro, cidade, estado, cep, complemento, Usuarios_id)
VALUES
('Rua das Flores', '100', 'Centro', 'São Paulo', 'SP', '01000-000', 'Apto 101', 1),
('Av. Brasil', '200', 'Jardim América', 'Rio de Janeiro', 'RJ', '22000-000', 'Bloco B', 2),
('Rua Pará', '150', 'Savassi', 'Belo Horizonte', 'MG', '30130-000', 'Casa 2', 3),
('Rua Rio Verde', '321', 'Setor Oeste', 'Goiânia', 'GO', '74120-060', 'Apartamento 303', 4),
('Av. Paulista', '900', 'Bela Vista', 'São Paulo', 'SP', '01310-100', 'Cobertura', 5),
('Rua XV de Novembro', '45', 'Centro', 'Curitiba', 'PR', '80020-310', 'Sala 4', 6),
('Rua Bahia', '64', 'Funcionários', 'Belo Horizonte', 'MG', '30150-310', 'Apartamento 502', 7),
('Av. Afonso Pena', '1200', 'Centro', 'Campo Grande', 'MS', '79002-072', 'Casa 10', 8),
('Rua do Comércio', '300', 'Centro', 'Florianópolis', 'SC', '88010-120', 'Loja 5', 9),
('Rua Santa Catarina', '50', 'Centro', 'Porto Alegre', 'RS', '90010-000', 'Próximo ao mercado', 10),
('Rua das Acácias', '150', 'Bairro Jardim', 'Fortaleza', 'CE', '60000-000', 'Apartamento 12', 11),
('Rua da Paz', '230', 'Vila Nova', 'Recife', 'PE', '50000-000', 'Casa 6', 12),
('Rua das Palmeiras', '500', 'Centro', 'Natal', 'RN', '59000-000', 'Sala 101', 13),
('Rua Liberdade', '120', 'Centro', 'Salvador', 'BA', '40000-000', 'Apartamento 1A', 14),
('Rua da Alegria', '98', 'Jardim América', 'Brasília', 'DF', '70000-000', 'Casa 4', 15),
('Rua do Sol', '456', 'Centro', 'Manaus', 'AM', '69000-000', 'Apto 201', 16),
('Rua das Orquídeas', '77', 'Centro', 'Belém', 'PA', '66000-000', 'Apartamento 12B', 17),
('Rua dos Coqueiros', '34', 'Centro', 'João Pessoa', 'PB', '58000-000', 'Casa 8', 18),
('Rua do Comércio', '221', 'Centro', 'Maceió', 'AL', '57000-000', 'Loja 2', 19),
('Rua das Hortênsias', '10', 'Centro', 'Teresina', 'PI', '64000-000', 'Apartamento 202', 20);


INSERT INTO produtos (
    nome, descricao, preco, validade, quantidade, categorias_id, imagem_url, valor, Estabelecimentos_id
) VALUES
("Macarrão Espaguete 500g", "Massa de trigo tipo espaguete", 6.90, '2025-10-01', 200, 7, 'http://example.com/macarrao.jpg', 6.90, 1),
("Óleo de Soja 900ml", "Óleo vegetal refinado", 8.49, '2026-03-15', 150, 7, 'http://example.com/oleo.jpg', 8.49, 1),
("Açúcar Refinado 1kg", "Açúcar branco refinado", 4.80, '2026-01-01', 180, 7, 'http://example.com/acucar.jpg', 4.80, 2),
("Sal Refinado 1kg", "Sal iodado refinado", 2.99, '2026-05-20', 250, 7, 'http://example.com/sal.jpg', 2.99, 2),
("Café Torrado e Moído 500g", "Café tradicional", 14.99, '2025-12-20', 100, 1, 'http://example.com/cafe.jpg', 14.99, 3),
("Leite Integral 1L", "Leite UHT integral", 5.79, '2025-09-10', 120, 4, 'http://example.com/leite.jpg', 5.79, 3),
("Farinha de Trigo 1kg", "Farinha de trigo enriquecida com ferro e ácido fólico", 6.25, '2025-11-15', 130, 3, 'http://example.com/farinha.jpg', 6.25, 4),
("Molho de Tomate 340g", "Molho de tomate tradicional", 3.49, '2026-02-28', 110, 2, 'http://example.com/molho.jpg', 3.49, 4),
("Achocolatado em Pó 400g", "Achocolatado solúvel", 7.99, '2025-12-10', 90, 1, 'http://example.com/achocolatado.jpg', 7.99, 5),
("Biscoito Maizena 400g", "Biscoito doce tipo maizena", 4.75, '2025-10-30', 140, 3, 'http://example.com/biscoito.jpg', 4.75, 5);


INSERT INTO pedidos (id_usuario, data_pedido, status, id_endereco, id_estabelecimento, total, pedido) VALUES
(1, '2025-07-01 08:00:00', 'Entregue', 1, 1, 50.00, 'Pedido 1'),
(2, '2025-07-01 08:30:00', 'Entregue', 2, 2, 30.00, 'Pedido 2'),
(3, '2025-07-01 09:00:00', 'Em andamento', 3, 3, 70.00, 'Pedido 3'),
(4, '2025-07-01 09:30:00', 'Cancelado', 4, 4, 20.00, 'Pedido 4'),
(5, '2025-07-01 10:00:00', 'Entregue', 5, 5, 100.00, 'Pedido 5'),
(6, '2025-07-01 10:30:00', 'Entregue', 6, 6, 15.00, 'Pedido 6'),
(7, '2025-07-01 11:00:00', 'Em andamento', 7, 7, 40.00, 'Pedido 7'),
(8, '2025-07-01 11:30:00', 'Entregue', 8, 8, 55.00, 'Pedido 8'),
(9, '2025-07-01 12:00:00', 'Entregue', 9, 9, 25.00, 'Pedido 9'),
(10, '2025-07-01 12:30:00', 'Cancelado', 10, 10, 0.00, 'Pedido 10'),
(11, '2025-07-01 13:00:00', 'Entregue', 11, 11, 75.00, 'Pedido 11'),
(12, '2025-07-01 13:30:00', 'Em andamento', 12, 12, 60.00, 'Pedido 12'),
(13, '2025-07-01 14:00:00', 'Entregue', 13, 13, 45.00, 'Pedido 13'),
(14, '2025-07-01 14:30:00', 'Cancelado', 14, 14, 10.00, 'Pedido 14'),
(15, '2025-07-01 15:00:00', 'Entregue', 15, 15, 35.00, 'Pedido 15'),
(16, '2025-07-01 15:30:00', 'Entregue', 16, 16, 80.00, 'Pedido 16'),
(17, '2025-07-01 16:00:00', 'Em andamento', 17, 17, 20.00, 'Pedido 17'),
(18, '2025-07-01 16:30:00', 'Entregue', 18, 18, 90.00, 'Pedido 18'),
(19, '2025-07-01 17:00:00', 'Entregue', 19, 19, 10.00, 'Pedido 19'),
(20, '2025-07-01 17:30:00', 'Cancelado', 20, 20, 0.00, 'Pedido 20');


INSERT INTO itens_pedido (id_pedido, id_produto, quantidade, preco_unitario, valor)
VALUES
(1, 1, 2, 6.90, 13.80),
(2, 2, 1, 8.49, 8.49),
(3, 3, 3, 4.80, 14.40),
(4, 4, 2, 2.99, 5.98),
(5, 5, 2, 14.99, 29.98),
(6, 6, 1, 5.79, 5.79),
(7, 7, 2, 6.25, 12.50),
(8, 8, 1, 3.49, 3.49),
(9, 9, 3, 7.99, 23.97),
(10, 10, 1, 4.75, 4.75),
(11, 1, 4, 6.90, 27.60),
(12, 2, 2, 8.49, 16.98),
(13, 3, 1, 4.80, 4.80),
(14, 4, 5, 2.99, 14.95),
(15, 5, 1, 14.99, 14.99),
(16, 6, 3, 5.79, 17.37),
(17, 7, 1, 6.25, 6.25),
(18, 8, 4, 3.49, 13.96),
(19, 9, 2, 7.99, 15.98),
(20, 10, 5, 4.75, 23.75);
