//
//  ZOriganizationTeachSwitchView.h
//  NoWait
//
//  Created by zhuang zhang on 2020/2/20.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZOriganizationTeachSwitchView : UIView
@property (nonatomic,strong) void (^handleBlock)(NSInteger);
@end

NS_ASSUME_NONNULL_END
