//
//  ZStudentOrganizationListCell.h
//  NoWait
//
//  Created by zhuang zhang on 2020/5/28.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZBaseCell.h"
#import "ZOriganizationModel.h"
#import "CWStarRateView.h"

@interface ZStudentOrganizationListCell : ZBaseCell
@property (nonatomic,strong) UIImageView *goodsImageView;
@property (nonatomic,strong) UILabel *titleLabel;
@property (nonatomic,strong) UILabel *payPeopleNumLabel;
@property (nonatomic,strong) UILabel *addressLabel;
@property (nonatomic,strong) CWStarRateView *crView;

@property (nonatomic,strong) UIView *activityView;
@property (nonatomic,strong) UIButton *collectionBtn;
@property (nonatomic,strong) UIView *moreView;
@property (nonatomic,strong) UIImageView *moreImageView;

@property (nonatomic,strong) ZStoresListModel *model;
@property (nonatomic,strong) void (^handleBlock)(ZStoresListModel *);
@property (nonatomic,strong) void (^moreBlock)(ZStoresListModel *);

@end
