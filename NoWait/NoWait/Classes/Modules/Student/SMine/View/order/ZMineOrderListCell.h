//
//  ZMineOrderListCell.h
//  NoWait
//
//  Created by zhuang zhang on 2020/4/7.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZBaseCell.h"
#import "ZOrderModel.h"

@interface ZMineOrderListCell : ZBaseCell

@property (nonatomic,strong) UIImageView *userImgeView;
@property (nonatomic,strong) UILabel *statelabel;
@property (nonatomic,strong) UILabel *clubLabel;
@property (nonatomic,strong) UILabel *orderNameLabel;
@property (nonatomic,strong) UILabel *priceLabel;
@property (nonatomic,strong) UILabel *detailLabel;
@property (nonatomic,strong) UIImageView *leftImageView;
@property (nonatomic,strong) UIImageView *clubImageView;

@property (nonatomic,strong) UILabel *failHintLabel;
@property (nonatomic,strong) UILabel *failLabel;

@property (nonatomic,strong) UIView *contView;
@property (nonatomic,strong) UIView *bottomView;
@property (nonatomic,strong) UIView *midView;
@property (nonatomic,strong) UIView *failView;
@property (nonatomic,strong) UIView *topView;

@property (nonatomic,strong) UIButton *delBtn;
@property (nonatomic,strong) UIButton *payBtn;
@property (nonatomic,strong) UIButton *cancleBtn;
@property (nonatomic,strong) UIButton *evaBtn;
@property (nonatomic,strong) UIButton *receivedBtn;
@property (nonatomic,strong) UIButton *receivedNOBtn;
@property (nonatomic,strong) UIButton *refundSureBtn;//同意退款
@property (nonatomic,strong) UIButton *refundRefectBtn;//协商退款
@property (nonatomic,strong) UIButton *refundCancle;//取消退款
@property (nonatomic,strong) UIButton *refundOSureBtn;//校区同意
@property (nonatomic,strong) UIButton *refundORefectBtn;//校区拒绝
@property (nonatomic,strong) UIButton *refundPayBtn;//校区拒绝

@property (nonatomic,strong) ZOrderListModel *model;

@property (nonatomic,strong) void (^handleBlock)(NSInteger, ZOrderListModel *);
@end

