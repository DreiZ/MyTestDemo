//
//  ZStudentMineOrderListCell.m
//  NoWait
//
//  Created by zhuang zhang on 2020/1/15.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZStudentMineOrderListCell.h"

@interface ZStudentMineOrderListCell ()
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
@property (nonatomic,strong) UIButton *closeBtn;
@property (nonatomic,strong) UIButton *evaBtn;

@end

@implementation ZStudentMineOrderListCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupView];
    }
    return self;
}

-(void)setupView {
    [super setupView];
    
    [self.contentView addSubview:self.contView];
    [self.contView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(CGFloatIn750(30));
        make.right.equalTo(self.mas_right).offset(-CGFloatIn750(30));
        make.top.equalTo(self.mas_top).offset(CGFloatIn750(20));
        make.bottom.equalTo(self.mas_bottom).offset(-CGFloatIn750(10));
    }];
    
    [self.contView addSubview:self.topView];
    [self.topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(self.contView);
        make.height.mas_equalTo(CGFloatIn750(88));
    }];
    
    
    [self.contView addSubview:self.bottomView];
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.equalTo(self.contView);
        make.height.mas_equalTo(CGFloatIn750(136));
    }];
    
    [self.contView addSubview:self.failView];
    [self.failView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.contView);
        make.bottom.equalTo(self.bottomView.mas_top);
        make.height.mas_equalTo(50);
    }];
    
    
    [self.contView addSubview:self.midView];
    [self.midView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.contView);
        make.top.equalTo(self.topView.mas_bottom);
        make.bottom.equalTo(self.failView.mas_top);
    }];
    
    [self.topView addSubview:self.clubLabel];
    [self.topView addSubview:self.statelabel];
    
    [self.clubLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.topView.mas_left).offset(CGFloatIn750(30));
        make.centerY.equalTo(self.topView.mas_centerY);
    }];
    
    _clubImageView = [[UIImageView alloc] init];
    _clubImageView.image = [[UIImage imageNamed:@"rightBlackArrowN"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    _clubImageView.tintColor = adaptAndDarkColor([UIColor colorBlack], [UIColor colorWhite]);
    [self.topView addSubview:_clubImageView];
    [self.clubImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.clubLabel.mas_right).offset(CGFloatIn750(20));
        make.centerY.equalTo(self.topView.mas_centerY);
    }];
    
    __weak typeof(self) weakSelf = self;
    UIButton *clubBtn = [[UIButton alloc] initWithFrame:CGRectZero];
    [clubBtn bk_whenTapped:^{
        if (weakSelf.handleBlock) {
            weakSelf.handleBlock(5, weakSelf.model);
        }
    }];
    [self.topView addSubview:clubBtn];
    [clubBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.equalTo(self.topView);
        make.right.equalTo(self.clubImageView.mas_right).offset(CGFloatIn750(20));
    }];
    
    [self.statelabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.topView.mas_right).offset(-CGFloatIn750(30));
        make.centerY.equalTo(self.topView.mas_centerY);
    }];
    
    [self.midView addSubview:self.leftImageView];
    [self.midView addSubview:self.priceLabel];
    [self.midView addSubview:self.detailLabel];
    [self.midView addSubview:self.orderNameLabel];
    

   [self.leftImageView mas_makeConstraints:^(MASConstraintMaker *make) {
       make.left.equalTo(self.midView.mas_left).offset(CGFloatIn750(30));
       make.top.bottom.equalTo(self.midView);
       make.width.mas_equalTo(CGFloatIn750(240));
   }];

    [self.orderNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.leftImageView.mas_right).offset(CGFloatIn750(20));
        make.top.equalTo(self.leftImageView.mas_top).offset(CGFloatIn750(2));
        make.right.equalTo(self.midView.mas_right).offset(-CGFloatIn750(20));
    }];
    
    [self.detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.orderNameLabel.mas_left);
        make.top.equalTo(self.orderNameLabel.mas_bottom).offset(CGFloatIn750(38));
    }];

    [self.priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.orderNameLabel.mas_left);
        make.bottom.equalTo(self.leftImageView.mas_bottom).offset(CGFloatIn750(-8));
        make.right.equalTo(self.midView.mas_right).offset(-CGFloatIn750(20));
    }];
    
    [self.bottomView addSubview:self.payBtn];
    [self.bottomView addSubview:self.evaBtn];
    [self.bottomView addSubview:self.closeBtn];
    [self.bottomView addSubview:self.delBtn];
    
    [self.payBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.bottomView);
    }];
    
    [self.evaBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.bottomView);
    }];
    
    [self.closeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.bottomView);;
    }];
    
    [self.delBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.bottomView);
    }];
    
    [self.failView addSubview:self.failHintLabel];
    [self.failView addSubview:self.failLabel];
    [self.failHintLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.failView);
    }];

    [self.failLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.failView);
    }];
    [ZPublicTool setLineSpacing:CGFloatIn750(10) label:self.failLabel];
}


