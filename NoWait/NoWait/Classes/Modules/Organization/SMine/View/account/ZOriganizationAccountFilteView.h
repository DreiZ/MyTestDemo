//
//  ZOriganizationAccountFilteView.h
//  NoWait
//
//  Created by zhuang zhang on 2020/4/9.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZOriganizationModel.h"

@interface ZOriganizationAccountFilteView : UIView
@property (nonatomic,strong) ZStoresAccountBillListNetModel *model;

@property (nonatomic,assign) BOOL isHandle;
@property (nonatomic,strong) void (^handleBlock)(NSInteger);
@end

