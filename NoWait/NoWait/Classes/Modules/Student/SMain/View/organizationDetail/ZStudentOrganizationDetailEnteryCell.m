//
//  ZStudentOrganizationDetailEnteryCell.m
//  NoWait
//
//  Created by zhuang zhang on 2020/3/21.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZStudentOrganizationDetailEnteryCell.h"

@interface ZStudentOrganizationDetailEnteryCell ()
@property (nonatomic,strong) UILabel *nameLabel;
@property (nonatomic,strong) UIImageView *organizationImageView;
@property (nonatomic,strong) UILabel *lessonLabel;
@property (nonatomic,strong) UIButton *openBtn;

@end

@implementation ZStudentOrganizationDetailEnteryCell
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
    
    [self.contentView addSubview:self.organizationImageView];
    [self.contentView addSubview:self.nameLabel];
    [self.contentView addSubview:self.openBtn];
    [self.contentView addSubview:self.lessonLabel];
    
    [self.organizationImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(CGFloatIn750(30));
        make.width.mas_equalTo(CGFloatIn750(120));
        make.height.mas_equalTo(CGFloatIn750(74));
        make.centerY.equalTo(self.mas_centerY);
    }];
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.organizationImageView.mas_top);
        make.left.equalTo(self.organizationImageView.mas_right).offset(CGFloatIn750(20));
        make.right.equalTo(self.openBtn.mas_left).offset(-CGFloatIn750(20));
    }];
    
    [self.lessonLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.organizationImageView.mas_bottom).offset(-CGFloatIn750(6));
        make.left.equalTo(self.organizationImageView.mas_right).offset(CGFloatIn750(20));
        make.right.equalTo(self.openBtn.mas_left).offset(-CGFloatIn750(20));
    }];
    
    [self.openBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView.mas_right).offset(-CGFloatIn750(30));
        make.width.mas_equalTo(CGFloatIn750(136));
        make.height.mas_equalTo(CGFloatIn750(48));
        make.centerY.equalTo(self.mas_centerY);
    }];
    
   [ _organizationImageView tt_setImageWithURL:[NSURL URLWithString:@"http://wx2.sinaimg.cn/mw600/5922e2ddly1gd181y4p42j20j60y246s.jpg"]];
}

- (UILabel *)nameLabel {
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _nameLabel.textColor = adaptAndDarkColor([UIColor colorTextBlack], [UIColor colorTextBlackDark]);
        _nameLabel.text = @"齐丽旺";
        _nameLabel.numberOfLines = 1;
        _nameLabel.textAlignment = NSTextAlignmentLeft;
        [_nameLabel setFont:[UIFont boldFontContent]];
    }
    return _nameLabel;
}

- (UILabel *)lessonLabel {
    if (!_lessonLabel) {
        _lessonLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _lessonLabel.textColor = adaptAndDarkColor([UIColor colorTextGray], [UIColor colorTextGrayDark]);
        _lessonLabel.text = @"瑜伽培训班";
        _lessonLabel.numberOfLines = 1;
        _lessonLabel.textAlignment = NSTextAlignmentLeft;
        [_lessonLabel setFont:[UIFont fontSmall]];
    }
    return _lessonLabel;
}

- (UIImageView *)organizationImageView {
    if (!_organizationImageView) {
        _organizationImageView = [[UIImageView alloc] init];
        _organizationImageView.contentMode = UIViewContentModeScaleAspectFill;
        ViewRadius(_organizationImageView, CGFloatIn750(16));
    }
    return _organizationImageView;
}


- (UIButton *)openBtn {
    if (!_openBtn) {
        __weak typeof(self) weakSelf = self;
        _openBtn = [[UIButton alloc] initWithFrame:CGRectZero];
        [_openBtn.titleLabel setFont:[UIFont fontMin]];
        [_openBtn setTitle:@"进入机构" forState:UIControlStateNormal];
        [_openBtn setTitleColor:adaptAndDarkColor([UIColor colorWhite], [UIColor colorWhite]) forState:UIControlStateNormal];
        ViewRadius(_openBtn, CGFloatIn750(24));
        _openBtn.backgroundColor = adaptAndDarkColor([UIColor colorMain], [UIColor colorMainDark]);
        [_openBtn bk_whenTapped:^{
            if (weakSelf.handleBlock) {
                weakSelf.handleBlock(1);
            };
        }];
    }
    return _openBtn;
}

+(CGFloat)z_getCellHeight:(id)sender {
    return CGFloatIn750(80);
}

@end




