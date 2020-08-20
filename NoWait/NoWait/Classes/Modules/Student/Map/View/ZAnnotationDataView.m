//
//  ZAnnotationDataView.m
//  NoWait
//
//  Created by zhuang zhang on 2020/8/20.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZAnnotationDataView.h"

@interface ZAnnotationDataView ()

@property (nonatomic, strong) UILabel *countLabel;
@property (nonatomic, strong) UILabel *contentLabel;
@property (nonatomic, strong) UIView *bottomView;
@property (nonatomic, strong) UIColor *drawColor;

@end

@implementation ZAnnotationDataView


- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initMainView];
    }
    return self;
}

#pragma mark 初始化view
- (void)initMainView {
    self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.01];
    self.clipsToBounds = YES;
    self.layer.masksToBounds = YES;
  
    self.drawColor = [UIColor colorMain];
    
    [self addSubview:self.bottomView];
    [self addSubview:self.contentLabel];
    [self addSubview:self.countLabel];
    
    [self.countLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.centerY.equalTo(self.mas_centerY);
        make.height.mas_equalTo(CGFloatIn750(40));
        make.left.equalTo(self.mas_left).offset(CGFloatIn750(8));
        make.right.equalTo(self.mas_right).offset(-CGFloatIn750(8));
    }];
    
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.centerY.equalTo(self.mas_centerY);
        make.height.mas_equalTo(CGFloatIn750(40));
        make.left.equalTo(self.mas_left).offset(CGFloatIn750(8));
        make.right.equalTo(self.mas_right).offset(-CGFloatIn750(8));
    }];
    
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.centerY.equalTo(self.mas_centerY);
        make.height.mas_equalTo(CGFloatIn750(40));
        make.left.equalTo(self.mas_left).offset(CGFloatIn750(8));
        make.right.equalTo(self.mas_right).offset(-CGFloatIn750(8));
    }];
}

- (UILabel *)countLabel {
    if (!_countLabel) {
        _countLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 40, 80, 36)];
        _countLabel.textColor       = [UIColor colorMain];
        _countLabel.textAlignment   = NSTextAlignmentCenter;
        _countLabel.backgroundColor = [UIColor colorWhite];
        _countLabel.layer.cornerRadius = CGFloatIn750(20);
        _countLabel.layer.masksToBounds = YES;
        _countLabel.numberOfLines = 1;
        _countLabel.font = [UIFont boldSystemFontOfSize:CGFloatIn750(24)];
        _countLabel.baselineAdjustment = UIBaselineAdjustmentAlignCenters;
    }
    return _countLabel;
}

- (UILabel *)contentLabel {
    if (!_contentLabel) {
        _contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 40, 80, 36)];
        _contentLabel.textColor       = [UIColor whiteColor];
        _contentLabel.textAlignment   = NSTextAlignmentCenter;
        _contentLabel.backgroundColor = [UIColor colorMain];
        _contentLabel.layer.cornerRadius = CGFloatIn750(20);
        _contentLabel.layer.masksToBounds = YES;
        _contentLabel.numberOfLines = 1;
        _contentLabel.font = [UIFont boldSystemFontOfSize:CGFloatIn750(24)];
        _contentLabel.baselineAdjustment = UIBaselineAdjustmentAlignCenters;
    }
    return _contentLabel;
}

- (UIView *)bottomView {
    if (!_bottomView) {
        _bottomView = [[UIView alloc] init];
        _bottomView.layer.masksToBounds = YES;
        _bottomView.clipsToBounds = YES;
    }
    return _bottomView;
}

- (void)setMain:(NSDictionary *)data {
    self.bottomView.hidden = YES;
    self.countLabel.hidden = YES;
    self.contentLabel.hidden = NO;
    
    
    self.contentLabel.textColor = [UIColor colorWhite];
    self.contentLabel.backgroundColor = [UIColor colorMain];
    
    self.contentLabel.text = [NSString stringWithFormat:@"%@\n%@",data[@"content"],data[@"count"]];
    self.contentLabel.numberOfLines = 0;
    
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.centerY.equalTo(self.mas_centerY);
        make.left.equalTo(self.mas_left).offset(CGFloatIn750(8));
        make.right.equalTo(self.mas_right).offset(-CGFloatIn750(8));
        make.top.equalTo(self.mas_top).offset(CGFloatIn750(8));
        make.bottom.equalTo(self.mas_bottom).offset(-CGFloatIn750(8));
    }];
    
    self.contentLabel.layer.cornerRadius = CGFloatIn750(120);
    [self setNeedsDisplay];
}


