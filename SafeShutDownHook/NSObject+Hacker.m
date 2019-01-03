//
//  NSObject+Hacker.m
//  SafeShutDownHook
//
//  Created by Jyer on 2018/9/30.
//  Copyright © 2018 Jyer. All rights reserved.
//

#import "NSObject+Hacker.h"
#import <objc/runtime.h>

/*
 v7 = (unsigned __int64)-[SSDRootListController hashCheck:](v2, "hashCheck:", 0LL);
 byte_9DE0 = v7;
 if ( !(byte_9DE1 & 1) )
 {
 v8 = objc_msgSend(&OBJC_CLASS___PIPackage, "packageWithIdentifier:", CFSTR("com.kurrt.safeshutdown"));
 if ( !v8 )
 goto LABEL_17;
 v9 = objc_msgSend(&OBJC_CLASS___NSDate, "date");
 objc_msgSend(v9, "timeIntervalSince1970");
 v11 = v10;
 v12 = objc_msgSend(v8, "installDate");
 objc_msgSend(v12, "timeIntervalSince1970");
 if ( v11 > v13 + 28800.0 )
 {
 byte_9DE1 = 1;
 v14 = objc_msgSend(v8, "identifier");
 v15 = objc_msgSend(v14, "UTF8String");
 v16 = objc_msgSend(&OBJC_CLASS___NSString, "stringWithUTF8String:", v15);
 v17 = objc_msgSend(v8, "name");
 v18 = objc_msgSend(v17, "UTF8String");
 v19 = objc_msgSend(&OBJC_CLASS___NSString, "stringWithUTF8String:", v18);
 v20 = objc_msgSend(v8, "author");
 v21 = objc_msgSend(v20, "UTF8String");
 v22 = objc_msgSend(&OBJC_CLASS___NSString, "stringWithUTF8String:", v21);
 v23 = objc_msgSend(&OBJC_CLASS___NSString, "stringWithFormat:", CFSTR("%@%@%@"), v16, v19, v22);
 v24 = -[SSDRootListController doSha256:](v2, "doSha256:", v23);
 if ( !((unsigned __int64)objc_msgSend(
 CFSTR("93d516633faa4f1ee793b797de056fc5f7a36eeaf1ad49d32f8e1e643d29ee04"),
 "isEqualToString:",
 v24) & 1) )
 {
 LABEL_17:
 byte_9DE0 = 0;
 v25 = objc_msgSend(&OBJC_CLASS___NSNumber, "numberWithBool:", 0LL);
 v26 = objc_msgSend(v2, "specifierForID:", CFSTR("enableSwitch"));
 -[SSDListController setPreferenceValue:specifier:](v2, "setPreferenceValue:specifier:", v25, v26);
 }
 }
 v7 = (unsigned __int8)byte_9DE0;
 }
 if ( v7 )
 v27 = CFSTR("Root");
 else
 v27 = CFSTR("purchase");
 v28 = objc_msgSend(v2, "loadSpecifiersFromPlistName:target:", v27, v2);
 */

@implementation NSObject (Hacker)

- (void)hack {
    NSString *className = @"SSDRootListController";
    Class selfClass = [self class];
    //Hook Check Functions Group
    [self exchangeMethod:@"hashCheck:" ofClass:className toMethod:@selector(hookedHashCheck:) ofClass:selfClass isInstanceMethod:YES];
    [self exchangeMethod:@"doSha256:" ofClass:className toMethod:@selector(hookedDoSha256:) ofClass:selfClass isInstanceMethod:YES];
    /*
     Or Hook Function
     loadSpecifiersFromPlistName:target:
    */
    //[self exchangeMethod:@"loadSpecifiersFromPlistName:target:" ofClass:className toMethod:@selector(hookedloadSpecifiersFromPlistName:target:) ofClass:selfClass isInstanceMethod:YES];
}

- (void)exchangeMethod:(NSString *)methodName ofClass:(NSString *)className toMethod:(SEL)method ofClass:(Class)class isInstanceMethod:(BOOL)isInstanceMethod {
    Class c = NSClassFromString(className);
    SEL sel = NSSelectorFromString(methodName);
    Method om = isInstanceMethod ? class_getInstanceMethod(c, sel) : class_getClassMethod(c, sel);
    Method nm = isInstanceMethod ? class_getInstanceMethod(class, method) : class_getClassMethod(class, method);
    method_exchangeImplementations(om, nm);
}

- (BOOL)hookedHashCheck:(BOOL)hashRes {
    return YES;
}

- (NSString*)hookedDoSha256:(id)arg1 {
    return @"93d516633faa4f1ee793b797de056fc5f7a36eeaf1ad49d32f8e1e643d29ee04";
}

- (NSArray *)hookedloadSpecifiersFromPlistName:(NSString*)name target:(id)target {
    if ([name isEqualToString:@"purchase"]) {
        return [self hookedloadSpecifiersFromPlistName:@"Root" target:target];
    } else {
        return [self hookedloadSpecifiersFromPlistName:name target:target];
    }
}

@end
