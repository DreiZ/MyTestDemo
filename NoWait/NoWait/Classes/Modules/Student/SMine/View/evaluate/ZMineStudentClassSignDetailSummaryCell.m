//
//  ZMineStudentClassSignDetailSummaryCell.m
//  NoWait
//
//  Created by zhuang zhang on 2020/9/15.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZMineStudentClassSignDetailSummaryCell.h"

@interface ZMineStudentClassSignDetailSummaryCell ()
@property (nonatomic,strong) UIView *contView;
@property (nonatomic,strong) UIView *cont1View;
@property (nonatomic,strong) UIView *cont2View;

@property (nonatomic,strong) UILabel *titleLabel;
@property (nonatomic,strong) UILabel *title1Label;
@property (nonatomic,strong) UILabel *title2Label;
@end

@implementation ZMineStudentClassSignDetailSummaryCell

-(void)setupView {
    [super setupView];
    
    [self.contentView addSubview:self.contView];
    [self.contentView addSubview:self.cont1View];
    [self.contentView addSubview:self.cont2View];
    
    [self.contView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).mas_offset(CGFloatIn750(30));
        make.top.bottom.equalTo(self.contentView);
        make.width.mas_equalTo(CGFloatIn750(210));
    }];
    
    [self.cont1View mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contView.mas_right).mas_offset(CGFloatIn750(10));
        make.top.bottom.equalTo(self.contentView);
        make.width.mas_equalTo(CGFloatIn750(210));
    }];
    
    [self.cont2View mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.cont1View.mas_right).mas_offset(CGFloatIn750(10));
        make.top.bottom.equalTo(self.contentView);
        make.width.mas_equalTo(CGFloatIn750(210));
    }];
    
    {
        UILabel *hintLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        hintLabel.textColor = adaptAndDarkColor([UIColor colorTextBlack], [UIColor colorTextBlackDark]);
        hintLabel.text = @"已签课";
        hintLabel.numberOfLines = 0;
        hintLabel.textAlignment = NSTextAlignmentCenter;
        [hintLabel setFont:[UIFont fontSmall]];
        [self.contView addSubview:hintLabel];
        [hintLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self.contView);
            make.bottom.equalTo(self.contView.mas_bottom).offset(-CGFloatIn750(28));
        }];
        
        [self.contView addSubview:self.titleLabel];
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self.contView);
            make.bottom.equalTo(hintLabel.mas_top).offset(-CGFloatIn750(18));
        }];
    }
    
    {
        UILabel *hintLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        hintLabel.textColor = adaptAndDarkColor(HexAColor(0xf7c173, 1), HexAColor(0xf7c173, 1));
        hintLabel.text = @"补签";
        hintLabel.numberOfLines = 0;
        hintLabel.textAlignment = NSTextAlignmentCenter;
        [hintLabel setFont:[UIFont fontSmall]];
        [self.cont1View addSubview:hintLabel];
        [hintLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self.cont1View);
            make.bottom.equalTo(self.cont1View.mas_bottom).offset(-CGFloatIn750(28));
        }];
        
        [self.cont1View addSubview:self.title1Label];
        [self.title1Label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self.cont1View);
            make.bottom.equalTo(hintLabel.mas_top).offset(-CGFloatIn750(18));
        }];
    }
    
    {
        UILabel *hintLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        hintLabel.textColor = adaptAndDarkColor(HexAColor(0x5e73ce, 1), HexAColor(0x5e73ce, 1));
        hintLabel.text = @"待签课";
        hintLabel.numberOfLines = 0;
        hintLabel.textAlignment = NSTextAlignmentCenter;
        [hintLabel setFont:[UIFont fontSmall]];
        [self.cont2View addSubview:hintLabel];
        [hintLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self.cont2View);
            make.bottom.equalTo(self.cont2View.mas_bottom).offset(-CGFloatIn750(28));
        }];
        
        [self.cont2View addSubview:self.title2Label];
        [self.title2Label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self.cont2View);
            make.bottom.equalTo(hintLabel.mas_top).offset(-CGFloatIn750(18));
        }];
    }
}

#pragma mark -Getter
- (UIView *)contView {
    if (!_contView) {
        _contView = [[UIView alloc] init];
        _contView.layer.masksToBounds = YES;
        _contView.backgroundColor = adaptAndDarkColor([UIColor colorGrayBG], [UIColor colorGrayBGDark]);
        ViewRadius(_contView, CGFloatIn750(16));
    }
    return _contView;
}

- (UIView *)cont1View {
    if (!_cont1View) {
        _cont1View = [[UIView alloc] init];
        _cont1View.layer.masksToBounds = YES;
        _cont1View.backgroundColor = adaptAndDarkColor([UIColor colorGrayBG], [UIColor colorGrayBGDark]);
        ViewRadius(_cont1View, CGFloatIn750(16));
    }
    return _cont1View;
}

- (UIView *)cont2View {
    if (!_cont2View) {
        _cont2View = [[UIView alloc] init];
        _cont2View.layer.masksToBounds = YES;
        _cont2View.backgroundColor = adaptAndDarkColor([UIColor colorGrayBG], [UIColor colorGrayBGDark]);
        ViewRadius(_cont2View, CGFloatIn750(16));
    }
    return _cont2View;
}


- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _titleLabel.textColor = adaptAndDarkColor([UIColor colorTextBlack], [UIColor colorTextBlackDark]);
        _titleLabel.numberOfLines = 0;
        _titleLabel.text = @"2节";
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        [_titleLabel setFont:[UIFont fontContent]];
    }
    return _titleLabel;
}


- (UILabel *)title1Label {
    if (!_title1Label) {
        _title1Label = [[UILabel alloc] initWithFrame:CGRectZero];
        _title1Label.textColor = adaptAndDarkColor(HexAColor(0xf7c173, 1), HexAColor(0xf7c173, 1));
        _title1Label.numberOfLines = 0;
        _title1Label.text = @"2节";
        _title1Label.textAlignment = NSTextAlignmentCenter;
        [_title1Label setFont:[UIFont fontContent]];
    }
    return _title1Label;
}


- (UILabel *)title2Label {
    if (!_title2Label) {
        _title2Label = [[UILabel alloc] initWithFrame:CGRectZero];
        _title2Label.textColor = adaptAndDarkColor(HexAColor(0x5e73ce, 1), HexAColor(0x5e73ce, 1));
        _title2Label.numberOfLines = 0;
        _title2Label.text = @"12节";
        _title2Label.textAlignment = NSTextAlignmentCenter;
        [_title2Label setFont:[UIFont fontContent]];
    }
    return _title2Label;
}


+(CGFloat)z_getCellHeight:(id)sender {
    return CGFloatIn750(132);
}
@end







