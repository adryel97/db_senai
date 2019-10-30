# ----------------------------------------------
# 24/10/2019
# Refatorando o script SQL para a atender
# as novas tabelas e campos
# ----------------------------------------------

# DDL - Data Defintion Language
drop database if exists livraria;
create database livraria; #pressionar as teclas ctrl enter ao final
use livraria; #ctrl enter, atualizar o Schemas

# DDL - Data Definition Language
# Criação da tabela pais
create table pais(
	id_pais int unsigned not null primary key auto_increment,
    nome varchar(45) not null unique
); #CTRL ENTER

# Criação da tabela idioma
create table idioma(
	id_idioma int unsigned not null primary key auto_increment,
    nome varchar(45) not null unique
); #CTRL ENTER

# Criação da tabela tipo
create table tipo(
	id_tipo int unsigned not null primary key auto_increment,
    nome varchar(45) not null unique
); #CTRL ENTER

# DDL - Data Definition Language
# Criação da tabela autor
create table autor(
	id_autor int unsigned not null primary key auto_increment,
	pseudonimo varchar(45) not null unique,
    nome_de_nascimento varchar(100) not null,
    data_de_nascimento date,
    nota_biografica tinytext,
    id_pais int unsigned not null,
    foreign key(id_pais) references pais(id_pais)
);

# DDL - Data Definition Language
# Criação da tabela livro
create table livro(
	id_livro int unsigned not null primary key auto_increment,
    titulo varchar(100) not null unique,
    ano_de_lancamento int(4) not null,
    id_idioma int unsigned not null,
    foreign key(id_idioma) references idioma(id_idioma)
); #CTRL ENTER

# DDL - Data Definition Language
# Criação da tabela associativa autor_escreve_livro
create table autor_escreve_livro(
	id_livro int unsigned not null,
    id_autor int unsigned not null,
    primary key(id_livro, id_autor),
    foreign key(id_autor) references autor(id_autor),
    foreign key(id_livro) references livro(id_livro)
); # CTRL ENTER

# DDL - Data Definition Language
# Criação da tabela editora
create table editora(
	id_editora int unsigned not null primary key auto_increment,
	# utf8mb4_bin para distinguir maiúsculas e minúsculas
	nome varchar(100) not null collate utf8mb4_bin,
    # unique para não se repetir
    razao_social varchar(100) not null unique,
    endereco tinytext
); #CTRL ENTER

# DDL - Data Definition Language
# Criação da tabela telefone
create table telefone(
	id_telefone int unsigned not null auto_increment,
    numero varchar(16),    
    id_editora int unsigned not null, 
    id_tipo int unsigned not null, 
    primary key(id_telefone),
    foreign key(id_editora) references editora(id_editora),
    foreign key(id_tipo) references tipo(id_tipo)
); # Ctrl Enter

# Criação da tabela edicao
create table edicao(
	id_edicao int unsigned not null primary key auto_increment,
	isbn bigint(13) unsigned zerofill not null,
    preco_de_venda decimal(5,2) not null,
    ano_da_publicacao int(4),
    numero_de_paginas int unsigned,
    quantidade_em_estoque int not null,  
    id_livro int unsigned not null,
    id_editora int unsigned not null,
    foreign key(id_editora) references editora(id_editora),
    foreign key(id_livro) references livro(id_livro)
); #ctrl enter


# DML - Data Manipulation Language
# Cadastro de Editoras
insert into editora values
(100,"Novatec", "Editora Novatec", "Rua da Novatec"),
(200,"Brasport", "Editora Brasport", "Rua da Brasport"),
(300,"Érica","Editora Érica", "Rua da Érica");

# DML - Data Manipulation Language
# Cadastro de Idiomas
INSERT INTO idioma(nome) VALUES
("Português"),("Inglês"),("Alemão"),('Espanhol');
SELECT * FROM idioma order by id_idioma;

#unique não se repete

# DML - Data Manipulation Language
# Cadastro de Livros
INSERT INTO livro(titulo, ano_de_lancamento, id_idioma)
VALUES
# 1 http://www.brasport.com.br/negocios/gerenciamento-de-servico-itil/agile-scrum-master-no-gerenciamento-avancado-de-projetos-2a-edicao/
("Agile Scrum Master no Gerenciamento Avançado de Projetos", 2019, 1),
# 2 http://www.brasport.com.br/informatica-e-tecnologia/seguranca/fundamentos-de-seguranca-da-informacao/
("Fundamentos de Segurança da Informação", 2018, 1),
# 3 https://novatec.com.br/livros/agile-para-todos/
("Agile para todos", 2019, 1),
# 4 https://novatec.com.br/livros/amazon-web-services-acao/
("Amazon Web Services em Ação", 2015, 1),
# 5 https://www.editoraerica.com.br/php-5---conceitos-programacao-e-integracao-com-banco-de-dados/p
("PHP 5", 2013, 1),
# 6 https://www.editoraerica.com.br/cloud-computing---inteligencia-da-nuvem-e-seu-novo-valor-em-ti/p
("Cloud Computing", 2017, 1);

