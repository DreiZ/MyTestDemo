//
//  ZOrganizationLessonTopSearchView.m
//  NoWait
//
//  Created by zhuang zhang on 2020/2/25.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZOrganizationLessonTopSearchView.h"

@interface ZOrganizationLessonTopSearchView ()
@property (nonatomic,strong) UIButton *searchBtn;

@end

@implementation ZOrganizationLessonTopSearchView


- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initMainView];
    }
    return self;
}

#pragma mark 初始化view
- (void)initMainView {
    self.backgroundColor = adaptAndDarkColor([UIColor colorWhite], [UIColor colorBlackBGDark]);
    self.clipsToBounds = YES;
    self.layer.masksToBounds = YES;
    
    
    [self addSubview:self.searchBtn];
    [self.searchBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(CGFloatIn750(30));
        make.right.equalTo(self.mas_right).offset(CGFloatIn750(-30));
        make.height.mas_equalTo(CGFloatIn750(56));
        make.bottom.equalTo(self.mas_bottom);
    }];
}

- (UIButton *)searchBtn {
    if (!_searchBtn) {
        __weak typeof(self) weakSelf = self;
        _searchBtn = [[UIButton alloc] initWithFrame:CGRectZero];
        [_searchBtn setTitle:@"搜索" forState:UIControlStateNormal];
        [_searchBtn setTitleColor:adaptAndDarkColor([UIColor colorTextGray], [UIColor colorTextGrayDark]) forState:UIControlStateNormal];
        [_searchBtn.titleLabel setFont:[UIFont fontSmall]];
        [_searchBtn setImage:[UIImage imageNamed:@"mainSearch"] forState:UIControlStateNormal];
        ViewRadius(_searchBtn, CGFloatIn750(28));
        _searchBtn.backgroundColor = adaptAndDarkColor([UIColor colorGrayBG], [UIColor colorGrayBGDark]);
        [_searchBtn bk_addEventHandler:^(id sender) {
            if (weakSelf.handleBlock) {
                weakSelf.handleBlock();
            }
        } forControlEvents:UIControlEventTouchUpInside];
    }
    return _searchBtn;
}

- (void)setTitle:(NSString *)title {
    [_searchBtn setTitle:title forState:UIControlStateNormal];
}
@end
