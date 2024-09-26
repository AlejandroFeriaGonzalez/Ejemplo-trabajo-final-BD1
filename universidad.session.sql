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
CREATE TABLE PROGRAMA_ACADEMICOS(
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
