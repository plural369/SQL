/*
1.Quais s�o os tipos de dados b�sicos em PL/SQL? 
Num�rico, caracter, boolean, bin�rio e data e hora

2.Como voc� usa um operador de atribui��o em PL/SQL? 
v_numero := 12;

3.Como voc� cria uma estrutura de dados em PL/SQL? 
DECLARE
   declara��es
BEGIN
   c�digo
EXCEPTION
   tratamento de exce��es
END;

4.Criar a estrutura de tabelas entre duas entidades produto e cliente e associa-las. Incluir os campos de chave primaria e estrangeira. 

CREATE TABLE Produto( id NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY 
                     , nome VARCHAR2(300)
                     , codigoNUMBER
                     , cliente_id NUMBER
                     , FOREIGN KEY(cliente_id) REFERENCES clientes(cliente_id) ON DELETE CASCADE);

CREATE TABLE clientes( id NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY 
                     , nome VARCHAR2(50)
                     , telefone NUMBER
                     , email     VARCHAR2(50));

5.Como criar uma procedure em PL/SQL e como chama-la. 
CREATE OR REPLACE PROCEDURE nome_da_procedure(par�metros IN/ OUT/ IN OUT)
IS 
    declara��es
BEGIN

END nome_da_procedure;

nome_da_procedure(par�metros => valor);

6.Como criar um trigger? 
Trigger de comando:

CREATE OR REPLACE TRIGGER nome_da_trigger
BEFORE INSERT OR UPDATE OR DELETE
ON nome_da_tabela
BEGIN
COMMIT;
END;

Trigger de linha:
CREATE OR REPLACE TRIGGER nome_da_trigger
  AFTER INSERT OR UPDATE OF nome_da_coluna OR DELETE 
  ON nome_da_tabela
  FOR EACH ROW
DECLARE
   declara��es
BEGIN
COMMIT;
END;
7.Como voc� cria um record em PL/SQL? D� um exemplo de uso em um bloco an�nimo. 

SET SERVEROUTPUT ON
DECLARE
TYPE r_dados IS RECORD ( nome    varchar2(50)
                                              , telefone number
                                              , email varchar2(50));
v_record r_dados;
BEGIN
   v_record.nome := 'Gabriel';
   v_record.telefone := 16992845808;
   v_record.email     :='gabriel.espadoni99@outlook.com';
   
   DBMS_OUTPUT.PUT_LINE('Nome: ' || v_record.nome ||' - '|| 'Telefone: '||v_record.telefone || ' - '|| 'Email: ' || v_record.email);  
END;
8.Como voc� usa um loop for em PL/SQL? D� um exemplo de uso em um bloco an�nimo. 

set serveroutput on
BEGIN
   FOR dados IN 1..12
   LOOP
      DBMS_OUTPUT.PUT_LINE('Contagem:' || dados);
   END LOOP;

END;
9.Como voc� concede privil�gios a um usu�rio? 
GRANT CREATE SESSION, CREATE VIEW, CREATE TABLE, ALTER SESSION, CREATE SEQUENCE, CREATE PROCEDURE, CREATE TRIGGER TO USUARIO;

10.Escreva um c�digo que lida com a exce��o invalid_number 
SET SERVEROUTPUT ON
DECLARE
   v_numero NUMBER;
BEGIN
   SELECT TO_NUMBER('TRATAMENTO NUMERO') 
     INTO v_numero
     FROM DUAL;
EXCEPTION
   WHEN INVALID_NUMBER THEN
      DBMS_OUTPUT.PUT_LINE('Numero inv�lido');
END;

11.Indicar defini��o de trigger mutante.
Mutante trigger � quando vc tenta a nivel de linha, alterar os dados em colunas de chaves prim�rias, estrangeiras e unicas de tabelas relacionadas aquela a qual a trigger foi disparada e a nivel de comando ocorre quando se usa um delete em uma coluna de chave estrangeira que � delete cascade. 

12.Qual � o impacto na utiliza��o de bind nos objetos de banco de dados? D� um exemplo de utiliza��o de bind. 
Ganho de performance por permitir reutilizar o plano de execu��o e previne sql injection 

SET SERVEROUTPUT ON
DECLARE
    v_id_aluno aluno.id%TYPE:= 1;
    v_nome     aluno.nome%TYPE;
BEGIN
    EXECUTE IMMEDIATE 
        'SELECT nome
           FROM Aluno
          WHERE id = :id'
    INTO v_nome
    USING v_id_aluno;
    DBMS_OUTPUT.PUT_LINE('Nome: ' || v_nome);
END;

*/

