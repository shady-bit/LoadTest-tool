// ignore: file_names
import 'package:bbs_utilv2/screens/bizUrlUtilScreen.dart';
import 'package:bbs_utilv2/screens/powerShellScriptScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/config.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sidebarx/sidebarx.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return
        Scaffold(
      body: Container(
        padding: const EdgeInsets.all(30),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(
            "All tools",
            style: GoogleFonts.ubuntu(
                textStyle:
                    const TextStyle(fontSize: 24, fontWeight: FontWeight.w400)),
          ),
          const SizedBox(
            height: 20,
          ),
          Wrap(
            children: [
              ToolWidget(
                size: size,
                title: "BizUrl",
                logoImage: "images/api.png",
                onPress: () {
                  Get.to(() => const BizUrlUtilScreen());
                },
              ),
              const SizedBox(
                width: 15,
              ),
              ToolWidget(
                size: size,
                title: "Script Util",
                logoImage: "images/file.png",
                onPress: () {
                  Get.to(() => const PowerShellScriptScreen());
                },
              ),
              const SizedBox(
                width: 15,
              ),
              ToolWidget(
                size: size,
                title: "TCP",
                logoImage: "images/global.png",
                onPress: () {},
              ),
            ],
          )
        ]),
      ),
    );
  }
}

class ToolWidget extends StatelessWidget {
  final String title;
  final String logoImage;
  final VoidCallback onPress;
  const ToolWidget({
    required this.logoImage,
    required this.title,
    required this.onPress,
    Key? key,
    required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: Container(
        alignment: Alignment.center,
        height: size.height * 0.2,
        width: size.width * 0.2,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10), color: Colors.white),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Hero(
                tag: title,
                child: Image.asset(
                  logoImage,
                  height: 80,
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              Text(
                title,
                style: GoogleFonts.ubuntu(
                    textStyle: const TextStyle(
                        color: Colors.black, fontWeight: FontWeight.w400)),
              )
            ]),
      ),
    );
  }
}
