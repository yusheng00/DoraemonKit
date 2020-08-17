//
//  DoraemonJumpRecordManager.m
//  DoraemonKit
//
//  Created by apple on 2020/8/11.
//

#import "DoraemonJumpRecordManager.h"
#import "DoraemonJumpTimeModel.h"
#import "DoraemonToastUtil.h"

static float DjumpDuration = 0.8;

@interface DoraemonJumpRecordManager()

@property (nonatomic, strong) NSMutableArray *recordArray;

@property (nonatomic, assign) BOOL isStartRecord;

@end

@implementation DoraemonJumpRecordManager

+ (instancetype)sharedInstance {
    static id instance = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

- (instancetype)init{
    if (self = [super init]) {
        self.recordArray = [NSMutableArray array];
    }
    return self;
}

- (void)startRecordWithOrigin:(UIViewController *)origin target:(UIViewController *)target {
    self.isStartRecord = YES;
    DoraemonJumpTimeModel *model = [[DoraemonJumpTimeModel alloc] init];
    model.originController = NSStringFromClass(origin.class);
    model.targetControllrt  = NSStringFromClass(target.class);
    model.startTime = CACurrentMediaTime();
    [self.recordArray addObject:model];
}

- (void)finishRecord:(UIViewController *)controller {
    if (self.isStartRecord) {
        for (DoraemonJumpTimeModel *model in self.recordArray) {
            if ([model.targetControllrt isEqualToString: NSStringFromClass(controller.class)]) {
                if (model.finishTime > 0) {
                    
                } else {
                    self.isStartRecord = NO;
                    model.finishTime = CACurrentMediaTime();
                    model.timeCost = model.finishTime - model.startTime;
                    if (model.timeCost > DjumpDuration) {
                        [DoraemonToastUtil showToastBlack:@"跳转时间过长" inView: [UIApplication sharedApplication].keyWindow];
                    }
                }
            }
        }
    }
}

@end
