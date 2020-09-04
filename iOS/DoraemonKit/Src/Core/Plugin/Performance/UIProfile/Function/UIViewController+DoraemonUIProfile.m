//
//  UIViewController+Doraemon.m
//  DoraemonKit
//
//  Created by xgb on 2019/8/1.
//

#import "UIViewController+Doraemon.h"
#import "DoraemonUIProfileManager.h"
#import "NSObject+Doraemon.h"
#import "DoraemonDefine.h"
#import <objc/runtime.h>
#import "DoraemonUIProfileWindow.h"
#import "DoraemonManager.h"
#import "DoraemonTimeProfiler.h"
#import "Aspects.h"
#import "DoraemonJumpRecordManager.h"

@interface UIViewController ()

@property (nonatomic, strong) NSNumber *doraemon_depth;
@property (nonatomic, strong) UIView *doraemon_depthView;

@property (nonatomic, strong) id strongSelf;

@end

@implementation UIViewController (DoraemonUIProfile)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [[self class] doraemon_swizzleInstanceMethodWithOriginSel:@selector(init) swizzledSel:@selector(doraemon_init)];
        [[self class] doraemon_swizzleInstanceMethodWithOriginSel:@selector(viewWillAppear:) swizzledSel:@selector(doraemon_viewWillAppear:)];
        [[self class] doraemon_swizzleInstanceMethodWithOriginSel:@selector(presentViewController: animated: completion:) swizzledSel:@selector(doraemon_presentViewController: animated: completion:)];
        [[self class] aspect_hookSelector:@selector(viewDidAppear:) withOptions:AspectPositionAfter usingBlock:^(id<AspectInfo> aspectInfo, BOOL animated) {
            [[DoraemonJumpRecordManager sharedInstance] finishRecord: aspectInfo.instance];
        } error:NULL];

    });
}

- (instancetype)doraemon_init {
    

    return [self doraemon_init];
}

- (void)doraemon_viewWillAppear:(BOOL)animated {
    [self doraemon_viewWillAppear:animated];
    if ([NSStringFromClass(self.class) hasPrefix:@"Doraemon"]) {
        return;
    }
    [DoraemonManager shareInstance].currentPage = NSStringFromClass(self.class);
}


- (void)doraemon_presentViewController:(UIViewController *)viewControllerToPresent animated:(BOOL)flag completion:(void (^)(void))completion {
    [[DoraemonJumpRecordManager sharedInstance] startRecordWithOrigin:self target:viewControllerToPresent];
    [self doraemon_presentViewController:viewControllerToPresent animated:flag completion:completion];
}


@end
