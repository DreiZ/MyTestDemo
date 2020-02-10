//
//  ZMineStudentEvaListEvaCoachCell.m
//  NoWait
//
//  Created by zhuang zhang on 2020/1/14.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZMineStudentEvaListEvaCoachCell.h"
#import "CWStarRateView.h"

@interface ZMineStudentEvaListEvaCoachCell ()

@property (nonatomic,strong) UILabel *evaTitleLabel;
@property (nonatomic,strong) UILabel *evaDesLabel;
@property (nonatomic,strong) CWStarRateView *crView;
@end

@implementation ZMineStudentEvaListEvaCoachCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupView];
    }
    return self;
}

-(void)setupView {
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.contentView.backgroundColor = KAdaptAndDarkColor(KWhiteColor, K1aBackColor);
    
    [self.contentView addSubview:self.evaTitleLabel];
    [self.contentView addSubview:self.evaDesLabel];
    [self.contentView addSubview:self.crView];
    
    [self.evaTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).offset(CGFloatIn750(24));
        make.centerY.equalTo(self.contentView.mas_centerY);
    }];
    
   [self.evaDesLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       make.right.equalTo(self.contentView.mas_right).offset(CGFloatIn750(-24));
       make.centerY.equalTo(self.contentView.mas_centerY);
   }];

    [self.crView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(CGFloatIn750(30));
        make.right.equalTo(self.evaDesLabel.mas_left).offset(CGFloatIn750(-20));
        make.width.offset(CGFloatIn750(230.));
        make.centerY.equalTo(self.mas_centerY);
    }];
}


#pragma mark -Getter

-(CWStarRateView *)crView
{
    if (!_crView) {
        _crView = [[CWStarRateView alloc] init];
    }
    return _crView;
}


- (UILabel *)evaTitleLabel {
    if (!_evaTitleLabel) {
        _evaTitleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _evaTitleLabel.textColor = KMainColor;
        _evaTitleLabel.text = @"教练评价";
        _evaTitleLabel.numberOfLines = 1;
        _evaTitleLabel.textAlignment = NSTextAlignmentLeft;
        [_evaTitleLabel setFont:[UIFont systemFontOfSize:CGFloatIn750(28)]];
    }
    return _evaTitleLabel;
}


- (UILabel *)evaDesLabel {
    if (!_evaDesLabel) {
        _evaDesLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _evaDesLabel.textColor = KAdaptAndDarkColor(KFont9Color, KFont6Color);
        _evaDesLabel.text = @"很好";
        _evaDesLabel.numberOfLines = 1;
        _evaDesLabel.textAlignment = NSTextAlignmentRight;
        [_evaDesLabel setFont:[UIFont systemFontOfSize:CGFloatIn750(22)]];
    }
    return _evaDesLabel;
}


+(CGFloat)z_getCellHeight:(id)sender {
    return CGFloatIn750(40);
}
@end

