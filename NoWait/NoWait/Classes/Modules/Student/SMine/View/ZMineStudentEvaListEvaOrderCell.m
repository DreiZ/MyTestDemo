//
//  ZMineStudentEvaListEvaOrderCell.m
//  NoWait
//
//  Created by zhuang zhang on 2020/1/14.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZMineStudentEvaListEvaOrderCell.h"
@interface ZMineStudentEvaListEvaOrderCell ()

@property (nonatomic,strong) UIImageView *lessonImageVIew;
@property (nonatomic,strong) UILabel *orderSNLabel;
@property (nonatomic,strong) UILabel *lessonLabel;
@property (nonatomic,strong) UILabel *cocahLabel;
@property (nonatomic,strong) UIButton *orderDetailBtn;

@end

@implementation ZMineStudentEvaListEvaOrderCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupView];
    }
    return self;
}

-(void)setupView {
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.contentView.backgroundColor = KWhiteColor;
    
    UIView *contView = [[UIView alloc] init];
    [self.contentView addSubview:contView];
    [contView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView);
    }];
    
    
    UIView *topView = [[UIView alloc] initWithFrame:CGRectZero];
    topView.backgroundColor = KWhiteColor;
    [contView addSubview:topView];
    [topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(CGFloatIn750(80));
        make.left.right.top.equalTo(contView);
    }];

    
    UIView *middleView = [[UIView alloc] initWithFrame:CGRectZero];
    middleView.backgroundColor = KWhiteColor;
    [contView addSubview:middleView];
    [middleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(topView.mas_bottom);
        make.bottom.equalTo(self.mas_bottom);
        make.left.right.equalTo(contView);
    }];


    [topView addSubview:self.orderSNLabel];
    [topView addSubview:self.orderDetailBtn];
    
    [middleView addSubview:self.lessonImageVIew];
    [middleView addSubview:self.lessonLabel];
    [middleView addSubview:self.cocahLabel];
    
    [self.orderSNLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(topView.mas_left).offset(CGFloatIn750(30));
        make.centerY.equalTo(topView.mas_centerY);
    }];
    
    UIView *bottomLineView = [[UIView alloc] initWithFrame:CGRectZero];
    bottomLineView.backgroundColor = KLineColor;
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
    
    
    [self.cocahLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.lessonImageVIew.mas_right).offset(CGFloatIn750(20));
        make.bottom.equalTo(self.lessonImageVIew.mas_bottom).offset(CGFloatIn750(-10));

    }];
    
    [self.orderDetailBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.bottom.equalTo(topView);
        make.width.mas_equalTo(CGFloatIn750(150));
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
        _orderSNLabel.textColor = KFont2Color;
        _orderSNLabel.text = @"订单号：NS239854385892";
        _orderSNLabel.numberOfLines = 1;
        _orderSNLabel.textAlignment = NSTextAlignmentLeft;
        [_orderSNLabel setFont:[UIFont systemFontOfSize:CGFloatIn750(28)]];
    }
    return _orderSNLabel;
}


- (UILabel *)lessonLabel {
    if (!_lessonLabel) {
        _lessonLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _lessonLabel.textColor = KFont3Color;
        _lessonLabel.text = @"暑期瑜伽班";
        _lessonLabel.numberOfLines = 1;
        _lessonLabel.textAlignment = NSTextAlignmentLeft;
        [_lessonLabel setFont:[UIFont systemFontOfSize:CGFloatIn750(28)]];
    }
    return _lessonLabel;
}


- (UILabel *)cocahLabel {
    if (!_cocahLabel) {
        _cocahLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _cocahLabel.textColor = KFont6Color;
        _cocahLabel.text = @"财源健身房-钟教练";
        _cocahLabel.numberOfLines = 1;
        _cocahLabel.textAlignment = NSTextAlignmentLeft;
        [_cocahLabel setFont:[UIFont systemFontOfSize:CGFloatIn750(24)]];
    }
    return _cocahLabel;
}

- (UIButton *)orderDetailBtn {
    if (!_orderDetailBtn) {
        _orderDetailBtn = [[UIButton alloc] initWithFrame:CGRectZero];
        _orderDetailBtn.layer.masksToBounds = YES;
        [_orderDetailBtn setTitle:@"查看详情>>" forState:UIControlStateNormal];
        [_orderDetailBtn setTitleColor:KFont6Color forState:UIControlStateNormal];
        [_orderDetailBtn.titleLabel setFont:[UIFont systemFontOfSize:CGFloatIn750(24)]];
        
        __weak typeof(self) weakSelf = self;
        [_orderDetailBtn bk_whenTapped:^{
            if (weakSelf.detailBlock) {
                weakSelf.detailBlock();
            }
        }];
    }
    return _orderDetailBtn;
}

+(CGFloat)z_getCellHeight:(id)sender {
    return CGFloatIn750(244+40);
}
@end

