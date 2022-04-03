--alter session set "_oracle_script"=true;  
--create user VazquezJoseAntonioeje1 identified BY VazquezJoseAntonioeje1  ;
--GRANT CONNECT, RESOURCE, DBA TO VazquezJoseAntonioeje1 ;

CREATE TABLE T_MAESTRO(
	suscripcion NUMBER(5),
	alta DATE,
	nombre VARCHAR2(20) NOT NULL,
	direccion VARCHAR2(30) NOT NULL,
	barrio VARCHAR2(16),
	saldoactual NUMBER(10,2),
	estrato NUMBER(5),
	mail VARCHAR2(80) NOT NULL UNIQUE,
	fechaalta DATE,
	CONSTRAINT PK_T_MAESTRO PRIMARY KEY (suscripcion),
	CONSTRAINT CK_T_MAESTRO CHECK(TO_CHAR(fechaalta,'dd/mm/yy')>01/01/1990)
);

CREATE TABLE T_ESTRATO(
	estrato NUMBER(38),
	descripcion VARCHAR2(50),
	totalusuarios NUMBER,
	CONSTRAINT PK_T_ESTRATO PRIMARY KEY (estrato),
	CONSTRAINT CK_T_ESTRATO CHECK(estrato>= 39)
);
ALTER TABLE T_MAESTRO ADD CONSTRAINT FK_T_MAESTRO FOREIGN KEY (estrato) REFERENCES T_ESTRATO(estrato);

CREATE TABLE T_CARGOS(
	idcargo VARCHAR2(2),
	descripcioncargo VARCHAR2(50),
	CONSTRAINT PK_T_CARGOS PRIMARY KEY(idcargo),
	CONSTRAINT CK_T_CARGOS CHECK(idcargo IN ('FC','RC','RF','CO'))
);

CREATE TABLE T_SERVICIOS(
	servicio VARCHAR2(3),
	nservicio NUMBER(4),
	descripcionservicio VARCHAR2(200) NOT NULL,
	cupousuarios NUMBER(6),
	nusuarios NUMBER(10),
	testrato NUMBER,
	importefijo NUMBER(8,2),
	valorconsumo NUMBER(10,2),
	CONSTRAINT PK_T_SERVICIOS PRIMARY KEY (servicio,nservicio),
	CONSTRAINT CK_T_SERVICIOS CHECK(nusuarios >=0),
	CONSTRAINT FK_T_SERVICIOS FOREIGN KEY (testrato) REFERENCES T_ESTRATO(estrato)
);

CREATE TABLE T_MOVIMIENTOS(
	id_cliente NUMBER(5) NOT NULL,
	fechaimporte DATE DEFAULT SYSDATE,
	fechamovimiento DATE,
	cargo_aplicado VARCHAR2(2) NOT NULL,
	servicio VARCHAR2(3) NOT NULL,
	nservicio NUMBER(4) NOT NULL,
	consumo NUMBER(10,2) NOT NULL,
	importefac NUMBER(10,2) NOT NULL,
	importerec NUMBER(10,2) NOT NULL,
	impmorterefa NUMBER(10,2) NOT NULL,
	importeconv NUMBER(10,2) NOT NULL,
	CONSTRAINT PK_T_MOVIMIENTOS PRIMARY KEY(id_cliente,cargo_aplicado,servicio,nservicio),
	CONSTRAINT FK_T_MOVIMIENTOS FOREIGN KEY (cargo_aplicado) REFERENCES T_CARGOS(idcargo),
	CONSTRAINT FK2_T_MOVIMIENTOS FOREIGN KEY (servicio,nservicio) REFERENCES T_SERVICIOS(servicio,nservicio)
);

--Añade el campo dni a la tabla t_maestro, teniendo que ser un campo único.
ALTER TABLE T_MAESTRO ADD COLUMN dni  VARCHAR2(20) NOT NULL; 

--• Elimina el campo barrio de la tabla t_maestro.
ALTER TABLE T_MAESTRO DROP COLUMN barrio;

--• Amplía el campo descripción de la tabla t_estrato en 10 caracteres.
ALTER TABLE T_ESTRATO MODIFY descripcion VARCHAR2(10);

--• Elimina todas las tablas creadas.
--DROP TABLE T_MAESTRO CASCADE CONSTRAINT
--DROP TABLE T_ESTRATO CASCADE CONSTRAINT
--DROP TABLE T_CARGOS CASCADE CONSTRAINT
--DROP TABLE T_SERVICIOS CASCADE CONSTRAINT
--DROP TABLE T_MOVIMIENTOS CASCADE CONSTRAINT

	
	
	
	
	