import 'package:bbs_utilv2/providers/powerShellScriptProvider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:provider/provider.dart';

import '../constants/widgetStyles.dart';
import '../widgets/incidentSequenceWidget.dart';

class PowerShellScriptScreen extends StatelessWidget {
  const PowerShellScriptScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return ChangeNotifierProvider(
        create: ((context) => PowerShellScriptProvider()),
        builder: (context, child) {
          final provider = Provider.of<PowerShellScriptProvider>(context);
          return Scaffold(
              appBar: AppBar(
                  title: Row(
                children: [
                  const Text("Script Util"),
                  const SizedBox(
                    width: 8,
                  ),
                  Hero(
                    tag: "Script Util",
                    child: Image.asset(
                      "images/file.png",
                      height: 20,
                    ),
                  ),
                ],
              )),
              body: Stack(
                children: [
                  Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 10,
                          ),
                          SizedBox(
                            width: size.width * 0.2,
                            child: TextField(
                              controller: provider.serverIpInput,
                              decoration:
                                  WidgetStyles.textFieldDecor("Server Ip"),
                            ),
                          ),

                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              SizedBox(
                                width: size.width * 0.2,
                                child: TextField(
                                  controller: provider.statusCodeInput,
                                  decoration: WidgetStyles.textFieldDecor(
                                      "Status Code"),
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              ElevatedButton.icon(
                                icon: const Icon(Icons.add),
                                label: const Text("Add"),
                                style: const ButtonStyle(
                                    padding: MaterialStatePropertyAll(
                                        EdgeInsets.symmetric(
                                            horizontal: 10, vertical: 11))),
                                onPressed: () => provider.addStatusCode(),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              ElevatedButton.icon(
                                icon: const Icon(Icons.cancel),
                                label: const Text("Remove"),
                                style: const ButtonStyle(
                                    backgroundColor: MaterialStatePropertyAll(
                                        Colors.redAccent),
                                    padding: MaterialStatePropertyAll(
                                        EdgeInsets.symmetric(
                                            horizontal: 10, vertical: 11))),
                                onPressed: () => provider.removeStatusCode(),
                              )
                            ],
                          ),
                          // ignore: prefer_const_constructors
                          SizedBox(
                            height: 10,
                          ),
                          IncidentSequenceWidget(
                            incidentSequence:
                                provider.statusCodeList.join(' ⮕ '),
                          ),
                          const SizedBox(
                            height: 10,
                          ),

                          ElevatedButton.icon(
                            icon: const Icon(Icons.file_download),
                            label: const Text('Import Terminals'),
                            style: const ButtonStyle(
                                padding: MaterialStatePropertyAll(
                                    EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 11))),
                            onPressed: () => provider.loadCsvFromStorage(),
                          ),
                          const SizedBox(
                            height: 17,
                          ),
                          Text(
                            "Command to run script",
                            style: GoogleFonts.ubuntu(
                                textStyle: const TextStyle(
                                    fontWeight: FontWeight.w500, fontSize: 17)),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text('1. Open Windows Powershell',
                              style: GoogleFonts.aBeeZee(
                                  textStyle: const TextStyle(
                                      fontWeight: FontWeight.w300,
                                      color: Colors.amber))),
                          Row(
                            children: [
                              Text('2. Run ::  ${provider.scriptCommand}',
                                  style: GoogleFonts.aBeeZee(
                                      textStyle: const TextStyle(
                                          fontWeight: FontWeight.w300,
                                          color: Colors.amber))),
                              IconButton(
                                  onPressed: () {
                                    Clipboard.setData(ClipboardData(
                                        text: provider.scriptCommand));
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(SnackBar(
                                      elevation: 5,
                                      backgroundColor: Colors.blueGrey,
                                      content: Text(
                                        "Copied 😀!! ${provider.scriptCommand} ",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ));
                                  },
                                  icon: const Icon(Icons.copy)),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          LinearPercentIndicator(
                            width: 230.0,
                            lineHeight: 20.0,
                            percent: provider.scriptWrittenProgress,
                            animation: true,
                            center: Text("${provider.scriptWrittenProgress*100}% "),
                            barRadius: const Radius.circular(5),
                            backgroundColor: Colors.grey.shade700,
                            progressColor: Colors.blueAccent,
                          ),
                        ],
                      )),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Row(
                      children: [
                        Expanded(
                          child: ElevatedButton.icon(
                            icon: const Icon(Icons.start),
                            label: const Text('Generate'),
                            style: ButtonStyle(
                                backgroundColor: MaterialStatePropertyAll(
                                    provider.isValid()
                                        ? Colors.green
                                        : Colors.grey.shade800),
                                padding: const MaterialStatePropertyAll(
                                    EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 15))),
                            onPressed: provider.isValid()
                                ? () => provider.createScript()
                                : null,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ));
        });
  }
}
