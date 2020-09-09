//
//  ZStudentBannerCell.m
//  NoWait
//
//  Created by zhuang zhang on 2020/1/6.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZStudentBannerCell.h"


@interface ZStudentBannerCell ()<SDCycleScrollViewDelegate>
@end

@implementation ZStudentBannerCell

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
        make.left.equalTo(self.mas_left).offset(CGFloatIn750(30));
        make.right.equalTo(self.mas_right).offset(CGFloatIn750(-30));
        make.top.equalTo(self.mas_top).offset(CGFloatIn750(0));
        make.bottom.equalTo(self.mas_bottom).offset(CGFloatIn750(0));
    }];
    ViewRadius(self.iCycleScrollView, CGFloatIn750(8));
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
    }
    return _iCycleScrollView;
}

+(CGFloat)z_getCellHeight:(id)sender {
    return CGFloatIn750(248);
}

#pragma mark -  scrollview回调
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index{
    if (_bannerBlock && _list && _list.count > index) {
        _bannerBlock(_list[index]);
    }
}

-(void)setList:(NSArray<ZStudentBannerModel *> *)list {
    _list = list;
    NSMutableArray *imageList = @[].mutableCopy;
    for (ZStudentBannerModel *model in list) {
        [imageList addObject:model.image];
    }
    _iCycleScrollView.imageURLStringsGroup = imageList;
}
@end
