## Visão da tabela student purchases
SELECT 
	*
FROM
	student_purchases;

## Renomear a coluna date_purchased para date_start

ALTER TABLE student_purchases
CHANGE date_purchased date_start DATE;


## Adicionar coluna date_end

ALTER TABLE student_purchases
ADD COLUMN date_end DATE;

## Fazer o cálculo do da data final a partir da colunna date_start e plan_ID

UPDATE student_purchases 
SET date_end =IFNULL(date_refunded,CASE 
    WHEN plan_id = 0 THEN DATE_ADD(date_start, INTERVAL 1 MONTH)
    WHEN plan_id = 1 THEN DATE_ADD(date_start, INTERVAL 3 MONTH)
    WHEN plan_id = 2 THEN DATE_ADD(date_start, INTERVAL 12 MONTH)
    ELSE date_end
END);
        
        
## Criando a coluna paid_q2_2021 e paid_q2_2022 e adicionando a uma tabela de visualização

CREATE VIEW purchases_info AS
SELECT
    purchase_id,
    student_id,
    date_start,
    date_end,
    CASE 
        WHEN ((YEAR(date_start) = 2021 AND MONTH(date_start) BETWEEN 4 AND 6)) THEN 1
        ELSE 0
    END AS paid_q2_2021,
    CASE 
        WHEN ((YEAR(date_start) = 2022 AND MONTH(date_start) BETWEEN 4 AND 6)) THEN 1
        ELSE 0
    END AS paid_q2_2022
FROM
    student_purchases;
## Pegando a visualização criada
SELECT 
	*
FROM
	purchases_info;
    
## Calculando os minutos totais assistidos em Q1 2021 e Q2 2022

## Q1 2021
SELECT 
	student_id, SUM(seconds_watched) AS seconds_watched
FROM 
	student_video_watched
WHERE (MONTH(date_watched) BETWEEN 4 AND 6) AND (YEAR(date_watched)= 2021)
GROUP BY student_id; 

## Q2 2022

SELECT 
	student_id, SUM(seconds_watched) AS seconds_watched
FROM 
	student_video_watched
WHERE (MONTH(date_watched) BETWEEN 4 AND 6) AND (YEAR(date_watched)= 2022)
GROUP BY student_id; 

## Dados estudantes  que não pagaram inscrição em Q2 2021

SELECT 
    a.student_id,
    SUM(a.seconds_watched)/60 AS minutes_watched,
    IF(i.student_id IS NOT NULL, 1, 0) AS paid_in_q2
FROM
    (SELECT 
			student_id, SUM(seconds_watched) AS seconds_watched
	FROM 
			student_video_watched
	WHERE (MONTH(date_watched) BETWEEN 4 AND 6) AND (YEAR(date_watched)= 2021)
	GROUP BY student_id) a
        LEFT JOIN
    purchases_info i ON a.student_id = i.student_id
GROUP BY a.student_id
HAVING paid_in_q2 = 0;

## Dados estudantes que pagaram inscrição em Q2_2021
 SELECT 
    a.student_id,
    SUM(a.seconds_watched)/60 AS minutes_watched,
    IF(MAX(i.student_id IS NOT NULL), 1, 0) AS paid_in_q2
FROM
    (SELECT 
			student_id, SUM(seconds_watched) AS seconds_watched
	FROM 
			student_video_watched
	WHERE (MONTH(date_watched) BETWEEN 4 AND 6) AND (YEAR(date_watched)= 2021)
	GROUP BY student_id) a
        LEFT JOIN
    purchases_info i ON a.student_id = i.student_id
GROUP BY a.student_id
HAVING paid_in_q2 = 1;

## Dados estudantes que pagaram inscrição em Q2_2022

SELECT 
    a.student_id,
    SUM(a.seconds_watched)/60 AS minutes_watched,
    IF(MAX(i.student_id IS NOT NULL), 1, 0) AS paid_in_q2
FROM
    (SELECT 
			student_id, SUM(seconds_watched) AS seconds_watched
	FROM 
			student_video_watched
	WHERE (MONTH(date_watched) BETWEEN 4 AND 6) AND (YEAR(date_watched)= 2022)
	GROUP BY student_id) a
        LEFT JOIN
    purchases_info i ON a.student_id = i.student_id
GROUP BY a.student_id
HAVING paid_in_q2 = 1;

## Dados estudantes que não pagaram inscrição em Q2_2022

SELECT 
    a.student_id,
    SUM(a.seconds_watched)/60 AS minutes_watched,
    IF(MAX(i.student_id IS NOT NULL), 1, 0) AS paid_in_q2
FROM
    (SELECT 
			student_id, SUM(seconds_watched) AS seconds_watched
	FROM 
			student_video_watched
	WHERE (MONTH(date_watched) BETWEEN 4 AND 6) AND (YEAR(date_watched)= 2022)
	GROUP BY student_id) a
        LEFT JOIN
    purchases_info i ON a.student_id = i.student_id
GROUP BY a.student_id
HAVING paid_in_q2 = 0;

## Contagem de certificado para cada aluno (separado por student_id)
SELECT 
	a.student_id,
    a.certificates_issued,
    IFNULL(SUM(w.seconds_watched)/60,0) as  minutes_watched
FROM 
	(SELECT 
		student_id,
		COUNT(certificate_id) as certificates_issued 
	FROM
		student_certificates
	GROUP BY student_id) a
		LEFT JOIN
	student_video_watched w ON a.student_id = w.student_id
GROUP BY a.student_id,a.certificates_issued;

############################################################

# -- Evento A: O estudante assistiria uma aula em Q2 2021
# -- Evento B: O estudante assistiria uma aula em Q2 2022

# Contagem de alunos que assistem no Q2 2021
SELECT 
	COUNT(DISTINCT student_id) AS students_Q2_2021
FROM
	student_video_watched
WHERE (MONTH(date_watched) BETWEEN 4 AND 6) AND (YEAR(date_watched)= 2021);	
## Existem 7639 dados

# Contagem de alunos que assistem no Q2 2022
SELECT 
	COUNT(DISTINCT student_id) AS students_Q2_2022
FROM
	student_video_watched
WHERE (MONTH(date_watched) BETWEEN 4 AND 6) AND (YEAR(date_watched)= 2022);		
## Existem 8841 dados

## Contagem de amostra que assistiram tanto Q2 2021 e Q2 2022
    SELECT 
    COUNT(DISTINCT student_id)
FROM
    (SELECT DISTINCT
        student_id
    FROM
        student_video_watched
    WHERE
        YEAR(date_watched) = 2021) a JOIN (SELECT DISTINCT
        student_id
    FROM
        student_video_watched
    WHERE
        YEAR(date_watched) = 2022) b using(student_id);
## Existem 640 dados

## Número total de estudantes que assistiram a aula
SELECT 
    COUNT(DISTINCT student_id)
FROM
    student_video_watched;
## Retornaram 15840 dados

-- P_A = 7639 / 15840 = 0.48
-- P_B = 8841 / 15840 = 0.56
-- P_A_intersecção_P_B = 640 /15840 = 0.04

-- P(B|A) = 640 / 7639 = 0.084
-- P(A|B) = P(B|A) * P_A / P_B = 0.084 * 0.48 / 0.56 = 0.072
	