//
//  ZMineStudentEvaListNoEvaCell.m
//  NoWait
//
//  Created by zhuang zhang on 2020/1/14.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZMineStudentEvaListNoEvaCell.h"
@interface ZMineStudentEvaListNoEvaCell ()

@property (nonatomic,strong) UIImageView *lessonImageVIew;
@property (nonatomic,strong) UILabel *orderSNLabel;
@property (nonatomic,strong) UILabel *lessonLabel;
@property (nonatomic,strong) UILabel *orderStateLabel;
@property (nonatomic,strong) UILabel *cocahLabel;
@property (nonatomic,strong) UIButton *evaBtn;

@end

@implementation ZMineStudentEvaListNoEvaCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupView];
    }
    return self;
}

-(void)setupView {
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.contentView.backgroundColor = adaptAndDarkColor([UIColor colorGrayBG], [UIColor colorGrayBGDark]);
    
    UIView *contView = [[UIView alloc] init];
    contView.layer.masksToBounds = YES;
    contView.layer.cornerRadius = CGFloatIn750(12);
    [self.contentView addSubview:contView];
    [contView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).offset(CGFloatIn750(20));
        make.right.equalTo(self.contentView.mas_right).offset(CGFloatIn750(-20));
        make.top.equalTo(self.contentView);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-CGFloatIn750(30));
    }];
    
    
    UIView *topView = [[UIView alloc] initWithFrame:CGRectZero];
    topView.backgroundColor = adaptAndDarkColor([UIColor colorWhite], [UIColor colorBlackBGDark]);
    [contView addSubview:topView];
    [topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(CGFloatIn750(80));
        make.left.right.top.equalTo(contView);
    }];

    UIView *bottomView = [[UIView alloc] initWithFrame:CGRectZero];
    bottomView.backgroundColor = adaptAndDarkColor([UIColor colorWhite], [UIColor colorBlackBGDark]);
    [contView addSubview:bottomView];
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(CGFloatIn750(88));
        make.left.right.bottom.equalTo(contView);
    }];
    
    UIView *middleView = [[UIView alloc] initWithFrame:CGRectZero];
    middleView.backgroundColor = adaptAndDarkColor([UIColor colorWhite], [UIColor colorBlackBGDark]);
    [contView addSubview:middleView];
    [middleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(topView.mas_bottom);
        make.bottom.equalTo(bottomView.mas_top);
        make.left.right.equalTo(contView);
    }];


    [topView addSubview:self.orderSNLabel];
    [bottomView addSubview:self.evaBtn];
    
    [middleView addSubview:self.lessonImageVIew];
    [middleView addSubview:self.lessonLabel];
    [middleView addSubview:self.cocahLabel];
    [middleView addSubview:self.orderStateLabel];
    
    [self.orderSNLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(topView.mas_left).offset(CGFloatIn750(30));
        make.centerY.equalTo(topView.mas_centerY);
    }];
    
    UIView *bottomLineView = [[UIView alloc] initWithFrame:CGRectZero];
    bottomLineView.backgroundColor = adaptAndDarkColor([UIColor colorGrayLine], [UIColor colorGrayBGDark]);
    [topView addSubview:bottomLineView];
    [bottomLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(topView);
        make.height.mas_equalTo(0.5);
    }];
    
    [self.lessonImageVIew mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(middleView.mas_top).offset(CGFloatIn750(22));
        make.left.equalTo(contView.mas_left).offset(CGFloatIn750(30));
        make.width.mas_equalTo(CGFloatIn750(160));
        make.height.mas_equalTo(CGFloatIn750(120));
    }];

    
    [self.lessonLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.lessonImageVIew.mas_right).offset(CGFloatIn750(20));
        make.top.equalTo(self.lessonImageVIew.mas_top).offset(CGFloatIn750(10));
        make.right.equalTo(middleView.mas_right).offset(-CGFloatIn750(20));
    }];
    
    [self.orderStateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.lessonImageVIew.mas_right).offset(CGFloatIn750(20));
        make.top.equalTo(self.lessonLabel.mas_bottom).offset(CGFloatIn750(14));
    }];
    
    [self.cocahLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.lessonImageVIew.mas_right).offset(CGFloatIn750(20));
        make.top.equalTo(self.orderStateLabel.mas_bottom).offset(CGFloatIn750(14));

    }];
    
    [self.evaBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(bottomView.mas_right).offset(-CGFloatIn750(20));
        make.centerY.equalTo(bottomView.mas_centerY);
        make.height.mas_equalTo(CGFloatIn750(40));
        make.width.mas_equalTo(CGFloatIn750(100));
    }];
    
    __weak typeof(self) weakSelf = self;
    UIButton *eva = [[UIButton alloc] initWithFrame:CGRectZero];
    [eva bk_whenTapped:^{
        if (weakSelf.evaBlock) {
            weakSelf.evaBlock();
        }
    }];
    [bottomView addSubview:eva];
    [eva mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(CGFloatIn750(160));
        make.right.top.bottom.equalTo(bottomView);
    }];
    
    
    UIView *evabottomLineView = [[UIView alloc] initWithFrame:CGRectZero];
    evabottomLineView.backgroundColor = adaptAndDarkColor([UIColor colorGrayLine], [UIColor colorGrayBGDark]);
    [bottomView addSubview:evabottomLineView];
    [evabottomLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(bottomView);
        make.height.mas_equalTo(0.5);
    }];
}


