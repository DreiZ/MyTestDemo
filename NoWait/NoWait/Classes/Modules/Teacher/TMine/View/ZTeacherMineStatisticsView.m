//
//  ZTeacherMineStatisticsView.m
//  NoWait
//
//  Created by zhuang zhang on 2020/9/15.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZTeacherMineStatisticsView.h"

@interface ZTeacherMineStatisticsView ()
@property (nonatomic,strong) UIView *contView;
@property (nonatomic,strong) UIView *cont1View;
@property (nonatomic,strong) UIView *cont2View;

@property (nonatomic,strong) UILabel *titleLabel;
@property (nonatomic,strong) UILabel *title1Label;
@end

@implementation ZTeacherMineStatisticsView

-(void)setupView {
    [super setupView];
    
    self.contentView.backgroundColor = adaptAndDarkColor([UIColor colorGrayBG], [UIColor colorGrayBGDark]);
    
    [self.contentView addSubview:self.contView];
    [self.contView addSubview:self.cont1View];
    [self.contView addSubview:self.cont2View];
    
    [self.contView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).offset(CGFloatIn750(30));
        make.right.equalTo(self.contentView.mas_right).offset(-CGFloatIn750(30));
        make.top.equalTo(self.contentView).offset(CGFloatIn750(20));
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-CGFloatIn750(0));
    }];
    
    [self.cont1View mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contView.mas_left);
        make.top.bottom.equalTo(self.contView);
        make.right.equalTo(self.contView.mas_centerX);
    }];
    
    [self.cont2View mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contView.mas_centerX);
        make.top.bottom.equalTo(self.contView);
        make.right.equalTo(self.contView.mas_right);
    }];
    
    UIView *bottomLineView = [[UIView alloc] initWithFrame:CGRectZero];
    bottomLineView.backgroundColor = adaptAndDarkColor([UIColor colorTextGray1], [UIColor colorTextGray1Dark]);
    [self.contView addSubview:bottomLineView];
    [bottomLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.contView);
        make.height.mas_equalTo(CGFloatIn750(40));
        make.width.mas_equalTo(1);
    }];
    
    {
        UILabel *hintLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        hintLabel.textColor = adaptAndDarkColor([UIColor colorTextGray], [UIColor colorTextGrayDark]);
        hintLabel.text = @"带过的课";
        hintLabel.numberOfLines = 0;
        hintLabel.textAlignment = NSTextAlignmentCenter;
        [hintLabel setFont:[UIFont fontMin]];
        [self.cont1View addSubview:hintLabel];
        [hintLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self.cont1View);
            make.bottom.equalTo(self.cont1View.mas_bottom).offset(-CGFloatIn750(26));
        }];
        
        [self.cont1View addSubview:self.titleLabel];
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self.cont1View);
            make.bottom.equalTo(hintLabel.mas_top).offset(-CGFloatIn750(8));
        }];
    }
    
    {
        UILabel *hintLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        hintLabel.textColor = adaptAndDarkColor([UIColor colorTextGray], [UIColor colorTextGrayDark]);
        hintLabel.text = @"累计学员";
        hintLabel.numberOfLines = 0;
        hintLabel.textAlignment = NSTextAlignmentCenter;
        [hintLabel setFont:[UIFont fontMin]];
        [self.cont2View addSubview:hintLabel];
        [hintLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self.cont2View);
            make.bottom.equalTo(self.cont2View.mas_bottom).offset(-CGFloatIn750(26));
        }];
        
        [self.cont2View addSubview:self.title1Label];
        [self.title1Label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self.cont2View);
            make.bottom.equalTo(hintLabel.mas_top).offset(-CGFloatIn750(8));
        }];
    }
}

#pragma mark -Getter
- (UIView *)contView {
    if (!_contView) {
        _contView = [[UIView alloc] init];
        _contView.layer.masksToBounds = YES;
        _contView.backgroundColor = adaptAndDarkColor([UIColor colorWhite], [UIColor colorBlackBGDark]);
        ViewRadius(_contView, CGFloatIn750(16));
    }
    return _contView;
}

- (UIView *)cont1View {
    if (!_cont1View) {
        _cont1View = [[UIView alloc] init];
        _cont1View.layer.masksToBounds = YES;
        _cont1View.backgroundColor = adaptAndDarkColor([UIColor colorWhite], [UIColor colorBlackBGDark]);
        ViewRadius(_cont1View, CGFloatIn750(16));
    }
    return _cont1View;
}

- (UIView *)cont2View {
    if (!_cont2View) {
        _cont2View = [[UIView alloc] init];
        _cont2View.layer.masksToBounds = YES;
        _cont2View.backgroundColor = adaptAndDarkColor([UIColor colorWhite], [UIColor colorBlackBGDark]);
        ViewRadius(_cont2View, CGFloatIn750(16));
    }
    return _cont2View;
}


- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _titleLabel.textColor = adaptAndDarkColor([UIColor colorTextBlack], [UIColor colorTextBlackDark]);
        _titleLabel.numberOfLines = 0;
        _titleLabel.text = @"12";
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        [_titleLabel setFont:[UIFont boldFontMaxTitle]];
    }
    return _titleLabel;
}


- (UILabel *)title1Label {
    if (!_title1Label) {
        _title1Label = [[UILabel alloc] initWithFrame:CGRectZero];
        _title1Label.textColor = adaptAndDarkColor([UIColor colorTextBlack], [UIColor colorTextBlackDark]);
        _title1Label.numberOfLines = 0;
        _title1Label.text = @"20";
        _title1Label.textAlignment = NSTextAlignmentCenter;
        [_title1Label setFont:[UIFont boldFontMaxTitle]];
    }
    return _title1Label;
}


+(CGFloat)z_getCellHeight:(id)sender {
    return CGFloatIn750(140);
}
@end








