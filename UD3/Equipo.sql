CREATE TABLE EQUIPOS (
	cod_equipo 		VARCHAR2(4),
	nombre 			VARCHAR2(30) NOT NULL,
	localidad 		VARCHAR2(15),
	CONSTRAINT PK_EQUIPOS PRIMARY KEY (cod_equipo) ,
);

CREATE TABLE JUGADORES(
	cod_jugador 	VARCHAR2(4),
	nombre 			VARCHAR2(30) NOT NULL,
	f_nacimiento 	DATE,
	demarcacion 	VARCHAR2(10),
	cod_equipo 		VARCHAR2(4),
	CONSTRAINT PK_JUGADORES PRIMARY KEY (cod_jugador),
	CONSTRAINT FK_JUGADORES FOREIGN KEY (cod_equipo) REFERENCES EQUIPOS (cod_equipo),
);


CREATE TABLE PARTIDOS (
	cod_partido 	VARCHAR2(4),
	cod_equipo_local VARCHAR2(4),
	cod_equipo_visitante VARCHAR2(4),
	fecha 			DATE,
	competicion 	VARCHAR2(4),
	jornada 		VARCHAR2(20),
	CONSTRAINT PK_PARTIDOS PRIMARY KEY (cod_partido),
	CONSTRAINT FK1_PARTIDOS FOREIGN KEY (cod_equipo_local) REFERENCES EQUIPO(cod_equipo),
	CONSTRAINT FK2_PARTIDOS FOREIGN KEY (cod_equipo_visitante) REFERENCES EQUIPO(cod_equipo),
	CONSTRAINT ck_fecha CHECK (EXTRACT (MONTH FROM FECHA) NOT IN (7,8)),
	CONSTRAINT ck_competicion CHECK (competicion IN ('copa' ,'liga')),
);

CREATE TABLE INCIDENCIAS (
	num_incidencia 	VARCHAR2(6),
	cod_partido 	VARCHAR2(4),
	cod_jugador 	VARCHAR2(4),
	minuto 			NUMBER(2),
	tipo 			VARCHAR2(20),
	CONSTRAINT PK_INCIDENCIAS PRIMARY KEY (num_incidencia)
	CONSTRAINT FK_INCIDENCIAS FOREIGN KEY (cod_partido) REFERENCES PARTIDOS(cod_partido)
	CONSTRAINT FK_INCIDECNIAS FOREIGN KEY (cod_jugador) REFERENCES JUGADORES(cod_jugador)
	CONSTRAINT ck_minuto CHECK (MInuto > 0 AND Minuto <100)
);