// TouchPointKit.h

#import <React/RCTBridgeModule.h>
#import <React/RCTEventEmitter.h>
@import TouchPointKit;

@interface TouchPointKit : RCTEventEmitter <RCTBridgeModule, TouchPointActivityCompletionDelegate>

@end
