//
//  ZStudentOrganizationListCell.m
//  NoWait
//
//  Created by zhuang zhang on 2020/5/28.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZStudentOrganizationListCell.h"

@interface ZStudentOrganizationListCell ()
@end

@implementation ZStudentOrganizationListCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupView];
    }
    return self;
}

-(void)setupView {
    [super setupView];
    self.clipsToBounds = YES;
    
    [self.contentView addSubview:self.goodsImageView];
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.payPeopleNumLabel];
    [self.contentView addSubview:self.addressLabel];
    [self.contentView addSubview:self.collectionBtn];
    
    [self.goodsImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).offset(CGFloatIn750(24));
        make.left.equalTo(self.contentView.mas_left).offset(CGFloatIn750(30));
        make.height.mas_equalTo(CGFloatIn750(132));
        make.width.mas_equalTo(CGFloatIn750(210));
    }];
    
    [self.collectionBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top);
        make.left.equalTo(self.mas_right);
        make.height.width.mas_equalTo(CGFloatIn750(84));
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.goodsImageView.mas_right).offset(CGFloatIn750(20));
        make.top.equalTo(self.goodsImageView.mas_top);
        make.right.equalTo(self.collectionBtn.mas_left).offset(-CGFloatIn750(20));
    }];
    
    [self.payPeopleNumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.goodsImageView.mas_right).offset(CGFloatIn750(20));
        make.top.equalTo(self.titleLabel.mas_bottom).offset(CGFloatIn750(10));
        make.right.equalTo(self.contentView.mas_right).offset(-CGFloatIn750(20));
    }];
    
    [self.addressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(CGFloatIn750(170));
        make.centerY.equalTo(self.payPeopleNumLabel.mas_centerY);
        make.right.equalTo(self.contentView.mas_right).offset(-CGFloatIn750(20));
    }];
    
    [self.contentView addSubview:self.activityView];
    [self.activityView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.goodsImageView.mas_right).offset(CGFloatIn750(20));
        make.top.equalTo(self.payPeopleNumLabel.mas_bottom).offset(CGFloatIn750(18));
        make.right.equalTo(self.contentView.mas_right).offset(-CGFloatIn750(20));
        make.height.mas_equalTo(CGFloatIn750(40));
    }];
    
    [self.contentView addSubview:self.moreView];
    [self.moreView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView.mas_right);
        make.top.equalTo(self.goodsImageView.mas_bottom).offset(-CGFloatIn750(38));
        make.width.height.mas_equalTo(CGFloatIn750(100));
    }];
}

#pragma mark - Getter
-(UIImageView *)goodsImageView {
    if (!_goodsImageView) {
        _goodsImageView = [[UIImageView alloc] init];
        _goodsImageView.contentMode = UIViewContentModeScaleAspectFill;
        _goodsImageView.clipsToBounds = YES;
        ViewRadius(_goodsImageView, CGFloatIn750(8));
    }
    return _goodsImageView;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _titleLabel.textColor = adaptAndDarkColor([UIColor colorTextBlack],[UIColor colorTextGray1]);
        _titleLabel.numberOfLines = 1;
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        [_titleLabel setFont:[UIFont boldFontTitle]];
    }
    return _titleLabel;
}

- (UILabel *)payPeopleNumLabel {
    if (!_payPeopleNumLabel) {
        _payPeopleNumLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _payPeopleNumLabel.textColor = adaptAndDarkColor([UIColor colorTextGray1],[UIColor colorTextGray]);
        _payPeopleNumLabel.numberOfLines = 1;
        _payPeopleNumLabel.textAlignment = NSTextAlignmentLeft;
        [_payPeopleNumLabel setFont:[UIFont fontSmall]];
    }
    return _payPeopleNumLabel;
}

- (UILabel *)addressLabel {
    if (!_addressLabel) {
        _addressLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _addressLabel.textColor = adaptAndDarkColor([UIColor colorTextGray1],[UIColor colorTextGray]);
        _addressLabel.numberOfLines = 1;
        _addressLabel.textAlignment = NSTextAlignmentRight;
        [_addressLabel setFont:[UIFont fontSmall]];
    }
    return _addressLabel;
}

- (UIView *)activityView {
    if (!_activityView) {
        _activityView = [[UIView alloc] init];
        _activityView.layer.masksToBounds = YES;
    }
    return _activityView;
}

