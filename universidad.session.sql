-- Se usa solamento SQL stander

-- TABLA USUARIO CON DOS SUBTIPOS LLAMADOS PROFESOR Y ESTUDIANTE
DROP TABLE IF EXISTS USUARIO;
CREATE TABLE USUARIO(
    codigo INT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    cedula INT NOT NULL,
    correo_institucional VARCHAR(50) NOT NULL,
    correo_personal VARCHAR(50) NOT NULL,
    genero VARCHAR(50) NOT NULL,
    numero_telefonico INT NOT NULL,
    fecha_nacimiento DATE NOT NULL,
    tipo VARCHAR(1) NOT NULL CHECK (tipo IN ('P', 'E'))
);

CREATE TABLE PROFESOR(
    codigo INT PRIMARY KEY,
    oficina VARCHAR(50) NOT NULL,
    area_actuacion VARCHAR(50) NOT NULL,
    facultad VARCHAR(50) NOT NULL,
    FOREIGN KEY (codigo) REFERENCES USUARIO(codigo),
    FOREIGN KEY (facultad) REFERENCES FACULTAD(nombre_facultad)
);

CREATE TABLE ESTUDIANTE(
    codigo INT PRIMARY KEY,
    creditos_aprobados INT NOT NULL,
    FOREIGN KEY (codigo) REFERENCES USUARIO(codigo)
);

CREATE TABLE PREGRADO(
    nivel_formacion VARCHAR(50) PRIMARY KEY -- tecnologico o profesional
);

CREATE TABLE POSGRADO(
    tipo VARCHAR(50) PRIMARY KEY -- Especializaciones, Maestrías o Doctorados.
);

-- programa academico pertenece a pregrado o posgrado
CREATE TABLE PROGRAMA_ACADEMICO(
    nombre VARCHAR(50) PRIMARY KEY,
    codigo INT NOT NULL,
    numero_creditos INT NOT NULL,
    nivel_formacion_pregrado VARCHAR(50) REFERENCES PREGRADO(nivel_formacion),
    tipo_posgrado VARCHAR(50) REFERENCES POSGRADO(tipo),
    CHECK (
        (nivel_formacion_pregrado IS NULL AND tipo_posgrado IS NOT NULL)
        OR
        (nivel_formacion_pregrado IS NOT NULL AND tipo_posgrado IS NULL)
    )
);

CREATE TABLE ASIGNATURA(
    nombre VARCHAR(50) PRIMARY KEY,
    codigo INT NOT NULL,
    numero_creditos INT NOT NULL
);

CREATE TABLE PROGRAMA_ACADEMICO_X_ASIGNATURA(
    programa_academico VARCHAR(50) NOT NULL,
    asignatura VARCHAR(50) NOT NULL,
    FOREIGN KEY (programa_academico) REFERENCES PROGRAMA_ACADEMICOS(nombre),
    FOREIGN KEY (asignatura) REFERENCES ASIGNATURA(nombre)
);

-- PROFESOR_X_ASIGNATURA
CREATE TABLE GRUPO(
    profesor INT NOT NULL,
    asignatura VARCHAR(50) NOT NULL,
    FOREIGN KEY (profesor) REFERENCES PROFESOR(codigo),
    FOREIGN KEY (asignatura) REFERENCES ASIGNATURA(nombre)
);

CREATE TABLE FACULTAD(
    nombre_facultad VARCHAR(50) PRIMARY KEY,
    numero_contacto INT NOT NULL,
    correo VARCHAR(50) NOT NULL
);

CREATE TABLE ADMINISTRATIVO (
    cedula INT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    salario INT NOT NULL,
    facultad VARCHAR(50) NOT NULL,
    FOREIGN KEY (facultad) REFERENCES FACULTAD(nombre_facultad)
);

CREATE TABLE SOLICITUD(
    codigo INT PRIMARY KEY,
    fecha_solicitud DATE NOT NULL,
    tipo_solicitud VARCHAR(50) NOT NULL,
    valor INT NOT NULL,
    RECEPCIONISTA INT NOT NULL,
    REVISOR INT NOT NULL,
    FOREIGN KEY (RECEPCIONISTA) REFERENCES ADMINISTRATIVO(codigo),
    FOREIGN KEY (REVISOR) REFERENCES ADMINISTRATIVO(codigo)
);

CREATE TABLE DETALLE_CALIFICACION(
    puntuacion INT,
    semestre VARCHAR(50) NOT NULL,
    grupo INT NOT NULL,
    estudiante INT NOT NULL,
    FOREIGN KEY (grupo) REFERENCES GRUPO(codigo),
    FOREIGN KEY (estudiante) REFERENCES ESTUDIANTE(codigo)
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
(4, 'Ana Torres', 44444444, 'ana.torres@universidad.edu', 'ana.torres@gmail.com', 'F', 666666666, '1993-04-04', 'E');

-- Insertar datos en la tabla PROFESOR
INSERT INTO PROFESOR (codigo, oficina, area_actuacion, facultad) VALUES
(1, 'Oficina 101', 'Matematicas', 'Ciencias'),
(3, 'Oficina 102', 'Filosofia', 'Humanidades');

-- Insertar datos en la tabla ESTUDIANTE
INSERT INTO ESTUDIANTE (codigo, creditos_aprobados) VALUES
(2, 30),
(4, 45);

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

-- Insertar datos en la tabla PROGRAMA_ACADEMICOS
INSERT INTO PROGRAMA_ACADEMICOS (nombre, codigo, numero_creditos, nivel_formacion_pregrado, tipo_posgrado) VALUES
('Ingenieria de Sistemas', 101, 180, 'Profesional', NULL),
('Maestria en Ciencias', 102, 60, NULL, 'Maestria');
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
(44444444, 'Laura Sanchez', 3500, 'Humanidades');


-- Insertar datos en la tabla SOLICITUD
INSERT INTO SOLICITUD (codigo, fecha_solicitud, tipo_solicitud, valor, RECEPCIONISTA, REVISOR) VALUES
(1, '2023-01-01', 'Inscripcion', 100, 33333333, 33333333),
(2, '2023-02-01', 'Matricula', 200, 44444444, 44444444);

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