#pragma mark - Getter
- (UIView *)contView {
    if (!_contView) {
        
        _contView = [[UIView alloc] init];
        _contView.backgroundColor = adaptAndDarkColor([UIColor colorWhite], [UIColor colorBlackBGDark]);
        
//        _contView.clipsToBounds = YES;
        ViewShadowRadius(_contView, CGFloatIn750(30), CGSizeMake(0, 0), 0.5, isDarkModel() ? [UIColor colorGrayContentBGDark] : [UIColor colorGrayContentBG]);
         _contView.layer.cornerRadius = CGFloatIn750(12);
    }
    return _contView;
}

- (UIView *)failView {
    if (!_failView) {
        _failView = [[UIView alloc] init];
        _failView.backgroundColor = adaptAndDarkColor([UIColor colorWhite], [UIColor colorBlackBGDark]);
        _failView.clipsToBounds = YES;
    }
    return _failView;
}

- (UIView *)topView {
    if (!_topView) {
        _topView = [[UIView alloc] init];
        _topView.backgroundColor = adaptAndDarkColor([UIColor colorWhite], [UIColor colorBlackBGDark]);
        _topView.clipsToBounds = YES;
        _topView.layer.cornerRadius = CGFloatIn750(12);
    }
    return _topView;
}

- (UIView *)midView {
    if (!_midView) {
        _midView = [[UIView alloc] init];
        _midView.backgroundColor = adaptAndDarkColor([UIColor colorWhite], [UIColor colorBlackBGDark]);
        _midView.clipsToBounds = YES;
    }
    return _midView;
}

- (UIView *)bottomView {
    if (!_bottomView) {
        _bottomView = [[UIView alloc] init];
        _bottomView.backgroundColor = adaptAndDarkColor([UIColor colorWhite], [UIColor colorBlackBGDark]);
        _bottomView.clipsToBounds = YES;
        _bottomView.layer.cornerRadius = CGFloatIn750(12);
    }
    return _bottomView;
}

- (UILabel *)orderNameLabel {
    if (!_orderNameLabel) {
        _orderNameLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _orderNameLabel.textColor = adaptAndDarkColor([UIColor colorTextBlack],[UIColor colorTextBlackDark]);
        _orderNameLabel.text = @"";
        _orderNameLabel.numberOfLines = 1;
        _orderNameLabel.textAlignment = NSTextAlignmentLeft;
        [_orderNameLabel setFont:[UIFont boldFontContent]];
    }
    return _orderNameLabel;
}


- (UILabel *)priceLabel {
    if (!_priceLabel) {
        _priceLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _priceLabel.textColor = adaptAndDarkColor([UIColor colorTextBlack],[UIColor colorTextBlackDark]);
        _priceLabel.text = @"";
        _priceLabel.numberOfLines = 1;
        _priceLabel.textAlignment = NSTextAlignmentLeft;
        [_priceLabel setFont:[UIFont boldFontContent]];
    }
    return _priceLabel;
}

