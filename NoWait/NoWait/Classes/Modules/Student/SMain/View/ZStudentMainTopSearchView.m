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
@property (nonatomic,strong) UIView *contView;
@property (nonatomic,strong) UIImageView *searchImageView;

@property (nonatomic,strong) UIButton *mapSchoolBtn;
@property (nonatomic,strong) UIImageView *mapSchoolImage;
@property (nonatomic,strong) NSString *city;

@property (nonatomic,strong) UIView *backView;
@property (nonatomic,strong) NSTimer *timer;
@property (nonatomic,assign) NSInteger index;
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
    self.backgroundColor = adaptAndDarkColor([UIColor colorWhite],[UIColor colorBlackBGDark]);
    self.clipsToBounds = YES;
    self.layer.masksToBounds = YES;
    
    [self addSubview:self.backView];
    [self.backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    
    [self addSubview:self.contView];
    [self.contView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(CGFloatIn750(88));
        make.left.right.equalTo(self);
        make.bottom.equalTo(self.mas_bottom);
    }];
    
    [self.contView addSubview:self.mapSchoolBtn];
    [self.contView addSubview:self.addressLabel];
    [self.contView addSubview:self.addressHintImageView];
    [self.contView addSubview:self.searhBackView];
    
    [self.addressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contView.mas_left).offset(CGFloatIn750(30));
        make.centerY.equalTo(self.contView.mas_centerY);
        make.width.mas_equalTo(CGFloatIn750(100));
    }];
    
    [self.mapSchoolBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contView.mas_right).offset(-CGFloatIn750(20));
        make.centerY.equalTo(self.contView.mas_centerY);
        make.width.mas_equalTo(CGFloatIn750(100));
        make.top.bottom.equalTo(self.contView);
    }];
    
    [self.addressHintImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.addressLabel.mas_right).offset(CGFloatIn750(-8));
        make.centerY.equalTo(self.addressLabel.mas_centerY);
        make.width.height.mas_equalTo(CGFloatIn750(44));
    }];
    
    [self.contView addSubview:self.searhBackView];
    [self.searhBackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.addressLabel.mas_right).offset(CGFloatIn750(2));
        make.height.mas_equalTo(CGFloatIn750(64));
        make.right.equalTo(self.mapSchoolBtn.mas_left).offset(-CGFloatIn750(0));
        make.centerY.equalTo(self.addressHintImageView);
    }];
    
    __weak typeof(self) weakSelf = self;
    UIButton *addressBtn = [[UIButton alloc] initWithFrame:CGRectZero];
    [addressBtn bk_addEventHandler:^(id sender) {
        [weakSelf startTimer];
        if (weakSelf.addressBlock) {
            weakSelf.addressBlock(0);
        }
    } forControlEvents:UIControlEventTouchUpInside];
    [self.contView addSubview:addressBtn];
    [addressBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.equalTo(self.contView);
        make.right.equalTo(self.searhBackView.mas_left);
    }];
    
    
    UIButton *searchBtn = [[UIButton alloc] initWithFrame:CGRectZero];
    [searchBtn bk_addEventHandler:^(id sender) {
        if (weakSelf.searchBlock) {
            weakSelf.searchBlock(0);
        }
    } forControlEvents:UIControlEventTouchUpInside];
    [self.contView addSubview:searchBtn];
    [searchBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.contView);
        make.left.equalTo(self.searhBackView.mas_left);
        make.right.equalTo(self.searhBackView.mas_right);
    }];
    
    self.addressHintImageView.hidden = YES;
}

- (UIView *)contView {
    if (!_contView) {
        _contView = [[UIView alloc] init];
        _contView.layer.masksToBounds = YES;
//        _contView.backgroundColor = adaptAndDarkColor([UIColor colorWhite],[UIColor colorBlackBGDark]);
    }
    return _contView;
}

- (UILabel *)addressLabel {
    if (!_addressLabel) {
        _addressLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _addressLabel.textColor = adaptAndDarkColor([UIColor colorTextBlack],[UIColor colorWhite]);
        _addressLabel.text = @"-";
        _addressLabel.numberOfLines = 1;
        _addressLabel.textAlignment = NSTextAlignmentLeft;
        [_addressLabel setFont:[UIFont fontSmall]];
    }
    return _addressLabel;
}

