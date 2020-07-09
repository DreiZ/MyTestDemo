//
//  ZOrganizationTimeRightCell.m
//  NoWait
//
//  Created by zhuang zhang on 2020/2/25.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZOrganizationTimeRightCell.h"

@interface ZOrganizationTimeRightCell ()

@property (nonatomic,strong) UILabel *nameLabel;
@property (nonatomic,strong) UIImageView *hintView;

@end

@implementation ZOrganizationTimeRightCell

-(void)setupView {
    [super setupView];
    
    [self.contentView addSubview:self.hintView];
    [self.contentView addSubview:self.nameLabel];
    
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.contentView);
    }];
    
    [self.hintView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView.mas_right).offset(CGFloatIn750(-30));
        make.centerY.equalTo(self.contentView.mas_centerY);
        make.height.mas_equalTo(CGFloatIn750(20));
        make.width.mas_equalTo(CGFloatIn750(20));
    }];
    
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(btnLong:)];
    longPress.minimumPressDuration = 0.5; //定义按的时间
    [self.contentView addGestureRecognizer:longPress];
}


- (void)btnLong:(UILongPressGestureRecognizer *)sender {
    if (sender.state == UIGestureRecognizerStateBegan) {
        if (self.handleBlock) {
            self.handleBlock(1);
        }
    }
}


#pragma mark -Getter
- (UILabel *)nameLabel {
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _nameLabel.textColor = adaptAndDarkColor([UIColor colorTextBlack],[UIColor colorTextBlackDark]);
        _nameLabel.text = @"添加时间段 >";
        _nameLabel.numberOfLines = 1;
        _nameLabel.textAlignment = NSTextAlignmentCenter;
        [_nameLabel setFont:[UIFont fontContent]];
    }
    return _nameLabel;
}

- (UIImageView *)hintView {
    if (!_hintView) {
        _hintView = [[UIImageView alloc] init];
        _hintView.backgroundColor = [UIColor colorRedForButton];
        ViewRadius(_hintView, CGFloatIn750(10));
    }
    return _hintView;
}

- (void)setModel:(ZBaseUnitModel *)model {
    _model = model;
   
    if (!ValidStr(model.data)) {
        if ([model.subName intValue] < 10) {
            _nameLabel.text = [NSString stringWithFormat:@"%@:0%@",model.name,model.subName];
        }else{
            _nameLabel.text = [NSString stringWithFormat:@"%@:%@",model.name,model.subName];
        }
    }else{
        _nameLabel.text = model.data;
    }
}

- (void)setTime:(NSString *)time {
    _time = time;
    _nameLabel.text = time;
}

+(CGFloat)z_getCellHeight:(id)sender {
    return CGFloatIn750(108);
}

@end

