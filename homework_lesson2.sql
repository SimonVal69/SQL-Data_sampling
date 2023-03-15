-- Database: skypro

-- DROP DATABASE IF EXISTS skypro;

CREATE DATABASE skypro
    WITH
    OWNER = postgres
    ENCODING = 'UTF8'
    LC_COLLATE = 'Russian_Russia.1251'
    LC_CTYPE = 'Russian_Russia.1251'
    TABLESPACE = pg_default
    CONNECTION LIMIT = -1
    IS_TEMPLATE = False;

COMMENT ON DATABASE skypro
    IS 'База данных для выполнения домашних заданий';

-- Table: employee

-- DROP TABLE IF EXISTS employee;

CREATE TABLE IF NOT EXISTS employee
(
    id BIGSERIAL NOT NULL PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    gender VARCHAR(6) NOT NULL,
    age INT NOT NULL
);

ALTER TABLE IF EXISTS employee
    OWNER to postgres;

INSERT INTO employee(
    first_name, last_name, gender, age)
VALUES
    ('John', 'Smith', 'male', 35),
    ('Thom', 'Soyer', 'male', 40),
    ('Sarah', 'Jackson', 'female', 28),
    ('Linda', 'Hamilton', 'female', 33),
    ('Paul', 'Simpson', 'male', 53);

/* Получите информацию об именах и фамилиях по всем сотрудникам */
SELECT first_name AS ИМЯ,
       last_name AS ФАМИЛИЯ
FROM employee;

/* Получите всю информацию о сотрудниках, которые младше 30 или старше 50 лет */
SELECT first_name AS ИМЯ,
       last_name AS ФАМИЛИЯ
FROM employee
WHERE age < 30
   OR age > 50;

/* Получите всю информацию о сотрудниках, которым от 30 до 50 лет */
SELECT first_name AS ИМЯ,
       last_name AS ФАМИЛИЯ
FROM employee
WHERE age BETWEEN 30 AND 50;

/* Выведите полный список сотрудников, которые отсортированы по фамилиям в обратном порядке */
SELECT first_name AS ИМЯ,
       last_name AS ФАМИЛИЯ
FROM employee
ORDER BY last_name DESC;

/* Выведите сотрудников, имена которых длиннее 4 символов */
SELECT first_name AS ИМЯ,
       last_name AS ФАМИЛИЯ
FROM employee
WHERE LENGTH (first_name) > 4;

/* Измените имена у двух сотрудников так, чтобы на 5 сотрудников было только 3 разных имени, то есть чтобы получились две пары тезок и один сотрудник с уникальным именем */
UPDATE employee
SET last_name='Smith'
WHERE id=2;

UPDATE employee
SET last_name='Hamilton'
WHERE id=3;

/* Посчитайте суммарный возраст для каждого имени. Выведите в двух столбцах «имя» и «суммарный возраст» */
SELECT last_name AS ФАМИЛИЯ,
       SUM(age) AS СУММАРНЫй_ВОЗРАСТ
FROM employee
GROUP BY last_name;

/* Выведите имя и самый юный возраст, соответствующий имени */
SELECT first_name AS ИМЯ,
       age AS ВОЗРАСТ
FROM employee
WHERE age = (
    SELECT MIN(age)
    FROM employee
);

/* Выведите имя и максимальный возраст только для неуникальных имен. Результат отсортируйте по возрасту в порядке возрастания */
SELECT last_name AS ФАМИЛИЯ,
       COUNT(last_name) AS КОЛИЧЕСТВО_ОДНОФАМИЛЬЦЕВ,
       MAX(age) AS МАКСИМАЛЬНЫЙ_ВОЗРАСТ
FROM employee
GROUP BY last_name
HAVING COUNT(last_name) > 1
ORDER BY MAX(age);