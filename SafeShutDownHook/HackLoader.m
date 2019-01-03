//
//  HackLoader.m
//  SafeShutDownHook
//
//  Created by Jyer on 2018/9/30.
//  Copyright © 2018 Jyer. All rights reserved.
//

#import "HackLoader.h"
#import "NSObject+Hacker.h"

@implementation HackLoader

static void __attribute__((constructor)) entry(void) {
    @autoreleasepool {
        NSObject *obj = [[NSObject alloc] init];
        [obj hack];
    }
}

@end
