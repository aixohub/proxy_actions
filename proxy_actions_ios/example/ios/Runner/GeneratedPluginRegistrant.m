//
//  Generated file. Do not edit.
//

// clang-format off

#import "GeneratedPluginRegistrant.h"

#if __has_include(<integration_test/IntegrationTestPlugin.h>)
#import <integration_test/IntegrationTestPlugin.h>
#else
@import integration_test;
#endif

#if __has_include(<proxy_actions_ios/ProxyActionsPlugin.h>)
#import <proxy_actions_ios/ProxyActionsPlugin.h>
#else
@import proxy_actions_ios;
#endif

@implementation GeneratedPluginRegistrant

+ (void)registerWithRegistry:(NSObject<FlutterPluginRegistry>*)registry {
  [IntegrationTestPlugin registerWithRegistrar:[registry registrarForPlugin:@"IntegrationTestPlugin"]];
  [ProxyActionsPlugin registerWithRegistrar:[registry registrarForPlugin:@"ProxyActionsPlugin"]];
}

@end
