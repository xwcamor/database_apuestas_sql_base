-- Tablas Core del Deporte y Eventos
CREATE TABLE Deportes (
    deporte_id INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(100) NOT NULL
);

CREATE TABLE Ligas (
    liga_id INT PRIMARY KEY AUTO_INCREMENT,
    deporte_id INT NOT NULL,
    nombre VARCHAR(100) NOT NULL,
    region VARCHAR(50),
    FOREIGN KEY (deporte_id) REFERENCES Deportes(deporte_id)
);

CREATE TABLE Equipos (
    equipo_id INT PRIMARY KEY AUTO_INCREMENT,
    liga_id INT NOT NULL,
    nombre VARCHAR(100) NOT NULL,
    logo_url VARCHAR(255),
    FOREIGN KEY (liga_id) REFERENCES Ligas(liga_id)
);

CREATE TABLE Jugadores (
    jugador_id INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(100) NOT NULL,
    fecha_nacimiento DATE,
    pais VARCHAR(50)
);

CREATE TABLE Temporadas (
    temporada_id INT PRIMARY KEY AUTO_INCREMENT,
    liga_id INT NOT NULL,
    anio_inicio INT NOT NULL,
    anio_fin INT NOT NULL,
    FOREIGN KEY (liga_id) REFERENCES Ligas(liga_id)
);

CREATE TABLE Tipos_Evento (
    tipo_evento_id INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(50) NOT NULL
);

CREATE TABLE Sedes_Evento (
    sede_id INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(100) NOT NULL,
    ubicacion VARCHAR(255)
);

CREATE TABLE Eventos (
    evento_id INT PRIMARY KEY AUTO_INCREMENT,
    tipo_evento_id INT NOT NULL,
    temporada_id INT NOT NULL,
    nombre VARCHAR(255) NOT NULL,
    fecha_hora DATETIME NOT NULL,
    sede_id INT,
    FOREIGN KEY (tipo_evento_id) REFERENCES Tipos_Evento(tipo_evento_id),
    FOREIGN KEY (temporada_id) REFERENCES Temporadas(temporada_id),
    FOREIGN KEY (sede_id) REFERENCES Sedes_Evento(sede_id)
);

CREATE TABLE Eventos_Detalles (
    evento_detalle_id INT PRIMARY KEY AUTO_INCREMENT,
    evento_id INT NOT NULL,
    descripcion TEXT,
    estado VARCHAR(50),
    FOREIGN KEY (evento_id) REFERENCES Eventos(evento_id)
);

CREATE TABLE Equipos_Evento (
    evento_id INT NOT NULL,
    equipo_id INT NOT NULL,
    rol VARCHAR(50),
    PRIMARY KEY (evento_id, equipo_id),
    FOREIGN KEY (evento_id) REFERENCES Eventos(evento_id),
    FOREIGN KEY (equipo_id) REFERENCES Equipos(equipo_id)
);

CREATE TABLE Jugadores_Evento (
    evento_id INT NOT NULL,
    jugador_id INT NOT NULL,
    equipo_id INT NOT NULL,
    rol VARCHAR(50),
    PRIMARY KEY (evento_id, jugador_id),
    FOREIGN KEY (evento_id) REFERENCES Eventos(evento_id),
    FOREIGN KEY (jugador_id) REFERENCES Jugadores(jugador_id),
    FOREIGN KEY (equipo_id) REFERENCES Equipos(equipo_id)
);

CREATE TABLE Resultados (
    resultado_id INT PRIMARY KEY AUTO_INCREMENT,
    evento_id INT NOT NULL,
    marcador_local VARCHAR(10),
    marcador_visitante VARCHAR(10),
    fecha_actualizacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (evento_id) REFERENCES Eventos(evento_id)
);

CREATE TABLE Estadisticas_Evento (
    estadistica_evento_id INT PRIMARY KEY AUTO_INCREMENT,
    evento_id INT NOT NULL,
    nombre_estadistica VARCHAR(100) NOT NULL,
    valor_local VARCHAR(50),
    valor_visitante VARCHAR(50),
    FOREIGN KEY (evento_id) REFERENCES Eventos(evento_id)
);

CREATE TABLE Estadisticas_Jugador_Evento (
    estadistica_jugador_evento_id INT PRIMARY KEY AUTO_INCREMENT,
    evento_id INT NOT NULL,
    jugador_id INT NOT NULL,
    nombre_estadistica VARCHAR(100) NOT NULL,
    valor VARCHAR(50),
    FOREIGN KEY (evento_id) REFERENCES Eventos(evento_id),
    FOREIGN KEY (jugador_id) REFERENCES Jugadores(jugador_id)
);

