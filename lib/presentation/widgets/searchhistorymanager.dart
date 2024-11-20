import 'package:shared_preferences/shared_preferences.dart';

class SearchHistoryManager {
  static const String _searchHistoryKey = 'search_history';

  // Сохраняем историю поиска
  Future<void> saveSearchHistory(List<String> history) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(_searchHistoryKey, history);
  }

  // Загружаем историю поиска
  Future<List<String>> loadSearchHistory() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList(_searchHistoryKey) ?? [];
  }

  // Добавляем новый запрос в историю поиска
  Future<void> addSearchQuery(String query) async {
    final history = await loadSearchHistory();
    history.insert(0, query);
    await saveSearchHistory(history);
  }

  // Очищаем историю поиска
  Future<void> clearSearchHistory() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_searchHistoryKey);
  }
}
