import 'dart:convert';

import 'package:appupdater/releases.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:package_info/package_info.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'App Updater',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MainPage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MainPage extends StatefulWidget {
  MainPage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  var resBody;
  bool searching = false, updateAvailable = false;
  String username = "GauthamAsir", repoName = "JioFiStatus";
  GitRelease gitRelease;
  String version;

  Future _getReleases() async {
    setState(() {
      searching = true;
    });

    String url =
        "https://api.github.com/repos/$username/$repoName/releases/latest";

    var res = await http
        .get(Uri.encodeFull(url), headers: {"Accept": "application/json"});

    setState(() {
      resBody = json.decode(res.body);
      gitRelease = GitRelease.fromJson(resBody);
    });

    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    version = packageInfo.version;

    if (double.parse(gitRelease.release_tag_name) > double.parse(version)) {
      setState(() {
        updateAvailable = true;
      });
    } else {
      setState(() {
        updateAvailable = false;
      });
    }
  }

  @override
  void initState() {
    _getReleases();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          updateAvailable
              ? "Update Available  |  $version"
              : "No Updates Available  |  $version",
          textScaleFactor: 2,
        ),
      ),
    );
  }
}
