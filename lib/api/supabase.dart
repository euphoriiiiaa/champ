import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseInit {
  static final SupabaseInit _instance = SupabaseInit._internal();
  SupabaseClient? supabase;
  bool _isInitialized = false;

  factory SupabaseInit() {
    return _instance;
  }

  SupabaseInit._internal();

  Future<void> init() async {
    if (_isInitialized) {
      return; // Уже инициализирован
    }

    const String url = 'https://smueyuadnkwfxxzkupej.supabase.co';
    const String anonKey =
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InNtdWV5dWFkbmt3Znh4emt1cGVqIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MzE3NDcxMTYsImV4cCI6MjA0NzMyMzExNn0.diZuAMATbCdbuvFeSQafXLHdLLIfJ_3bEA7FbuyWof8';

    await Supabase.initialize(url: url, anonKey: anonKey);

    supabase = Supabase.instance.client;
    _isInitialized = true;
  }

  bool get isInitialized => _isInitialized;

  SupabaseClient get client {
    if (!_isInitialized) {
      throw Exception('Supabase is not initialized');
    }
    return supabase!;
  }
}