#mostrar os liros mais novos no topo da lista DESC = DESCENDENTE || ASC = ASCENDENTE
select * from livro order by ano_de_lancamento desc;

# Fim da aula quinta-feira 24/10/2019
# Continua ...

#Início da aula 30/10
select * from pais;
insert into pais(nome) values
("Brasil"),("Holanda"),("Estados Unidos"),("Alemanha");
# DML - Data Manipulation Language
# Cadastro de Autores
insert into autor(pseudonimo, nome_de_nascimento, data_de_nascimento, nota_biografica, id_pais) values
# 1 http://www.brasport.com.br/negocios/gerenciamento-de-servico-itil/agile-scrum-master-no-gerenciamento-avancado-de-projetos-2a-edicao/
("Massari","Vitor L. Massari", null, "Sócio e Especialista em Agile/Lean da Hiflex. Sua missão é percorrer todo o Brasil ajudando pessoas e empresas a atingir melhores resultados utilizando abordagens enxutas e colaborativas de gestão.", 1);

# 2 http://www.brasport.com.br/informatica-e-tecnologia/seguranca/fundamentos-de-seguranca-da-informacao/
insert into autor(pseudonimo, nome_de_nascimento, data_de_nascimento, nota_biografica, id_pais) values
("Baars","Hans Baars",null,"CISSP, CISM, trabalhou como oficial de segurança da informação e auditor EDP na Polícia Nacional holandesa de 1999 a 2002. Em 2002 se tornou consultor de segurança na Agência Nacional de Serviços de Polícia da Holanda. ",2),
("K. Hintzbergen","Kees Hintzbergen",null,"Consultor sênior, autônomo, de segurança da informação. Kees possui mais de 30 anos de experiência em TI e no provisionamento de informações, e trabalha na área de segurança da informação desde 1999.",2),
("J. Hintzbergen","Jule Hintzbergen",null,"CISSP CEH. Depois de trabalhar inicialmente por 21 anos no Ministério da Defesa, Jule trabalha desde 1999 na Capgemini como consultor de segurança cibernética. ",2),
("Smulders","André Smulders",null,"(CISSP) é consultor de negócios, voltado para segurança da informação e gestão de riscos, na TNO. Quando André concluiu seus estudos em Gestão de Tecnologia na Universidade de Eindhoven, ele começou a trabalhar em projetos inovadores de TIC.",2);

# 3 https://novatec.com.br/livros/agile-para-todos/
insert into autor(pseudonimo, nome_de_nascimento, data_de_nascimento, nota_biografica, id_pais) values
("Lemay","Matt Lemay",null,"Matt LeMay é cofundador e sócio da Sudden Compass, uma empresa de consultoria que ajudou empresas como Spotify, Clorox e Procter & Gamble a colocar o foco no cliente em prática.",3);

# 4 https://novatec.com.br/livros/amazon-web-services-acao/
insert into autor(pseudonimo, nome_de_nascimento, data_de_nascimento, nota_biografica, id_pais) values
("A. Wittig","Andreas Wittig",null,"Andreas Wittig é engenheiro e consultor de software, especialista em AWS e desenvolvimento web.",4),
("M. Wittig","Michael Wittig",null,"Michael Wittig é engenheiro e consultor de software, especialista em AWS e desenvolvimento web.",4);

# 5 https://www.editoraerica.com.br/php-5---conceitos-programacao-e-integracao-com-banco-de-dados/p
insert into autor(pseudonimo, nome_de_nascimento, 
nota_biografica, id_pais) values
("Walace","Walace Soares","Mochileiro viajante",1);

# 6 https://www.editoraerica.com.br/cloud-computing---inteligencia-da-nuvem-e-seu-novo-valor-em-ti/p
insert into autor(pseudonimo, nome_de_nascimento, 
nota_biografica, id_pais) values
("Molinari","Leonardo Molinari","Cabeça nas nuvens",1);

#desafio!
#Mostrar o nome do autor e o nome do pais id e o nome do pais
select * from autor;
select * from pais;

select a.id_autor, 
	   a.nome_de_nascimento, 
       p.id_pais,  
       p.nome
from autor a 
inner join pais p
using (id_pais);
#on a.id_pais = p.id_pais;

