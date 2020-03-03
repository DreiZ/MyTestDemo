//
//  ZStudentMineSignDetailHandleCell.m
//  NoWait
//
//  Created by zhuang zhang on 2020/1/15.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZStudentMineSignDetailHandleCell.h"
@interface ZStudentMineSignDetailHandleCell ()
@property (nonatomic,strong) UILabel *lessonLabel;
@property (nonatomic,strong) UIButton *signBtn;
@property (nonatomic,strong) UILabel *timeLabel;
@property (nonatomic,strong) UILabel *rightLabel;
@end

@implementation ZStudentMineSignDetailHandleCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupView];
    }
    return self;
}

-(void)setupView
{
    [super setupView];
    
    [self.contentView addSubview:self.lessonLabel];
    [self.contentView addSubview:self.signBtn];
    [self.contentView addSubview:self.timeLabel];
    [self.contentView addSubview:self.rightLabel];
    
    
    [self.lessonLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).offset(CGFloatIn750(30));
        make.centerY.equalTo(self.contentView.mas_centerY);
        make.width.mas_equalTo(CGFloatIn750(200));
    }];
    
    [self.signBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView.mas_right).offset(-CGFloatIn750(30));
        make.centerY.equalTo(self.contentView.mas_centerY);
        make.width.mas_equalTo(CGFloatIn750(98));
        make.height.mas_equalTo(CGFloatIn750(48));
    }];
    
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(CGFloatIn750(242));
        make.centerY.equalTo(self.mas_centerY);
    }];
    
    [self.rightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.signBtn.mas_left).offset(-CGFloatIn750(30));
        make.centerY.equalTo(self.mas_centerY);
    }];
}


- (UILabel *)lessonLabel {
    if (!_lessonLabel) {
        _lessonLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _lessonLabel.textColor = adaptAndDarkColor([UIColor colorTextBlack], [UIColor colorTextBlackDark]);
        _lessonLabel.text = @"第1节";
        _lessonLabel.numberOfLines = 1;
        _lessonLabel.textAlignment = NSTextAlignmentLeft;
        [_lessonLabel setFont:[UIFont fontContent]];
    }
    return _lessonLabel;
}

- (UILabel *)timeLabel {
    if (!_timeLabel) {
        _timeLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _timeLabel.textColor = adaptAndDarkColor([UIColor colorTextGray], [UIColor colorTextGrayDark]);
        _timeLabel.text = @"2019.05.12 15:30";
        _timeLabel.numberOfLines = 1;
        _timeLabel.textAlignment = NSTextAlignmentLeft;
        [_timeLabel setFont:[UIFont fontSmall]];
    }
    return _timeLabel;
}

- (UILabel *)rightLabel {
    if (!_rightLabel) {
        _rightLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _rightLabel.textColor = adaptAndDarkColor([UIColor colorTextGray], [UIColor colorTextGrayDark]);
        _rightLabel.text = @"已扫码签课";
        _rightLabel.numberOfLines = 1;
        _rightLabel.textAlignment = NSTextAlignmentRight;
        [_rightLabel setFont:[UIFont fontContent]];
    }
    return _rightLabel;
}


- (UIButton *)signBtn {
    if (!_signBtn) {
        _signBtn = [[UIButton alloc] initWithFrame:CGRectZero];
        ViewRadius(_signBtn, CGFloatIn750(24));
        
        [_signBtn setTitle:@"签课" forState:UIControlStateNormal];
        [_signBtn setTitleColor:[UIColor colorWhite] forState:UIControlStateNormal];
        [_signBtn.titleLabel setFont:[UIFont fontContent]];
        _signBtn.backgroundColor = [UIColor colorMain];
        
        __weak typeof(self) weakSelf = self;
        [_signBtn bk_whenTapped:^{
            if (weakSelf.handleBlock) {
                weakSelf.handleBlock(1);
            }
        }];
    }
    return _signBtn;
}



+(CGFloat)z_getCellHeight:(id)sender {
    return CGFloatIn750(80);
}
@end

