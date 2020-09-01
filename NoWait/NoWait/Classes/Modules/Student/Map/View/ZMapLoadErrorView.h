//
//  ZMapLoadErrorView.h
//  NoWait
//
//  Created by zhuang zhang on 2020/8/31.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZMapLoadErrorView : UIView
@property (nonatomic,strong) NSString *title;

@property (nonatomic,strong) void (^reloadBlock)(void);
@property (nonatomic,strong) void (^backBlock)(void);
@end

NS_ASSUME_NONNULL_END
