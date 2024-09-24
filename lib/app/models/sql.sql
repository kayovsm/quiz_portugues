-- import sqlite3

-- # Conectando ao banco de dados (será criado se não existir)
-- conn = sqlite3.connect('quiz.db')
-- cursor = conn.cursor()

-- # Criação da tabela
-- cursor.execute('''
--     CREATE TABLE IF NOT EXISTS perguntas (
--         id INTEGER PRIMARY KEY AUTOINCREMENT,
--         pergunta TEXT,
--         alternativas TEXT,
--         resposta_correta INTEGER,
--         explicacao TEXT,
--         resposta_notifica TEXT
--     )
-- ''')

-- # Dados das perguntas
-- quizDados = [
--     # ... (seus dados de perguntas aqui)
-- ]

-- # Inserção dos dados nas perguntas
-- for pergunta in quizDados:
--     cursor.execute('''
--         INSERT INTO perguntas (pergunta, alternativas, resposta_correta, explicacao, resposta_notifica)
--         VALUES (?, ?, ?, ?, ?)
--     ''', (
--         pergunta['Pergunta'],
--         ', '.join(pergunta['Alternativas']),
--         pergunta['Resposta_Correta'],
--         pergunta['Explicacao'],
--         pergunta['Resposta_notifica']
--     ))

-- # Confirmando as alterações e fechando a conexão
-- conn.commit()
-- conn.close()