CREATE TABLE Arbitros (
    arbitro_id INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(100) NOT NULL,
    nacionalidad VARCHAR(50)
);

CREATE TABLE Arbitros_Evento (
    evento_id INT NOT NULL,
    arbitro_id INT NOT NULL,
    rol VARCHAR(50),
    PRIMARY KEY (evento_id, arbitro_id),
    FOREIGN KEY (evento_id) REFERENCES Eventos(evento_id),
    FOREIGN KEY (arbitro_id) REFERENCES Arbitros(arbitro_id)
);

CREATE TABLE Fases_Torneo (
    fase_id INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(50) NOT NULL,
    orden INT
);

CREATE TABLE Equipos_Torneo (
    torneo_id INT NOT NULL,
    equipo_id INT NOT NULL,
    fase_id INT,
    PRIMARY KEY (torneo_id, equipo_id),
    -- Assuming 'torneo_id' refers to an 'evento_id' of type 'Torneo'
    FOREIGN KEY (torneo_id) REFERENCES Eventos(evento_id),
    FOREIGN KEY (equipo_id) REFERENCES Equipos(equipo_id),
    FOREIGN KEY (fase_id) REFERENCES Fases_Torneo(fase_id)
);

CREATE TABLE Rondas_Evento (
    ronda_id INT PRIMARY KEY AUTO_INCREMENT,
    evento_id INT NOT NULL,
    nombre VARCHAR(50),
    orden INT,
    FOREIGN KEY (evento_id) REFERENCES Eventos(evento_id)
);

CREATE TABLE Lesiones_Jugador (
    lesion_id INT PRIMARY KEY AUTO_INCREMENT,
    jugador_id INT NOT NULL,
    fecha_inicio DATE NOT NULL,
    fecha_fin_estimada DATE,
    descripcion TEXT,
    FOREIGN KEY (jugador_id) REFERENCES Jugadores(jugador_id)
);

CREATE TABLE Suspensiones_Jugador (
    suspension_id INT PRIMARY KEY AUTO_INCREMENT,
    jugador_id INT NOT NULL,
    fecha_inicio DATE NOT NULL,
    fecha_fin DATE NOT NULL,
    motivo VARCHAR(255),
    FOREIGN KEY (jugador_id) REFERENCES Jugadores(jugador_id)
);

-- Tablas de Cuotas y Mercados de Apuestas
CREATE TABLE Mercados_Apuesta (
    mercado_id INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(100) NOT NULL,
    descripcion TEXT
);

CREATE TABLE Opciones_Apuesta (
    opcion_id INT PRIMARY KEY AUTO_INCREMENT,
    mercado_id INT NOT NULL,
    nombre VARCHAR(100) NOT NULL,
    descripcion TEXT,
    FOREIGN KEY (mercado_id) REFERENCES Mercados_Apuesta(mercado_id)
);

CREATE TABLE Tipos_Cuota (
    tipo_cuota_id INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(50) NOT NULL
);

CREATE TABLE Mercados_Evento (
    mercado_evento_id INT PRIMARY KEY AUTO_INCREMENT,
    evento_id INT NOT NULL,
    mercado_id INT NOT NULL,
    activo BOOLEAN DEFAULT TRUE,
    FOREIGN KEY (evento_id) REFERENCES Eventos(evento_id),
    FOREIGN KEY (mercado_id) REFERENCES Mercados_Apuesta(mercado_id)
);

CREATE TABLE Opciones_Mercado_Evento (
    opcion_mercado_evento_id INT PRIMARY KEY AUTO_INCREMENT,
    mercado_evento_id INT NOT NULL,
    opcion_id INT NOT NULL,
    valor_opcion VARCHAR(255),
    FOREIGN KEY (mercado_evento_id) REFERENCES Mercados_Evento(mercado_evento_id),
    FOREIGN KEY (opcion_id) REFERENCES Opciones_Apuesta(opcion_id)
);

CREATE TABLE Cuotas (
    cuota_id INT PRIMARY KEY AUTO_INCREMENT,
    mercado_evento_id INT NOT NULL,
    opcion_mercado_evento_id INT NOT NULL,
    valor DECIMAL(10, 2) NOT NULL,
    fecha_actualizacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (mercado_evento_id) REFERENCES Mercados_Evento(mercado_evento_id),
    FOREIGN KEY (opcion_mercado_evento_id) REFERENCES Opciones_Mercado_Evento(opcion_mercado_evento_id)
);

