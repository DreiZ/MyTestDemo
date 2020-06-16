//
//  ZOrganizationDetailOrderBottomView.h
//  NoWait
//
//  Created by zhuang zhang on 2020/6/16.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZOrganizationDetailBottomView.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZOrganizationDetailOrderBottomView : ZOrganizationDetailBottomView
@property (nonatomic,strong) NSString *orderPrice;

@property (nonatomic,strong) UIButton *orderBtn;
@property (nonatomic,strong) UIView *orderView;
@property (nonatomic,strong) UILabel *hintLabel;
@end

NS_ASSUME_NONNULL_END