--Relacionar todos os c�digos e nomes das disciplinas que possuam n�mero de cr�ditos maior ou igual a 2. 
SELECT nome
     , codigo 
  FROM disciplina
 WHERE credito >= 2;
 
 --Relacionar os nomes, c�digos e n�mero de cr�ditos das disciplinas ministradas pelo professor Zez�. 
 SELECT nome
      , codigo 
  FROM disciplina
 WHERE professor_id = 2;
 
 --Relacionar os c�digos de todas as disciplinas em que o aluno �Rog�rio� se matriculou.
 SELECT disciplina.codigo 
  FROM disciplina
  JOIN matricula ON(disciplina.id = matricula.disciplina_id)
 WHERE aluno_id = 1;
 
 --Relacionar os c�digos dos alunos matriculados na disciplina �Banco de Dados II�, que tiraram nota maior ou igual 6. 
SELECT aluno.codigo 
  FROM aluno
  JOIN matricula ON(aluno.id = matricula.aluno_id)
 WHERE disciplina_id IN(SELECT ID
                          FROM disciplina
                         WHERE nome = 'Banco de Dados II')
   AND matricula.nota >= 6;
   
/*Relacionar os c�digos e nomes de todas as disciplinas que n�o possuam pr�-requisito. 
No resultado, as colunas dever�o conter o cabe�alho NRO e DISCIPLINA, respectivamente.*/
SELECT codigo as NRO
     , nome as DISCIPLINA
  FROM disciplina
 WHERE pre_requisito_id IS NULL;
 
--Relacionar os c�digos e nomes de todos os alunos cujos nomes possuem letra A.
SELECT codigo
     , nome 
  FROM aluno
 WHERE UPPER(nome) LIKE '%A%'
    OR UPPER(nome) LIKE '%�%';
    
--Relacionar as disciplinas cujos nomes contenham mais que uma palavra.
SELECT nome
  FROM disciplina
 WHERE INSTR(nome,' ') > 0;
 
--Relacionar os c�digos, nomes e cr�ditos de todas as disciplinas cujos nomes possuam as letras II
SELECT codigo
     , nome
     , credito
  FROM disciplina
 WHERE INSTR(nome,'II') > 0;
 
--Fazer uma rela��o com o c�digo, nome, dia de anivers�rio e m�s de anivers�rio de cada aluno cujo �ano de anivers�rio� seja maior que 1982.
SELECT codigo
     , nome
     , TO_CHAR(data_nasc,'DD') dia_de_anivers�rio
     , TO_CHAR(data_nasc,'MM') m�s_de_anivers�rio
  FROM aluno
 WHERE TO_CHAR(data_nasc,'YYYY') > 1982;
 
--Relacionar os nomes e os dias dos anivers�rios de todos os alunos que nasceram no m�s seguinte ao da data atual.
SELECT nome
     , TO_CHAR(data_nasc,'DD') dia_de_anivers�rio
  FROM aluno
 WHERE TO_CHAR(data_nasc,'MM') > TO_CHAR(sysdate,'MM');

--Relacionar todos os nomes e data de nascimento dos alunos que faram anivers�rio at� dezembro. 
SELECT nome
     , data_nasc data_de_nascimento
  FROM aluno
 WHERE TO_CHAR(data_nasc,'MM') between TO_CHAR(sysdate,'MM') and 12;

