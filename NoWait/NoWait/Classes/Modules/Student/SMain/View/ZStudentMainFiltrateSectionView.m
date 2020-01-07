//
//  ZStudentMainFiltrateSectionView.m
//  NoWait
//
//  Created by zhuang zhang on 2020/1/6.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZStudentMainFiltrateSectionView.h"
#import "WMZDropDownMenu.h"

@interface ZStudentMainFiltrateSectionView ()<WMZDropMenuDelegate>
@property(nonatomic,strong)NSDictionary *dataDic;
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
    
    WMZDropMenuParam *param =
    MenuParam()
    .wMainRadiusSet(10)
    .wCollectionViewCellSelectTitleColorSet(KMainColor)
    .wCollectionViewSectionRecycleCountSet(8)
    .wMaxHeightScaleSet(0.5);
    
    WMZDropDownMenu *menu = [[WMZDropDownMenu alloc] initWithFrame:CGRectMake(0, 0, Menu_Width, CGFloatIn750(88)) withParam:param];
    menu.delegate = self;
    [self addSubview:menu];
    
    UIView *bottomLineView = [[UIView alloc] initWithFrame:CGRectZero];
    bottomLineView.backgroundColor = KMainColor;
    [self addSubview:bottomLineView];
    [bottomLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self);
        make.height.mas_equalTo(1);
    }];
}

- (NSArray*)titleArrInMenu:(WMZDropDownMenu *)menu{
    return @[
         @{@"name":@"综合排序",@"normalImage":@"mineLessonDown",@"selectImage":@"mineLessonSelectDown"},
         @{@"name":@"附近",@"normalImage":@"mineLessonDown",@"selectImage":@"mineLessonSelectDown"},
         @{@"name":@"机构",@"normalImage":@"mineLessonDown",@"selectImage":@"mineLessonSelectDown"},
         @{@"name":@"筛选",@"normalImage":@"mineLessonDown",@"selectImage":@"mineLessonSelectDown"},
    ];
}


- (NSInteger)menu:(WMZDropDownMenu *)menu numberOfRowsInSection:(NSInteger)section{
   if (section == 1){
        return 2;
    }else if (section == 3){
        return 5;
    }

    return 1;
}

- (NSArray *)menu:(WMZDropDownMenu *)menu dataForRowAtDropIndexPath:(WMZDropIndexPath *)dropIndexPath{
      if (dropIndexPath.section == 0){
          return @[@"综合排序",@"销量优先",@"速度优先",@"评分优先",
                   @"综合排序",@"销量优先",@"速度优先",@"评分优先"];

      }else if (dropIndexPath.section == 1){
          if (dropIndexPath.row == 0) return @[@"全城",@"附近",@"推荐商圈",@"鼓楼区",
                                               @"云龙区",@"泉山区",@"贾汪区"];
          if (dropIndexPath.row == 1) return @[];
      }else if (dropIndexPath.section == 2){
           return @[@"全部",@"体育竞技",@"兴趣爱好",@"艺术舞蹈",@"游泳健身",@"教育培训",@"球类",@"舞蹈"];
      }else if (dropIndexPath.section == 3){
           if (dropIndexPath.row == 0) return @[@"四星以上",@"品牌商家"];
           if (dropIndexPath.row == 1) return @[@"专送",@"到店自取"];
           if (dropIndexPath.row == 2) return @[@"优惠商家",@"满减优惠",@"近端领券",@"折扣商品",
                                                @"优惠商家",@"满减优惠",@"近端领券",@"折扣商品",
                                                @"优惠商家",@"满减优惠",@"近端领券",@"折扣商品"];
           if (dropIndexPath.row == 3) return @[@"跨天预定",@"开发票",
                                                @{@"name":@"赠准时宝",@"image":@"menu_xinyong"},
                                                @{@"name":@"极速退款",@"image":@"menu_xinyong"}];
          if (dropIndexPath.row == 4) return @[@"30分钟内",@"40分钟内",@"50分钟内",@"60分钟内",
                                               @"30km内",@"40km内",@"50km内",@"60km内"];
      }
      return @[];
}

