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
@property (nonatomic,strong) CWStarRateView *crView;
@end

@implementation ZMineStudentEvaListEvaCoachCell

-(void)setupView {
    [super setupView];
    
    [self.contentView addSubview:self.evaTitleLabel];
    [self.contentView addSubview:self.crView];
    
    [self.evaTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).offset(CGFloatIn750(30));
        make.centerY.equalTo(self.contentView.mas_centerY);
    }];
    
    [self.crView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(CGFloatIn750(12));
        make.left.equalTo(self.evaTitleLabel.mas_right).offset(CGFloatIn750(10));
        make.width.offset(CGFloatIn750(100));
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
        _evaTitleLabel.textColor = adaptAndDarkColor([UIColor colorTextGray], [UIColor colorTextGrayDark]);
        _evaTitleLabel.text = @"2013-12-02";
        _evaTitleLabel.numberOfLines = 1;
        _evaTitleLabel.textAlignment = NSTextAlignmentLeft;
        [_evaTitleLabel setFont:[UIFont fontMin]];
    }
    return _evaTitleLabel;
}

- (void)setModel:(ZOrderEvaListModel *)model {
    _model = model;
    _evaTitleLabel.text = [model.update_at timeStringWithFormatter:@"yyyy-MM-dd"];
    _crView.scorePercent = [model.score intValue]/5.0f;
}

+(CGFloat)z_getCellHeight:(id)sender {
    return CGFloatIn750(38);
}
@end

