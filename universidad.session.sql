-- Se usa solamento SQL stander
DROP TABLE IF EXISTS solicitud;

-- TABLA USUARIO CON DOS SUBTIPOS LLAMADOS PROFESOR Y ESTUDIANTE
DROP TABLE IF EXISTS USUARIO;
CREATE TABLE USUARIO(
    codigo INT(10) PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    cedula INT(10) NOT NULL,
    correo_institucional VARCHAR(50) NOT NULL,
    correo_personal VARCHAR(50) NOT NULL,
    genero VARCHAR(50) NOT NULL,
    numero_telefonico INT(10) NOT NULL,
    fecha_nacimiento DATE NOT NULL,
    tipo VARCHAR(1) NOT NULL CHECK (tipo IN ('P', 'E')),
    CHECK (correo_institucional LIKE '%@universidad.edu.co')
);

DROP TABLE IF EXISTS PROFESOR;
CREATE TABLE PROFESOR(
    codigo INT(10) PRIMARY KEY,
    oficina VARCHAR(50) NOT NULL,
    area_actuacion VARCHAR(50) NOT NULL,
    facultad VARCHAR(50) NOT NULL,
    FOREIGN KEY (codigo) REFERENCES USUARIO(codigo),
    FOREIGN KEY (facultad) REFERENCES FACULTAD(codigo)
);

DROP TABLE IF EXISTS ESTUDIANTE;
CREATE TABLE ESTUDIANTE(
    codigo INT(10) PRIMARY KEY,
    creditos_aprobados INT(10) NOT NULL,
    FOREIGN KEY (codigo) REFERENCES USUARIO(codigo)
);

DROP TABLE IF EXISTS PREGRADO;
CREATE TABLE PREGRADO(
    nivel_formacion VARCHAR(50) PRIMARY KEY -- tecnologico o profesional
);

DROP TABLE IF EXISTS POSGRADO;
CREATE TABLE POSGRADO(
    tipo VARCHAR(50) PRIMARY KEY -- Especializaciones, Maestrías o Doctorados.
);

-- programa academico pertenece a pregrado o posgrado
DROP TABLE IF EXISTS PROGRAMA_ACADEMICO;
CREATE TABLE PROGRAMA_ACADEMICO(
    nombre VARCHAR(50) PRIMARY KEY,
    codigo INT(10) NOT NULL,
    numero_creditos INT(10) NOT NULL,
    nivel_formacion_pregrado VARCHAR(50) REFERENCES PREGRADO(nivel_formacion),
    tipo_posgrado VARCHAR(50) REFERENCES POSGRADO(tipo),
    CHECK (
        (nivel_formacion_pregrado IS NULL AND tipo_posgrado IS NOT NULL)
        OR
        (nivel_formacion_pregrado IS NOT NULL AND tipo_posgrado IS NULL)
    )
);

DROP TABLE IF EXISTS ASIGNATURA;
CREATE TABLE ASIGNATURA(
    nombre VARCHAR(50) PRIMARY KEY,
    codigo INT(10) NOT NULL,
    numero_creditos INT(10) NOT NULL
);

DROP TABLE IF EXISTS PROGRAMA_ACADEMICO_X_ASIGNATURA;
CREATE TABLE PROGRAMA_ACADEMICO_X_ASIGNATURA(
    programa_academico VARCHAR(50) NOT NULL,
    asignatura VARCHAR(50) NOT NULL,
    FOREIGN KEY (programa_academico) REFERENCES PROGRAMA_ACADEMICO(nombre),
    FOREIGN KEY (asignatura) REFERENCES ASIGNATURA(nombre)
);

-- PROFESOR_X_ASIGNATURA
DROP TABLE IF EXISTS GRUPO;
CREATE TABLE GRUPO(
    profesor INT(10) NOT NULL,
    asignatura VARCHAR(50) NOT NULL,
    FOREIGN KEY (profesor) REFERENCES PROFESOR(codigo),
    FOREIGN KEY (asignatura) REFERENCES ASIGNATURA(nombre)
);

DROP TABLE IF EXISTS FACULTAD;
CREATE TABLE FACULTAD(
    codigo INT(10) PRIMARY KEY,
    nombre VARCHAR(50),
    numero_contacto INT(10) NOT NULL,
    correo_institucional VARCHAR(50) NOT NULL,
    CHECK (correo_institucional LIKE '%@universidad.edu.co')
);

DROP TABLE IF EXISTS ADMINISTRATIVO;
CREATE TABLE ADMINISTRATIVO (
    cedula INT(10) PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    salario INT(10) NOT NULL,
    facultad VARCHAR(50) NOT NULL,
    FOREIGN KEY (facultad) REFERENCES FACULTAD(codigo)
);

