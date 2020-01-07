//
//  ZStudentMainFiltrateSectionView.m
//  NoWait
//
//  Created by zhuang zhang on 2020/1/6.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZStudentMainFiltrateSectionView.h"
#import "ZHFilterMenuView.h"
#import "FilterDataUtil.h"

@interface ZStudentMainFiltrateSectionView ()<ZHFilterMenuViewDelegate,ZHFilterMenuViewDetaSource>
@property (nonatomic, strong) NSMutableArray *dataArr;
@property (nonatomic, strong) ZHFilterMenuView *menuView;

@end

@implementation ZStudentMainFiltrateSectionView



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
    
   FilterDataUtil *dataUtil = [[FilterDataUtil alloc] init];
   self.menuView.filterDataArr = [dataUtil getTabDataByType:FilterTypeSecondHandHouse];
   //开始显示
   [self.menuView beginShowMenuView];
    
    UIView *bottomLineView = [[UIView alloc] initWithFrame:CGRectZero];
    bottomLineView.backgroundColor = KMainColor;
    [self addSubview:bottomLineView];
    [bottomLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self);
        make.height.mas_equalTo(1);
    }];
}


/** 确定回调 */
- (void)menuView:(ZHFilterMenuView *)menuView didSelectConfirmAtSelectedModelArr:(NSArray *)selectedModelArr
{
    NSArray *dictArr = [ZHFilterItemModel mj_keyValuesArrayWithObjectArray:selectedModelArr];
    NSLog(@"结果回调：%@",dictArr.mj_JSONString);
}

/** 警告回调(用于错误提示) */
- (void)menuView:(ZHFilterMenuView *)menuView wangType:(ZHFilterMenuViewWangType)wangType
{
    if (wangType == ZHFilterMenuViewWangTypeInput) {
        NSLog(@"请输入正确的价格区间！");
    }
}

/** 返回每个 tabIndex 下的确定类型 */
- (ZHFilterMenuConfirmType)menuView:(ZHFilterMenuView *)menuView confirmTypeInTabIndex:(NSInteger)tabIndex
{
    if (tabIndex == 4) {
        return ZHFilterMenuConfirmTypeSpeedConfirm;
    }
    return ZHFilterMenuConfirmTypeBottomConfirm;
}

/** 返回每个 tabIndex 下的下拉展示类型 */
- (ZHFilterMenuDownType)menuView:(ZHFilterMenuView *)menuView downTypeInTabIndex:(NSInteger)tabIndex
{
    if (tabIndex == 0) {
        return ZHFilterMenuDownTypeTwoLists;
    } else if (tabIndex == 1) {
        return ZHFilterMenuDownTypeItemInput;
    } else if (tabIndex == 2) {
       return ZHFilterMenuDownTypeOnlyItem;
    } else if (tabIndex == 3) {
        return ZHFilterMenuDownTypeOnlyItem;
    } else if (tabIndex == 4) {
        return ZHFilterMenuDownTypeOnlyList;
    }
    return ZHFilterMenuDownTypeOnlyList;
}


- (ZHFilterMenuView *)menuView
{
    if (!_menuView) {
        _menuView = [[ZHFilterMenuView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, CGFloatIn750(88)) maxHeight:CGRectGetHeight(self.frame) - CGFloatIn750(88)];
        _menuView.zh_delegate = self;
        _menuView.zh_dataSource = self;
       _menuView.titleArr = @[@"区域",@"价格",@"房型",@"更多",@"排序"];
        _menuView.imageNameArr = @[@"mineLessonDown",@"mineLessonDown",@"mineLessonDown",@"mineLessonDown",@"x_arrow"];
        [self addSubview:_menuView];
    }
    return _menuView;
}

@end