#pragma mark -Getter
-(UIImageView *)lessonImageVIew {
    if (!_lessonImageVIew) {
        _lessonImageVIew = [[UIImageView alloc] init];
        _lessonImageVIew.image = [UIImage imageNamed:@"lessonOrder"];
        _lessonImageVIew.contentMode = UIViewContentModeScaleAspectFill;
        _lessonImageVIew.clipsToBounds = YES;
    }
    
    return _lessonImageVIew;
}

- (UILabel *)orderSNLabel {
    if (!_orderSNLabel) {
        _orderSNLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _orderSNLabel.textColor = adaptAndDarkColor([UIColor colorTextBlack], [UIColor colorTextBlackDark]);
        _orderSNLabel.text = @"订单号：NS239854385892";
        _orderSNLabel.numberOfLines = 1;
        _orderSNLabel.textAlignment = NSTextAlignmentLeft;
        [_orderSNLabel setFont:[UIFont fontContent]];
    }
    return _orderSNLabel;
}


- (UILabel *)lessonLabel {
    if (!_lessonLabel) {
        _lessonLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _lessonLabel.textColor = adaptAndDarkColor([UIColor colorTextBlack], [UIColor colorTextBlackDark]);
        _lessonLabel.text = @"暑期瑜伽班";
        _lessonLabel.numberOfLines = 1;
        _lessonLabel.textAlignment = NSTextAlignmentLeft;
        [_lessonLabel setFont:[UIFont fontContent]];
    }
    return _lessonLabel;
}

- (UILabel *)orderStateLabel {
    if (!_orderStateLabel) {
        _orderStateLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _orderStateLabel.textColor = [UIColor colorRedDefault];
        _orderStateLabel.text = @"已支付：233元";
        _orderStateLabel.numberOfLines = 1;
        _orderStateLabel.textAlignment = NSTextAlignmentLeft;
        [_orderStateLabel setFont:[UIFont fontSmall]];
    }
    return _orderStateLabel;
}

- (UILabel *)cocahLabel {
    if (!_cocahLabel) {
        _cocahLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _cocahLabel.textColor = [UIColor colorTextGray];
        _cocahLabel.text = @"财源健身房-钟教练";
        _cocahLabel.numberOfLines = 1;
        _cocahLabel.textAlignment = NSTextAlignmentLeft;
        [_cocahLabel setFont:[UIFont fontSmall]];
    }
    return _cocahLabel;
}

- (UIButton *)evaBtn {
    if (!_evaBtn) {
        _evaBtn = [[UIButton alloc] initWithFrame:CGRectZero];
        _evaBtn.layer.masksToBounds = YES;
        _evaBtn.layer.cornerRadius = 3;
        _evaBtn.layer.borderColor = [UIColor  colorMain].CGColor;
        _evaBtn.layer.borderWidth = 1;
        [_evaBtn setTitle:@"去评价" forState:UIControlStateNormal];
        [_evaBtn setTitleColor:[UIColor  colorMain] forState:UIControlStateNormal];
        [_evaBtn.titleLabel setFont:[UIFont fontSmall]];
        
        __weak typeof(self) weakSelf = self;
        [_evaBtn bk_whenTapped:^{
            if (weakSelf.evaBlock) {
                weakSelf.evaBlock();
            }
        }];
    }
    return _evaBtn;
}

+(CGFloat)z_getCellHeight:(id)sender {
    return CGFloatIn750(340+40);
}
@end
