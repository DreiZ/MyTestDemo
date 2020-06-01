//
//  ZMessageHistoryReadCell.m
//  NoWait
//
//  Created by zhuang zhang on 2020/6/1.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZMessageHistoryReadCell.h"

@interface ZMessageHistoryReadCell ()
@property (nonatomic,strong) UILabel *historyLabel;

@end

@implementation ZMessageHistoryReadCell

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
    self.contentView.backgroundColor = adaptAndDarkColor([UIColor colorGrayBG], [UIColor colorGrayBGDark]);
    
    [self.contentView addSubview:self.historyLabel];
    [self.historyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.contentView.mas_centerX);
        make.centerY.equalTo(self.contentView.mas_centerY);
    }];
    
    UIView *leftLineView = [[UIView alloc] initWithFrame:CGRectZero];
    leftLineView.backgroundColor = adaptAndDarkColor([UIColor colorTextGray1], [UIColor colorTextGray]);
    [self.contentView addSubview:leftLineView];
    [leftLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView.mas_centerY);
        make.left.equalTo(self.contentView.mas_left).offset(CGFloatIn750(50));
        make.right.equalTo(self.historyLabel.mas_left).offset(-CGFloatIn750(20));
        make.height.mas_equalTo(0.5);
    }];

    UIView *rightLineView = [[UIView alloc] initWithFrame:CGRectZero];
    rightLineView.backgroundColor = adaptAndDarkColor([UIColor colorTextGray1], [UIColor colorTextGray]);
    [self.contentView addSubview:rightLineView];
    [rightLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView.mas_centerY);
        make.left.equalTo(self.historyLabel.mas_right).offset(CGFloatIn750(20));
        make.right.equalTo(self.contentView.mas_right).offset(-CGFloatIn750(50));
        make.height.mas_equalTo(0.5);
    }];
}


- (UILabel *)historyLabel {
    if (!_historyLabel) {
        _historyLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _historyLabel.textColor = adaptAndDarkColor([UIColor colorTextGray1], [UIColor colorTextGray1Dark]);
        _historyLabel.text = @"以下为历史消息";
        _historyLabel.numberOfLines = 1;
        _historyLabel.textAlignment = NSTextAlignmentCenter;
        [_historyLabel setFont:[UIFont fontSmall]];
    }
    return _historyLabel;
}

@end
