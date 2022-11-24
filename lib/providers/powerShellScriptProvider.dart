// ignore_for_file: unnecessary_brace_in_string_interps

import 'dart:convert';
import 'dart:io';
import 'package:csv/csv.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:path_provider/path_provider.dart';


class PowerShellScriptProvider with ChangeNotifier{
  late TextEditingController serverIpInput = TextEditingController();
  late TextEditingController statusCodeInput = TextEditingController();
  late String importFilePath = "";
  late List<List<dynamic>> terminalList = [];
  late List<String> statusCodeList = [];
  bool isReadytoRun = false;


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

  void createScript() async{
    final directory = await getApplicationDocumentsDirectory();
    String filename = DateTime.now().millisecondsSinceEpoch.toString();
    debugPrint(directory.toString());
    File f1 = File("${directory} \$ ${filename}.txt");
    f1.writeAsStringSync("Good");
  }

}