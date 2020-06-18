//
//  ZMineSignListDetailImageCell.m
//  NoWait
//
//  Created by zhuang zhang on 2020/5/15.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZMineSignListDetailImageCell.h"
#import "SDCycleScrollView.h"

@interface ZMineSignListDetailImageCell ()<SDCycleScrollViewDelegate>
@property (nonatomic,strong) SDCycleScrollView *iCycleScrollView;
@property (nonatomic,strong) UILabel *timeLabel;

@end


@implementation ZMineSignListDetailImageCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupView];
    }
    return self;
}

-(void)setupView
{
    [super setupView];
    
    [self.contentView addSubview:self.iCycleScrollView];
    [self.iCycleScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(CGFloatIn750(0));
        make.right.equalTo(self.mas_right).offset(CGFloatIn750(-0));
        make.top.equalTo(self.mas_top).offset(CGFloatIn750(0));
        make.bottom.equalTo(self.mas_bottom).offset(CGFloatIn750(-0));
    }];
    
    [self.contentView addSubview:self.timeLabel];
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(CGFloatIn750(30));
        make.bottom.equalTo(self.mas_bottom).offset(CGFloatIn750(-22));
    }];
}

#pragma mark - lazy loading
- (SDCycleScrollView *)iCycleScrollView {
    if (!_iCycleScrollView) {
        _iCycleScrollView =  [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(CGFloatIn750(0), CGFloatIn750(0), KScreenWidth, CGFloatIn750(150)) delegate:self placeholderImage:[UIImage imageNamed:@"default_loadFail292"]];
        _iCycleScrollView.autoScrollTimeInterval = 8;
//        _iCycleScrollView.currentPageDotImage =  [UIImage imageNamed:@"pageControlCurrentDot"];
//        _iCycleScrollView.pageDotImage = [UIImage imageNamed:@"pageControlDot"];
        _iCycleScrollView.imageURLStringsGroup = @[];
        _iCycleScrollView.backgroundColor = adaptAndDarkColor([UIColor colorWhite], [UIColor colorBlackBGDark]);
        _iCycleScrollView.bannerImageViewContentMode = UIViewContentModeScaleAspectFill;
        _iCycleScrollView.delegate = self;
    }
    return _iCycleScrollView;
}


- (UILabel *)timeLabel {
    if (!_timeLabel) {
        _timeLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _timeLabel.textColor = adaptAndDarkColor([UIColor colorWhite],[UIColor colorWhite]);
        _timeLabel.text = @"2020/03/04 12:33:22";
        _timeLabel.numberOfLines = 1;
        _timeLabel.textAlignment = NSTextAlignmentLeft;
        [_timeLabel setFont:[UIFont fontSmall]];
    }
    return _timeLabel;
}

- (void)setDetailModel:(ZOriganizationSignListNetModel *)detailModel {
    _detailModel = detailModel;
    NSMutableArray *imageArr = @[].mutableCopy;
    [_detailModel.image enumerateObjectsUsingBlock:^(ZOriganizationSignListImageNetModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [imageArr addObject:obj.image];
        if (idx == 0) {
            _timeLabel.text = obj.time;
        }
    }];
    _iCycleScrollView.imageURLStringsGroup = imageArr;
}


/** 点击图片回调 */
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index {
    [[ZImagePickerManager sharedManager] showBrowser:_iCycleScrollView.imageURLStringsGroup withIndex:index];
}

+ (CGFloat)z_getCellHeight:(id)sender {
    return CGFloatIn750(300);
}
@end
