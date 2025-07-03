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
('Higiene Pessoal');

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
("Mercado Popular", 11, "Rua das Acácias, 170", "(11) 91111-8888");

INSERT INTO usuarios (id, Nome, Email, Senha, Tipo, Data_cadastro, Estabelecimentos_id)
VALUES
(51, 'João Silva', 'joao.silva@gmail.com', 'senha123', 'cliente', '2025-07-02 09:42:53', 1),
(52, 'Maria Oliveira', 'maria.oliveira@yahoo.com', 'minhasenha', 'cliente', '2025-07-02 09:42:53', 1),
(53, 'Pedro Santos', 'pedro.santos@outlook.com', '123456', 'admin', '2025-07-02 09:42:53', 1),
(54, 'Ana Costa', 'ana.costa@hotmail.com', 'ana123', 'cliente', '2025-07-02 09:42:53', 1),
(55, 'Lucas Lima', 'lucas.lima@gmail.com', 'lucas2023', 'fornecedor', '2025-07-02 09:42:53', 1),
(56, 'Juliana Rocha', 'juliana.rocha@empresa.com', 'senhaSegura', 'cliente', '2025-07-02 09:42:53', 1),
(57, 'Fernando Souza', 'fernando.souza@gmail.com', 'fsouza', 'admin', '2025-07-02 09:42:53', 1),
(58, 'Camila Martins', 'camila.martins@gmail.com', 'cm123', 'cliente', '2025-07-02 09:42:53', 1),
(59, 'Bruno Teixeira', 'bruno.t@gmail.com', 'brunot123', 'fornecedor', '2025-07-02 09:42:53', 1),
(60, 'Larissa Mendes', 'larissa.mendes@yahoo.com', 'larissa321', 'cliente', '2025-07-02 09:42:53', 1);

INSERT INTO enderecos (rua, numero, bairro, cidade, estado, cep, complemento, Usuarios_id)
VALUES
('Rua das Flores', '100', 'Centro', 'São Paulo', 'SP', '01000-000', 'Apto 1', 51),
('Av. Brasil', '200', 'Jardim América', 'Rio de Janeiro', 'RJ', '22000-000', NULL, 52),
('Rua Pará', '150', 'Savassi', 'Belo Horizonte', 'MG', '30130-000', NULL, 53),
('Rua Rio Verde', '321', 'Setor Oeste', 'Goiânia', 'GO', '74120-060', NULL, 54),
('Av. Paulista', '900', 'Bela Vista', 'São Paulo', 'SP', '01310-100', NULL, 55),
('Rua XV de Novembro', '45', 'Centro', 'Curitiba', 'PR', '80020-310', NULL, 56),
('Rua Bahia', '64', 'Funcionários', 'Belo Horizonte', 'MG', '30150-310', NULL, 57),
('Av. Afonso Pena', '1200', 'Centro', 'Campo Grande', 'MS', '79002-072', NULL, 58),
('Rua do Comércio', '300', 'Centro', 'Florianópolis', 'SC', '88010-120', NULL, 59),
('Rua Santa Catarina', '50', 'Centro', 'Porto Alegre', 'RS', '90010-000', 'Próximo ao mercado', 60);

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
(51, '2025-07-01 10:00:00', 'Entregue', 1, 1, 27.00, 'Pedido 1'),
(52, '2025-07-01 10:15:00', 'Entregue', 2, 2, 12.00, 'Pedido 2'),
(53, '2025-07-01 11:00:00', 'Em andamento', 3, 3, 80.00, 'Pedido 3'),
(54, '2025-07-01 12:00:00', 'Entregue', 4, 4, 18.00, 'Pedido 4'),
(55, '2025-07-01 12:10:00', 'Cancelado', 5, 5, 10.00, 'Pedido 5'),
(56, '2025-07-01 13:00:00', 'Entregue', 6, 6, 14.00, 'Pedido 6'),
(57, '2025-07-01 13:30:00', 'Em andamento', 7, 7, 32.00, 'Pedido 7'),
(58, '2025-07-01 14:00:00', 'Entregue', 8, 8, 40.00, 'Pedido 8'),
(59, '2025-07-01 15:00:00', 'Entregue', 9, 9, 10.00, 'Pedido 9'),
(60, '2025-07-01 16:00:00', 'Entregue', 10, 10, 0.00, 'Pedido 10');


INSERT INTO itens_pedido (id_pedido, id_produto, quantidade, preco_unitario, valor)
VALUES
(1, 1, 2, 6.90, 13.80),
(1, 2, 1, 8.49, 8.49),
(2, 3, 3, 4.80, 14.40),
(3, 4, 2, 2.99, 5.98),
(4, 6, 1, 5.79, 5.79),
(5, 5, 2, 14.99, 29.98),
(6, 10, 2, 4.75, 9.50),
(7, 7, 1, 6.25, 6.25),
(8, 8, 2, 3.49, 6.98),
(9, 9, 1, 7.99, 7.99);