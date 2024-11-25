import 'package:get_it/get_it.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseInit {
  Future<void> init() async {
    const String url = 'https://smueyuadnkwfxxzkupej.supabase.co';
    const String anonKey =
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InNtdWV5dWFkbmt3Znh4emt1cGVqIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MzE3NDcxMTYsImV4cCI6MjA0NzMyMzExNn0.diZuAMATbCdbuvFeSQafXLHdLLIfJ_3bEA7FbuyWof8';

    final supabase = await Supabase.initialize(url: url, anonKey: anonKey);

    final SupabaseClient client = supabase.client;
    GetIt.I.registerSingleton<SupabaseClient>(client);
  }
}
