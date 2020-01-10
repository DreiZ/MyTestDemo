//
//  ZStudentLessonOrderNormalCell.m
//  NoWait
//
//  Created by zhuang zhang on 2020/1/10.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZStudentLessonOrderNormalCell.h"

@interface ZStudentLessonOrderNormalCell ()
@property (nonatomic,strong) UIImageView *arrowImageView;
@property (nonatomic,strong) UILabel *leftTitleLabel;
@property (nonatomic,strong) UILabel *rightTitleLabel;
@property (nonatomic,strong) UIView *bottomLineView;


@property (nonatomic,strong) NSDictionary *data;
@end

@implementation ZStudentLessonOrderNormalCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        [self initMainView];
    }
    
    return self;
}

- (void)initMainView {
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.backgroundColor = [UIColor whiteColor];
    self.clipsToBounds = YES;
    
    [self.contentView addSubview:self.arrowImageView];
    [self.contentView addSubview:self.leftTitleLabel];
    [self.contentView addSubview:self.rightTitleLabel];
    [self.contentView addSubview:self.bottomLineView];
    
    [self.arrowImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView.mas_centerY);
        make.right.equalTo(self.contentView.mas_right).offset(-12);
    }];
    
    [self.leftTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView.mas_centerY);
        make.left.equalTo(self.contentView.mas_left).offset(12);
    }];
    
    [self.rightTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.arrowImageView.mas_left).offset(-4);
        make.centerY.equalTo(self.contentView.mas_centerY);
        make.height.width.mas_equalTo(CGFloatIn750(272));
    }];
    
    
    [self.bottomLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.contentView);
        make.height.mas_equalTo(0.5);
    }];
}



#pragma mark -Getter
- (UIImageView *)arrowImageView {
    if (!_arrowImageView) {
        _arrowImageView = [[UIImageView alloc] init];
        _arrowImageView.image = [UIImage imageNamed:@"mineLessonRight"];
        _arrowImageView.layer.masksToBounds = YES;
        _arrowImageView.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _arrowImageView;
}

- (UILabel *)leftTitleLabel {
    if (!_leftTitleLabel) {
        _leftTitleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _leftTitleLabel.textColor = KBlackColor;
        _leftTitleLabel.text = @"标题";
        _leftTitleLabel.numberOfLines = 1;
        _leftTitleLabel.textAlignment = NSTextAlignmentLeft;
        [_leftTitleLabel setFont:[UIFont systemFontOfSize:CGFloatIn750(30)]];
    }
    return _leftTitleLabel;
}

- (UILabel *)rightTitleLabel {
    if (!_rightTitleLabel) {
        _rightTitleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _rightTitleLabel.textColor = KFont9Color;
        _rightTitleLabel.text = @"";
        _rightTitleLabel.numberOfLines = 1;
        _rightTitleLabel.textAlignment = NSTextAlignmentRight;
        [_rightTitleLabel setFont:[UIFont systemFontOfSize:CGFloatIn750(30)]];
    }
    return _rightTitleLabel;
}

- (UIView *)bottomLineView {
    if (!_bottomLineView) {
        _bottomLineView = [[UIView alloc] init];
        _bottomLineView.layer.masksToBounds = YES;
        _bottomLineView.backgroundColor = KLineColor;
    }
    return _bottomLineView;
}

- (void)setData:(NSDictionary *)data {
    if (data && [data objectForKey:@"title"] && [data[@"title"] isKindOfClass:[NSString class]]) {
        self.leftTitleLabel.text = data[@"title"];
    }
    
    if (data && [data objectForKey:@"right"] && [data[@"right"] isKindOfClass:[NSString class]]) {
        self.rightTitleLabel.text = data[@"right"];
    }else{
        self.rightTitleLabel.text = @"";
    }
    
    if (data && [data objectForKey:@"arrow"] && [data[@"arrow"] isKindOfClass:[NSString class]]) {
        NSString *arrow = data[@"arrow"];
        if (arrow.length > 0) {
            self.arrowImageView.hidden = NO;
            [self.arrowImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(self.contentView.mas_centerY);
                make.right.equalTo(self.contentView.mas_right).offset(-12);
            }];
        }else{
            self.arrowImageView.hidden = YES;
            [self.arrowImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(self.contentView.mas_centerY);
                make.right.equalTo(self.contentView.mas_right).offset(-0);
            }];
        }
    }else{
        self.arrowImageView.hidden = YES;
        [self.arrowImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.contentView.mas_centerY);
            make.right.equalTo(self.contentView.mas_right).offset(-0);
        }];
    }
    
    if (data && [data objectForKey:@"color"] && [data[@"color"] isKindOfClass:[UIColor class]]) {
        self.rightTitleLabel.textColor = data[@"color"];
    }else{
        self.rightTitleLabel.textColor = KFont6Color;
    }
    
    
}

- (void)setBottomLineHidden:(BOOL)isHidden {
    self.bottomLineView.hidden = isHidden;
}

+ (CGFloat)z_getCellHeight:(id)sender {
    return CGFloatIn750(100);
}
@end


