import 'package:flutter/material.dart';

/// enumeração para opções de tamanho de fonte
enum FontSizeOption { small, medium, large }

/// classe UtilPreferenceCommon para gerenciar as preferências do usuário
class UtilPreferenceCommon extends ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.system;
  FontSizeOption _fontSizeOption = FontSizeOption.medium;

  /// obtém o modo de tema atual
  ThemeMode get themeMode => _themeMode;

  /// obtém a opção de tamanho de fonte atual
  FontSizeOption get fontSizeOption => _fontSizeOption;

  /// construtor que carrega as preferências do usuário
  UtilPreferenceCommon() {
    _loadUserPreferences();
  }

  /// define o modo de tema e salva as preferências do usuário
  Future<void> setThemeMode(ThemeMode mode) async {
    _themeMode = mode;
    await _saveUserPreferences(); // salva as preferências do usuário
    notifyListeners(); // notifica os ouvintes da mudança
  }

  /// define o tamanho de fonte e salva as preferências do usuário
  Future<void> setFontSize(FontSizeOption option) async {
    _fontSizeOption = option;
    await _saveUserPreferences(); // salva as preferências do usuário
    notifyListeners(); // notifica os ouvintes da mudança
  }

  /// salva as preferências do usuário (implementação comentada)
  Future<void> _saveUserPreferences() async {
    // String fontSize = _fontSizeOption.toString().split('.').last;
    // String theme = _themeMode.toString().split('.').last;
    // await UserDataDB().saveUserPreferences(fontSize, theme);
  }

  /// carrega as preferências do usuário com valores padrão
  Future<void> _loadUserPreferences() async {
    // valor padrão
    Map<String, String> preferences = {'fontSize': 'small', 'theme': 'light'};

    _fontSizeOption = FontSizeOption.values.firstWhere(
      (e) => e.toString().split('.').last == preferences['fontSize'],
    );

    _themeMode = ThemeMode.values.firstWhere(
      (e) => e.toString().split('.').last == preferences['theme'],
    );
    notifyListeners(); // notifica os ouvintes da mudança
  }
}
