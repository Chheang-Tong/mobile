import 'app.dart' as app;
import 'core/core.dart';

void main() {
  Env.name = "uat";
  Env.appName = "Mobile App UAT";
  Env.isDebugging = true;
  Env.shouldShowApiLog = true;
  // Env.baseApiUrl = "https://api.uat.example.com";
  app.main();
}
