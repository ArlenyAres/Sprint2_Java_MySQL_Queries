
-- TIENDA 

-- nombre de todos los fabricantes en una columna
SELECT nombre, SUBSTRING(nombre, 1, 2) AS "Dos primeros caracteres" FROM fabricante;

-- Nombres y precios productos redondeado 
SELECT ROUND(precio) AS precio_redondeado FROM producto;

-- Lista de nombre y precio de los productos truncaandi valor de precio
SELECT TRUNCATE(precio, 0) AS precio_truncado FROM producto;

-- Lista el codigo de los fabricantes que tienen productos en la mesa producto
SELECT DISTINCT codigo FROM fabricante WHERE codigo IN (SELECT codigo_fabricante FROM producto);

--  nombres de los fabricantes ordenados de forma ascendente
SELECT nombre FROM fabricante ORDER BY nombre DESC ;

-- Productos ordenados, por el nombre de forma ascendente por el precio de forma descendente
SELECT nombre, precio FROM producto ORDER BY nombre ASC, precio DESC ;

-- 5 Primeras filas de grabricante 
SELECT * FROM fabricante LIMIT 5;

-- nombre y precio del producto mas barato.
SELECT nombre , precio	FROM producto ORDER BY precio ASC LIMIT 1;

-- nombre y precio de producto mas caro
SELECT nombre, precio FROM producto ORDER BY precio DESC LIMIT 1;

-- productos del fabricante codigo = 2
SELECT nombre FROM producto p WHERE codigo_fabricante = 2;

--  nombre del producto, precio y nombre de fabricante de todos los productos, Ordenados el por el nombre del fabricante alfabeltico
SELECT p.nombre, p.precio, f.nombre AS nombre_fabricante FROM producto p JOIN fabricante f ON p.codigo_fabricante = f.codigo ORDER BY f.nombre;

-- 
SELECT p.nombre FROM producto p JOIN fabricante f ON p.codigo_fabricante = f.codigo WHERE f.nombre = 'Lenovo' ORDER BY p.precio DESC LIMIT 1;

-- 
SELECT p.nombre FROM producto p JOIN fabricante f ON p.codigo_fabricante = f.codigo WHERE f.nombre = 'Hewlett-Packard' ORDER BY p.precio ASC LIMIT 1;

-- Utilizando SelecMAX
SELECT p.* FROM producto p WHERE p.precio >= (SELECT MAX(precio) FROM producto  WHERE codigo_fabricante = (SELECT codigo FROM fabricante WHERE nombre = 'Lenovo'));

SELECT fabricante.codigo AS codigo_fabricante, fabricante.nombre AS nombre_fabricante FROM fabricante LEFT JOIN producto ON  fabricante.codigo = producto.codigo_fabricante WHERE producto.codigo_fabricante IS NULL;

-- orden ascendente limite 5
SELECT nombre , precio	FROM producto ORDER BY precio ASC LIMIT 5;

SELECT p.nombre FROM producto p JOIN fabricante f ON p.codigo_fabricante = f.codigo WHERE f.nombre = 'Samsung' ORDER BY p.precio DESC LIMIT 1;

-- Utilizando SelecMAX con otro proveedor
SELECT p.* FROM producto p WHERE p.precio >= (SELECT MAX(precio) FROM producto  WHERE codigo_fabricante = (SELECT codigo FROM fabricante WHERE nombre = 'Huawei'));

 -- Utilizando HAVING COUNT AS LEFT
SELECT f.nombre AS fabricante, COUNT(p.codigo) AS total_productos FROM fabricante f LEFT JOIN producto p ON f.codigo = p.codigo_fabricante GROUP BY f.codigo;

-- con AVG
SELECT codigo_fabricante, AVG(precio) AS precio_promedio FROM producto GROUP BY codigo_fabricante HAVING AVG(precio) > 200;



-- UNIVERSIDAD


-- Listado de alumnos ordenado por apellido y nombre
SELECT apellido1, apellido2, nombre FROM persona WHERE tipo = 'alumno' ORDER BY apellido1, apellido2, nombre;

-- Alunos que no han dado de alta el telefono
SELECT * FROM persona WHERE tipo = 'alumno' AND telefono IS NULL;

-- Alumnos que nacieron en 1999
SELECT * FROM persona WHERE tipo = 'alumno' AND YEAR (fecha_nacimiento)= 1999;

