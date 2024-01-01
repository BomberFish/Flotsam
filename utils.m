#import "utils.h"
#import "fishhook/fishhook.h"

typedef struct __SecTask * SecTaskRef;
extern CFTypeRef SecTaskCopyValueForEntitlement( // this will show as an error if you use VSCode, ignore it since it thinks you're using the macOS SDK which has this function public
        SecTaskRef task, 
        NSString* entitlement, 
        CFErrorRef  _Nullable *error
    ) 
    __attribute__((weak_import));

extern SecTaskRef SecTaskCreateFromSelf(CFAllocatorRef allocator)
    __attribute__((weak_import));

BOOL getEntitlementValue(NSString *key) 
{
    if (SecTaskCreateFromSelf == NULL || SecTaskCopyValueForEntitlement == NULL)
        return NO;
    SecTaskRef sec_task = SecTaskCreateFromSelf(NULL);
    if(!sec_task) return NO;
    CFTypeRef value = SecTaskCopyValueForEntitlement(sec_task, key, nil);
    if (value != nil) 
    {
        CFRelease(value);
    }
    CFRelease(sec_task);
    return value != nil && [(__bridge id)value boolValue];
}