import 'dart:async';

import '../platform/plaid_platform_interface.dart';
import 'events.dart';
import 'link_configuration.dart';

/// Provides Plaid Link drop in functionality.
class PlaidLink {
  /// Platform interface
  static PlaidPlatformInterface get _platform =>
      PlaidPlatformInterface.instance;

  /// A broadcast stream for [LinkEvent] from the native platform
  ///   * [name] A string representing the event that has just occurred in the Link flow.
  ///   * [metadata] An [LinkEventMetadata] object containing information about the event.
  /// For more information see https://plaid.com/docs/link/ios/#onevent
  static Stream<LinkEvent> get onEvent =>
      _platform.onObject.where((event) => event is LinkEvent).cast();

  /// A broadcast stream for [LinkSuccess] from the native platform
  ///   * [publicToken] The public token for the linked item. It is a string.
  ///   * [metadata] The additional data related to the link session and account. It is an [LinkSuccessMetadata] object.
  /// For more information see https://plaid.com/docs/link/ios/#onsuccess
  static Stream<LinkSuccess> get onSuccess =>
      _platform.onObject.where((event) => event is LinkSuccess).cast();

  /// A broadcast stream for [LinkExit] from the native platform
  ///   * [error] The error code. (can be null)
  ///   * [metadata] An [LinkExitMetadata] object containing information about the last error encountered by the user (if any), institution selected by the user, and the most recent API request ID, and the Link session ID.
  /// /// For more information see https://plaid.com/docs/link/ios/#onexit
  static Stream<LinkExit> get onExit =>
      _platform.onObject.where((event) => event is LinkExit).cast();

  /// Initializes the Plaid Link flow on the device.
  static Future<void> open({required LinkConfiguration configuration}) async {
    await _platform.open(configuration: configuration);
  }

  /// Closes Plaid Link View
  static Future<void> close() async {
    await _platform.close();
  }

  /// Continue with redirect uri
  static Future<void> continueWithRedirectUri(String redirectUri) async {
    await _platform.continueWithRedirectUri(redirectUri);
  }
}
