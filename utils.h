#if __has_feature(modules)
@import Foundation;
#else
#import "Foundation/Foundation.h"
#endif

#define DISPATCH_ASYNC_START dispatch_async(dispatch_get_main_queue(), ^{
#define DISPATCH_ASYNC_CLOSE });

#define CS_DEBUGGED 0x10000000
extern int csops(
        pid_t pid, 
        unsigned int ops,
        void *useraddr, 
        size_t usersize
    );

extern BOOL getEntitlementValue(NSString *key);