//
//  ZOrganizationLessonDetailHeaderCell.m
//  NoWait
//
//  Created by zhuang zhang on 2020/2/25.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZOrganizationLessonDetailHeaderCell.h"
#import "SDCycleScrollView.h"

@interface ZOrganizationLessonDetailHeaderCell ()<SDCycleScrollViewDelegate>
@property (nonatomic,strong) SDCycleScrollView *iCycleScrollView;
@end

@implementation ZOrganizationLessonDetailHeaderCell

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
    self.contentView.backgroundColor = adaptAndDarkColor([UIColor colorWhite], [UIColor colorBlackBGDark]);
    self.clipsToBounds = YES;
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    [self.contentView addSubview:self.iCycleScrollView];
    [self.iCycleScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(CGFloatIn750(0));
        make.right.equalTo(self.mas_right).offset(CGFloatIn750(-0));
        make.top.equalTo(self.mas_top).offset(CGFloatIn750(0));
        make.bottom.equalTo(self.mas_bottom).offset(CGFloatIn750(-0));
    }];
}

#pragma mark - lazy loading
- (SDCycleScrollView *)iCycleScrollView {
    if (!_iCycleScrollView) {
        UIImage *dot = [[UIImage imageNamed:@"pageControlCurrentDot"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        
        _iCycleScrollView =  [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(CGFloatIn750(0), CGFloatIn750(0), KScreenWidth-CGFloatIn750(0), CGFloatIn750(500)) delegate:self placeholderImage:[UIImage imageNamed:@"lessonDetail"]];
        _iCycleScrollView.autoScrollTimeInterval = 5;
        _iCycleScrollView.currentPageDotImage = dot;
        _iCycleScrollView.pageDotImage = [UIImage imageNamed:@"pageControlDot"];
        _iCycleScrollView.imageURLStringsGroup = @[];
        _iCycleScrollView.backgroundColor = adaptAndDarkColor([UIColor colorWhite], [UIColor colorBlackBGDark]);
        _iCycleScrollView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _iCycleScrollView;
}

+(CGFloat)z_getCellHeight:(id)sender {
    return CGFloatIn750(500);
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
    for (int i = 0; i < list.count; i++) {
        [imageList addObject:list[i].data];
    }
    
    _iCycleScrollView.imageURLStringsGroup = imageList;
}
@end