CREATE TABLE Cuotas_Historicas (
    historial_cuota_id INT PRIMARY KEY AUTO_INCREMENT,
    cuota_id INT NOT NULL,
    valor_anterior DECIMAL(10, 2) NOT NULL,
    fecha_cambio TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (cuota_id) REFERENCES Cuotas(cuota_id)
);

CREATE TABLE Reglas_Mercado (
    regla_mercado_id INT PRIMARY KEY AUTO_INCREMENT,
    mercado_id INT NOT NULL,
    descripcion TEXT,
    FOREIGN KEY (mercado_id) REFERENCES Mercados_Apuesta(mercado_id)
);

CREATE TABLE Margenes_Casa_Apuestas (
    margen_id INT PRIMARY KEY AUTO_INCREMENT,
    mercado_id INT NOT NULL,
    valor DECIMAL(5, 2),
    FOREIGN KEY (mercado_id) REFERENCES Mercados_Apuesta(mercado_id)
);

CREATE TABLE Proveedores_Mercados (
    proveedor_mercado_id INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(100) NOT NULL
);

CREATE TABLE Restricciones_Mercado (
    restriccion_mercado_id INT PRIMARY KEY AUTO_INCREMENT,
    mercado_id INT NOT NULL,
    limite_minimo DECIMAL(10, 2),
    limite_maximo DECIMAL(10, 2),
    FOREIGN KEY (mercado_id) REFERENCES Mercados_Apuesta(mercado_id)
);

CREATE TABLE Combinaciones_Mercado (
    combinacion_id INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(255) NOT NULL,
    mercados_incluidos TEXT
);

CREATE TABLE Cuotas_Especiales (
    cuota_especial_id INT PRIMARY KEY AUTO_INCREMENT,
    evento_id INT NOT NULL,
    mercado_id INT NOT NULL,
    opcion_id INT NOT NULL,
    valor DECIMAL(10, 2) NOT NULL,
    descripcion TEXT,
    FOREIGN KEY (evento_id) REFERENCES Eventos(evento_id),
    FOREIGN KEY (mercado_id) REFERENCES Mercados_Apuesta(mercado_id),
    FOREIGN KEY (opcion_id) REFERENCES Opciones_Apuesta(opcion_id)
);

-- Tablas de Usuarios y Cuentas
CREATE TABLE Monedas (
    moneda_id INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(50) NOT NULL,
    codigo VARCHAR(3) NOT NULL UNIQUE,
    simbolo VARCHAR(5)
);

