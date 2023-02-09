// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';
import 'package:proxy_actions/quick_actions.dart';
import 'package:proxy_actions_platform_interface/quick_actions_platform_interface.dart';

void main() {
  group('$QuickActions', () {
    setUp(() {
      ProxyActionsPlatform.instance = MockQuickActionsPlatform();
    });

    test('constructor() should return valid QuickActions instance', () {
      const QuickActions quickActions = QuickActions();
      expect(quickActions, isNotNull);
    });

    test('initialize() PlatformInterface', () async {
      const QuickActions quickActions = QuickActions();
      void handler(String type) {}

      await quickActions.initialize(handler);
      verify(ProxyActionsPlatform.instance.initialize(handler)).called(1);
    });

    test('setShortcutItems() PlatformInterface', () {
      const QuickActions quickActions = QuickActions();
      void handler(String type) {}
      quickActions.initialize(handler);
      quickActions.setShortcutItems(<ShortcutItem>[]);

      verify(ProxyActionsPlatform.instance.initialize(handler)).called(1);
      verify(ProxyActionsPlatform.instance.setShortcutItems(<ShortcutItem>[]))
          .called(1);
    });

    test('clearShortcutItems() PlatformInterface', () {
      const QuickActions quickActions = QuickActions();
      void handler(String type) {}

      quickActions.initialize(handler);
      quickActions.clearShortcutItems();

      verify(ProxyActionsPlatform.instance.initialize(handler)).called(1);
      verify(ProxyActionsPlatform.instance.clearShortcutItems()).called(1);
    });
  });
}

class MockQuickActionsPlatform extends Mock
    with MockPlatformInterfaceMixin
    implements ProxyActionsPlatform {
  @override
  Future<void> clearShortcutItems() async =>
      super.noSuchMethod(Invocation.method(#clearShortcutItems, <Object?>[]));

  @override
  Future<void> initialize(ProxyActionHandler? handler) async =>
      super.noSuchMethod(Invocation.method(#initialize, <Object?>[handler]));

  @override
  Future<void> setShortcutItems(List<ShortcutItem>? items) async => super
      .noSuchMethod(Invocation.method(#setShortcutItems, <Object?>[items]));
}

class MockQuickActions extends QuickActions {}