- (void)setSubMain:(NSDictionary *)data {
    self.bottomView.hidden = NO;
    self.contentLabel.hidden = NO;
    self.countLabel.hidden = NO;
    
    self.bottomView.backgroundColor = [UIColor whiteColor];
    
    self.countLabel.textColor = [UIColor colorWhite];
    self.countLabel.backgroundColor = [UIColor colorMain];
    
    self.contentLabel.textColor = [UIColor colorTextBlack];
    self.contentLabel.backgroundColor = [UIColor colorWhite];
    
    self.contentLabel.text = [NSString stringWithFormat:@"%@",data[@"content"]];
    self.countLabel.text = [NSString stringWithFormat:@"%@",data[@"count"]];
    
    self.countLabel.numberOfLines = 1;
    self.contentLabel.numberOfLines = 1;
    
    CGSize countSize = [self.countLabel.text tt_sizeWithFont:[UIFont systemFontOfSize:CGFloatIn750(24)] constrainedToSize:CGSizeMake(CGFloatIn750(240), CGFloatIn750(40))];
    
    [self.bottomView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.centerY.equalTo(self.mas_centerY);
        make.left.equalTo(self.mas_left).offset(CGFloatIn750(0));
        make.right.equalTo(self.mas_right).offset(-CGFloatIn750(0));
        make.height.mas_equalTo(CGFloatIn750(62));
    }];
    
    ViewBorderRadius(self.bottomView, CGFloatIn750(31), 1, [UIColor colorMain]);
    
    [self.countLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.mas_centerY);
        make.left.equalTo(self.mas_left).offset(CGFloatIn750(8));
        make.width.mas_equalTo(countSize.width + CGFloatIn750(20));
        make.height.mas_equalTo(CGFloatIn750(40));
    }];
    
    [self.contentLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.mas_centerY);
        make.left.equalTo(self.countLabel.mas_right).offset(CGFloatIn750(8));
        make.right.equalTo(self.bottomView.mas_right).offset(-CGFloatIn750(8));
    }];
    
    self.bottomView.layer.cornerRadius = CGFloatIn750(31);
}

- (void)setTogether:(NSDictionary *)data {
    self.bottomView.hidden = NO;
    self.contentLabel.hidden = YES;
    self.countLabel.hidden = NO;
    
    self.countLabel.backgroundColor = [UIColor colorWhite];
    self.countLabel.textColor = [UIColor colorMain];
    self.bottomView.backgroundColor = [UIColor colorWhite];
    
    self.countLabel.text = [NSString stringWithFormat:@"%@个%@",data[@"count"],@"校区"];
    ViewBorderRadius(self.bottomView, CGFloatIn750(31), 1, [UIColor colorMain]);
    
    self.countLabel.numberOfLines = 1;
 
    [self.countLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.centerY.equalTo(self.mas_centerY);
        make.left.equalTo(self.bottomView.mas_left).offset(CGFloatIn750(8));
        make.right.equalTo(self.bottomView.mas_right).offset(-CGFloatIn750(8));
    }];
    
    [self.bottomView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.centerY.equalTo(self.mas_centerY);
        make.left.equalTo(self.mas_left).offset(CGFloatIn750(0));
        make.right.equalTo(self.mas_right).offset(-CGFloatIn750(0));
        make.height.mas_equalTo(CGFloatIn750(62));
    }];
    
    self.bottomView.layer.cornerRadius = CGFloatIn750(31);
}

- (void)setDetail:(NSString *)str {
    self.bottomView.hidden = NO;
    self.contentLabel.hidden = NO;
    self.countLabel.hidden = YES;
    
    
    self.bottomView.backgroundColor = [UIColor colorMain];
    
    self.contentLabel.backgroundColor = [UIColor colorMain];
    self.contentLabel.textColor = [UIColor colorWhite];
    
    
    self.contentLabel.text = str;
    self.contentLabel.numberOfLines = 1;
    
    [self.countLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.centerY.equalTo(self.mas_centerY);
        make.height.mas_equalTo(CGFloatIn750(60));
        make.left.equalTo(self.mas_left).offset(CGFloatIn750(8));
        make.right.equalTo(self.mas_right).offset(-CGFloatIn750(8));
    }];
    
    [self.bottomView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.centerY.equalTo(self.mas_centerY);
        make.left.equalTo(self.mas_left).offset(CGFloatIn750(0));
        make.right.equalTo(self.mas_right).offset(-CGFloatIn750(0));
        make.height.mas_equalTo(CGFloatIn750(62));
    }];
    self.bottomView.layer.cornerRadius = CGFloatIn750(31);
}

@end
