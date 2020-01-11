//
//  ZStudentLessonOrderStatusCell.m
//  NoWait
//
//  Created by zhuang zhang on 2020/1/11.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZStudentLessonOrderStatusCell.h"

@interface ZStudentLessonOrderStatusCell ()
@property (nonatomic,strong) UIImageView *statusImageView;
@property (nonatomic,strong) UILabel *statusLabel;

@end

@implementation ZStudentLessonOrderStatusCell

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
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.backgroundColor = KMainColor;
    self.clipsToBounds = YES;
    
    [self.contentView addSubview:self.statusImageView];
    [self.contentView addSubview:self.statusLabel];
    
    [self.statusImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView.mas_centerY);
        make.left.equalTo(self.contentView.mas_left).offset(CGFloatIn750(26));
    }];
    
    [self.statusLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView.mas_centerY);
        make.left.equalTo(self.statusImageView.mas_right).offset(CGFloatIn750(16));
    }];
}

#pragma mark -Getter
-(UIImageView *)statusImageView {
    if (!_statusImageView) {
        _statusImageView = [[UIImageView alloc] init];
        _statusImageView.image = [UIImage imageNamed:@"orderStatus"];
        _statusImageView.contentMode = UIViewContentModeScaleAspectFill;
        _statusImageView.clipsToBounds = YES;
    }
    
    return _statusImageView;
}

- (UILabel *)statusLabel {
    if (!_statusLabel) {
        _statusLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _statusLabel.textColor = KWhiteColor;
        _statusLabel.text = @"等待商家确认";
        _statusLabel.numberOfLines = 1;
        _statusLabel.textAlignment = NSTextAlignmentLeft;
        [_statusLabel setFont:[UIFont systemFontOfSize:CGFloatIn750(26)]];
    }
    return _statusLabel;
}


+ (CGFloat)z_getCellHeight:(id)sender {
    return CGFloatIn750(100);
}
@end
