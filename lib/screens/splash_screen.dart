import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:parentdesk_uai/utils/helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    new Future.delayed(const Duration(seconds: 3), versi);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Image.asset(
                  LOGO_UAI_IMAGE
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.1),
              Center(
                child: CircularProgressIndicator(),
              )
            ],
          ),
        )
      ),
    );
  }

  void splash() async {
    var url = BASE_URL + "login/splashscreen/format/json";

    var response = await post(
        Uri.parse(url), body: {
      "token": TOKEN_BODY,
    }, headers: {
      'token': TOKEN_HEADER,
      'Authorization': 'Basic ' + BASIC_AUTH,
    });
    // print(url);
    print("splash=" + response.body);

    SharedPreferences prefs = await SharedPreferences.getInstance();

    Map<String, dynamic> decodedMap = json.decode(response.body);
    String status = decodedMap["status"];

    if (status == "TRUE") {
      prefs.setString("bg_img", decodedMap["data"]);
    }

    bool isLogged = prefs.getBool("logged") ?? false;
    if (isLogged) {
      Navigator.pushReplacementNamed(context, '/main');
    } else {
      Navigator.pushReplacementNamed(context, '/login');
    }
  }

  void versi() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    String projectVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      projectVersion = packageInfo.version;
    } on PlatformException {
      projectVersion = 'Failed to get project version.';
    }

    var url = BASE_URL + "login/adaVersiTerbaru/format/json";

    var response = await post(Uri.parse(url), body: {
      "token": TOKEN_BODY,
      "versi": projectVersion
    }, headers: {
      'token': TOKEN_HEADER,
      'Authorization': 'Basic ' + BASIC_AUTH,
    });

    print("versi=" + response.body);

    Map<String, dynamic> decodedMap = json.decode(response.body);
    String status = decodedMap["status"];
    if (status == "FALSE") {
      splash();
    } else if (status == "TRUE") {
      alert(
          "Sudah tersedia aplikasi terbaru StudentDesk UAI. Silahkan melakukan update terlebih dahulu melalui playstore",
          context);
    }
  }
}
