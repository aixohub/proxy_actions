// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:proxy_actions_ios/proxy_actions_ios.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Quick Actions Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String shortcut = 'no action set';
  String _platformVersion = 'Unknown';
  final _proxyCmdPlugin = ProxyActionsIos();

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    String platformVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
    // We also handle the message potentially returning null.
    try {
      platformVersion = await _proxyCmdPlugin.getPlatformVersion() ??
          'Unknown platform version';
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
    });
  }

  @override
  void initState() {
    super.initState();
    initPlatformState();
    final ProxyActionsIos quickActions = ProxyActionsIos();
    quickActions.initialize((String shortcutType) {
      setState(() {
        if (shortcutType != null) {
          shortcut = shortcutType;
        }
      });
    });

    quickActions.setShortcutItems(<ShortcutItem>[
      const ShortcutItem(
        type: 'action_one',
        localizedTitle: 'Action one',
        icon: 'AppIcon',
      ),
      const ShortcutItem(
          type: 'action_two',
          localizedTitle: 'Action two',
          icon: 'ic_launcher'),
    ]).then((void _) {
      setState(() {
        if (shortcut == 'no action set') {
          shortcut = 'actions ready';
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(shortcut),
      ),
      body: InkWell(
        onTap: () {
          print('Running on: $_platformVersion\n');
        },
        child: Center(
          child: Text('On home screen, long press the app icon to '
              'get Action one or Action two options. Tapping on that action should  '
              'set the toolbar title.'),
        ),
      ),
    );
  }
}