# DML - Data Manipulation Language
# Associação de Autores e Livros
insert into autor_escreve_livro(autor_pseudonimo, livro_codigo) 
# 1 http://www.brasport.com.br/negocios/gerenciamento-de-servico-itil/agile-scrum-master-no-gerenciamento-avancado-de-projetos-2a-edicao/
values ("Massari",1);

# 2 http://www.brasport.com.br/informatica-e-tecnologia/seguranca/fundamentos-de-seguranca-da-informacao/
insert into autor_escreve_livro(autor_pseudonimo, livro_codigo)
values ("Baars",2),("J. Hintzbergen",2),
("K. Hintzbergen",2),("Smulders",2);

# 3 https://novatec.com.br/livros/agile-para-todos/
insert into autor_escreve_livro(autor_pseudonimo, livro_codigo)
values ("Lemay",3);

# 4 https://novatec.com.br/livros/amazon-web-services-acao/
insert into autor_escreve_livro(autor_pseudonimo, livro_codigo)
values ("M. Wittig",4);
insert into autor_escreve_livro(autor_pseudonimo, livro_codigo)
values ("A. Wittig",4);

# 5 https://www.editoraerica.com.br/php-5---conceitos-programacao-e-integracao-com-banco-de-dados/p
insert into autor_escreve_livro(autor_pseudonimo, livro_codigo)
values ("Walace",5);

# 6 https://www.editoraerica.com.br/cloud-computing---inteligencia-da-nuvem-e-seu-novo-valor-em-ti/p
insert into autor_escreve_livro(autor_pseudonimo, livro_codigo)
values ("Molinari",6);


# Cadastro de edições
# DML - Data Manipulation Language
# Associação de Livros e Editoras

# 1 http://www.brasport.com.br/negocios/gerenciamento-de-servico-itil/agile-scrum-master-no-gerenciamento-avancado-de-projetos-2a-edicao/
insert into edicao(isbn, preco_de_venda, ano_da_publicacao, numero_de_pagina, quantidade_em_estoque, livro_codigo, fk_nome_editora) values
(9788574529394, 76.50, 2019, 320, 10, 1, "Brasport");

# 2 http://www.brasport.com.br/informatica-e-tecnologia/seguranca/fundamentos-de-seguranca-da-informacao/
insert into edicao(isbn, preco_de_venda, ano_da_publicacao, numero_de_pagina, quantidade_em_estoque, livro_codigo, fk_nome_editora) values
(9788574528601, 69.70, 2018, 256, 15, 2, "Brasport");

# 3 https://novatec.com.br/livros/agile-para-todos/
insert into edicao(isbn, preco_de_venda, ano_da_publicacao, numero_de_pagina, quantidade_em_estoque, livro_codigo, fk_nome_editora) values
(9788575227909, 56, 2019, 176, 25, 3, "Novatec");

# 4 https://novatec.com.br/livros/amazon-web-services-acao/
insert into edicao(isbn, preco_de_venda, ano_da_publicacao, numero_de_pagina, quantidade_em_estoque, livro_codigo, fk_nome_editora) values
(9788575224694, 97, 2015, 512, 2, 4, "Novatec");

# 5 https://www.editoraerica.com.br/php-5---conceitos-programacao-e-integracao-com-banco-de-dados/p
insert into edicao(isbn, preco_de_venda, ano_da_publicacao, numero_de_pagina, quantidade_em_estoque, livro_codigo, fk_nome_editora) values
(9788536500317, 147.42, 2013, 528, 2, 5, "Érica");

# 6 https://www.editoraerica.com.br/cloud-computing---inteligencia-da-nuvem-e-seu-novo-valor-em-ti/p
insert into edicao(isbn, preco_de_venda, ano_da_publicacao, numero_de_pagina, quantidade_em_estoque, livro_codigo, fk_nome_editora) values
(9788536524863, 32.90, 2017, 120, 10, 6, "Érica");

# Cadastro de telefones
# DML - Data Manipulation Language
# Associação de Editoras e Telefones

insert into telefone(numero, tipo, editora_nome) values
("(21) 3497-2162", "Comercial", "Brasport"),
("(11) 2959-6529", "Comercial", "Novatec"),
("4949 0155", "Comercial", "Érica");

# Exibir o nome do livro e o seu peso, dado que o peso por página é 2,223g
select titulo, numero_de_pagina * 2.223 as "peso em gramas"from edicao 
inner join livro on livro_codigo = codigo;

# Exibir o ISBN da edição, o título do livro, o nome do autor, a razão social da editora e o número.
select isbn, titulo, nome_de_nascimento, razao_social, numero from edicao eo
inner join livro l on livro_codigo = codigo
inner join autor_escreve_livro ael on ael.livro_codigo = codigo
inner join autor a on autor_pseudonimo = pseudonimo
inner join editora ea on nome = fk_nome_editora
inner join telefone t on nome = editora_nome;