- (UIImageView *)addressHintImageView {
    if (!_addressHintImageView) {
        _addressHintImageView = [[UIImageView alloc] init];
        _addressHintImageView.image = [[UIImage imageNamed:@"mineLessonDown"]  imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        _addressHintImageView.tintColor = isDarkModel() ? [UIColor colorWhite] : [UIColor colorBlackBGDark];
        _addressHintImageView.layer.masksToBounds = YES;
        _addressHintImageView.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _addressHintImageView;
}

- (UIView *)searhBackView {
    if (!_searhBackView) {
        _searhBackView = [[UIView alloc] init];
        _searhBackView.layer.masksToBounds = YES;
        _searhBackView.backgroundColor = adaptAndDarkColor([UIColor colorGrayLine],[UIColor colorGrayBGDark]);
        _searhBackView.layer.cornerRadius = 4;
        
        [_searhBackView addSubview:self.searchImageView];
        [_searchImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.searhBackView.mas_centerY);
            make.width.mas_equalTo(self.searchImageView.width);
            make.left.mas_equalTo(CGFloatIn750(20));
            make.height.mas_equalTo(self.searchImageView.height);
        }];

        [_searhBackView addSubview:self.searchPlaceholder];
        [self.searchPlaceholder mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.searchImageView.mas_centerY);
            make.left.equalTo(self.searchImageView.mas_right).offset(CGFloatIn750(20));
        }];
    }
    return _searhBackView;
}

- (UIImageView *)searchImageView {
    if (!_searchImageView) {
        _searchImageView = [[UIImageView alloc] initWithImage:[[UIImage imageNamed:@"mainSearch"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate]];
        _searchImageView.tintColor = isDarkModel() ? [UIColor colorWhite] : [UIColor colorTextGray1];
        _searchImageView.layer.masksToBounds = YES;
        _searchImageView.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _searchImageView;
}

- (UILabel *)searchPlaceholder {
    if (!_searchPlaceholder) {
        _searchPlaceholder = [[UILabel alloc] initWithFrame:CGRectZero];
        _searchPlaceholder.textColor = adaptAndDarkColor([UIColor colorTextGray1],[UIColor colorTextGray]);
        _searchPlaceholder.text = @"搜索";
        _searchPlaceholder.numberOfLines = 1;
        _searchPlaceholder.textAlignment = NSTextAlignmentLeft;
        [_searchPlaceholder setFont:[UIFont fontSmall]];
    }
    return _searchPlaceholder;
}

- (UIView *)backView {
    if (!_backView) {
        _backView = [[UIView alloc] init];
        _backView.backgroundColor = adaptAndDarkColor([UIColor colorMain], [UIColor colorMainDark]);
        _backView.alpha = 0;
    }
    return _backView;
}

- (UIButton *)mapSchoolBtn {
    if (!_mapSchoolBtn) {
        __weak typeof(self) weakSelf = self;
        _mapSchoolBtn = [[UIButton alloc] init];
        _mapSchoolImage = [[UIImageView alloc] init];
        [_mapSchoolBtn setUserInteractionEnabled:YES];
        _mapSchoolImage.image = [[UIImage imageNamed:@"mapschool"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
//        _mapSchoolImage.image = [UIImage imageNamed:@"mapSchool"];
        _mapSchoolImage.tintColor = adaptAndDarkColor([UIColor colorTextBlack], [UIColor colorGrayBG]);
        
        [_mapSchoolBtn addSubview:_mapSchoolImage];
        [_mapSchoolImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self.mapSchoolBtn);
            make.width.mas_equalTo(CGFloatIn750(44));
            make.height.mas_equalTo(CGFloatIn750(44));
        }];
        [_mapSchoolBtn bk_whenTapped:^{
            if (weakSelf.addressBlock) {
                weakSelf.addressBlock(1);
            }
        }];
        
    }
    return _mapSchoolBtn;
}

#pragma mark - 更新背景色
- (void)updateWithOffset:(CGFloat)offsetY {
    if (isDarkModel()) {
        _searchImageView.tintColor = isDarkModel() ? [UIColor colorWhite] : [UIColor colorTextGray1];
        _addressHintImageView.tintColor = isDarkModel() ? [UIColor colorWhite] : [UIColor colorBlackBGDark];
        return;
    }
    if (offsetY > 0) {
        CGFloat alpha = offsetY/CGFloatIn750(80);
        self.backView.alpha = alpha;
        self.addressLabel.textColor = [UIColor colorWithRed:alpha green:alpha blue:alpha alpha:1];
        _addressHintImageView.tintColor = [UIColor colorWithRed:alpha green:alpha blue:alpha alpha:1];
    }else {
        self.backView.alpha = 0;
        self.addressLabel.textColor = [UIColor colorTextBlack];
        _addressHintImageView.tintColor = [UIColor colorBlackBGDark];
    }
    _searchImageView.tintColor = isDarkModel() ? [UIColor colorWhite] : [UIColor colorTextGray1];
    _addressHintImageView.tintColor = isDarkModel() ? [UIColor colorWhite] : [UIColor colorBlackBGDark];
}

- (void)setAddress:(NSString *)city {
    [self stopTimer];
    
    _city = city;
    if (city) {
        _addressLabel.text = city;
    }else{
        _addressLabel.text = @"-";
    }
    
    CGSize citySize = [city sizeForFont:[UIFont fontSmall] size:CGSizeMake(CGFloatIn750(200), MAXFLOAT) mode:NSLineBreakByWordWrapping];
    
    
    [self.addressLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contView.mas_left).offset(CGFloatIn750(30));
        make.centerY.equalTo(self.contView.mas_centerY);
        make.width.mas_equalTo(citySize.width > CGFloatIn750(100)?citySize.width:CGFloatIn750(100));
    }];
}

