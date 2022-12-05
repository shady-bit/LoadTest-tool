import 'dart:convert';
import 'dart:io';
import 'package:csv/csv.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:path_provider/path_provider.dart';


class PowerShellScriptProvider with ChangeNotifier {
  late TextEditingController serverIpInput = TextEditingController();
  late TextEditingController statusCodeInput = TextEditingController();
  double scriptWrittenProgress = 0;
  late String importFilePath = "";
  late List<List<dynamic>> terminalList = [];
  late List<String> statusCodeList = [];
  bool isReadytoRun = false;
  String scriptCommand = "powershell -ExecutionPolicy Bypass -File .\\Documents\\RezyScript.ps1";

  void updateServerIpField(String value) {
    serverIpInput.text = value;
    notifyListeners();
  }

  void updatestatusCodeField(String value) {
    statusCodeInput.text = value;
    notifyListeners();
  }

  loadCsvFromStorage() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowedExtensions: ['csv'],
      type: FileType.custom,
    );
    String? path = result!.files.first.path;
    debugPrint(path);
    final terminalList = await loadingCsvData(path!);
    this.terminalList = terminalList;
    notifyListeners();
  }

  Future<List<List<dynamic>>> loadingCsvData(String path) async {
    final csvFile = File(path).openRead();
    return await csvFile
        .transform(utf8.decoder)
        .transform(
          const CsvToListConverter(
            textDelimiter: '#',
          ),
        )
        .toList();
  }

  void addStatusCode() {
    if (statusCodeInput.text.isNotEmpty) {
      statusCodeList.add(statusCodeInput.text);
      statusCodeInput.clear();
    }
    debugPrint(statusCodeList.length.toString());
    notifyListeners();
  }

  void removeStatusCode() {
    if (statusCodeList.isNotEmpty) {
      statusCodeList.removeLast();
    }
    notifyListeners();
  }

  bool isValid() {
    if (statusCodeList.isNotEmpty &&
        terminalList.isNotEmpty &&
        serverIpInput.text.isNotEmpty) {
      return true;
    }
    return false;
  }

  void createScript() async {
    int count = 0;
    final directory = await getApplicationDocumentsDirectory();
    debugPrint(directory.path);
    if (isValid()) {
      File f1 = File('${directory.path}\\RezyScript.ps1');
      int tts = statusCodeList.length * terminalList.length;
      for (int i = 0; i < statusCodeList.length; i++) {
        for (int j = 0; j < terminalList.length; j++) {
          // debugPrint(
          //     "terminal: ${terminalList[j]} statuscode: ${statusCodeList[i]}");
          try {
            f1.writeAsStringSync(
                "Invoke-WebRequest 'https://${serverIpInput.text}/incident-service/status/${terminalList[j][0]}/${statusCodeList[i]}/load-test/load-test/load-test'\n",
                mode: FileMode.append);
          } catch (e) {
            debugPrint(e.toString());
          }
          count++;
          scriptWrittenProgress = count/tts;
        }
      }
    }
    notifyListeners();
  }
 
}