- (UIImageView *)leftImageView {
    if (!_leftImageView) {
        _leftImageView = [[UIImageView alloc] init];
        _leftImageView.image = [UIImage imageNamed:@"serverTopbg"];
        _leftImageView.contentMode = UIViewContentModeScaleAspectFill;
        ViewRadius(_leftImageView, CGFloatIn750(12));
    }
    return _leftImageView;
}


- (UILabel *)detailLabel {
    if (!_detailLabel) {
        _detailLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _detailLabel.textColor = adaptAndDarkColor([UIColor colorTextGray],[UIColor colorTextGrayDark]);
        _detailLabel.text = @"";
        _detailLabel.numberOfLines = 1;
        _detailLabel.textAlignment = NSTextAlignmentLeft;
        [_detailLabel setFont:[UIFont fontSmall]];
    }
    return _detailLabel;
}


- (UILabel *)clubLabel {
    if (!_clubLabel) {
        _clubLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _clubLabel.textColor = adaptAndDarkColor([UIColor colorTextBlack],[UIColor colorTextBlackDark]);
        _clubLabel.text = @"";
        _clubLabel.numberOfLines = 1;
        _clubLabel.textAlignment = NSTextAlignmentLeft;
        [_clubLabel setFont:[UIFont fontContent]];
    }
    return _clubLabel;
}


- (UILabel *)statelabel {
    if (!_statelabel) {
        _statelabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _statelabel.textColor = adaptAndDarkColor([UIColor colorTextBlack],[UIColor colorTextBlackDark]);
        _statelabel.text = @"";
        _statelabel.numberOfLines = 1;
        _statelabel.textAlignment = NSTextAlignmentRight;
        [_statelabel setFont:[UIFont boldFontSmall]];
    }
    return _statelabel;
}


- (UILabel *)failHintLabel {
    if (!_failHintLabel) {
        _failHintLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _failHintLabel.textColor = adaptAndDarkColor([UIColor colorTextBlack],[UIColor colorTextBlackDark]);
        _failHintLabel.text = @"失败原因:";
        _failHintLabel.numberOfLines = 1;
        _failHintLabel.textAlignment = NSTextAlignmentLeft;
        [_failHintLabel setFont:[UIFont fontSmall]];
    }
    return _failHintLabel;
}


- (UILabel *)failLabel {
    if (!_failLabel) {
        _failLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _failLabel.textColor = adaptAndDarkColor([UIColor colorTextGray],[UIColor colorTextGrayDark]);
        _failLabel.text = @"";
        _failLabel.numberOfLines = 0;
        _failLabel.textAlignment = NSTextAlignmentLeft;
        [_failLabel setFont:[UIFont fontSmall]];
    }
    return _failLabel;
}

- (UIButton *)payBtn {
    if (!_payBtn) {
        __weak typeof(self) weakSelf = self;
        _payBtn = [[UIButton alloc] initWithFrame:CGRectZero];
        [_payBtn setTitle:@"去支付" forState:UIControlStateNormal];
        [_payBtn setTitleColor:[UIColor colorWhite] forState:UIControlStateNormal];
        [_payBtn.titleLabel setFont:[UIFont fontContent]];
        _payBtn.backgroundColor = [UIColor colorMain];
        ViewBorderRadius(_payBtn, CGFloatIn750(28), CGFloatIn750(2), [UIColor colorMain]);
        [_payBtn bk_whenTapped:^{
            if (weakSelf.handleBlock) {
                weakSelf.handleBlock(0,self.model);
            };
        }];
    }
    return _payBtn;
}

