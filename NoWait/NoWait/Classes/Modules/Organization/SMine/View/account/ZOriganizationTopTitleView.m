//
//  ZOriganizationTopTitleView.m
//  NoWait
//
//  Created by zhuang zhang on 2020/2/27.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZOriganizationTopTitleView.h"

@interface ZOriganizationTopTitleView ()

@end

@implementation ZOriganizationTopTitleView


- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initMainView];
    }
    return self;
}

#pragma mark 初始化view
- (void)initMainView {
   self.backgroundColor = adaptAndDarkColor([UIColor colorGrayBG], [UIColor colorGrayBGDark]);
    self.clipsToBounds = YES;
    self.layer.masksToBounds = YES;
}


- (void)setTitleArr:(NSArray *)titleArr {
    _titleArr = titleArr;
    
    [self removeAllSubviews];
    UILabel *tempLabel;
    for (int i = 0; i < titleArr.count; i++) {
        UILabel *label = [self getLabel:titleArr[i]];
        [self addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            if (tempLabel) {
                make.left.equalTo(tempLabel.mas_right);
            }else{
               make.left.equalTo(self.mas_left);
            }
            make.centerY.equalTo(self.mas_centerY);
            make.width.equalTo(self.mas_width).multipliedBy(1.0/titleArr.count);
        }];
        
        tempLabel = label;
    }
}

- (UILabel *)getLabel:(NSString *)title {
    UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    nameLabel.textColor = adaptAndDarkColor([UIColor colorTextBlack],[UIColor colorTextBlackDark]);
    nameLabel.text = title;
    nameLabel.numberOfLines = 1;
    nameLabel.textAlignment = NSTextAlignmentCenter;
    [nameLabel setFont:[UIFont fontContent]];
    
    return nameLabel;
}
@end
