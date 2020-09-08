//
//  ZMapSearchView.h
//  NoWait
//
//  Created by zhuang zhang on 2020/9/8.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZMapSearchView : UIView
@property (nonatomic,strong) UITextField *iTextField;
@property (nonatomic,strong) void (^searchBlock)(NSString *);
@property (nonatomic,strong) void (^textChangeBlock)(NSString *);
@end

NS_ASSUME_NONNULL_END
