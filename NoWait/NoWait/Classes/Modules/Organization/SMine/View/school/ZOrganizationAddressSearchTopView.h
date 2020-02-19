//
//  ZOrganizationAddressSearchTopView.h
//  NoWait
//
//  Created by zhuang zhang on 2020/2/17.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZOrganizationAddressSearchTopView : UIView
@property (nonatomic,strong) UITextField *iTextField;
@property (nonatomic,strong) void (^cancleBlock)(void);

@end

NS_ASSUME_NONNULL_END