--Relacionar o nome e data de nascimento dos alunos com mais de 30 anos completos. 
SELECT nome
     , data_nasc data_de_nascimento
  FROM aluno
 WHERE TRUNC(MONTHS_BETWEEN(SYSDATE, data_nasc) / 12) > 30;
 
--Relacionar o nome e data de nascimento dos alunos com menos de 30 anos completos. 
SELECT nome
     , data_nasc data_de_nascimento
  FROM aluno
 WHERE TRUNC(MONTHS_BETWEEN(SYSDATE, data_nasc) / 12) < 30;
 
 --Adicionar 1 segundo na data atual e demonstrar o resultado, exibindo a data atual com hora, minuto e segundo, e o nova data da mesma maneira.
SELECT 
  SYSTIMESTAMP AS data_atual,
  SYSTIMESTAMP + INTERVAL '1' SECOND AS Somado_1_segundo
FROM DUAL;

--Calcule a m�dia dos alunos reprovados.
SELECT AVG(nota) M�dia_reprovados
  FROM MATRICULA
 WHERE situacao = 'Reprovado';
 
--Calcule a maior e a menor nota tirada na disciplina �Portugu�s�.  
SELECT MAX(nota) maior_nota
     , MIN(nota) menor_nota
  FROM matricula
  JOIN disciplina ON(disciplina.id = matricula.disciplina_id)
 WHERE disciplina.nome = 'Portugu�s';
 
 --Calcule o n�mero de disciplinas que possuam n�mero de cr�ditos igual a 2.
 SELECT COUNT(nome)
  FROM disciplina 
 WHERE credito = 2;
 
 --Quantos alunos est�o sem data de nascimento?R:0
 SELECT COUNT(id)
   FROM aluno 
  WHERE data_nasc IS NULL;
  
--Quantas disciplinas n�o t�m professores?R:0
SELECT COUNT(id) 
  FROM disciplina
 WHERE professor_id IS NULL;
 
 --Qual o n�mero de matriculas que a disciplina �Sistema de Informa��o� recebeu?
SELECT COUNT(matricula.id) n�mero_de_matriculas
  FROM matricula
  JOIN disciplina ON(disciplina.id = matricula.disciplina_id)
 WHERE disciplina.nome = 'Sistema de Informa��o';
 
 --Relacione os c�digos e nomes de todos os alunos cuja nota seja menor ou igual � m�dia geral.
 SELECT aluno.codigo, aluno.nome
   FROM aluno
   JOIN matricula ON(aluno.id = matricula.aluno_id)
  WHERE matricula.nota <= (SELECT AVG(nota)
                             FROM matricula)
  GROUP BY aluno.codigo, aluno.nome;

--Relacione os c�digos das disciplinas que tenham n�mero de cr�ditos maior que a m�dia de cr�ditos de todas as disciplinas.
SELECT codigo 
  FROM disciplina
 WHERE credito > (SELECT AVG(credito) 
                    FROM disciplina);
                    
--Relacione os nomes dos alunos que tenham se matriculado nas mesmas disciplinas que o aluno �Vinicius� se matriculou. 
 SELECT DISTINCT aluno.codigo, aluno.nome
   FROM aluno
   JOIN matricula ON(aluno.id = matricula.aluno_id)
  WHERE matricula.disciplina_id IN (SELECT disciplina_id
                                      FROM aluno
                                      JOIN matricula ON(aluno.id = matricula.aluno_id)
                                     WHERE aluno.nome = 'Vinicius' );
                                     
--Listar o nome das disciplinas que possuam n�mero de cr�ditos maior que a disciplina �Banco de Dados�
SELECT nome
  FROM disciplina
 WHERE credito > (SELECT credito
                    FROM disciplina
                   WHERE nome = 'Banco de Dados');
                   
--Relacionar os nomes e c�digos dos alunos que obtiveram notas iguais ou maiores que alguma das notas do aluno �Rog�rio�.
SELECT DISTINCT aluno.nome, aluno.codigo
  FROM aluno
  JOIN matricula ON(aluno.id = matricula.aluno_id)
 WHERE matricula.nota >= ANY (SELECT m2.nota
                                FROM aluno a2
                                JOIN matricula m2 ON(a2.id = m2.aluno_id)
                               WHERE a2.nome = 'Rog�rio');
                               
