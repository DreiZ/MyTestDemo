//
//  ZOrganizationLessonAddImageCell.m
//  NoWait
//
//  Created by zhuang zhang on 2020/2/19.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZOrganizationLessonAddImageCell.h"
@interface ZOrganizationLessonAddImageCell ()

@property (nonatomic,strong) UILabel *titleLabel;
@property (nonatomic,strong) UIImageView *leftImageView;
@property (nonatomic,strong) UIImageView *contImageView;

@property (nonatomic,strong) UIView *backContentView;
@end

@implementation ZOrganizationLessonAddImageCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupView];
    }
    return self;
}

-(void)setupView {
    [super setupView];
    self.contentView.backgroundColor = adaptAndDarkColor([UIColor colorGrayBG],[UIColor colorGrayBGDark]);
    
    
    [self.contentView addSubview:self.leftImageView];
    [self.contentView addSubview:self.contImageView];
    [self.contentView addSubview:self.backContentView];
    [self.backContentView addSubview:self.titleLabel];
    
    [self.backContentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(CGFloatIn750(62));
        make.left.right.bottom.equalTo(self);
    }];
    
    [self.contImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self.contentView);
        make.bottom.equalTo(self.backContentView.mas_top);
    }];
    self.contImageView.hidden = YES;
    
    [self.leftImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.centerY.equalTo(self.mas_centerY).offset(CGFloatIn750(-20));
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.backContentView);
    }];

}


#pragma mark -Getter
- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _titleLabel.textColor = adaptAndDarkColor([UIColor colorWhite],[UIColor colorBlack]);
        _titleLabel.text = @"上传课程封面";
        _titleLabel.numberOfLines = 1;
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        [_titleLabel setFont:[UIFont fontContent]];
    }
    return _titleLabel;
}



- (UIImageView *)leftImageView {
    if (!_leftImageView) {
        _leftImageView = [[UIImageView alloc] init];
    }
    return _leftImageView;
}

- (UIImageView *)contImageView {
    if (!_contImageView) {
        _contImageView = [[UIImageView alloc] init];
    }
    return _contImageView;
}

- (UIView *)backContentView {
    if (!_backContentView) {
        _backContentView = [[UIView alloc] init];
        _backContentView.backgroundColor = adaptAndDarkColor([UIColor colorBlack], [UIColor colorWhite]);

    }
    return _backContentView;
}

- (void)setImage:(id)image {
    _image = image;
    
    self.contImageView.hidden = NO;
    self.leftImageView.hidden = YES;
    if (!image) {
        self.contImageView.hidden = YES;
        self.leftImageView.hidden = NO;
    }else if ([image isKindOfClass:[UIImage class]]) {
        self.contImageView.image = image;
    }else if ([image isKindOfClass:[NSString class]]){
        NSString *temp = image;
        if (temp.length > 0) {
            [self.contImageView tt_setImageWithURL:[NSURL URLWithString:temp]];
        }else{
            self.contImageView.hidden = YES;
            self.leftImageView.hidden = NO;
        }
    }
}

+(CGFloat)z_getCellHeight:(id)sender {
    return CGFloatIn750(400) + CGFloatIn750(62);
}

@end
