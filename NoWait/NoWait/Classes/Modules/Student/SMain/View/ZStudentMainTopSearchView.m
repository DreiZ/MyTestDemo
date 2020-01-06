//
//  ZStudentMainTopSearchView.m
//  NoWait
//
//  Created by zhuang zhang on 2020/1/6.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZStudentMainTopSearchView.h"

@interface ZStudentMainTopSearchView ()
@property (nonatomic,strong) UILabel *addressLabel;
@property (nonatomic,strong) UIImageView *addressHintImageView;
@property (nonatomic,strong) UIView *searhBackView;
@property (nonatomic,strong) UILabel *searchPlaceholder;


@property (nonatomic,strong) UIView *backView;

@end

@implementation ZStudentMainTopSearchView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initMainView];
    }
    return self;
}

#pragma mark 初始化view
- (void)initMainView {
    self.backgroundColor = [UIColor whiteColor];
    self.clipsToBounds = YES;
    self.layer.masksToBounds = YES;
    
    [self addSubview:self.backView];
    [self.backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    
    UIView *contView = [[UIView alloc] initWithFrame:CGRectZero];
    [self addSubview:contView];
    [contView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(CGFloatIn750(88));
        make.left.right.equalTo(self);
        make.bottom.equalTo(self.mas_bottom);
    }];
    
    [contView addSubview:self.addressLabel];
    [contView addSubview:self.addressHintImageView];
    [contView addSubview:self.searhBackView];
    
    [self.addressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(contView.mas_left).offset(CGFloatIn750(30));
        make.centerY.equalTo(contView.mas_centerY);
        make.width.mas_equalTo(CGFloatIn750(80));
    }];
    
    [self.addressHintImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.addressLabel.mas_right).offset(CGFloatIn750(-8));
        make.centerY.equalTo(self.addressLabel.mas_centerY);
        make.width.height.mas_equalTo(CGFloatIn750(44));
    }];
    
    [contView addSubview:self.searhBackView];
    [self.searhBackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.addressHintImageView.mas_right).offset(CGFloatIn750(18));
        make.height.mas_equalTo(CGFloatIn750(64));
        make.right.equalTo(contView.mas_right).offset(-CGFloatIn750(30));
        make.centerY.equalTo(self.addressHintImageView);
    }];
    
    UIButton *addressBtn = [[UIButton alloc] initWithFrame:CGRectZero];
    [addressBtn bk_whenTapped:^{
        
    }];
    [contView addSubview:addressBtn];
    [addressBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.equalTo(contView);
        make.right.equalTo(contView.mas_right);
    }];
    
    UIButton *searchBtn = [[UIButton alloc] initWithFrame:CGRectZero];
    [searchBtn bk_whenTapped:^{
        
    }];
    [contView addSubview:searchBtn];
    [searchBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.top.bottom.equalTo(contView);
        make.left.equalTo(self.searhBackView.mas_left);
    }];
}

- (UILabel *)addressLabel {
    if (!_addressLabel) {
        _addressLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _addressLabel.textColor = KFont2Color;
        _addressLabel.text = @"徐州";
        _addressLabel.numberOfLines = 1;
        _addressLabel.textAlignment = NSTextAlignmentLeft;
        [_addressLabel setFont:[UIFont systemFontOfSize:CGFloatIn750(32)]];
    }
    return _addressLabel;
}

- (UIImageView *)addressHintImageView {
    if (!_addressHintImageView) {
        _addressHintImageView = [[UIImageView alloc] init];
        _addressHintImageView.image = [[UIImage imageNamed:@"mineLessonDown"]  imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        _addressHintImageView.tintColor = KBlackColor;
        _addressHintImageView.layer.masksToBounds = YES;
        _addressHintImageView.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _addressHintImageView;
}

- (UIView *)searhBackView {
    if (!_searhBackView) {
        _searhBackView = [[UIView alloc] init];
        _searhBackView.layer.masksToBounds = YES;
        _searhBackView.backgroundColor = CLineColor;
        _searhBackView.layer.cornerRadius = 4;
        
        UIImageView *searchImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"mainSearch"]];
        [_searhBackView addSubview:searchImageView];
        [searchImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.searhBackView.mas_centerY);
            make.width.mas_equalTo(searchImageView.width);
            make.left.mas_equalTo(CGFloatIn750(20));
            make.height.mas_equalTo(searchImageView.height);
        }];

        [_searhBackView addSubview:self.searchPlaceholder];
        [self.searchPlaceholder mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(searchImageView.mas_centerY);
            make.left.equalTo(searchImageView.mas_right).offset(CGFloatIn750(20));
        }];
    }
    return _searhBackView;
}

- (UILabel *)searchPlaceholder {
    if (!_searchPlaceholder) {
        _searchPlaceholder = [[UILabel alloc] initWithFrame:CGRectZero];
        _searchPlaceholder.textColor = KFont9Color;
        _searchPlaceholder.text = @"搜索";
        _searchPlaceholder.numberOfLines = 1;
        _searchPlaceholder.textAlignment = NSTextAlignmentLeft;
        [_searchPlaceholder setFont:[UIFont systemFontOfSize:CGFloatIn750(24)]];
    }
    return _searchPlaceholder;
}

- (UIView *)backView {
    if (!_backView) {
        _backView = [[UIView alloc] init];
        _backView.backgroundColor = KMainColor;
        _backView.alpha = 0;
    }
    return _backView;
}

#pragma mark - 更新背景色
- (void)updateWithOffset:(CGFloat)offsetY {
    if (offsetY > 0) {
        CGFloat alpha = offsetY/CGFloatIn750(80);
        self.backView.alpha = alpha;
        self.addressLabel.textColor = [UIColor colorWithRed:alpha green:alpha blue:alpha alpha:1];
        _addressHintImageView.tintColor = [UIColor colorWithRed:alpha green:alpha blue:alpha alpha:1];
    }else {
        self.backView.alpha = 0;
        self.addressLabel.textColor = KFont2Color;
        _addressHintImageView.tintColor = KBlackColor;
    }
}
@end