- (UIButton *)closeBtn {
    if (!_closeBtn) {
        __weak typeof(self) weakSelf = self;
        _closeBtn = [[UIButton alloc] initWithFrame:CGRectZero];
        [_closeBtn setTitle:@"删除" forState:UIControlStateNormal];
        [_closeBtn setTitleColor:adaptAndDarkColor([UIColor colorTextGray], [UIColor colorTextGrayDark]) forState:UIControlStateNormal];
        [_closeBtn.titleLabel setFont:[UIFont fontContent]];
        ViewBorderRadius(_closeBtn, CGFloatIn750(28), CGFloatIn750(2), adaptAndDarkColor([UIColor colorTextGray], [UIColor colorTextGrayDark]));
        [_closeBtn bk_whenTapped:^{
            if (weakSelf.handleBlock) {
                weakSelf.handleBlock(1,self.model);
            };
        }];
    }
    return _closeBtn;
}

- (UIButton *)delBtn {
    if (!_delBtn) {
        __weak typeof(self) weakSelf = self;
        _delBtn = [[UIButton alloc] initWithFrame:CGRectZero];
        [_delBtn setTitle:@"删除订单" forState:UIControlStateNormal];
        [_delBtn setTitleColor:adaptAndDarkColor([UIColor colorTextGray], [UIColor colorTextGrayDark]) forState:UIControlStateNormal];
        [_delBtn.titleLabel setFont:[UIFont fontContent]];
        ViewBorderRadius(_delBtn, CGFloatIn750(28), CGFloatIn750(2), adaptAndDarkColor([UIColor colorTextGray], [UIColor colorTextGrayDark]));
        [_delBtn bk_whenTapped:^{
            if (weakSelf.handleBlock) {
                weakSelf.handleBlock(2,self.model);
            };
        }];
    }
    return _delBtn;
}


- (UIButton *)evaBtn {
    if (!_evaBtn) {
        __weak typeof(self) weakSelf = self;
        _evaBtn = [[UIButton alloc] initWithFrame:CGRectZero];
        [_evaBtn setTitle:@"评价" forState:UIControlStateNormal];
        [_evaBtn setTitleColor:adaptAndDarkColor([UIColor colorMain], [UIColor colorMain]) forState:UIControlStateNormal];
        [_evaBtn.titleLabel setFont:[UIFont fontContent]];
        ViewBorderRadius(_evaBtn, CGFloatIn750(28), CGFloatIn750(2), adaptAndDarkColor([UIColor colorMain], [UIColor colorMain]));
        [_evaBtn bk_whenTapped:^{
            if (weakSelf.handleBlock) {
                weakSelf.handleBlock(3,self.model);
            };
        }];
    }
    return _evaBtn;
}

