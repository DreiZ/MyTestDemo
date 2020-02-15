//
//  ZStudentLessonDetailLessonItemCell.m
//  NoWait
//
//  Created by zhuang zhang on 2020/1/9.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZStudentLessonDetailLessonItemCell.h"

@interface ZStudentLessonDetailLessonItemCell ()
@property (nonatomic,strong) UIView *dotView;
@property (nonatomic,strong) UILabel *titleLabel;

@end

@implementation ZStudentLessonDetailLessonItemCell
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
    self.contentView.backgroundColor = adaptAndDarkColor([UIColor colorWhite], [UIColor colorBlackBGDark]);
    self.clipsToBounds = YES;
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    [self.contentView addSubview:self.dotView];
    [self.contentView addSubview:self.titleLabel];
    
    [self.dotView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).offset(CGFloatIn750(20));
        make.left.equalTo(self.mas_left).offset(CGFloatIn750(30));
        make.width.height.mas_equalTo(CGFloatIn750(12));
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.dotView.mas_right).offset(CGFloatIn750(18));
        make.top.equalTo(self.mas_top).offset(CGFloatIn750(10));
        make.right.equalTo(self.mas_right).offset(-CGFloatIn750(30));
    }];
}

#pragma mark --lazy loading------
- (UIView *)dotView {
    if (!_dotView) {
        _dotView = [[UIView alloc] init];
        _dotView.layer.masksToBounds = YES;
        _dotView.layer.cornerRadius = CGFloatIn750(6);
        _dotView.backgroundColor = [UIColor colorGrayLine];
    }
    return _dotView;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _titleLabel.textColor = adaptAndDarkColor([UIColor colorTextBlack], [UIColor colorTextBlackDark]);
        _titleLabel.text = @"课程简介";
        _titleLabel.numberOfLines = 0;
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        [_titleLabel setFont:[UIFont fontContent]];
    }
    return _titleLabel;
}

- (void)setDetail:(NSString *)detail {
    _detail = detail;
    _titleLabel.text = detail;
}

+ (CGFloat)z_getCellHeight:(id)sender {
    NSString *detail = sender; //80  190
    CGSize tempSize = [detail tt_sizeWithFont:[UIFont fontContent] constrainedToSize:CGSizeMake(kScreenWidth- CGFloatIn750(80), MAXFLOAT)];
    if (tempSize.height < CGFloatIn750(32)) {
        return CGFloatIn750(36);
    }
    return tempSize.height + CGFloatIn750(20);
}
@end
