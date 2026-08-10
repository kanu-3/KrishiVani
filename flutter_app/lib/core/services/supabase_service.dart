import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseService {
  SupabaseService._();

  static Future<void> initialize() async {
    await Supabase.initialize(
      url: 'https://mozwliwlttuykkyqrcwz.supabase.co',
      anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im1vendsaXdsdHR1eWtreXFyY3d6Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3ODYwMTk1MDIsImV4cCI6MjEwMTU5NTUwMn0.BnbEh4pXdeOln5m6S4lnnGcuzFx39JrlcFxJjSrMbN4',
    );
  }

  static SupabaseClient get client =>
      Supabase.instance.client;
}