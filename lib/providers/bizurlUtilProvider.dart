import 'dart:convert';
import 'dart:io';
import 'package:csv/csv.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:stop_watch_timer/stop_watch_timer.dart';

class BizUrlProvider with ChangeNotifier {
  late TextEditingController serverIpInput = TextEditingController();
  late TextEditingController statusCodeInput = TextEditingController();
  ScrollController scrollController = ScrollController();
  late String importFilePath = "";
  late int totalTerminalImported = 0;
  late int totalRequestSent = 0;
  late int totalFailedRequest = 0;
  late List<List<dynamic>> terminalList = [];
  late List<String> statusCodeList = [];
  bool isReadytoRun = false;
  late List<Widget> logsView = [];
  final StopWatchTimer stopWatchTimer = StopWatchTimer(); 

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
    totalTerminalImported = terminalList.length;
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

  void runSequence() async {
    var client = http.Client();
    String logText = "";
    stopWatchTimer.onStartTimer();
    for (int i = 0; i < statusCodeList.length; i++) {
      for (int j = 0; j < terminalList.length; j++) {
        debugPrint(
            "terminal: ${terminalList[j]} statuscode: ${statusCodeList[i]}");
        try {
          var response = await client.get(Uri.https(
              'random-data-api.com', 'api/v2/users'));
          logText = "${response.statusCode} : ${response.request}";
          debugPrint(logText);
          if (response.statusCode == 200 || response.statusCode == 202) {
            ++totalRequestSent;
            logsView.add(Text(
              logText,
              style: GoogleFonts.sourceCodePro(textStyle: const TextStyle(color: Colors.greenAccent,fontSize: 12,)),
            ));
            _scrollDown();
            notifyListeners();
          }else{
            ++totalFailedRequest;
          }
        } catch (e) {
          debugPrint(e.toString());
        }
      }
    }
     stopWatchTimer.onStopTimer();
     notifyListeners();
  }

  void _scrollDown() {
    SchedulerBinding.instance.addPostFrameCallback((_) {
    scrollController.jumpTo(scrollController.position.maxScrollExtent);
    });
  }

 
}
