//
//  ZTeacherClassReportFormTopView.h
//  NoWait
//
//  Created by zhuang zhang on 2020/9/14.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZTeacherClassReportFormTopView : UIView
@property (nonatomic,strong) void (^moreBlock)(NSInteger);
@property (nonatomic,strong) NSString *title;
@end

NS_ASSUME_NONNULL_END
