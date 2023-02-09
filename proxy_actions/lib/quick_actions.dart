// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:async';

import 'package:proxy_actions_platform_interface/platform_interface/quick_actions_platform.dart';
import 'package:proxy_actions_platform_interface/types/types.dart';

export 'package:proxy_actions_platform_interface/types/types.dart';

/// Quick actions plugin.
class QuickActions {
  /// Creates a new instance of [QuickActions].
  const QuickActions();

  /// Initializes this plugin.
  ///
  /// Call this once before any further interaction with the plugin.
  Future<void> initialize(ProxyActionHandler handler) async =>
      ProxyActionsPlatform.instance.initialize(handler);

  /// Sets the [ShortcutItem]s to become the app's quick actions.
  Future<void> setShortcutItems(List<ShortcutItem> items) async =>
      ProxyActionsPlatform.instance.setShortcutItems(items);

  /// Removes all [ShortcutItem]s registered for the app.
  Future<void> clearShortcutItems() =>
      ProxyActionsPlatform.instance.clearShortcutItems();
}
