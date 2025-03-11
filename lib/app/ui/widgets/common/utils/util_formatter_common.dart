import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class UtilFormatterCommon {
  /// converte uma string de data no formato 'dd/MM/yyyy' para um objeto DateTime
  /// [dateString]: a string de data a ser convertida
  /// retorna um objeto DateTime ou null se a string de data for inválida
  static DateTime? parseDateString(String? dateString) {
    if (dateString != null && dateString != '') {
      // converte a string de data para DateTime
      return DateFormat('dd/MM/yyyy').parse(dateString);
    } else {
      // retorna null se a string de data for inválida
      return null;
    }
  }

  /// converte uma string de horário no formato 'HH:mm' para um objeto TimeOfDay
  /// [timeString]: a string de horário a ser convertida
  /// retorna um objeto TimeOfDay ou null se a string de horário for inválida
  static TimeOfDay? parseTimeStringToTimeOfDay(String? timeString) {
    if (timeString != null && timeString != '') {
      // extrai a hora e os minutos da string de horário e cria um TimeOfDay
      return TimeOfDay(
        hour: int.parse(timeString.split(':')[0]),
        minute: int.parse(timeString.split(':')[1]),
      );
    } else {
      // retorna null se a string de horário for inválida
      return null;
    }
  }

  /// converte um objeto DateTime para uma string no formato 'dd/MM/yyyy'
  /// [date]: o objeto DateTime a ser formatado
  /// retorna uma string formatada ou uma string vazia se a data for nula
  static String formatDateToString(DateTime? date) {
    if (date != null) {
      // formata o DateTime para uma string
      return DateFormat('dd/MM/yyyy').format(date);
    } else {
      // retorna uma string vazia se a data for nula
      return '';
    }
  }

  /// converte um objeto TimeOfDay para uma string no formato 'HH:mm'
  /// [time]: o objeto TimeOfDay a ser formatado
  /// retorna uma string formatada ou uma string vazia se o horário for nulo
  static String formatTimeOfDayToString(TimeOfDay? time) {
    if (time != null) {
      // formata o TimeOfDay para uma string
      return '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}';
    } else {
      // retorna uma string vazia se o horário for nulo
      return '';
    }
  }

  /// converte a duração em segundos para uma string no formato 'MM:SS'
  /// [totalSeconds]: a duração em segundos a ser formatada
  /// retorna uma string formatada no formato 'MM:SS'
  static String formatDurationToTimeString(int totalSeconds) {
    // calcula os minutos
    int minutes = totalSeconds ~/ 60;
    // calcula os segundos restantes
    int seconds = totalSeconds % 60;
    // formata a duração como uma string
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  /// converte uma string de tempo no formato 'MM:SS' para a duração em segundos
  /// [formattedTime]: a string de tempo a ser convertida
  /// retorna a duração em segundos
  static int convertTimeStringToSeconds(String formattedTime) {
    // divide a string em minutos e segundos
    List<String> parts = formattedTime.split(':');
    // converte os minutos para int
    int minutes = int.parse(parts[0]);
    // converte os segundos para int
    int seconds = int.parse(parts[1]);
    // calcula a duração total em segundos
    return minutes * 60 + seconds;
  }
}
