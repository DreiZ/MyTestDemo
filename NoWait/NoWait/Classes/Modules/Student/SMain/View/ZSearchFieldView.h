//
//  ZSearchFieldView.h
//  NoWait
//
//  Created by zhuang zhang on 2020/4/8.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZSearchFieldView : UIView
@property (nonatomic,strong) UITextField *iTextField;
@property (nonatomic,strong) void (^searchBlock)(NSString *);
@property (nonatomic,strong) void (^backBlock)(void);
@property (nonatomic,strong) void (^textChangeBlock)(NSString *);
@end

