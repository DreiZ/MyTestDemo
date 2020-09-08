//
//  ZMapNavView.h
//  NoWait
//
//  Created by zhuang zhang on 2020/9/8.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZMapNavView : UIView
@property (nonatomic,strong) UILabel *navTitleLabel;
@property (nonatomic,strong) void (^handleBlock)(NSInteger);
@end

NS_ASSUME_NONNULL_END
