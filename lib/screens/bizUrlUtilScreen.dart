import 'package:bbs_utilv2/providers/bizurlUtilProvider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';

import '../constants/widgetStyles.dart';
import '../widgets/customRunButton.dart';
import '../widgets/incidentSequenceWidget.dart';

class BizUrlUtilScreen extends StatelessWidget {
  const BizUrlUtilScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ButtonStyle style = ElevatedButton.styleFrom(
        textStyle: const TextStyle(fontSize: 20),
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10));
    var size = MediaQuery.of(context).size;
    return ChangeNotifierProvider(
        create: (context) => BizUrlProvider(),
        builder: (context, child) {
          final provider = Provider.of<BizUrlProvider>(context);
          return Scaffold(
              appBar: AppBar(
                title: Row(children: [
                  Text("Bizurl Util",style: GoogleFonts.ubuntu(textStyle: const TextStyle()),),
                  const SizedBox(width: 8,),
                  Hero(tag: "BizUrl", child: Image.asset("images/api.png",height: 20,),)
                ],)
               
              ),
              body: Stack(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                          width: size.width * 0.2,
                          child: TextField(
                            controller: provider.serverIpInput,
                            decoration: WidgetStyles.textFieldDecor("Server Ip"),
                          ),
                        ),
                        const SizedBox(height: 8,),
                        Row(
                          children: [
                            SizedBox(
                              width: size.width * 0.2,
                              child: TextField(
                                controller: provider.statusCodeInput,
                                decoration: WidgetStyles.textFieldDecor("Status Code"),
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
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: IncidentSequenceWidget(
                                                      incidentSequence: provider.statusCodeList.join(' ⮕ '),
                                                    ),
                            ),
                            const SizedBox(width: 5,),
                        Container(
                          padding: EdgeInsets.all(8),
                          height: size.height*0.2,
                          width: size.width*0.3,
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(6),color: Colors.grey.shade900),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [

                            Text("Total teminal imported: ${provider.totalTerminalImported}"),
                            Text("Total requests count: ${provider.totalTerminalImported*provider.statusCodeList.length}"),
                            Text("Total request sent: ${provider.totalRequestSent}"),
                            Text("Failed requests: ${provider.totalFailedRequest}"),

                          ]),
                        )
                          ],
                        ),
                        const SizedBox(height: 10,)
,                        Text(
                          "Import you Terminal Ids (.csv)",
                          style: GoogleFonts.ubuntu(
                              textStyle:
                                  const TextStyle(fontStyle: FontStyle.italic,color: Colors.grey)),
                        ),
                        const SizedBox(height: 10,),
                        ElevatedButton.icon(
                          icon: const Icon(Icons.file_copy_outlined),
                          label: const Text('Import Terminals'),
                          style: const ButtonStyle(
                              padding: MaterialStatePropertyAll(
                                  EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 11))),
                          onPressed: () => provider.loadCsvFromStorage(),
                        ),
                        const SizedBox(height: 10,),
                        Row(
                          children: [
                            Expanded(
                              child: Container(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 15),
                                height: size.height * 0.3,
                                width: size.width * 0.4,
                                decoration: const BoxDecoration(
                                    color: Colors.black,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10))),
                                child: provider.logsView.isNotEmpty
                                    ? ListView.builder(
                                        shrinkWrap: true,
                                        controller: provider.scrollController,
                                        itemCount: provider.logsView.length,
                                        itemBuilder: ((context, index) =>
                                            provider.logsView[index]))
                                    : const Center(
                                        child: Text("No logs yet 🙃"),
                                      ),
                              ),
                            ),
                            const SizedBox(
                              width: 30,
                            ),
                            StreamBuilder<int>(
                              stream: provider.stopWatchTimer.rawTime,
                              initialData: 0,
                              builder: (context, snap) {
                                final value = snap.data;
                                final displayTime =
                                    StopWatchTimer.getDisplayTime(value!);
                                return Column(
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.all(8),
                                      child: Text(
                                        displayTime,
                                        style: GoogleFonts.ubuntu(textStyle: const TextStyle(
                                            fontSize: 40,
                                            fontWeight: FontWeight.bold),)
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8),
                                      child: Text(
                                        value.toString(),
                                        style: const TextStyle(
                                            fontSize: 16,
                                            fontFamily: 'Helvetica',
                                            fontWeight: FontWeight.w400),
                                      ),
                                    ),
                                  ],
                                );
                              },
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  RunButton(
                    onPress: provider.isValid()
                        ? () {
                            provider.runSequence();
                          }
                        : null,
                  )
                ],
              ));
        });
  }

  
}
