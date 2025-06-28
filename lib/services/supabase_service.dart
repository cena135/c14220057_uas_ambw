import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseService {
  static final supabase = Supabase.instance.client;

  static Future<AuthResponse> signUp(String email, String password) async {
    return await supabase.auth.signUp(email: email, password: password);
  }

  static Future<AuthResponse> signIn(String email, String password) async {
    return await supabase.auth.signInWithPassword(email: email, password: password);
  }

  static Future<void> signOut() async {
    await supabase.auth.signOut();
  }

  static Future<void> addActivity(String title, String time, String category) async {
    final user = supabase.auth.currentUser;
    await supabase.from('activities').insert({
      'user_id': user?.id,
      'title': title,
      'time': time,
      'category': category,
      'done': false,
    });
  }

  static Future<List<dynamic>> getActivities() async {
    final user = supabase.auth.currentUser;
    if (user == null) {
      return [];
    }
    final res = await supabase.from('activities').select().eq('user_id', user.id);
    return res;
  }

  static Future<void> markDone(int id, bool done) async {
    await supabase.from('activities').update({'done': done}).eq('id', id);
  }

  static Future<void> deleteActivity(int id) async {
    await supabase.from('activities').delete().eq('id', id);
  }
}