// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:proxy_actions_platform_interface/method_channel/method_channel_proxy_actions.dart';
import 'package:proxy_actions_platform_interface/types/shortcut_item.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('$MethodChannelProxyActions', () {
    final MethodChannelProxyActions proxyActions = MethodChannelProxyActions();

    final List<MethodCall> log = <MethodCall>[];

    setUp(() {
      proxyActions.channel
          .setMockMethodCallHandler((MethodCall methodCall) async {
        log.add(methodCall);
        return '';
      });

      log.clear();
    });

    group('#initialize', () {
      test('passes getLaunchAction on launch method', () {
        proxyActions.initialize((String type) {});

        expect(
          log,
          <Matcher>[
            isMethodCall('getLaunchAction', arguments: null),
          ],
        );
      });

      test('initialize', () async {
        final Completer<bool> proxyActionsHandler = Completer<bool>();
        await proxyActions
            .initialize((_) => proxyActionsHandler.complete(true));
        expect(
          log,
          <Matcher>[
            isMethodCall('getLaunchAction', arguments: null),
          ],
        );
        log.clear();

        expect(proxyActionsHandler.future, completion(isTrue));
      });
    });

    group('#setShortCutItems', () {
      test('passes shortcutItem through channel', () {
        proxyActions.initialize((String type) {});
        proxyActions.setShortcutItems(<ShortcutItem>[
          const ShortcutItem(
              type: 'test', localizedTitle: 'title', icon: 'icon.svg')
        ]);

        expect(
          log,
          <Matcher>[
            isMethodCall('getLaunchAction', arguments: null),
            isMethodCall('setShortcutItems', arguments: <Map<String, String>>[
              <String, String>{
                'type': 'test',
                'localizedTitle': 'title',
                'icon': 'icon.svg',
              }
            ]),
          ],
        );
      });

      test('setShortcutItems with demo data', () async {
        const String type = 'type';
        const String localizedTitle = 'localizedTitle';
        const String icon = 'icon';
        await proxyActions.setShortcutItems(
          const <ShortcutItem>[
            ShortcutItem(type: type, localizedTitle: localizedTitle, icon: icon)
          ],
        );
        expect(
          log,
          <Matcher>[
            isMethodCall(
              'setShortcutItems',
              arguments: <Map<String, String>>[
                <String, String>{
                  'type': type,
                  'localizedTitle': localizedTitle,
                  'icon': icon,
                }
              ],
            ),
          ],
        );
        log.clear();
      });
    });

    group('#clearShortCutItems', () {
      test('send clearShortcutItems through channel', () {
        proxyActions.initialize((String type) {});
        proxyActions.clearShortcutItems();

        expect(
          log,
          <Matcher>[
            isMethodCall('getLaunchAction', arguments: null),
            isMethodCall('clearShortcutItems', arguments: null),
          ],
        );
      });

      test('clearShortcutItems', () {
        proxyActions.clearShortcutItems();
        expect(
          log,
          <Matcher>[
            isMethodCall('clearShortcutItems', arguments: null),
          ],
        );
        log.clear();
      });
    });
  });

  group('$ShortcutItem', () {
    test('Shortcut item can be constructed', () {
      const String type = 'type';
      const String localizedTitle = 'title';
      const String icon = 'foo';

      const ShortcutItem item =
          ShortcutItem(type: type, localizedTitle: localizedTitle, icon: icon);

      expect(item.type, type);
      expect(item.localizedTitle, localizedTitle);
      expect(item.icon, icon);
    });
  });
}
