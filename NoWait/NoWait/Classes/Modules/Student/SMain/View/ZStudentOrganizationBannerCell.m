//
//  ZStudentOrganizationBannerCell.m
//  NoWait
//
//  Created by zhuang zhang on 2020/5/18.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZStudentOrganizationBannerCell.h"

@interface ZStudentOrganizationBannerCell ()<SDCycleScrollViewDelegate>
@property (nonatomic,strong) SDCycleScrollView *iCycleScrollView;
@property (nonatomic,strong) UILabel *titleLabel;
@property (nonatomic,strong) UILabel *numLabel;
@property (nonatomic,strong) UIImageView *numHintImageView;

@end

@implementation ZStudentOrganizationBannerCell
- (void)setupView {
    [super setupView];
    
    [self.contentView addSubview:self.iCycleScrollView];
    [self.iCycleScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(CGFloatIn750(30));
        make.right.equalTo(self.mas_right).offset(CGFloatIn750(-30));
        make.top.equalTo(self.mas_top).offset(CGFloatIn750(0));
        make.bottom.equalTo(self.mas_bottom).offset(CGFloatIn750(0));
    }];
    
    UIView *backView = [[UIView alloc] init];
    backView.backgroundColor = HexAColor(0x000000, 0.8);
    [self.iCycleScrollView addSubview:backView];
    [backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.equalTo(self.iCycleScrollView);
        make.height.mas_equalTo(CGFloatIn750(70));
    }];
    [backView addSubview:self.titleLabel];
    
    [backView addSubview:self.numLabel];
    [self.numLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.iCycleScrollView.mas_right).offset(-CGFloatIn750(30));
        make.centerY.equalTo(backView.mas_centerY);
        make.width.mas_equalTo(CGFloatIn750(40));
    }];
    
    [backView addSubview:self.numHintImageView];
    [self.numHintImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.numLabel.mas_left).offset(-CGFloatIn750(6));
        make.centerY.equalTo(backView.mas_centerY);
        make.width.mas_equalTo(CGFloatIn750(27));
        make.height.mas_equalTo(CGFloatIn750(22));
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.iCycleScrollView.mas_left).offset(CGFloatIn750(30));
        make.centerY.equalTo(backView.mas_centerY);
        make.right.equalTo(self.numHintImageView.mas_left).offset(-CGFloatIn750(30));
    }];
}

#pragma mark - lazy loading
- (SDCycleScrollView *)iCycleScrollView {
    if (!_iCycleScrollView) {
        _iCycleScrollView =  [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(CGFloatIn750(30), CGFloatIn750(0), KScreenWidth-CGFloatIn750(60), CGFloatIn750(248)) delegate:self placeholderImage:nil];
        _iCycleScrollView.autoScrollTimeInterval = 5;
//        _iCycleScrollView.currentPageDotImage =  [UIImage imageNamed:@"pageControlCurrentDot"];
//        _iCycleScrollView.pageDotImage = [UIImage imageNamed:@"pageControlDot"];
        _iCycleScrollView.imageURLStringsGroup = @[];
        _iCycleScrollView.bannerImageViewContentMode = UIViewContentModeScaleAspectFill;
        _iCycleScrollView.backgroundColor = adaptAndDarkColor([UIColor colorWhite],[UIColor colorBlackBGDark]);
        ViewRadius(_iCycleScrollView, CGFloatIn750(12));
        _iCycleScrollView.currentPageDotColor = [UIColor colorMain];
        _iCycleScrollView.pageDotBottom = CGFloatIn750(70);
    }
    return _iCycleScrollView;
}


- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _titleLabel.textColor = adaptAndDarkColor([UIColor colorWhite],[UIColor colorWhite]);
        _titleLabel.numberOfLines = 1;
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        [_titleLabel setFont:[UIFont fontContent]];
        
    }
    return _titleLabel;
}

- (UILabel *)numLabel {
    if (!_numLabel) {
        _numLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _numLabel.textColor = adaptAndDarkColor([UIColor colorWhite],[UIColor colorWhite]);
        _numLabel.numberOfLines = 1;
        _numLabel.textAlignment = NSTextAlignmentLeft;
        [_numLabel setFont:[UIFont fontContent]];
        
    }
    return _numLabel;
}

- (UIImageView *)numHintImageView {
    if (!_numHintImageView) {
        _numHintImageView = [[UIImageView alloc] init];
        _numHintImageView.image = [UIImage imageNamed:@"photonumHint"];
        _numHintImageView.layer.masksToBounds = YES;
        _numHintImageView.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _numHintImageView;
}
    

#pragma mark -  scrollview回调
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index{
    if (_bannerBlock && _images_list && _images_list.count > index) {
        _bannerBlock(_images_list[index]);
    }
}

-(void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didScrollToIndex:(NSInteger)index {
    _titleLabel.text = _images_list[index].name;
    _numLabel.text = _images_list[index].image_count;
    
}

- (void)setImages_list:(NSArray<ZImagesModel *> *)images_list {
    _images_list = images_list;
    NSMutableArray *mList = @[].mutableCopy;
    for (int i = 0; i < images_list.count; i ++) {
        [mList addObject:images_list[i].image];
        if (i == 0) {
            _titleLabel.text = images_list[i].name;
            _numLabel.text = images_list[0].image_count;
        }
    }
    _iCycleScrollView.imageURLStringsGroup = mList;
    
}

+ (CGFloat)z_getCellHeight:(id)sender {
    return KScreenWidth * (230.0f/345.0);
}
@end
