import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'dart:convert';

class JSONReader {
  String fileName = 'myTrickJSON';
  String stringJSON;
  Map<String, dynamic> jsonData = {};
  Map<String, dynamic> newTrickMap;
  Map<String, dynamic> initialTrickMap = {
    'streetTricks': [
      'OLLIE',
      'NOLLIE',
      'FAKIE OLLIE',
      'POP SHUV IT',
      'FRONT SHUV',
      'FAKIE SHUV',
      'FAKIE FRONT SHUV',
      'NOLLIE SHUV',
      'NOLLIE FRONT SHUV',
      'SWITCH SHUV',
      'SWITCH FRONT SHUV',
      'FRONT 180',
      'BACK 180',
      'HALF CAB',
      'FAKIE FRONT 180',
      'NOLLIE BACK 180',
      'NOLLIE FRONT 180',
      'SWITCH 180',
      'SWITCH BACK 180',
      'CAB',
      'FAKIE FRONT 360',
      'FRONT 360',
      'BACK 360',
      'KICKFLIP',
      'FAKIE FLIP',
      'BACKSIDE FLIP',
      'HALF CAB FLIP',
      'HEELFLIP',
      'BONELESS',
      'BONELESS 180',
      'BONELESS 360',
      'OLLIE NORTH',
      'OLLIE SEX CHANGE',
      'BIGSPIN',
      'FAKIE BIGSPIN',
      'NOLLIE BIGSPIN',
      'FAKIE FRONT BIGSPIN',
      'NO COMPLY 180' '50-50',
      'BACK 50-50',
      'BOARDSLIDE'
    ],
    'transitionTricks': [
      'ROCK TO FAKIE',
      'ROCK AND ROLL',
      'FRONT ROCK',
      'DROP IN',
      'FRONT SLASH',
      'BACK SLASH',
      'FRONT AXIAL',
      'BACK AXIAL',
      'FRONT 50-50',
      'BACK 50-50',
      'SWITCH ROCK',
      'HALF CAB ROCK',
      'TAIL STALL',
      'BOARDSLIDE',
      'FAKIE AXIAL',
      'FAKIE FRONT AXIAL',
      'FRONT 5-0',
      'BACK 5-0',
      'FAKIE FRONT 5-0',
      'FAKIE BACK 5-0',
      'BLUNT',
      'BACKSIDE AIR',
      'FRONTSIDE AIR',
      'SWEEPER'
    ],
  };
  File filePath;
  bool fileExists;
  JSONReader({this.newTrickMap});

  Future<String> get localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> get localFile async {
    final path = await localPath;
    return File('$path/$fileName');
  }

  void writeJSON(Map jsonInput) async {
    filePath = await localFile;
    stringJSON = jsonEncode(jsonInput);
    filePath.writeAsString(stringJSON);
  }

  Future<Map> readJSON() async {
    filePath = await localFile;
    fileExists = await filePath.exists();
    if (fileExists == true) {
      try {
        stringJSON = await filePath.readAsString();
        jsonData = jsonDecode(stringJSON);
      } catch (e) {
        print('Issue reading file: $e');
      }
    } else {
      try {
        writeJSON(initialTrickMap);
        stringJSON = await filePath.readAsString();
        jsonData = jsonDecode(stringJSON);
      } catch (e) {
        print('Issue reading file: $e');
      }
    }
    return jsonData;
  }
}
