//
//  ZStudentMainOrganizationListCell.m
//  NoWait
//
//  Created by zhuang zhang on 2020/1/6.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZStudentMainOrganizationListCell.h"

@interface ZStudentMainOrganizationListCell ()

@property (nonatomic,strong) UIImageView *goodsImageView;
@property (nonatomic,strong) UILabel *titleLabel;
@property (nonatomic,strong) UILabel *payPeopleNumLabel;
@property (nonatomic,strong) UILabel *addressLabel;
@property (nonatomic,strong) UIView *introductionView;
@property (nonatomic,strong) UIView *activityView;


@end

@implementation ZStudentMainOrganizationListCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupView];
    }
    return self;
}

-(void)setupView {
    [super setupView];
    
    [self.contentView addSubview:self.goodsImageView];
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.payPeopleNumLabel];
    [self.contentView addSubview:self.addressLabel];
    
    [self.goodsImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).offset(CGFloatIn750(24));
        make.left.equalTo(self.contentView.mas_left).offset(CGFloatIn750(30));
        make.height.mas_equalTo(CGFloatIn750(132));
        make.width.mas_equalTo(CGFloatIn750(210));
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.goodsImageView.mas_right).offset(CGFloatIn750(20));
        make.top.equalTo(self.goodsImageView.mas_top);
        make.right.equalTo(self.contentView.mas_right).offset(-CGFloatIn750(20));
    }];
    
    [self.payPeopleNumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.goodsImageView.mas_right).offset(CGFloatIn750(20));
        make.top.equalTo(self.titleLabel.mas_bottom).offset(CGFloatIn750(10));
        make.right.equalTo(self.contentView.mas_right).offset(-CGFloatIn750(20));
    }];
    
    [self.addressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(CGFloatIn750(120));
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
    
    [self setActivityData];
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


- (UIView *)introductionView {
    if (!_introductionView) {
        _introductionView = [[UIView alloc] init];
        _introductionView.layer.masksToBounds = YES;
    }
    return _introductionView;
}

- (UIView *)activityView {
    if (!_activityView) {
        _activityView = [[UIView alloc] init];
        _activityView.layer.masksToBounds = YES;
    }
    return _activityView;
}

- (void)setModel:(ZStoresListModel *)model {
    _model = model;
    _titleLabel.text = model.name;
    _payPeopleNumLabel.text = [NSString stringWithFormat:@"%@人已付款",model.pay_nums];
    _addressLabel.text = @"<1.3km";
    [_goodsImageView tt_setImageWithURL:[NSURL URLWithString:imageFullUrl(model.image)] placeholderImage:[UIImage imageNamed:@"default_loadFail276"]];
    
    [self setActivityData];
}

+(CGFloat)z_getCellHeight:(id)sender {
    ZStoresListModel *model = sender;
    if (model) {
        NSMutableArray *ttArr = @[].mutableCopy;
        [ttArr addObjectsFromArray:model.tags];
        for (int i = 0; i < model.coupons.count; i++) {
            ZOriganizationCardListModel *smodel = model.coupons[i];
            [ttArr addObject:smodel.title];
        }
        NSArray *textArr = ttArr;
        
        CGFloat leftX = 0;
        CGFloat leftY = 0;
        for (int i = 0; i < textArr.count; i++) {
            CGPoint label = [ZStudentMainOrganizationListCell getViewWithText:textArr[i] leftX:leftX leftY:leftY];
            leftY = label.y;
            leftX = label.x;
        }
        if (textArr.count == 0) {
            return CGFloatIn750(188);
        }
        
        return CGFloatIn750(188) + leftY;
    }
    return CGFloatIn750(188);
}


- (void)setActivityData {
    [self.activityView removeAllSubviews];
    NSMutableArray *ttArr = @[].mutableCopy;
    [ttArr addObjectsFromArray:self.model.tags];
    for (int i = 0; i < self.model.coupons.count; i++) {
        ZOriganizationCardListModel *model = self.model.coupons[i];
        [ttArr addObject:model.title];
    }
    NSArray *textArr = ttArr;
    
    CGFloat leftX = 0;
    CGFloat leftY = 0;
    for (int i = 0; i < textArr.count; i++) {
        UIView *label = [self getViewWithText:textArr[i] leftX:leftX leftY:leftY];
        leftY = label.top;
        [self.activityView addSubview:label];
        leftX = label.right + CGFloatIn750(8);
    }
    
    [self.activityView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.goodsImageView.mas_right).offset(CGFloatIn750(20));
        make.top.equalTo(self.payPeopleNumLabel.mas_bottom).offset(CGFloatIn750(18));
        make.right.equalTo(self.contentView.mas_right).offset(-CGFloatIn750(20));
        make.height.mas_equalTo(leftY + CGFloatIn750(40));
    }];
}

- (UIView *)getViewWithText:(NSString *)text leftX:(CGFloat)leftX leftY:(CGFloat)leftY{
     CGSize tempSize = [text tt_sizeWithFont:[UIFont fontContent] constrainedToSize:CGSizeMake(kScreenWidth/2, MAXFLOAT)];
    
    UILabel *actLabel = [[UILabel alloc] initWithFrame:CGRectMake(leftX, leftY, tempSize.width+6, CGFloatIn750(36))];
    actLabel.backgroundColor = adaptAndDarkColor([UIColor colorMainSub],[UIColor colorMainSub]);
    actLabel.textColor = adaptAndDarkColor([UIColor colorMain], [UIColor colorMainDark]);
    actLabel.layer.masksToBounds = YES;
    actLabel.layer.cornerRadius = 2;
    actLabel.text = text;
    actLabel.numberOfLines = 0;
    actLabel.textAlignment = NSTextAlignmentCenter;
    [actLabel setFont:[UIFont fontMin]];
    
    if (leftX + tempSize.width + 6 < KScreenWidth - CGFloatIn750(134 * 2 + 20)) {
        actLabel.frame = CGRectMake(leftX, leftY, tempSize.width+6, CGFloatIn750(36));
    }else{
        actLabel.frame = CGRectMake(0, leftY + CGFloatIn750(36) + CGFloatIn750(20), tempSize.width+6, CGFloatIn750(36));
    }
    return actLabel;
}

+ (CGPoint)getViewWithText:(NSString *)text leftX:(CGFloat)leftX leftY:(CGFloat)leftY{
     CGSize tempSize = [text tt_sizeWithFont:[UIFont fontContent] constrainedToSize:CGSizeMake(kScreenWidth/2, MAXFLOAT)];
     
     if (leftX + tempSize.width + 6 < KScreenWidth - CGFloatIn750(134 * 2 + 20)) {
         return CGPointMake(leftX + tempSize.width+6 + CGFloatIn750(8), leftY);
     }else{
         return CGPointMake(tempSize.width+6 + CGFloatIn750(8), leftY + CGFloatIn750(36) + CGFloatIn750(20));
     }
}
@end