--Relacione os c�digos e nomes de todos os alunos cuja nota seja menor ou igual � m�dia geral. 
SELECT DISTINCT aluno.nome, aluno.codigo
  FROM aluno
  JOIN matricula ON(aluno.id = matricula.aluno_id)
 WHERE matricula.nota <= (SELECT AVG(m2.nota)
                            FROM matricula m2);

--Exemplifique a cria��o de um �bloco PL/SQL�, com declara��o de vari�veis, que seja compil�vel. 
SET SERVEROUTPUT ON
DECLARE
   v_media NUMBER;
BEGIN
   SELECT AVG(nota)
     INTO v_media
     FROM matricula; 
   
   IF v_media > 7 THEN
      DBMS_OUTPUT.PUT_LINE('Turma boa.');
   ELSE
      DBMS_OUTPUT.PUT_LINE('Precisa melhorar.');
   END IF;
EXCEPTION
   WHEN NO_DATA_FOUND THEN
      NULL;
END;

--Sobre �cursores�: 

--Exemplifique um cursor simples.
SET SERVEROUTPUT ON
DECLARE
   CURSOR dados_cursor IS(SELECT *
                            FROM matricula);
   matricula_record dados_cursor%ROWTYPE;                 
BEGIN
   OPEN dados_cursor;
   
   LOOP
      FETCH dados_cursor
      INTO matricula_record;
      
      EXIT WHEN dados_cursor%notfound;
      
         DBMS_OUTPUT.PUT_LINE('NOTA: ' || matricula_record.nota ||' - '|| 'SITUA��O: '||matricula_record.situacao); 
      
      END LOOP;
   CLOSE dados_cursor;   
   
END;

--Exemplifique um cursor com estrutura de repeti��o.

SET SERVEROUTPUT ON
DECLARE
   CURSOR dados_cursor IS(SELECT *
                            FROM matricula);               
BEGIN
   FOR dados IN dados_cursor
   LOOP
      DBMS_OUTPUT.PUT_LINE('NOTA: ' || dados.nota ||' - '|| 'SITUA��O: '||dados.situacao); 
      
   END LOOP;
   
END;

-- Exemplifique a utiliza��o de uma tabela �index by�, baseado em tabela de banco. 

SET SERVEROUTPUT ON
DECLARE
  TYPE alunos_table_type IS TABLE OF aluno%rowtype
  INDEX BY BINARY_INTEGER;
  alunos_table  alunos_table_type;
BEGIN
  SELECT *
    BULK COLLECT INTO alunos_table 
    FROM aluno;
   FOR i IN alunos_table.first..alunos_table.last  
   LOOP
      DBMS_OUTPUT.PUT_LINE(alunos_table(i).nome || ' - ' || 
                           alunos_table(i).codigo || ' - ' || 
                           alunos_table(i).data_nasc);   
   END LOOP;
END;

--Exemplifique a utiliza��o de um �record table�.
SET SERVEROUTPUT ON
DECLARE
  TYPE alunos_table_type IS TABLE OF aluno%rowtype;
  alunos_table  alunos_table_type := alunos_table_type();
  
BEGIN
  SELECT *
    BULK COLLECT INTO alunos_table 
  FROM aluno;
  FOR i IN alunos_table.first..alunos_table.last  
  LOOP
    DBMS_OUTPUT.PUT_LINE(alunos_table(i).nome || ' - ' || 
                         alunos_table(i).codigo || ' - ' || 
                         alunos_table(i).data_nasc );   
  END LOOP;
END;

--Exemplifique a cria��o de uma �procedure�, que seja compil�vel. 
CREATE OR REPLACE PROCEDURE retorna_media_aluno( pi_aluno_id IN NUMBER
                                               , po_media OUT NUMBER) IS
BEGIN
   SELECT AVG(nota)
     INTO po_media
     FROM matricula
    WHERE aluno_id = pi_aluno_id;