- (void)startTimer {
    _index = 0;
    _timer = [NSTimer scheduledTimerWithTimeInterval:.2 target:self selector:@selector(changeLocationTime) userInfo:nil repeats:YES];
    NSRunLoop *main=[NSRunLoop currentRunLoop];
    [main addTimer:_timer forMode:NSRunLoopCommonModes];
}

- (void)changeLocationTime {
    if (_index==0) {
        _addressLabel.text = [NSString stringWithFormat:@"%@.",_city];
    }else if(_index == 1){
        _addressLabel.text = [NSString stringWithFormat:@"%@..",_city];
    }else{
        _addressLabel.text = [NSString stringWithFormat:@"%@...",_city];
    }
    
    CGSize citySize = [[NSString stringWithFormat:@"%@...",SafeStr(self.city)] sizeForFont:[UIFont fontSmall] size:CGSizeMake(CGFloatIn750(200), MAXFLOAT) mode:NSLineBreakByWordWrapping];
    
    
    [self.addressLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contView.mas_left).offset(CGFloatIn750(30));
        make.centerY.equalTo(self.contView.mas_centerY);
        make.width.mas_equalTo(citySize.width > CGFloatIn750(100)?citySize.width:CGFloatIn750(100));
    }];
    
    if (_index == 2) {
        _index = 0;
    }else{
        _index++;
    }
}

- (void)stopTimer {
    if ([_timer isValid]) {
        [_timer invalidate];
    }
    _timer = nil;
}

#pragma mark - 处理一些特殊的情况，比如layer的CGColor、特殊的，明景和暗景造成的文字内容变化等等
-(void)traitCollectionDidChange:(UITraitCollection *)previousTraitCollection{
    [super traitCollectionDidChange:previousTraitCollection];
    
    // darkmodel change
//    [self setupDarkModel];
    _searchImageView.tintColor = isDarkModel() ? [UIColor colorWhite] : [UIColor colorTextGray1];
    _addressHintImageView.tintColor = isDarkModel() ? [UIColor colorWhite] : [UIColor colorBlackBGDark];
}
@end