-- Tipos de solicitud: Cancelación de asignatura, Trabajo de grado, Reingreso, Derecho de grado
DROP TABLE IF EXISTS SOLICITUD_ACADEMICA;
CREATE TABLE SOLICITUD_ACADEMICA(
    codigo INT(10) PRIMARY KEY,
    fecha_solicitud DATE NOT NULL,
    tipo_solicitud VARCHAR(50) NOT NULL CHECK (tipo_solicitud IN ('Inscripcion', 'Cancelacion', 'Trabajo de grado', 'Reingreso', 'Derecho de grado')),
    valor INT(10) NOT NULL,
    estudiante INT(10) NOT NULL,
    recepcionista INT(10) NOT NULL,
    revisor INT(10) NOT NULL,
    FOREIGN KEY (recepcionista) REFERENCES ADMINISTRATIVO(codigo),
    FOREIGN KEY (revisor) REFERENCES ADMINISTRATIVO(codigo),
    FOREIGN KEY (estudiante) REFERENCES ESTUDIANTE(codigo)
);

DROP TABLE IF EXISTS DETALLE_CALIFICACION;
CREATE TABLE DETALLE_CALIFICACION(
    puntuacion INT(10),
    semestre VARCHAR(50) NOT NULL,
    grupo INT(10) NOT NULL,
    estudiante INT(10) NOT NULL,
    FOREIGN KEY (grupo) REFERENCES GRUPO(codigo),
    FOREIGN KEY (estudiante) REFERENCES ESTUDIANTE(codigo),
    PRIMARY KEY (grupo, estudiante, semestre)
);

-- Insertar datos en la tabla FACULTAD

INSERT INTO FACULTAD (codigo, nombre, numero_contacto, correo_institucional) VALUES
(1, 'Ingenieria', 123456789, 'ingenieria@universidad.edu.co'),
(2, 'Ciencias', 987654321, 'ciencias@universidad.edu.co'),
(3, 'Humanidades', 555555555, 'humanidades@universidad.edu.co'),
(4, 'Economia', 666666666, 'economia@universidad.edu.co');



-- Insertar datos en la tabla USUARIO
INSERT INTO USUARIO (codigo, nombre, cedula, correo_institucional, correo_personal, genero, numero_telefonico, fecha_nacimiento, tipo) VALUES
(1, 'Juan Perez', 11111111, 'juan.perez@universidad.edu.co', 'juan.perez@gmail.com', 'M', 123456789, '1990-01-01', 'P'),
(2, 'Maria Gomez', 22222222, 'maria.gomez@universidad.edu.co', 'maria.gomez@gmail.com', 'F', 987654321, '1992-02-02', 'E'),
(3, 'Luis Martinez', 33333333, 'luis.martinez@universidad.edu.co', 'luis.martinez@gmail.com', 'M', 555555555, '1991-03-03', 'P'),
(4, 'Ana Torres', 44444444, 'ana.torres@universidad.edu.co', 'ana.torres@gmail.com', 'F', 666666666, '1993-04-04', 'E'),
(5, 'Pedro Alvarez', 55555555, 'pedro.alvarez@universidad.edu.co', 'pedro.alvarez@gmail.com', 'M', 777777777, '1994-05-05', 'P'),
(6, 'Lucia Fernandez', 66666666, 'lucia.fernandez@universidad.edu.co', 'lucia.fernandez@gmail.com', 'F', 888888888, '1995-06-06', 'E'),
(7, 'Miguel Rojas', 77777777, 'miguel.rojas@universidad.edu.co', 'miguel.rojas@gmail.com', 'M', 999999999, '1996-07-07', 'P'),
(8, 'Sofia Ramirez', 88888888, 'sofia.ramirez@universidad.edu.co', 'sofia.ramirez@gmail.com', 'F', 111111111, '1997-08-08', 'E');

-- Insertar datos en la tabla PROFESOR
INSERT INTO PROFESOR (codigo, oficina, area_actuacion, facultad) VALUES
(1, 'Oficina 101', 'Matematicas', 2),
(3, 'Oficina 102', 'Filosofia', 3);

-- Insertar datos en la tabla ESTUDIANTE
INSERT INTO ESTUDIANTE (codigo, creditos_aprobados) VALUES
(2, 30),
(4, 45),
(6, 50),
(8, 60);

-- Insertar datos en la tabla PREGRADO
INSERT INTO PREGRADO (nivel_formacion) VALUES
('Tecnologico'),
('Profesional'),
('Tecnico');

-- Insertar datos en la tabla POSGRADO
INSERT INTO POSGRADO (tipo) VALUES
('Especializacion'),
('Maestria'),
('Doctorado'),
('Postdoctorado');

-- Insertar datos en la tabla PROGRAMA_ACADEMICO
INSERT INTO PROGRAMA_ACADEMICO (nombre, codigo, numero_creditos, nivel_formacion_pregrado, tipo_posgrado) VALUES
('Ingenieria de Sistemas', 101, 180, 'Profesional', NULL),
('Maestria en Ciencias', 102, 60, NULL, 'Maestria'),
('Filosofia', 103, 160, 'Profesional', NULL),
('Postdoctorado en Ciencias', 104, 40, NULL, 'Postdoctorado');

