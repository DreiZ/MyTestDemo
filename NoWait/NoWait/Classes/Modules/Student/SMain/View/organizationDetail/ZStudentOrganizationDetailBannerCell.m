//
//  ZStudentOrganizationDetailBannerCell.m
//  NoWait
//
//  Created by zhuang zhang on 2020/1/8.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZStudentOrganizationDetailBannerCell.h"
#import "SDCycleScrollView.h"

@interface ZStudentOrganizationDetailBannerCell ()<SDCycleScrollViewDelegate>
@property (nonatomic,strong) SDCycleScrollView *iCycleScrollView;
@end

@implementation ZStudentOrganizationDetailBannerCell

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
    self.contentView.backgroundColor = KBackColor;
    self.clipsToBounds = YES;
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    [self.contentView addSubview:self.iCycleScrollView];
    [self.iCycleScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(CGFloatIn750(10));
        make.right.equalTo(self.mas_right).offset(CGFloatIn750(-10));
        make.top.equalTo(self.mas_top).offset(CGFloatIn750(10));
        make.bottom.equalTo(self.mas_bottom).offset(CGFloatIn750(-10));
    }];
}

#pragma mark - lazy loading
- (SDCycleScrollView *)iCycleScrollView {
    if (!_iCycleScrollView) {
        _iCycleScrollView =  [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(CGFloatIn750(10), CGFloatIn750(10), KScreenWidth-CGFloatIn750(20), CGFloatIn750(232)) delegate:self placeholderImage:[UIImage imageNamed:@"wallhaven1"]];
        _iCycleScrollView.autoScrollTimeInterval = 1;
        _iCycleScrollView.currentPageDotImage =  [UIImage imageNamed:@"pageControlCurrentDot"];
        _iCycleScrollView.pageDotImage = [UIImage imageNamed:@"pageControlDot"];
        _iCycleScrollView.imageURLStringsGroup = @[];
        _iCycleScrollView.backgroundColor = KBackColor;
    }
    return _iCycleScrollView;
}

+(CGFloat)z_getCellHeight:(id)sender {
    return CGFloatIn750(232 + 30);
}


#pragma mark -  scrollview回调
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index{
    if (_bannerBlock && _list && _list.count > index) {
        _bannerBlock(_list[index]);
    }
}

-(void)setList:(NSArray<ZStudentDetailBannerModel *> *)list {
    _list = list;
    NSMutableArray *imageList = @[].mutableCopy;
    _iCycleScrollView.imageURLStringsGroup = imageList;
}
@end
