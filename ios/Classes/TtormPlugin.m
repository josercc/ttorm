#import "TtormPlugin.h"
#if __has_include(<ttorm/ttorm-Swift.h>)
#import <ttorm/ttorm-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "ttorm-Swift.h"
#endif

@implementation TtormPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftTtormPlugin registerWithRegistrar:registrar];
}
@end