#define titleArr2 @[@"品质",@"配送",@"优惠活动",@"商家特色",@"速度"]
- (NSString *)menu:(WMZDropDownMenu *)menu titleForHeadViewAtDropIndexPath:(WMZDropIndexPath *)dropIndexPath{
    if (dropIndexPath.section == 3){
        return titleArr2[dropIndexPath.row];
    }
    return nil;
}

- (CGFloat)menu:(WMZDropDownMenu *)menu heightAtDropIndexPath:(WMZDropIndexPath *)dropIndexPath AtIndexPath:(NSIndexPath *)indexpath{
    if (dropIndexPath.section == 0 || dropIndexPath.section == 1) {
        return 40;
    }
    return 35;
}
- (CGFloat)menu:(WMZDropDownMenu *)menu heightForFootViewAtDropIndexPath:(WMZDropIndexPath *)dropIndexPath{
    if (dropIndexPath.section ==3) {
        return 20;
    }
    return 0;
}

- (CGFloat)menu:(WMZDropDownMenu *)menu heightForHeadViewAtDropIndexPath:(WMZDropIndexPath *)dropIndexPath{
    if (dropIndexPath.section == 3) {
        return 35;
    }
    return 0;
}

- (MenuShowAnimalStyle)menu:(WMZDropDownMenu *)menu showAnimalStyleForRowInSection:(NSInteger)section{
    return MenuShowAnimalBottom;
}
- (MenuHideAnimalStyle)menu:(WMZDropDownMenu *)menu hideAnimalStyleForRowInSection:(NSInteger)section{
    return MenuHideAnimalTop;
}

- (MenuUIStyle)menu:(WMZDropDownMenu *)menu uiStyleForRowIndexPath:(WMZDropIndexPath *)dropIndexPath{
    if (dropIndexPath.section == 2||dropIndexPath.section == 3) {
        return MenuUICollectionView;
    }
    return MenuUITableView;
}

- (BOOL)menu:(WMZDropDownMenu *)menu showExpandAtDropIndexPath:(WMZDropIndexPath *)dropIndexPath{
    if (dropIndexPath.section == 3 && dropIndexPath.row == 2) {
        return YES;
    }
    return NO;
}

- (BOOL)menu:(WMZDropDownMenu *)menu closeWithTapAtDropIndexPath:(WMZDropIndexPath *)dropIndexPath{
    if (dropIndexPath.section == 1&&dropIndexPath.row == 1)  return YES;
    else if (dropIndexPath.section == 0) return YES;
    return NO;
}

- (void)menu:(WMZDropDownMenu *)menu didSelectRowAtDropIndexPath:(WMZDropIndexPath *)dropIndexPath dataIndexPath:(NSIndexPath *)indexpath data:(WMZDropTree*)data{
    //手动更新二级联动数据
    if (dropIndexPath.section == 1) {
        if (dropIndexPath.row == 0) {
            [menu updateData:self.dataDic[data.name] ForRowAtDropIndexPath:dropIndexPath];
        }
    }
}

- (void)menu:(WMZDropDownMenu *)menu customDefauultCollectionFootView:(WMZDropConfirmView *)confirmView{
    confirmView.showBorder = YES;
    confirmView.confirmBtn.backgroundColor = KMainColor;
    [confirmView.confirmBtn setTitleColor:KWhiteColor forState:UIControlStateNormal];
}

- (NSDictionary*)dataDic{
    if (!_dataDic) {
        _dataDic = @{
                  @"全城":@[],
                  @"附近":@[@"附近",@"500m",@"1km",@"3km",@"5km",@"10km"],
                  @"推荐商圈":@[@"滨湖",@"段庄广场",@"矿业大学",@"万达广场",@"苹果汇邻边"],
                  @"鼓楼区":@[@"全部",@"彭城广场",@"金地国际",@"彭城一号"],
                  @"云龙区":@[@"全部",@"绿地世纪城",@"世贸广场",@"老东门",@"青年路"],
                  @"泉山区":@[@"全部",@"滨湖",@"玉龙湖",@"公园一号",@"端庄广场",@"矿业大学"],
                  @"贾汪区":@[@"全部",@"高铁站",@"月星环球港",@"中心城区",@"高铁时代广场"],
        };
    }
    return _dataDic;
}

@end
