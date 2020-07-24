//
//  ZStudentTitleStarCell.m
//  NoWait
//
//  Created by zhuang zhang on 2020/7/24.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZStudentTitleStarCell.h"
#import "CWStarRateView.h"

@interface ZStudentTitleStarCell ()

@property (nonatomic,strong) UILabel *evaTitleLabel;
@property (nonatomic,strong) CWStarRateView *crView;
@end

@implementation ZStudentTitleStarCell

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
        _evaTitleLabel.textColor = adaptAndDarkColor([UIColor colorTextBlack], [UIColor colorTextBlackDark]);
        _evaTitleLabel.numberOfLines = 1;
        _evaTitleLabel.textAlignment = NSTextAlignmentLeft;
        [_evaTitleLabel setFont:[UIFont boldFontTitle]];
    }
    return _evaTitleLabel;
}

- (void)setScore:(NSString *)score {
    _score = score;
    _crView.scorePercent = [score intValue]/5.0f;
}

- (void)setTitle:(NSString *)title {
    _title = title;
    _evaTitleLabel.text = title;
}

+(CGFloat)z_getCellHeight:(id)sender {
    return CGFloatIn750(38);
}
@end


