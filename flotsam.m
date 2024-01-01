#include <Foundation/Foundation.h>
#include <unistd.h>
#if __has_feature(modules)
@import Foundation;
#else
#import "Foundation/Foundation.h"
#endif

#include "utils.h" // for entitlement getting
#include "fishhook/fishhook.h" // no clue ¯\_(ツ)_/¯
#include "kern_memorystatus.h" // stolen from xnu :trolley:

__attribute__((constructor)) static void entry(int argc, char **argv) {
    NSLog(@"[Flotsam] Hello from Flotsam!");

    if (!getEntitlementValue(@"com.apple.private.memorystatus")) {
        NSLog(@"[Flotsam:CRIT] I am not entitled to edit jetsam priority! Goodbye.");
    } else {
        NSLog(@"[Flotsam:INFO] Hammer time.");
        pid_t pid = getpid();
        memorystatus_priority_properties_t props = {JETSAM_PRIORITY_CRITICAL, 0};

        if (memorystatus_control(MEMORYSTATUS_CMD_SET_PRIORITY_PROPERTIES, pid, 0, &props, sizeof(props)) != 0) {
            NSLog(@"[Flotsam:WARN] Could not set jetsam priority for process %d. (%d)", pid, errno);
        } else {
            NSLog(@"[Flotsam:INFO] Set jetsam priority for process %d to %d.", pid, props.priority);
        }

        if (memorystatus_control(MEMORYSTATUS_CMD_SET_JETSAM_HIGH_WATER_MARK, pid, -1, NULL, 0) != 0) {
            NSLog(@"[Flotsam:WARN] Could not set jetsam high water mark on process %d. (%d)", pid, errno);
        } else {
            NSLog(@"[Flotsam:INFO] Set jetsam high water mark on process %d to -1.", pid);
        }

        if (memorystatus_control(MEMORYSTATUS_CMD_SET_PROCESS_IS_MANAGED, pid, 0, NULL, 0) != 0) {
            NSLog(@"[Flotsam:WARN] Could not set process %d as unmanaged. (%d)", pid, errno);
        } else {
            NSLog(@"[Flotsam:INFO] Set process %d as unmanaged.", pid);
        }

        if (memorystatus_control(MEMORYSTATUS_CMD_SET_PROCESS_IS_FREEZABLE, pid, 0, NULL, 0) != 0) {
            NSLog(@"[Flotsam:WARN] Could not set process %d as non-freezable. (%d)", pid, errno);
        } else {
            NSLog(@"[Flotsam:INFO] Set process %d as non-freezable.", pid);
        }
    }
}