// TouchPointKit.m

#import "TouchPointKit.h"


@implementation TouchPointKit
{
  bool hasListeners;
}

- (dispatch_queue_t)methodQueue
{
    return dispatch_get_main_queue();
}

// Will be called when this module's first listener is added.
-(void)startObserving {
    hasListeners = YES;
}

// Will be called when this module's last listener is removed, or on dealloc.
-(void)stopObserving {
    hasListeners = NO;
}

RCT_EXPORT_MODULE()

RCT_EXPORT_METHOD(configure:(NSString *)apiKey apiSecret:(NSString *)apiSecret pod:(int)pod screens:(NSArray *)screens visitor:(NSDictionary *)visitor )
{
  [[TouchPointActivity shared] configureWithApiKey: apiKey apiSecret: apiSecret podName: pod screenNames: screens visitor: visitor];
}

RCT_EXPORT_METHOD(setVisitor:(NSDictionary *)visitor)
{
  [TouchPointActivity shared].visitor = visitor;
}

RCT_EXPORT_METHOD(enableDebugLogs:(BOOL)enable)
{
  [TouchPointActivity shared].enableDebugLogs = enable;
}

RCT_EXPORT_METHOD(disableAllLogs:(BOOL)disable)
{
  [TouchPointActivity shared].disableAllLogs = disable;
}

RCT_EXPORT_METHOD(shouldApplyAPIFilter:(BOOL)apiFilter)
{
  [TouchPointActivity shared].shouldApplyAPIFilter = apiFilter;
}

RCT_EXPORT_METHOD(disableCaching:(BOOL)caching)
{
  [TouchPointActivity shared].disableCaching = caching;
}

RCT_EXPORT_METHOD(isStatusBarStyleLight:(BOOL)statusBarStyle)
{
  [TouchPointActivity shared].isStatusBarStyleLight = statusBarStyle;
}

RCT_EXPORT_METHOD(setScreen:(NSString *)name banner:(BOOL)banner)
{
  [[TouchPointActivity shared] setScreenNameWithScreenName:name banner:banner];
}

RCT_EXPORT_METHOD(openActivity:(NSString *)name)
{
  if ([[TouchPointActivity shared] shouldShowActivityWithScreenName: name]) {
        [[TouchPointActivity shared] openActivityWithScreenName: name delegate: self];
  }
}

RCT_EXPORT_BLOCKING_SYNCHRONOUS_METHOD(shouldShowActivity:(NSString *)screenName) {
  BOOL val = [[TouchPointActivity shared] shouldShowActivityWithScreenName:screenName];
  return [NSNumber numberWithBool:val];
}

RCT_EXPORT_METHOD(clearCache)
{
  NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
  NSDictionary * dict = [userDefaults dictionaryRepresentation];
  for (id key in dict) {
      [userDefaults removeObjectForKey:key];
  }
  [userDefaults synchronize];
}

- (void) didActivityCompleted {
  if (hasListeners) {
    [self sendEventWithName:@"didActivityCompletedEvent" body:@"ActivityCompleted"];
  }
}

- (NSArray<NSString *> *)supportedEvents {
  return @[@"didActivityCompletedEvent"];
}

@end