-- Profesores que no  han dado de alta su telefono y su nif
SELECT * FROM persona WHERE tipo= 'profesor' AND telefono IS NULL AND SUBSTRING(nif,-1)= 'K'; 

-- NOmbre de las asignaturas del alumno 26902806M
SELECT a.nombre AS asignatura_nombre, ce.anyo_inicio, ce.anyo_fin FROM alumno_se_matricula_asignatura ama JOIN asignatura a ON ama.id_asignatura = a.id JOIN curso_escolar ce ON ama.id_curso_escolar = ce.id JOIN persona p ON ama.id_alumno = p.id WHERE p.nif = '26902806M';

-- nombre de asignaturas  año de inicio y año de fin del  26902806M
SELECT a.nombre AS asignatura_nombre, ce.anyo_inicio, ce.anyo_fin FROM alumno_se_matricula_asignatura ama JOIN asignatura a ON ama.id_asignatura = a.id JOIN curso_escolar ce ON ama.id_curso_escolar = ce.id JOIN persona p ON ama.id_alumno = p.id WHERE p.nif = '26902806M';

-- Departamentos con profes de ingenieria informatica (2015)
SELECT DISTINCT d.nombre FROM departamento d JOIN profesor p ON d.id = p.id_departamento JOIN asignatura a ON p.id_profesor = a.id_profesor JOIN grado g ON a.id_grado = g.id WHERE g.nombre = 'Grau en Enginyeria Informàtica';

-- departamento que no esta asociado a profesor
SELECT d.* FROM departamento d LEFT JOIN profesor p ON d.id = p.id_departamento WHERE p.id_profesor IS NULL;

-- Profeso que no imparten asiganaturas
SELECT p.* FROM profesor p LEFT JOIN asignatura a ON p.id_profesor = a.id_profesor WHERE a.id_profesor IS NULL;

-- Asignaturas que no tienen porfe
SELECT a.* FROM asignatura a LEFT JOIN profesor p ON a.id_profesor = p.id_profesor WHERE p.id_profesor IS NULL; 

-- departamentos que no imparetn asignaruras 
SELECT d.*
FROM departamento d LEFT JOIN profesor p ON d.id = p.id_departamento LEFT JOIN asignatura a ON p.id_profesor = a.id_profesor WHERE a.id_profesor IS NULL;

-- allunos mateiculados en 2018/2019
SELECT DISTINCT p.nombre, p.apellido1, p.apellido2 FROM persona p JOIN alumno_se_matricula_asignatura ama ON p.id = ama.id_alumno JOIN curso_escolar ce ON ama.id_curso_escolar = ce.id WHERE ce.anyo_inicio = 2018 AND ce.anyo_fin = 2019;

-- departamentos sin profes
SELECT d.* FROM departamento d LEFT JOIN profesor p ON d.id = p.id_departamento WHERE p.id_profesor IS NULL;

-- asignaturas de no se han impartido en ningun curso escolar
SELECT d.* FROM departamento d LEFT JOIN profesor p ON d.id = p.id_departamento LEFT JOIN asignatura a ON p.id_profesor = a.id_profesor WHERE a.id_profesor IS NULL;

-- departamento que tiene mas de dos profes 
SELECT d.nombre, COUNT(p.id_profesor) AS numero_profesores FROM departamento d LEFT JOIN profesor p ON d.id = p.id_departamento GROUP BY d.nombre HAVING COUNT(p.id_profesor) >= 2;

-- personas que su nombre tenga mas 5 caracteres 
SELECT * FROM persona WHERE LENGTH(nombre) > 5;

-- departamentos con el nombre de mas de 15 caracteres
SELECT nombre FROM departamento WHERE LENGTH(nombre) > 15;

-- nombres de los profesores y el departamento en el que enseñan
SELECT p.nombre, d.nombre AS departamento FROM persona p LEFT JOIN profesor pr ON p.id = pr.id_profesor  LEFT JOIN departamento d ON pr.id_departamento = d.id

-- contar las personas de cada sexo en la taba personas
SELECT sexo, COUNT(id) AS numero_personas FROM persona GROUP BY sexo

-- asignaturas que tienen mas de 30 caracteres en su nombre
SELECT nombre FROM asignatura WHERE LENGTH(nombre) > 30;

-- 
SELECT d.* FROM departamento d LEFT JOIN profesor p ON d.id = p.id_departamento LEFT JOIN asignatura a ON p.id_profesor = a.id_profesor WHERE a.id_profesor IS NULL;






