USE santa_busca;

CREATE TABLE IF NOT EXISTS alertas_preco (
  id VARCHAR(64) PRIMARY KEY,
  usuario VARCHAR(64) NOT NULL,
  chave VARCHAR(255) NOT NULL,
  produto VARCHAR(150) NOT NULL,
  marca VARCHAR(100) NULL,
  estabelecimento VARCHAR(150) NOT NULL,
  preco_alvo DECIMAL(10,2) NOT NULL,
  ativo TINYINT(1) NOT NULL DEFAULT 1,
  criado_em DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  atualizado_em DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  INDEX idx_alertas_usuario (usuario),
  INDEX idx_alertas_chave (chave),
  INDEX idx_alertas_ativos (usuario, ativo)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS notificacoes_preco (
  id VARCHAR(64) PRIMARY KEY,
  usuario VARCHAR(64) NOT NULL,
  produto VARCHAR(150) NOT NULL,
  marca VARCHAR(100) NULL,
  estabelecimento VARCHAR(150) NOT NULL,
  preco DECIMAL(10,2) NOT NULL,
  preco_alvo DECIMAL(10,2) NOT NULL,
  tipo VARCHAR(40) NOT NULL DEFAULT 'preco_baixou',
  data_registro DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  INDEX idx_notificacoes_usuario (usuario),
  INDEX idx_notificacoes_data (usuario, data_registro)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS buscas (
  id VARCHAR(64) PRIMARY KEY,
  usuario VARCHAR(64) NULL,
  consulta VARCHAR(180) NOT NULL,
  consulta_normalizada VARCHAR(180) NOT NULL,
  mes CHAR(7) NOT NULL,
  data_registro DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  INDEX idx_buscas_mes (mes),
  INDEX idx_buscas_consulta (consulta_normalizada),
  INDEX idx_buscas_mes_consulta (mes, consulta_normalizada)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS visualizacoes_estabelecimentos (
  id VARCHAR(64) PRIMARY KEY,
  estabelecimento_id VARCHAR(64) NOT NULL,
  sessao VARCHAR(64) NULL,
  mes CHAR(7) NOT NULL,
  data_registro DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  INDEX idx_views_estabelecimento (estabelecimento_id),
  INDEX idx_views_mes (mes),
  INDEX idx_views_estabelecimento_mes (estabelecimento_id, mes),
  CONSTRAINT fk_view_estabelecimento FOREIGN KEY (estabelecimento_id) REFERENCES estabelecimentos(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