#pragma mark - set model
- (void)setModel:(ZStudentOrderListModel *)model {
    _model = model;
    
    [self.leftImageView tt_setImageWithURL:[NSURL URLWithString:model.image]];
    self.statelabel.text = model.state;
    self.orderNameLabel.text = model.name;
    self.priceLabel.text = [NSString stringWithFormat:@"¥%@",model.price];
    self.detailLabel.text = [NSString stringWithFormat:@"体验时长：%@",model.tiTime];
    self.clubLabel.text = model.club;
    self.failLabel.text = model.fail;
    
    switch (model.type) {
        case ZStudentOrderTypeForPay:
        {
            self.statelabel.textColor = adaptAndDarkColor([UIColor colorTextBlack],[UIColor colorTextBlackDark]);
            
            [self.bottomView mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.left.bottom.right.equalTo(self.contView);
                make.height.mas_equalTo(CGFloatIn750(136));
            }];
            
            [self.midView mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.left.right.equalTo(self.contView);
                make.top.equalTo(self.topView.mas_bottom);
                make.bottom.equalTo(self.bottomView.mas_top);
            }];
            
            self.bottomView.hidden = NO;
            self.failView.hidden = YES;
            self.payBtn.hidden = NO;
            self.closeBtn.hidden = NO;
            
            self.evaBtn.hidden = YES;
            self.delBtn.hidden = YES;
            
            [self.payBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(self.bottomView.mas_centerY);
                make.right.equalTo(self.bottomView.mas_right).offset(CGFloatIn750(-30));
                make.height.mas_equalTo(CGFloatIn750(56));
                make.width.mas_equalTo(CGFloatIn750(142));
            }];
            
            [self.closeBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(self.bottomView.mas_centerY);
                make.right.equalTo(self.payBtn.mas_left).offset(CGFloatIn750(-20));
                make.height.mas_equalTo(CGFloatIn750(56));
                make.width.mas_equalTo(CGFloatIn750(172));
            }];
        }
            break;
        case ZStudentOrderTypeHadPay:
        {
            self.statelabel.textColor = adaptAndDarkColor([UIColor colorTextBlack],[UIColor colorTextBlackDark]);
            
            [self.bottomView mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.left.bottom.right.equalTo(self.contView);
                make.height.mas_equalTo(CGFloatIn750(136));
            }];
            
            [self.midView mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.left.right.equalTo(self.contView);
                make.top.equalTo(self.topView.mas_bottom);
                make.bottom.equalTo(self.bottomView.mas_top);
            }];
            
            self.bottomView.hidden = NO;
            self.failView.hidden = YES;
            self.payBtn.hidden = NO;
            self.closeBtn.hidden = YES;
            
            self.evaBtn.hidden = NO;
            self.delBtn.hidden = NO;
            
            
            [self.payBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(self.bottomView.mas_centerY);
                make.right.equalTo(self.bottomView.mas_right).offset(CGFloatIn750(-30));
                make.height.mas_equalTo(CGFloatIn750(56));
                make.width.mas_equalTo(CGFloatIn750(142));
            }];
            
            [self.evaBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(self.bottomView.mas_centerY);
                make.right.equalTo(self.payBtn.mas_left).offset(CGFloatIn750(-20));
                make.height.mas_equalTo(CGFloatIn750(56));
                make.width.mas_equalTo(CGFloatIn750(172));
            }];
            
            [self.delBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(self.bottomView.mas_centerY);
                make.right.equalTo(self.evaBtn.mas_left).offset(CGFloatIn750(-20));
                make.height.mas_equalTo(CGFloatIn750(56));
                make.width.mas_equalTo(CGFloatIn750(182));
            }];
        }
            break;
        case ZStudentOrderTypeComplete:
        {
            self.statelabel.textColor = adaptAndDarkColor([UIColor colorTextGray1],[UIColor colorTextGray1Dark]);
            self.detailLabel.text = @"审核中...";
            
            
            [self.midView mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.left.right.equalTo(self.contView);
                make.top.equalTo(self.topView.mas_bottom);
                make.bottom.equalTo(self.contView.mas_bottom).offset(-CGFloatIn750(40));
            }];
            
            self.bottomView.hidden = YES;
            self.failView.hidden = YES;
            self.payBtn.hidden = YES;
            self.closeBtn.hidden = YES;
            
            self.evaBtn.hidden = YES;
            self.delBtn.hidden = YES;
            
        }
            break;
        case ZStudentOrderTypeForReceived:
        {
            self.statelabel.textColor = adaptAndDarkColor([UIColor colorRedDefault],[UIColor colorRedDefault]);
            self.detailLabel.text = @"";
            
            [self.bottomView mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.left.right.equalTo(self.contView);
                make.bottom.equalTo(self.contView.mas_bottom);
                make.height.mas_equalTo(CGFloatIn750(136));
            }];
            
            NSString *fail = self.model.fail ? self.model.fail : @"";
            CGSize failSize = [fail tt_sizeWithFont:[UIFont fontSmall] constrainedToSize:CGSizeMake((KScreenWidth - CGFloatIn750(30) * 2 - CGFloatIn750(30) - CGFloatIn750(16) - CGFloatIn750(240) - CGFloatIn750(30)), MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping lineSpace:CGFloatIn750(10)];
            
            [self.failView mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.left.right.equalTo(self.contView);
                make.bottom.equalTo(self.bottomView.mas_top);
                make.height.mas_equalTo(CGFloatIn750(36) + failSize.height + 4);
            }];
            
            [self.failHintLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.right.equalTo(self.leftImageView);
                make.top.equalTo(self.failView.mas_top).offset(CGFloatIn750(34));
            }];
            
            
            [self.failLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.failHintLabel.mas_right).offset(CGFloatIn750(16));
                make.top.equalTo(self.failHintLabel.mas_top);
                make.right.equalTo(self.failView.mas_right).offset(-CGFloatIn750(30));
            }];
            
            [self.midView mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.left.right.equalTo(self.contView);
                make.top.equalTo(self.topView.mas_bottom);
                make.bottom.equalTo(self.failView.mas_top);
            }];
            
            
            self.bottomView.hidden = NO;
            self.failView.hidden = NO;
            self.payBtn.hidden = NO;
            self.closeBtn.hidden = YES;
                       
            self.evaBtn.hidden = YES;
            self.delBtn.hidden = NO;
            
            [self.payBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(self.bottomView.mas_centerY);
                make.right.equalTo(self.bottomView.mas_right).offset(CGFloatIn750(-30));
                make.height.mas_equalTo(CGFloatIn750(56));
                make.width.mas_equalTo(CGFloatIn750(116));
            }];
            
            [self.delBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(self.bottomView.mas_centerY);
                make.right.equalTo(self.payBtn.mas_left).offset(CGFloatIn750(-20));
                make.height.mas_equalTo(CGFloatIn750(56));
                make.width.mas_equalTo(CGFloatIn750(182));
            }];
            
            [ZPublicTool setLineSpacing:CGFloatIn750(10) label:self.failLabel];
        }
            break;
            
        default:
            break;
    }
}

