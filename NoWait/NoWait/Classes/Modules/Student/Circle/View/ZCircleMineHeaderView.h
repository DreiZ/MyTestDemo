//
//  ZCircleMineHeaderView.h
//  NoWait
//
//  Created by zhuang zhang on 2020/7/4.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZCircleMineHeaderView : UIView
@property (nonatomic,strong) void (^handleBlock)(NSInteger);
@property (nonatomic,strong) void (^valueChangeBlock)(NSString *);
@end

NS_ASSUME_NONNULL_END
