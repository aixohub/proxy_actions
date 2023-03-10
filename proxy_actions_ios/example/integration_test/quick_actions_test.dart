// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:proxy_actions_ios/proxy_actions_ios.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Can set shortcuts', (WidgetTester tester) async {
    final ProxyActionsIos quickActions = ProxyActionsIos();
    await quickActions.initialize((String value) {});

    const ShortcutItem shortCutItem = ShortcutItem(
      type: 'action_one',
      localizedTitle: 'Action one',
      icon: 'AppIcon',
    );
    expect(
        quickActions.setShortcutItems(<ShortcutItem>[shortCutItem]), completes);
  });
}
