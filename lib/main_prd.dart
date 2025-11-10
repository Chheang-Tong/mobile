import 'app.dart' as app;
import 'core/core.dart';

void main() {
  Env.name = "prd";
  Env.appName = "Mobile App PRD";
  Env.isDebugging = false;
  Env.shouldShowApiLog = true;
  // Env.baseApiUrl = "https://api.uat.example.com";
  app.main();
}
