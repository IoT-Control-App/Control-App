// import 'dart:convert';
// import 'package:googleapis/assistant/v1.dart';
// import 'package:googleapis_auth/auth_io.dart';
// import 'package:http/http.dart' as http;
// import 'package:path_provider/path_provider.dart';
// import 'dart:io';

// class GoogleAssistantHelper {
//   static const _scopes = ['https://www.googleapis.com/auth/assistant-sdk-prototype'];

//   Future<AuthClient> getClient() async {
//     final directory = await getApplicationDocumentsDirectory();
//     final filePath = '${directory.path}/google_service_account.json';

//     // Ensure the file is present
//     final file = File(filePath);
//     if (!file.existsSync()) {
//       throw Exception("Google service account file not found at: $filePath");
//     }

//     final serviceAccount = json.decode(file.readAsStringSync());
//     return await clientViaServiceAccount(ServiceAccountCredentials.fromJson(serviceAccount), _scopes);
//   }

//   Future<void> sendCommand(String command) async {
//     final client = await getClient();
//     final assistant = AssistantApi(client);
//     // Assuming the projectId is present in the JSON file
//     final projectId = serviceAccount['project_id'];

//     // Send a command to the Google Assistant
//     await assistant.projects.agent.invoke(InvokeRequest(
//       command: command,
//       projectId: projectId,
//     ));
//   }
// }
