import 'package:supabase_flutter/supabase_flutter.dart';

final supabase = Supabase.instance.client;

class Authentication {
  Future<bool> isAdvisor(int id) async {
    dynamic response =
        await supabase.rpc('check_advisor', params: {'id_param': id});
    return response;
  }
}