END retorna_media_aluno;
SET SERVEROUTPUT ON
DECLARE
   v_media NUMBER;
BEGIN 
   retorna_media_aluno( pi_aluno_id => 5
                      , po_media => v_media);
   DBMS_OUTPUT.PUT_LINE('Media aluno: ' || v_media);                   
END;

--Exemplifique a cria��o de uma �fun��o�, que seja compil�vel. 
CREATE OR REPLACE FUNCTION retorna_media_disciplina(pi_disciplina_id NUMBER) RETURN NUMBER IS
   v_media_disciplina NUMBER;
BEGIN
   SELECT AVG(nota)
     INTO v_media_disciplina
     FROM matricula
    WHERE disciplina_id = pi_disciplina_id;
    
   RETURN v_media_disciplina;
END retorna_media_disciplina;

SET SERVEROUTPUT ON
DECLARE
   v_media_disciplina NUMBER;
BEGIN 
   v_media_disciplina := retorna_media_disciplina(pi_disciplina_id => 2);
   DBMS_OUTPUT.PUT_LINE('Media Disciplina: ' || v_media_disciplina);                   
END;

--Exemplifique a cria��o de uma package com especifica��o, corpo, procedure e fun��o, que seja compil�vel.
CREATE OR REPLACE PACKAGE ALUNOS AS
   SUBTYPE S_RECORD IS ALUNO%ROWTYPE;
   
   PROCEDURE INSERIR(pio_registro IN OUT S_RECORD);
   
   FUNCTION RETORNA_SITUACAO_ALUNO( pi_aluno_id      NUMBER
                                  , pi_disciplina_id NUMBER
                                  ) RETURN VARCHAR2;
END ALUNOS;


CREATE OR REPLACE PACKAGE BODY ALUNOS AS
   
   PROCEDURE INSERIR(pio_registro IN OUT S_RECORD)IS
   BEGIN
      INSERT INTO aluno
      VALUES pio_registro;
   END INSERIR;
   
   FUNCTION RETORNA_SITUACAO_ALUNO( pi_aluno_id      NUMBER
                                  , pi_disciplina_id NUMBER
                                  ) RETURN VARCHAR2 IS
      v_situacao matricula.situacao%type;                            
   BEGIN
      SELECT situacao
        INTO v_situacao
        FROM matricula
       WHERE disciplina_id = pi_disciplina_id
         AND aluno_id = pi_aluno_id;
         
       RETURN v_situacao;  
   END RETORNA_SITUACAO_ALUNO;
END ALUNOS;

DECLARE 
   v_record ALUNOS.S_RECORD;
BEGIN
   v_record.nome := 'Gabriel';
   v_record.data_nasc := TO_DATE('29/12/1999');
   ALUNOS.INSERIR(pio_registro => v_record);
END;

SET SERVEROUTPUT ON
DECLARE 
   v_situacao matricula.situacao%type;
BEGIN
   v_situacao := ALUNOS.RETORNA_SITUACAO_ALUNO( pi_aluno_id      => 5
                                              , pi_disciplina_id => 2
                                              );
   DBMS_OUTPUT.PUT_LINE('Situa��o Aluno: ' || v_situacao);                                           
END;

--Exemplifique a utiliza��o de Bulk Collect. 
SET SERVEROUTPUT ON
DECLARE
   TYPE matricula_table_type IS TABLE OF matricula%ROWTYPE
     INDEX BY BINARY_INTEGER;

   matricula_table  matricula_table_type;
BEGIN
   SELECT *
     BULK COLLECT INTO matricula_table
     FROM matricula;

   FOR i IN 1 .. matricula_table.COUNT LOOP
     DBMS_OUTPUT.PUT_LINE('id: ' || matricula_table(i).id || 
                          ' - Nota: ' || matricula_table(i).nota || 
                          ' - Situa��o: ' || matricula_table(i).situacao || 
                          ' - aluno_id: ' || matricula_table(i).aluno_id || 
                          ' - disciplina_id: ' || matricula_table(i).disciplina_id );
   END LOOP;
END;