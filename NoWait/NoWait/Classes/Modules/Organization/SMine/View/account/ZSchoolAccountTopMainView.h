//
//  ZSchoolAccountTopMainView.h
//  NoWait
//
//  Created by zhuang zhang on 2020/4/9.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZOriganizationModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface ZSchoolAccountTopMainView : UIView
@property (nonatomic,strong) ZStoresAccountModel *model;

@property (nonatomic,strong) void (^handleBlock)(NSInteger);
@end

NS_ASSUME_NONNULL_END