+ (CGFloat)z_getCellHeight:(id)sender {
    if (sender && [sender isKindOfClass:[ZStudentOrderListModel class]]) {
        ZStudentOrderListModel *listModel = (ZStudentOrderListModel *)sender;
        if (listModel.type == ZStudentOrderTypeComplete) {
            return CGFloatIn750(318);
        }else if (listModel.type == ZStudentOrderTypeForReceived){
            NSString *fail = listModel.fail ? listModel.fail : @"";
            CGSize failSize = [fail tt_sizeWithFont:[UIFont fontSmall] constrainedToSize:CGSizeMake((KScreenWidth - CGFloatIn750(30) * 2 - CGFloatIn750(30) - CGFloatIn750(16) - CGFloatIn750(240) - CGFloatIn750(30)), MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping lineSpace:CGFloatIn750(10)];
            return CGFloatIn750(414) + failSize.height + CGFloatIn750(40);
        } else{
            return CGFloatIn750(414);
        }
    }
    
    return CGFloatIn750(0);
}

- (void)traitCollectionDidChange:(UITraitCollection *)previousTraitCollection {
    ViewBorderRadius(_closeBtn, CGFloatIn750(28), CGFloatIn750(2), adaptAndDarkColor([UIColor colorTextGray], [UIColor colorTextGrayDark]));
    
    ViewBorderRadius(_delBtn, CGFloatIn750(28), CGFloatIn750(2), adaptAndDarkColor([UIColor colorTextGray], [UIColor colorTextGrayDark]));
    
    _clubImageView.tintColor = adaptAndDarkColor([UIColor colorBlack], [UIColor colorWhite]);
    ViewShadowRadius(_contView, CGFloatIn750(30), CGSizeMake(0, 0), 0.5, isDarkModel() ? [UIColor colorGrayContentBGDark] : [UIColor colorGrayContentBG]);
}
@end
