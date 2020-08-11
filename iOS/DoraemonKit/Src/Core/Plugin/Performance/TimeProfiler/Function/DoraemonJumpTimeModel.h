//
//  DoraemonJumpTimeModel.h
//  DoraemonKit
//
//  Created by apple on 2020/8/11.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface DoraemonJumpTimeModel : NSObject

@property (nonatomic, strong) NSString *originController;
@property (nonatomic, strong) NSString *targetControllrt;
@property (nonatomic, assign) CFTimeInterval timeCost;
@property (nonatomic, assign) CFTimeInterval startTime;
@property (nonatomic, assign) CFTimeInterval finishTime;


@end

NS_ASSUME_NONNULL_END
