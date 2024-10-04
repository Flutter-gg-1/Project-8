import 'package:supabase_flutter/supabase_flutter.dart';

import 'client/supabase_mgr.dart';

class SupabaseCart {
  static final SupabaseClient supabase = SupabaseMgr.shared.supabase;
  static final String tableKey = 'order';
}