CREATE TABLE Usuarios (
    usuario_id INT PRIMARY KEY AUTO_INCREMENT,
    username VARCHAR(50) NOT NULL UNIQUE,
    password_hash VARCHAR(255) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    fecha_registro TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE Detalles_Usuario (
    detalle_usuario_id INT PRIMARY KEY AUTO_INCREMENT,
    usuario_id INT NOT NULL UNIQUE,
    nombre VARCHAR(100),
    apellido VARCHAR(100),
    fecha_nacimiento DATE,
    direccion VARCHAR(255),
    pais VARCHAR(50),
    telefono VARCHAR(20),
    FOREIGN KEY (usuario_id) REFERENCES Usuarios(usuario_id)
);

CREATE TABLE Cuentas_Usuario (
    cuenta_id INT PRIMARY KEY AUTO_INCREMENT,
    usuario_id INT NOT NULL UNIQUE,
    saldo DECIMAL(10, 2) DEFAULT 0.00,
    moneda_id INT NOT NULL,
    FOREIGN KEY (usuario_id) REFERENCES Usuarios(usuario_id),
    FOREIGN KEY (moneda_id) REFERENCES Monedas(moneda_id)
);

CREATE TABLE Tipos_Transaccion (
    tipo_transaccion_id INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(50) NOT NULL
);

CREATE TABLE Transacciones (
    transaccion_id INT PRIMARY KEY AUTO_INCREMENT,
    cuenta_id INT NOT NULL,
    tipo_transaccion_id INT NOT NULL,
    monto DECIMAL(10, 2) NOT NULL,
    fecha_hora TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    descripcion TEXT,
    FOREIGN KEY (cuenta_id) REFERENCES Cuentas_Usuario(cuenta_id),
    FOREIGN KEY (tipo_transaccion_id) REFERENCES Tipos_Transaccion(tipo_transaccion_id)
);

CREATE TABLE Bonos (
    bono_id INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(100) NOT NULL,
    descripcion TEXT,
    monto DECIMAL(10, 2) DEFAULT 0.00,
    requisitos TEXT,
    fecha_inicio DATE,
    fecha_fin DATE
);

CREATE TABLE Estados_Bono_Usuario (
    estado_bono_usuario_id INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(50) NOT NULL
);

CREATE TABLE Bonos_Usuario (
    bono_usuario_id INT PRIMARY KEY AUTO_INCREMENT,
    usuario_id INT NOT NULL,
    bono_id INT NOT NULL,
    fecha_asignacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    estado_bono_usuario_id INT NOT NULL,
    FOREIGN KEY (usuario_id) REFERENCES Usuarios(usuario_id),
    FOREIGN KEY (bono_id) REFERENCES Bonos(bono_id),
    FOREIGN KEY (estado_bono_usuario_id) REFERENCES Estados_Bono_Usuario(estado_bono_usuario_id)
);

CREATE TABLE Historial_Login (
    login_id INT PRIMARY KEY AUTO_INCREMENT,
    usuario_id INT NOT NULL,
    fecha_hora TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    ip_address VARCHAR(50),
    user_agent VARCHAR(255),
    FOREIGN KEY (usuario_id) REFERENCES Usuarios(usuario_id)
);

CREATE TABLE Sesiones_Usuario (
    sesion_id VARCHAR(255) PRIMARY KEY,
    usuario_id INT NOT NULL,
    fecha_inicio TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    fecha_ultimo_acceso TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    ip_address VARCHAR(50),
    FOREIGN KEY (usuario_id) REFERENCES Usuarios(usuario_id)
);

CREATE TABLE Verificaciones_Usuario (
    verificacion_id INT PRIMARY KEY AUTO_INCREMENT,
    usuario_id INT NOT NULL UNIQUE,
    estado VARCHAR(50),
    fecha_solicitud TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    fecha_revision TIMESTAMP,
    agente_revision INT,
    FOREIGN KEY (usuario_id) REFERENCES Usuarios(usuario_id)
);

CREATE TABLE Tipos_Documento (
    tipo_documento_id INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(100) NOT NULL
);

CREATE TABLE Documentos_Verificacion (
    documento_id INT PRIMARY KEY AUTO_INCREMENT,
    verificacion_id INT NOT NULL,
    tipo_documento_id INT NOT NULL,
    ruta_archivo VARCHAR(255) NOT NULL,
    fecha_subida TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (verificacion_id) REFERENCES Verificaciones_Usuario(verificacion_id),
    FOREIGN KEY (tipo_documento_id) REFERENCES Tipos_Documento(tipo_documento_id)
);

CREATE TABLE Tipos_Cuota (
    tipo_cuota_id INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(50) NOT NULL
);

CREATE TABLE Preferencias_Usuario (
    preferencia_id INT PRIMARY KEY AUTO_INCREMENT,
    usuario_id INT NOT NULL UNIQUE,
    idioma VARCHAR(50),
    formato_cuota_id INT,
    zona_horaria VARCHAR(50),
    FOREIGN KEY (usuario_id) REFERENCES Usuarios(usuario_id),
    FOREIGN KEY (formato_cuota_id) REFERENCES Tipos_Cuota(tipo_cuota_id)
);

CREATE TABLE Alertas_Usuario (
    alerta_id INT PRIMARY KEY AUTO_INCREMENT,
    usuario_id INT NOT NULL,
    tipo_alerta VARCHAR(100),
    mensaje TEXT,
    fecha_hora TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    leido BOOLEAN DEFAULT FALSE,
    FOREIGN KEY (usuario_id) REFERENCES Usuarios(usuario_id)
);

CREATE TABLE Bancos (
    banco_id INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(100) NOT NULL
);

CREATE TABLE Tarjetas_Usuario (
    tarjeta_id INT PRIMARY KEY AUTO_INCREMENT,
    usuario_id INT NOT NULL,
    numero_tarjeta_hash VARCHAR(255) NOT NULL,
    fecha_expiracion DATE NOT NULL,
    cvv_hash VARCHAR(255) NOT NULL,
    banco_id INT,
    FOREIGN KEY (usuario_id) REFERENCES Usuarios(usuario_id),