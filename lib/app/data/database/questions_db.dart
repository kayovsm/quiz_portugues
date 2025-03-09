import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../models/question_model.dart';

class QuestionsDB {
  late Database _database;

  Future<void> initializeDatabase() async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, 'quiz.db');
    _database = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        return db.execute('''
          CREATE TABLE questions(
            id INTEGER PRIMARY KEY,
            pergunta TEXT,
            alternativas TEXT,
            resposta_correta INTEGER,
            explicacao TEXT,
            resposta_notifica TEXT
          )
        ''');
      },
    );
  }

  Future<Database> get database async {
    if (!_database.isOpen) {
      await initializeDatabase();
    }
    return _database;
  }

  Future<void> insertQuestion(QuestionModel question) async {
    final db = await database;

    await db.insert('questions', {
      'id': question.id,
      'pergunta': question.question,
      'alternativas': question.options.join(','),
      'resposta_correta': question.correctAnswerIndex,
      'explicacao': question.explanation,
      'resposta_notifca': question.correctAnswerText,
    });
  }

  Future<List<QuestionModel>> getQuestions() async {
    final db = await database;
    final questionsData = await db.query('questions');
    return questionsData.map((data) {
      final alternativas = (data['alternativas'] as String).split(',');
      return QuestionModel(
        id: data['id'] as int,
        question: data['question'] as String,
        options: alternativas,
        correctAnswerIndex: data['correctAnswerIndex'] as int,
        explanation: data['explanation'] as String,
        correctAnswerText: data['correctAnswerText'] as String,
      );
    }).toList();
  }
}