-- Insertar datos en la tabla ASIGNATURA
INSERT INTO ASIGNATURA (nombre, codigo, numero_creditos) VALUES
('Matematicas', 201, 5),
('Programacion', 202, 4),
('Etica', 203, 3),
('Logica', 204, 4);

-- Insertar datos en la tabla PROGRAMA_ACADEMICO_X_ASIGNATURA
INSERT INTO PROGRAMA_ACADEMICO_X_ASIGNATURA (programa_academico, asignatura) VALUES
('Ingenieria de Sistemas', 'Matematicas'),
('Ingenieria de Sistemas', 'Programacion'),
('Filosofia', 'Etica'),
('Filosofia', 'Logica');


-- Insertar datos en la tabla GRUPO
INSERT INTO GRUPO (profesor, asignatura) VALUES
(1, 'Matematicas'),
(1, 'Programacion'),
(3, 'Etica'),
(3, 'Logica');


-- Insertar datos en la tabla DETALLE_CALIFICACION
INSERT INTO DETALLE_CALIFICACION (puntuacion, semestre, grupo, estudiante) VALUES
(90, '2023-1', 1, 2),
(85, '2023-1', 2, 2),
(88, '2023-1', 3, 4),
(92, '2023-1', 4, 4);

INSERT INTO ADMINISTRATIVO (cedula, nombre, salario, facultad) VALUES
(11111111, 'Carlos', 1000000, 1),
(22222222, 'Andres', 2000000, 1),
(33333333, 'Juan', 2000000, 2),
(44444444, 'Camilo', 3000000, 3),
(55555555, 'Daniel', 4000000, 4);

INSERT INTO SOLICITUD_ACADEMICA (codigo, fecha_solicitud, tipo_solicitud, valor, estudiante, recepcionista, revisor) VALUES
(1, '2023-1-1', 'Inscripcion', 1000000, 2, 11111111, 11111111),
(2, '2023-1-2', 'Cancelacion', 2000000, 4, 33333333, 11111111),
(3, '2023-1-3', 'Trabajo de grado', 3000000, 6, 11111111, 22222222),
(4, '2023-1-4', 'Reingreso', 4000000, 8, 33333333, 22222222),
(5, '2023-1-5', 'Derecho de grado', 5000000, 2, 11111111, 33333333),
(6, '2023-1-6', 'Inscripcion', 6000000, 4, 33333333, 44444444),--
(7, '2023-1-7', 'Cancelacion', 7000000, 6, 11111111, 44444444),
(8, '2023-1-8', 'Trabajo de grado', 8000000, 8, 33333333, 44444444),
(9, '2023-1-9', 'Reingreso', 9000000, 2, 11111111, 11111111),
(10, '2023-1-10', 'Derecho de grado', 10000000, 4, 33333333, 11111111),
(11, '2023-1-11', 'Inscripcion', 11000000, 6, 11111111, 22222222),
(12, '2023-1-12', 'Cancelacion', 12000000, 8, 33333333, 22222222),
(13, '2023-1-13', 'Trabajo de grado', 13000000, 2, 11111111, 33333333),
(14, '2023-1-14', 'Reingreso', 14000000, 4, 33333333, 33333333),
(15, '2023-1-15', 'Derecho de grado', 15000000, 6, 11111111, 44444444),--
(16, '2023-1-16', 'Inscripcion', 16000000, 8, 33333333, 44444444),
(17, '2023-1-17', 'Cancelacion', 17000000, 2, 11111111, 11111111),
(18, '2023-1-18', 'Trabajo de grado', 18000000, 4, 33333333, 11111111),
(19, '2023-1-19', 'Reingreso', 19000000, 6, 11111111, 55555555),
(20, '2023-1-20', 'Derecho de grado', 20000000, 8, 33333333, 55555555);


-- mostrar todas las solicitudes que ha revisado el empleado de mayor salario de la facultad de Ingenieria, en consulta debe decir textualmento 'Ingenieria'

SELECT * FROM SOLICITUD_ACADEMICA WHERE revisor = (SELECT cedula FROM ADMINISTRATIVO WHERE salario = (SELECT MAX(salario) FROM ADMINISTRATIVO WHERE facultad = (SELECT codigo FROM FACULTAD WHERE nombre = 'Humanidades')));

SELECT * FROM SOLICITUD_ACADEMICA WHERE revisor IN (SELECT cedula FROM ADMINISTRATIVO WHERE facultad = 3 ORDER BY salario DESC LIMIT 1);

SELECT * 
FROM SOLICITUD_ACADEMICA 
JOIN (
    SELECT cedula 
    FROM ADMINISTRATIVO 
    WHERE facultad = 3 
    ORDER BY salario DESC 
    LIMIT 1
) AS top_revisor 
ON SOLICITUD_ACADEMICA.revisor = top_revisor.cedula;