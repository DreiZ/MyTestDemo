//
//  ZTeacherSignTopTitleView.h
//  NoWait
//
//  Created by zhuang zhang on 2020/4/13.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZOriganizationModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface ZTeacherSignTopTitleView : UIView
@property (nonatomic,strong) ZOriganizationClassDetailModel *model;
@property (nonatomic,strong) NSString *time;
@property (nonatomic,strong) void (^titleBlock)(NSInteger);
@property (nonatomic,strong) void (^handleBlock)(NSInteger);
@end

NS_ASSUME_NONNULL_END
