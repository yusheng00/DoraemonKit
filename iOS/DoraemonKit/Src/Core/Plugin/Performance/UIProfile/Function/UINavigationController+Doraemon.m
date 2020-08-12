//
//  UINavigationController+Doraemon.m
//  DoraemonKit
//
//  Created by apple on 2020/8/11.
//

#import "UINavigationController+Doraemon.h"
#import <objc/runtime.h>
#import "NSObject+Doraemon.h"
#import "Aspects.h"
#import "DoraemonJumpRecordManager.h"

@implementation UINavigationController (Doraemon)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [[self class] doraemon_swizzleInstanceMethodWithOriginSel:@selector(pushViewController:animated:) swizzledSel:@selector(doraemon_pushViewController:animated:)];
    });
}


- (void)doraemon_pushViewController:(UIViewController *)controller animated:(BOOL)animated {
    
    [[DoraemonJumpRecordManager sharedInstance] startRecordWithOrigin:self.topViewController target:controller];
    [self doraemon_pushViewController:controller animated:animated];
}

@end