- (UIView *)moreView {
    if (!_moreView) {
        _moreView = [[UIView alloc] init];
        _moreImageView = [[UIImageView alloc] init];
        _moreImageView.image = [[UIImage imageNamed:@"fillArrow"]  imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        _moreImageView.transform =  CGAffineTransformMakeRotation(M_PI);
        _moreImageView.tintColor = adaptAndDarkColor([UIColor colorTextGray1], [UIColor colorTextGray1Dark]);
        _moreImageView.layer.masksToBounds = YES;
        [_moreView addSubview:_moreImageView];
        [_moreImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.moreView.mas_right).offset(-CGFloatIn750(34));
            make.width.mas_equalTo(CGFloatIn750(14));
            make.height.mas_equalTo(CGFloatIn750(8));
            make.top.equalTo(self.moreView.mas_top).offset(CGFloatIn750(20));
        }];
        
        __weak typeof(self) weakSelf = self;
        UIButton *moreBtn = [[ZButton alloc] initWithFrame:CGRectZero];
        [moreBtn bk_addEventHandler:^(id sender) {
            if (weakSelf.moreBlock) {
                weakSelf.moreBlock(weakSelf.model);
            }
        } forControlEvents:UIControlEventTouchUpInside];
        [_moreView addSubview:moreBtn];
        [moreBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.moreView);
        }];
    }
    return _moreView;
}

- (UIButton *)collectionBtn {
    if (!_collectionBtn) {
        __weak typeof(self) weakSelf = self;
        _collectionBtn = [[ZButton alloc] initWithFrame:CGRectZero];
        UIImageView *collectionImageView = [[UIImageView alloc] init];
        collectionImageView.image = [UIImage imageNamed:@"collectionHandle"];
        collectionImageView.layer.masksToBounds = YES;
        [_collectionBtn addSubview:collectionImageView];
        [collectionImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self.collectionBtn);
            make.height.width.mas_equalTo(CGFloatIn750(20));
        }];
        [_collectionBtn bk_addEventHandler:^(id sender) {
            if (weakSelf.handleBlock) {
                weakSelf.handleBlock(self.model);
            };
        } forControlEvents:UIControlEventTouchUpInside];
    }
    return _collectionBtn;
}

- (void)setModel:(ZStoresListModel *)model {
    _model = model;
    
    _titleLabel.text = model.name;
    _payPeopleNumLabel.text = [NSString stringWithFormat:@"%@人已付款",model.pay_nums];
    _addressLabel.text = [NSString stringWithFormat:@"%@",model.distance];
    [_goodsImageView tt_setImageWithURL:[NSURL URLWithString:imageFullUrl(model.image)] placeholderImage:[UIImage imageNamed:@"default_loadFail276"]];
    
    self.moreView.hidden = YES;
    [self setActivityData];
    
    if (model.isStudentCollection) {
        [self.collectionBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.mas_top);
            make.right.equalTo(self.mas_right);
            make.height.width.mas_equalTo(CGFloatIn750(84));
        }];
    }else {
        [self.collectionBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.mas_top);
            make.left.equalTo(self.mas_right);
            make.height.width.mas_equalTo(CGFloatIn750(84));
        }];
    }
    
    if (_model.isMore) {
        _moreImageView.transform =  CGAffineTransformMakeRotation(0);
    }else{
        _moreImageView.transform =  CGAffineTransformMakeRotation(M_PI);
    }
}

- (void)setActivityData {
    [self.activityView removeAllSubviews];
    
    NSMutableArray <NSDictionary *>*ttArr = @[].mutableCopy;
    if (ValidArray(self.model.tags)) {
        [self.model.tags enumerateObjectsUsingBlock:^(NSString *obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [ttArr addObject:@{@"title":SafeStr(obj), @"type":@"1"}];
        }];
    }
    
    if (ValidArray(self.model.coupons)) {
        [self.model.coupons enumerateObjectsUsingBlock:^(ZOriganizationCardListModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [ttArr addObject:@{@"title":SafeStr(obj.title), @"type":@"0"}];
        }];
    }

    __block CGFloat leftX = 0;
    __block CGFloat leftY = 0;
    
    __block NSString *type;
    if (ValidArray(ttArr)) {
        type = ttArr[0][@"type"];
    }
    [ttArr enumerateObjectsUsingBlock:^(NSDictionary * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSString *title = obj[@"title"];
        BOOL isChange = NO;
        if (![type isEqualToString:obj[@"type"]]) {
            isChange = YES;
        }
        
        UIView *label = [self getViewWithText:title leftX:leftX leftY:leftY colorType:[obj[@"type"] boolValue] isChange:isChange];
        if (!label) {
            *stop = YES;
        }else{
            leftY = label.top;
            [self.activityView addSubview:label];
            leftX = label.right + CGFloatIn750(8);
            type = obj[@"type"];
        }
    }];
    
    [self.activityView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.goodsImageView.mas_right).offset(CGFloatIn750(20));
        make.top.equalTo(self.payPeopleNumLabel.mas_bottom).offset(CGFloatIn750(18));
        make.right.equalTo(self.contentView.mas_right).offset(-CGFloatIn750(20));
        if (self.model.isMore) {
            make.height.mas_equalTo(leftY + CGFloatIn750(40));
        }else{
            make.height.mas_equalTo(CGFloatIn750(40));
        }
    }];
}

