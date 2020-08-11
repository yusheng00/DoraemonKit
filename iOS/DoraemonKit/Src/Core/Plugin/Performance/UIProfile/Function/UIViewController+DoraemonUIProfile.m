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
        [[self class] doraemon_swizzleInstanceMethodWithOriginSel:@selector(viewWillDisappear:) swizzledSel:@selector(doraemon_viewWillDisappear:)];
        [[self class] doraemon_swizzleInstanceMethodWithOriginSel:@selector(init) swizzledSel:@selector(doraemon_init)];
        [[self class] doraemon_swizzleInstanceMethodWithOriginSel:@selector(presentViewController: animated: completion:) swizzledSel:@selector(doraemon_presentViewController: animated: completion:)];

    });
}

- (instancetype)doraemon_init {
    
    [[self class] aspect_hookSelector:@selector(viewDidLoad:) withOptions:AspectPositionBefore usingBlock:^(id<AspectInfo> aspectInfo, BOOL animated) {
        [DoraemonManager shareInstance].currentPage = NSStringFromClass(self.class);

        [[DoraemonJumpRecordManager sharedInstance] finishRecord: aspectInfo.instance];
    } error:NULL];
    
    [[self class] aspect_hookSelector:@selector(viewDidLoad:) withOptions:AspectPositionAfter usingBlock:^(id<AspectInfo> aspectInfo, BOOL animated) {
        NSLog(@"%@", [NSString stringWithFormat:@"%@ after appear1", self.class]);
    } error:NULL];

    return [self doraemon_init];
}


- (void)doraemon_presentViewController:(UIViewController *)viewControllerToPresent animated:(BOOL)flag completion:(void (^)(void))completion {
    [[DoraemonJumpRecordManager sharedInstance] startRecordWithOrigin:self target:viewControllerToPresent];
    [self doraemon_presentViewController:viewControllerToPresent animated:flag completion:completion];
}


- (void)doraemon_viewWillDisappear:(BOOL)animated {
    [self doraemon_viewWillDisappear:animated];
    [self resetProfileData];
}

- (void)profileViewDepth
{
    if (![DoraemonUIProfileManager sharedInstance].enable) {
        return;
    }
    [self travelView:self.view depth:0];
    [self showUIProfile];
}

- (void)showUIProfile
{
    NSString *text = [NSString stringWithFormat:@"[%d][%@]",self.doraemon_depth.intValue,NSStringFromClass([self.doraemon_depthView class])];
    
    NSMutableArray *tmp = [NSMutableArray new];
    if (self.doraemon_depthView) {
        [tmp addObject:NSStringFromClass([self.doraemon_depthView class])];
    }

    UIView *tmpSuperView = self.doraemon_depthView.superview;
    
    while (tmpSuperView && tmpSuperView != self.view) {
        [tmp addObject:NSStringFromClass([tmpSuperView class])];
        tmpSuperView = tmpSuperView.superview;
    }
    
    [tmp addObject:NSStringFromClass([self.view class])];


    NSArray *result = [[tmp reverseObjectEnumerator] allObjects];
    NSString *detail = [result componentsJoinedByString:@"\r\n"];
    
    [[DoraemonUIProfileWindow sharedInstance] showWithDepthText:text detailInfo:detail];
    
    self.doraemon_depthView.layer.borderWidth = 1;
    self.doraemon_depthView.layer.borderColor = [UIColor redColor].CGColor;

}

- (void)travelView:(UIView *)view depth:(int)depth
{
    depth++;
    if (depth > self.doraemon_depth.intValue) {
        self.doraemon_depth = @(depth);
        self.doraemon_depthView = view;
    }
    
    if (view.subviews.count == 0) {
        return;
    }
    
    for (int i = 0; i < view.subviews.count; i++) {
        UIView *subView = view.subviews[i];
        [self travelView:subView depth:depth];
    }
}

- (void)resetProfileData
{
    self.doraemon_depth = @(0);
    self.doraemon_depthView.layer.borderWidth = 0;
    self.doraemon_depthView.layer.borderColor = nil;
}

- (void)setDoraemon_depth:(NSNumber *)doraemon_depth
{
    objc_setAssociatedObject(self, @selector(doraemon_depth), doraemon_depth, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSNumber *)doraemon_depth
{
    return objc_getAssociatedObject(self, @selector(doraemon_depth));
}

- (void)setDoraemon_depthView:(UIView *)doraemon_depthView
{
    objc_setAssociatedObject(self, @selector(doraemon_depthView), doraemon_depthView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIView *)doraemon_depthView
{
    return objc_getAssociatedObject(self, @selector(doraemon_depthView));
}

@end
