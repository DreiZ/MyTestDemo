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
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.backgroundColor = KAdaptAndDarkColor(KWhiteColor, K1aBackColor);
    self.clipsToBounds = YES;
    
    [self.contentView addSubview:self.lessonLabel];
    [self.contentView addSubview:self.signBtn];
    
    
    [self.lessonLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).offset(CGFloatIn750(27));
        make.centerY.equalTo(self.contentView.mas_centerY);
    }];
    
    [self.signBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView.mas_right).offset(-CGFloatIn750(30));
        make.centerY.equalTo(self.contentView.mas_centerY);
        make.width.mas_equalTo(CGFloatIn750(116));
        make.height.mas_equalTo(CGFloatIn750(46));
    }];
}


- (UILabel *)lessonLabel {
    if (!_lessonLabel) {
        _lessonLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _lessonLabel.textColor = KFont6Color;
        _lessonLabel.text = @"瑜伽第一节";
        _lessonLabel.numberOfLines = 1;
        _lessonLabel.textAlignment = NSTextAlignmentLeft;
        [_lessonLabel setFont:[UIFont boldSystemFontOfSize:CGFloatIn750(26)]];
    }
    return _lessonLabel;
}



- (UIButton *)signBtn {
    if (!_signBtn) {
        _signBtn = [[UIButton alloc] initWithFrame:CGRectZero];
        _signBtn.layer.masksToBounds = YES;
        _signBtn.layer.cornerRadius = CGFloatIn750(23);
        _signBtn.backgroundColor = KWhiteColor;
        _signBtn.layer.borderColor = KMainColor.CGColor;
        _signBtn.layer.borderWidth = 1;
        
        [_signBtn setTitle:@"签到" forState:UIControlStateNormal];
        [_signBtn setTitleColor:KMainColor forState:UIControlStateNormal];
        [_signBtn.titleLabel setFont:[UIFont systemFontOfSize:CGFloatIn750(28)]];
        
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

