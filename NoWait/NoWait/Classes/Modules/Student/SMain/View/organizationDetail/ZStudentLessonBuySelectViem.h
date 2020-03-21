//
//  ZStudentLessonBuySelectViem.h
//  NoWait
//
//  Created by zhuang zhang on 2020/3/21.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZStudentLessonBuySelectViem : UIView
@property (nonatomic,strong) void (^bottomBlock)(void);
@property (nonatomic,strong) void (^closeBlock)(void);
@end

NS_ASSUME_NONNULL_END
