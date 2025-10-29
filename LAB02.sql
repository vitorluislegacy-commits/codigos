USE bd_empresarial;
GO

-- 1
SELECT nom_empregado
FROM funcionario
WHERE des_estado = 'MG';
GO

-- 2
SELECT f.nom_empregado,
       s.nom_empregado AS nom_supervisor
FROM funcionario AS f
LEFT JOIN funcionario AS s
       ON s.num_matricula = f.num_matricula_supervisor;
GO

-- 3
SELECT nom_projeto,
       nom_local
FROM projeto;
GO

-- 4
SELECT nom_dependente,
       relacao
FROM dependente
WHERE sexo = 'M';
GO

-- 5
SELECT nom_empregado,
       des_estado
FROM funcionario
WHERE num_matricula_supervisor IS NULL
  AND des_estado = 'MG';
GO

-- 6
SELECT cod_depto,
       nom_depto
FROM departamento
WHERE num_matricula_gerente IS NULL;
GO

-- 7
SELECT nom_empregado,
       num_salario
FROM funcionario
WHERE sexo = 'F'
  AND num_salario > 1500.00;
GO

-- 8
SELECT nom_projeto,
       dat_fim_projeto
FROM projeto
WHERE dat_fim_projeto IS NOT NULL
  AND YEAR(dat_fim_projeto) = 2005;
GO

-- 9
SELECT nom_projeto,
       DATEDIFF(DAY, dat_inicio_projeto, dat_fim_projeto) AS duracao_dias
FROM projeto
WHERE nom_local IN ('BH', 'RJ', 'SP');
GO

-- 10
SELECT DISTINCT des_cidade,
                des_estado
FROM funcionario;
GO

-- 11
SELECT nom_empregado,
       dat_nascimento
FROM funcionario
ORDER BY dat_nascimento ASC;
GO

-- 12
SELECT nom_empregado,
       num_salario
FROM funcionario
ORDER BY num_salario DESC;
GO

-- 13
SELECT DISTINCT nom_local
FROM projeto
WHERE LOWER(nom_projeto) LIKE '%novo%'
   OR LOWER(nom_projeto) LIKE '%nova%';
GO

-- 14
SELECT nom_projeto
FROM projeto
WHERE LOWER(nom_projeto) LIKE 'criar%'
   OR nom_projeto LIKE '%2005';
GO

-- 15
SELECT TOP (1) nom_empregado,
              num_salario
FROM funcionario
WHERE des_estado = 'MG'
ORDER BY num_salario DESC;
GO

-- 16
IF OBJECT_ID('dbo.equipe', 'U') IS NOT NULL
BEGIN
    DROP TABLE dbo.equipe;
END;
GO

CREATE TABLE dbo.equipe
(
    cod_equipe  SMALLINT NOT NULL,
    nom_equipe  VARCHAR(60) NOT NULL,
    cod_depto   SMALLINT NOT NULL,
    dat_criacao DATE NOT NULL DEFAULT (GETDATE()),
    CONSTRAINT PK_equipe PRIMARY KEY (cod_equipe),
    CONSTRAINT FK_equipe_departamento
        FOREIGN KEY (cod_depto) REFERENCES departamento (cod_depto)
);
GO

-- 17
INSERT INTO dbo.equipe (cod_equipe, nom_equipe, cod_depto, dat_criacao)
VALUES (1, 'Analise', 1, '2008-02-02'),
       (2, 'Desenvolvimento', 2, '2008-02-02');
GO

-- 18
SELECT *
FROM dbo.equipe;
GO

-- 19
INSERT INTO dbo.equipe (cod_equipe, nom_equipe, cod_depto)
VALUES (3, 'Testes', 3),
       (4, 'Suporte', 4);
GO

SELECT *
FROM dbo.equipe;
GO

-- 20
ALTER TABLE dbo.equipe
    ADD id_equipe INT IDENTITY(1, 1) NOT NULL;
GO

-- 21
INSERT INTO dbo.equipe (id_equipe, cod_equipe, nom_equipe, cod_depto)
VALUES (10, 5, 'Rosa', 3);
GO

-- 22
INSERT INTO dbo.equipe (cod_equipe, nom_equipe, cod_depto)
VALUES (5, 'Rosa', 3);
GO

SELECT *
FROM dbo.equipe;
GO

-- 23
DELETE FROM dbo.equipe
WHERE cod_depto = 3;
GO
