import 'package:bbs_utilv2/providers/powerShellScriptProvider.dart';
import 'package:flutter/material.dart';
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
                const Text("Create powershell Script"),
                const SizedBox(
                  width: 8,
                ),
                Hero(
                  tag: "Powershell Script",
                  child: Image.asset(
                    "images/file.png",
                    height: 20,
                  ),
                ),
              ],
            )),
            body: Container(
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
                        decoration: WidgetStyles.textFieldDecor("Server Ip"),
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
                            decoration:
                                WidgetStyles.textFieldDecor("Status Code"),
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
                              backgroundColor:
                                  MaterialStatePropertyAll(Colors.redAccent),
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
                      incidentSequence: provider.statusCodeList.join(' ⮕ '),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    ElevatedButton.icon(
                        icon: const Icon(Icons.file_copy_outlined),
                        label: const Text('Import Terminals'),
                        style: const ButtonStyle(
                            padding: MaterialStatePropertyAll(
                                EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 11))),
                        onPressed: () => provider.loadCsvFromStorage(),),
                        const SizedBox(height: 10,),
                        ElevatedButton.icon(
                        icon: const Icon(Icons.start),
                        label: const Text('Generate'),
                        style: const ButtonStyle(
                            padding: MaterialStatePropertyAll(
                                EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 11))),
                        onPressed: () => provider.createScript(),),
                  ],
                )),
          );
        });
  }
}
