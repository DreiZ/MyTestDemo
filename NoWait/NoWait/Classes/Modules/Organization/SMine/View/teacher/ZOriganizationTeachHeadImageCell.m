//
//  ZOriganizationTeachHeadImageCell.m
//  NoWait
//
//  Created by zhuang zhang on 2020/2/21.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZOriganizationTeachHeadImageCell.h"

@interface ZOriganizationTeachHeadImageCell ()
@property (nonatomic,strong) UIImageView *headImageView;
@property (nonatomic,strong) UIButton *openBtn;

@end

@implementation ZOriganizationTeachHeadImageCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupView];
    }
    return self;
}

-(void)setupView {
    [super setupView];
    
    [self.contentView addSubview:self.headImageView];
    
    
    [self.headImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).offset(CGFloatIn750(38));
        make.centerX.equalTo(self.mas_right).multipliedBy(0.5);
        make.height.width.mas_equalTo(CGFloatIn750(104));
    }];
    
    [self.contentView addSubview:self.openBtn];
    [self.openBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_right).multipliedBy(0.75);
        make.centerY.equalTo(self.headImageView.mas_centerY);
        make.height.mas_equalTo(CGFloatIn750(66));
        make.width.mas_equalTo(CGFloatIn750(170));
    }];
    
    self.openBtn.hidden = YES;
    
    __weak typeof(self) weakSelf = self;
    UIButton *userBtn = [[ZButton alloc] initWithFrame:CGRectZero];
    [userBtn bk_addEventHandler:^(id sender) {
        if (weakSelf.handleBlock) {
            weakSelf.handleBlock(0);
        }
    } forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:userBtn];
    [userBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.headImageView);
    }];
}

#pragma mark -Getter
- (UIImageView *)headImageView {
    if (!_headImageView) {
        _headImageView = [[UIImageView alloc] init];
        _headImageView.image = [UIImage imageNamed:@"uploadUserHeadImage"];
        _headImageView.backgroundColor = adaptAndDarkColor([UIColor colorGrayContentBG], [UIColor colorGrayContentBGDark]);
        _headImageView.contentMode = UIViewContentModeScaleAspectFit;
        ViewRadius(_headImageView, CGFloatIn750(52));
    }
    return _headImageView;
}

- (void)setImage:(id)image {
    _image = image;
    if (ValidStr(image)) {
        [self.headImageView tt_setImageWithURL:[NSURL URLWithString:image] placeholderImage:[UIImage imageNamed:@"default_head_noLogin"]];
    }else if (ValidClass(image, [UIImage class])){
        self.image = image;
    }
}


- (UIButton *)openBtn {
    if (!_openBtn) {
        __weak typeof(self) weakSelf = self;
        _openBtn = [[ZButton alloc] initWithFrame:CGRectZero];
        [_openBtn.titleLabel setFont:[UIFont fontSmall]];
        [_openBtn setTitle:@"查看教师课表" forState:UIControlStateNormal];
        [_openBtn setTitleColor:adaptAndDarkColor([UIColor colorWhite], [UIColor colorWhite]) forState:UIControlStateNormal];
        ViewRadius(_openBtn, CGFloatIn750(33));
        _openBtn.backgroundColor = adaptAndDarkColor([UIColor colorMain], [UIColor colorMainDark]);
        [_openBtn bk_addEventHandler:^(id sender) {
            if (weakSelf.handleBlock) {
                weakSelf.handleBlock(1);
            };
        } forControlEvents:UIControlEventTouchUpInside];
    }
    return _openBtn;
}

- (void)setIsTeacher:(BOOL)isTeacher {
    _isTeacher = isTeacher;
    if (isTeacher) {
        [self.headImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView.mas_top).offset(CGFloatIn750(38));
            make.centerX.equalTo(self.mas_right).multipliedBy(0.25);
            make.height.width.mas_equalTo(CGFloatIn750(104));
        }];
        
        [self.openBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.mas_right).multipliedBy(0.75);
            make.centerY.equalTo(self.headImageView.mas_centerY);
            make.height.mas_equalTo(CGFloatIn750(66));
            make.width.mas_equalTo(CGFloatIn750(170));
        }];
        self.openBtn.hidden = NO;
    }else{
        [self.headImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView.mas_top).offset(CGFloatIn750(38));
            make.centerX.equalTo(self.mas_right).multipliedBy(0.5);
            make.height.width.mas_equalTo(CGFloatIn750(104));
        }];
        self.openBtn.hidden = YES;
    }
}

+(CGFloat)z_getCellHeight:(id)sender {
    return CGFloatIn750(148);
}

@end




