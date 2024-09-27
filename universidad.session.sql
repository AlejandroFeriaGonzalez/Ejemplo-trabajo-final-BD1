-- Se usa solamento SQL stander

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
    tipo VARCHAR(1) NOT NULL CHECK (tipo IN ('P', 'E'))
);

DROP TABLE IF EXISTS PROFESOR;
CREATE TABLE PROFESOR(
    codigo INT(10) PRIMARY KEY,
    oficina VARCHAR(50) NOT NULL,
    area_actuacion VARCHAR(50) NOT NULL,
    facultad VARCHAR(50) NOT NULL,
    FOREIGN KEY (codigo) REFERENCES USUARIO(codigo),
    FOREIGN KEY (facultad) REFERENCES FACULTAD(nombre_facultad)
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
    nombre_facultad VARCHAR(50) PRIMARY KEY,
    numero_contacto INT(10) NOT NULL,
    correo VARCHAR(50) NOT NULL
);

DROP TABLE IF EXISTS ADMINISTRATIVO;
CREATE TABLE ADMINISTRATIVO (
    cedula INT(10) PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    salario INT(10) NOT NULL,
    facultad VARCHAR(50) NOT NULL,
    FOREIGN KEY (facultad) REFERENCES FACULTAD(nombre_facultad)
);

DROP TABLE IF EXISTS SOLICITUD;
CREATE TABLE SOLICITUD(
    codigo INT(10) PRIMARY KEY,
    fecha_solicitud DATE NOT NULL,
    tipo_solicitud VARCHAR(50) NOT NULL,
    valor INT(10) NOT NULL,
    RECEPCIONISTA INT(10) NOT NULL,
    REVISOR INT(10) NOT NULL,
    FOREIGN KEY (RECEPCIONISTA) REFERENCES ADMINISTRATIVO(codigo),
    FOREIGN KEY (REVISOR) REFERENCES ADMINISTRATIVO(codigo)
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
INSERT INTO FACULTAD (nombre_facultad, numero_contacto, correo) VALUES
('Ingenieria', 123456789, 'ingenieria@universidad.edu'),
('Ciencias', 987654321, 'ciencias@universidad.edu'),
('Humanidades', 555555555, 'humanidades@universidad.edu');

-- Insertar datos en la tabla USUARIO
INSERT INTO USUARIO (codigo, nombre, cedula, correo_institucional, correo_personal, genero, numero_telefonico, fecha_nacimiento, tipo) VALUES
(1, 'Juan Perez', 11111111, 'juan.perez@universidad.edu', 'juan.perez@gmail.com', 'M', 123456789, '1990-01-01', 'P'),
(2, 'Maria Gomez', 22222222, 'maria.gomez@universidad.edu', 'maria.gomez@gmail.com', 'F', 987654321, '1992-02-02', 'E'),
(3, 'Luis Martinez', 33333333, 'luis.martinez@universidad.edu', 'luis.martinez@gmail.com', 'M', 555555555, '1991-03-03', 'P'),
(4, 'Ana Torres', 44444444, 'ana.torres@universidad.edu', 'ana.torres@gmail.com', 'F', 666666666, '1993-04-04', 'E'),
(5, 'Pedro Alvarez', 55555555, 'pedro.alvarez@universidad.edu', 'pedro.alvarez@gmail.com', 'M', 777777777, '1994-05-05', 'P'),
(6, 'Lucia Fernandez', 66666666, 'lucia.fernandez@universidad.edu', 'lucia.fernandez@gmail.com', 'F', 888888888, '1995-06-06', 'E'),
(7, 'Miguel Rojas', 77777777, 'miguel.rojas@universidad.edu', 'miguel.rojas@gmail.com', 'M', 999999999, '1996-07-07', 'P'),
(8, 'Sofia Ramirez', 88888888, 'sofia.ramirez@universidad.edu', 'sofia.ramirez@gmail.com', 'F', 111111111, '1997-08-08', 'E');

-- Insertar datos en la tabla PROFESOR
INSERT INTO PROFESOR (codigo, oficina, area_actuacion, facultad) VALUES
(1, 'Oficina 101', 'Matematicas', 'Ciencias'),
(3, 'Oficina 102', 'Filosofia', 'Humanidades');

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

-- Insertar datos en la tabla ADMINISTRATIVO
INSERT INTO ADMINISTRATIVO (cedula, nombre, salario, facultad) VALUES
(33333333, 'Carlos Ruiz', 3000, 'Ingenieria'),
(44444444, 'Laura Sanchez', 3500, 'Humanidades'),
(55555555, 'Pedro Alvarez', 3200, 'Ciencias'),
(66666666, 'Lucia Fernandez', 3400, 'Ingenieria');


-- Insertar datos en la tabla SOLICITUD
INSERT INTO SOLICITUD (codigo, fecha_solicitud, tipo_solicitud, valor, RECEPCIONISTA, REVISOR) VALUES
(1, '2023-01-01', 'Inscripcion', 100, 33333333, 33333333),
(2, '2023-02-01', 'Matricula', 200, 44444444, 44444444),
(3, '2023-03-01', 'Inscripcion', 150, 55555555, 55555555),
(4, '2023-04-01', 'Matricula', 250, 66666666, 66666666),
(5, '2023-05-01', 'Inscripcion', 300, 33333333, 44444444),
(6, '2023-06-01', 'Matricula', 350, 44444444, 33333333);

-- Insertar datos en la tabla DETALLE_CALIFICACION
INSERT INTO DETALLE_CALIFICACION (puntuacion, semestre, grupo, estudiante) VALUES
(90, '2023-1', 1, 2),
(85, '2023-1', 2, 2),
(88, '2023-1', 3, 4),
(92, '2023-1', 4, 4);

-- querys

-- 3 administrativos que mas solicitudes han revisado

SELECT REVISOR, COUNT(*) AS SOLICITUDES_REVISADAS
FROM SOLICITUD
GROUP BY REVISOR
ORDER BY SOLICITUDES_REVISADAS DESC
LIMIT 3;

-- 3 facultades que mas dinero han manejado en solicitudes

SELECT facultad, SUM(valor) AS DINERO_MANEJADO
FROM SOLICITUD
JOIN ADMINISTRATIVO ON RECEPCIONISTA = cedula
GROUP BY facultad
ORDER BY DINERO_MANEJADO DESC
LIMIT 3;