- (UIView *)getViewWithText:(NSString *)text leftX:(CGFloat)leftX leftY:(CGFloat)leftY colorType:(BOOL)isTags isChange:(BOOL)isChange {
     CGSize tempSize = [text tt_sizeWithFont:[UIFont fontContent] constrainedToSize:CGSizeMake(kScreenWidth/2, MAXFLOAT)];
    
    UILabel *actLabel = [[UILabel alloc] initWithFrame:CGRectMake(leftX, leftY, tempSize.width+6, CGFloatIn750(36))];
    if (isTags) {
        actLabel.backgroundColor = adaptAndDarkColor([UIColor colorMainSub],[UIColor colorMainSub]);
        actLabel.textColor = adaptAndDarkColor([UIColor colorMain], [UIColor colorMainDark]);
    }else{
        actLabel.backgroundColor = adaptAndDarkColor([UIColor colorRedForLabelSub],[UIColor colorRedForLabelSub]);
        actLabel.textColor = adaptAndDarkColor([UIColor colorRedForLabel], [UIColor colorRedForLabel]);
    }
    
    actLabel.layer.masksToBounds = YES;
    actLabel.layer.cornerRadius = 2;
    actLabel.text = text;
    actLabel.numberOfLines = 0;
    actLabel.textAlignment = NSTextAlignmentCenter;
    [actLabel setFont:[UIFont fontMin]];
    
    if ((leftX + tempSize.width + 6 < (KScreenWidth - CGFloatIn750(134 * 2 + 20) - CGFloatIn750(48))) && !isChange) {
        actLabel.frame = CGRectMake(leftX, leftY, tempSize.width+6, CGFloatIn750(36));
    }else{
        self.moreView.hidden = NO;
        if (!self.model.isMore) {
            return nil;
        }
        actLabel.frame = CGRectMake(0, leftY + CGFloatIn750(36) + CGFloatIn750(20), tempSize.width+6, CGFloatIn750(36));
    }
    return actLabel;
}

+(CGFloat)z_getCellHeight:(id)sender {
    ZStoresListModel *model = sender;
    if (model) {
        if (!model.isMore) {
            return CGFloatIn750(188);
        }
        NSMutableArray <NSDictionary *>*ttArr = @[].mutableCopy;
        if (ValidArray(model.tags)) {
            [model.tags enumerateObjectsUsingBlock:^(NSString *obj, NSUInteger idx, BOOL * _Nonnull stop) {
                [ttArr addObject:@{@"title":SafeStr(obj), @"type":@"1"}];
            }];
        }
        
        if (ValidArray(model.coupons)) {
            [model.coupons enumerateObjectsUsingBlock:^(ZOriganizationCardListModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                [ttArr addObject:@{@"title":SafeStr(obj.title), @"type":@"0"}];
            }];
        }
        
        CGFloat tagHeight = 0;
        __block CGFloat leftX = 0;
        __block CGFloat leftY = 0;
        __block NSString *type;
        if (ValidArray(ttArr)) {
            type = ttArr[0][@"type"];
        }
        
        [ttArr enumerateObjectsUsingBlock:^(NSDictionary * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            NSString *title = obj[@"title"];
            BOOL isChange = NO;
            if (![type isEqualToString:obj[@"type"]]) {
                isChange = YES;
            }
            
            CGPoint label = [ZStudentOrganizationListCell getViewWithText:title leftX:leftX leftY:leftY model:model isChange:isChange];
            leftY = label.y;
            leftX = label.x;
            type = obj[@"type"];
        }];
        
        if (ValidArray(ttArr)) {
            tagHeight = leftY + CGFloatIn750(40);
        }
        
        CGFloat offsetHeight = tagHeight;
        if (offsetHeight > CGFloatIn750(38)) {
            offsetHeight = offsetHeight - CGFloatIn750(40);
        }
        return CGFloatIn750(188) + offsetHeight;
    }
    return CGFloatIn750(188);
}

+ (CGPoint)getViewWithText:(NSString *)text leftX:(CGFloat)leftX leftY:(CGFloat)leftY model:(ZStoresListModel *)model isChange:(BOOL)isChange{
     CGSize tempSize = [text tt_sizeWithFont:[UIFont fontContent] constrainedToSize:CGSizeMake(kScreenWidth/2, MAXFLOAT)];
     
     if ((leftX + tempSize.width + 6 < KScreenWidth - CGFloatIn750(134 * 2 + 20) - CGFloatIn750(48)) && !isChange) {
         return CGPointMake(leftX + tempSize.width+6 + CGFloatIn750(8), leftY);
     }else{
         return CGPointMake(tempSize.width+6 + CGFloatIn750(8), leftY + CGFloatIn750(36) + CGFloatIn750(20));
     }
}
@end
