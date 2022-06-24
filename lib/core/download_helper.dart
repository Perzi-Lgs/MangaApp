import 'dart:io';

import 'package:mobile/core/errors/exception.dart';
import 'package:path_provider/path_provider.dart';

// Exemple : mangaName = OnePiece
//
// return /storage/0/emulated/Android/data/com.mangaPebble.app/OnePiece/
Future<String> getFilePath(String mangaName) async {
  List<Directory>? appDocumentsDirectory = await getExternalStorageDirectories(
      type: StorageDirectory.downloads); // 1

  String appDocumentsPath = appDocumentsDirectory![0].path; // 2
  return '$appDocumentsPath/$mangaName'; // 3
}

// Input: /storage/0/emulated/Android/data/com.mangaPebble.app/OnePiece/0
void saveFile(String path, List<int> rawData) async {
  File file = File(path); // 1
  await file.create(recursive: true);
  file.writeAsBytes(rawData);
}

// void readFile() async {
//   File file = File(await getFilePath()); // 1
//   String fileContent = await file.readAsString(); // 2

// }
