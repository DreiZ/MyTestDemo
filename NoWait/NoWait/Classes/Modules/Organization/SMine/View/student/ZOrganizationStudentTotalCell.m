//
//  ZOrganizationStudentTotalCell.m
//  NoWait
//
//  Created by zhuang zhang on 2020/9/8.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZOrganizationStudentTotalCell.h"
#import "ZNumberCalculateView.h"

@interface ZOrganizationStudentTotalCell ()
@property (nonatomic,strong) UILabel *nameLabel;
@property (nonatomic,strong) ZNumberCalculateView *number;
@end

@implementation ZOrganizationStudentTotalCell

-(void)setupView {
    [super setupView];
    self.contentView.backgroundColor = adaptAndDarkColor([UIColor colorWhite],[UIColor colorBlackBGDark]);
    
    [self.contentView addSubview:self.nameLabel];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).offset(CGFloatIn750(30));
        make.centerY.equalTo(self.contentView.mas_centerY);
    }];
    
    [self.contentView addSubview:self.number];
    [self.number mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView.mas_centerY);
        make.width.mas_equalTo(CGFloatIn750(280));
        make.top.bottom.equalTo(self.contentView);
        make.right.equalTo(self.contentView.mas_right).offset(-CGFloatIn750(30));
    }];
    self.number.unit = @"节  ";
    
    __weak typeof(self) weakSelf = self;
    _number.resultNumber = ^(NSInteger number) {
        DLog(@"%ld>>>resultBlock>>",number);
        if (weakSelf.valueChangeBlock) {
            weakSelf.valueChangeBlock(number);
        }
    };
}

- (UILabel *)nameLabel {
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _nameLabel.textColor = adaptAndDarkColor([UIColor colorTextBlack],[UIColor colorTextBlackDark]);
        _nameLabel.numberOfLines = 0;
        
        _nameLabel.textAlignment = NSTextAlignmentLeft;
        [_nameLabel setFont:[UIFont fontContent]];
    }
    return _nameLabel;
}



- (void)setNum:(NSInteger)num {
    self.number.showNum = num;
}

- (void)setUnit:(NSString *)unit {
    self.number.unit = [NSString stringWithFormat:@"%@  ",unit];
}

- (void)setTitle:(NSString *)title {
    self.nameLabel.text = title;
}

- (void)setMin:(NSInteger)min {
    _number.minNum = min;
}

- (ZNumberCalculateView *)number {
    if (!_number) {
        _number = [[ZNumberCalculateView alloc] initWithNumberWidth:CGFloatIn750(240) height:CGFloatIn750(60)];
        _number.numCornerRadius = 6;
        _number.showNum = 0;
        _number.multipleNum = 1;//数值增减基数（倍数增减） 默认1的倍数增减
        _number.minNum = 1;
        _number.maxNum = 999;//最大值
    }
    return _number;
}

+ (CGFloat)z_getCellHeight:(id)sender {
    return CGFloatIn750(88);
}
@end
