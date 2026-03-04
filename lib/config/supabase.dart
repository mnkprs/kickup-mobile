import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class SupabaseConfig {
  /// OAuth redirect URL: .env override on web, current origin, or deep link on native.
  /// Set REDIRECT_URL in .env (e.g. http://localhost:8080) to force localhost during dev.
  static String get authRedirectUrl {
    if (!kIsWeb) return 'kickup://auth/callback';
    final override = dotenv.env['REDIRECT_URL'];
    if (override != null && override.isNotEmpty) return override;
    return Uri.base.origin;
  }

  /// Supabase URL from .env (when loaded) or from --dart-define=SUPABASE_URL.
  static String get url =>
      dotenv.env['SUPABASE_URL'] ??
      const String.fromEnvironment(
        'SUPABASE_URL',
        defaultValue: 'YOUR_SUPABASE_URL',
      );

  /// Supabase anon key from .env (when loaded) or from --dart-define=SUPABASE_ANON_KEY.
  static String get anonKey =>
      dotenv.env['SUPABASE_ANON_KEY'] ??
      const String.fromEnvironment(
        'SUPABASE_ANON_KEY',
        defaultValue: 'YOUR_SUPABASE_ANON_KEY',
      );
}
