//
//  DoraemonFPSUtil.m
//  AFNetworking
//
//  Created by yixiang on 2019/5/9.
//

#import "DoraemonFPSUtil.h"
#import <UIKit/UIKit.h>
#import "DoraemonToastUtil.h"

@interface DoraemonFPSUtil()

@property (nonatomic, strong) CADisplayLink *link;
@property (nonatomic, assign) NSUInteger count;
@property (nonatomic, assign) NSTimeInterval lastTime;
@property (nonatomic, assign) BOOL isStart;
@property (nonatomic, assign) NSInteger fps;
@property (nonatomic, copy) DoraemonFPSBlock block;

@property (nonatomic, strong) NSMutableArray *fpsArray;
@property (nonatomic, assign) BOOL startToRecord;
@property (nonatomic, assign) int lowFPSTime;


@end

@implementation DoraemonFPSUtil

+ (DoraemonFPSUtil *)shareInstance{
    static dispatch_once_t once;
    static DoraemonFPSUtil *instance;
    dispatch_once(&once, ^{
        instance = [[DoraemonFPSUtil alloc] init];
    });
    return instance;
}

- (instancetype)init{
    self = [super init];
    if (self) {
        _fpsArray = [NSMutableArray array];
        _isStart = NO;
        _count = 0;
        _lastTime = 0;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self start];
        });
    }
    return self;
}

- (void)start{
    if (!_link) {
        _link = [CADisplayLink displayLinkWithTarget:self selector:@selector(trigger:)];
        [_link addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
    }
}

- (void)end{
    if (_link) {
        [_link invalidate];
        _link = nil;
        _lastTime = 0;
        _count = 0;
        [_fpsArray removeAllObjects];
        _lowFPSTime = 0;
        _startToRecord = NO;
    }
}

- (void)trigger:(CADisplayLink *)link{
    if (_lastTime == 0) {
        _lastTime = link.timestamp;
        return;
    }
    
    _count++;
    NSTimeInterval delta = link.timestamp - _lastTime;
    if (delta < 1) return;
    _lastTime = link.timestamp;
    CGFloat fps = _count / delta;
    _count = 0;
    
    NSInteger intFps = (NSInteger)(fps+0.5);
    self.fps = intFps;
    if (self.block) {
        self.block(self.fps);
    }
    
    if (self.startToRecord) {
        if (self.fpsArray.count > 4) {
            int total = 0;
            for (NSNumber *num in self.fpsArray) {
                total += num.integerValue;
            }
            if (total < 250) {
                // 提醒 fps 过低
                [DoraemonToastUtil showToastBlack: @"FPS 连续过低" inView:[UIApplication sharedApplication].windows.firstObject];
                self.lowFPSTime++;
            }
            [self.fpsArray removeAllObjects];
            self.startToRecord = NO;
        } else {
            [self.fpsArray addObject: [NSNumber numberWithInteger: self.fps]];
        }
    } else {
        if (self.fps < 50) {
            self.startToRecord = YES;
        }
    }

}

- (void)addFPSBlock:(void(^)(NSInteger fps))block{
    self.block = block;
}

@end

