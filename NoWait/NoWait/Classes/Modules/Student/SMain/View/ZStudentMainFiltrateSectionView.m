//
//  ZStudentMainFiltrateSectionView.m
//  NoWait
//
//  Created by zhuang zhang on 2020/1/6.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZStudentMainFiltrateSectionView.h"


@interface ZStudentMainFiltrateSectionView ()<WMZDropMenuDelegate>
@property (nonatomic, strong) NSMutableArray *classifyOne;
@property (nonatomic, strong) NSMutableArray *sortArr;

@end

@implementation ZStudentMainFiltrateSectionView

- (instancetype)initWithFrame:(CGRect)frame classifys:(NSArray *)classifys {
    WMZDropMenuParam *param =
    MenuParam()
    .wPopOraignYSet(CGFloatIn750(88) + kTopHeight)
    .wMainRadiusSet(10)
    .wCollectionViewCellSelectTitleColorSet([UIColor colorMain])
    .wCollectionViewSectionRecycleCountSet(8)
    .wMaxHeightScaleSet(0.5);
    
    
    self = [super initWithFrame:frame withParam:param];
    if (self) {
        self.classifys = classifys;
        self.delegate = self;
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    WMZDropMenuParam *param =
    MenuParam()
    .wPopOraignYSet(CGFloatIn750(88) + kTopHeight)
    .wMainRadiusSet(10)
    .wCollectionViewCellSelectTitleColorSet([UIColor colorMain])
    .wCollectionViewSectionRecycleCountSet(8)
    .wMaxHeightScaleSet(0.5);
    
    
    self = [super initWithFrame:frame withParam:param];
    if (self) {
        self.delegate = self;

    }
    return self;
}

#pragma mark 初始化view
- (void)initMainView {
    self.backgroundColor = adaptAndDarkColor([UIColor colorWhite],[UIColor colorGrayLine]);
    self.clipsToBounds = YES;
    self.layer.masksToBounds = YES;
    
    UIView *bottomLineView = [[UIView alloc] initWithFrame:CGRectZero];
    bottomLineView.backgroundColor = adaptAndDarkColor([UIColor colorWhite],[UIColor colorBlackBGDark]);
    [self addSubview:bottomLineView];
    [bottomLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self);
        make.height.mas_equalTo(1);
    }];
}

- (NSArray*)titleArrInMenu:(WMZDropDownMenu *)menu{
    return @[@{@"name":@"机构类型",@"normalImage":@"menu_dowm",@"selectImage":@"menu_up"},
             @{@"name":@"综合排序",@"normalImage":@"menu_dowm",@"selectImage":@"menu_up"}
    ];
//    @{@"name":@"速度",@"normalImage":@"menu_dowm",@"selectImage":@"menu_up"},
//    @{@"name":@"全部筛选",@"normalImage":@"menu_dowm",@"selectImage":@"menu_up"
}


- (NSInteger)menu:(WMZDropDownMenu *)menu numberOfRowsInSection:(NSInteger)section{
   if (section == 0){
        return 2;
    }else if (section == 3){
        return 5;
    }

    return 1;
}

- (NSArray *)menu:(WMZDropDownMenu *)menu dataForRowAtDropIndexPath:(WMZDropIndexPath *)dropIndexPath{
      if (dropIndexPath.section == 1){
          return self.sortArr;

      }else if (dropIndexPath.section == 0){
          if (dropIndexPath.row == 0) return [self classifyOne];
          if (dropIndexPath.row == 1) return @[];
      }else if (dropIndexPath.section == 2){
           return @[@"30分钟内",@"40分钟内",@"50分钟内",@"60分钟内",@"30km内",@"40km内",@"50km内",@"60km内"];
      }else if (dropIndexPath.section == 3){
           if (dropIndexPath.row == 0) return @[@"四星以上",@"品牌商家"];
           if (dropIndexPath.row == 1) return @[@"美团专送",@"到店自取"];
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
    if (dropIndexPath.section == 0&&dropIndexPath.row == 1)  return YES;
    else if (dropIndexPath.section == 1) return YES;
    return NO;
}

/*
*是否关联 其他标题 即选中其他标题 此标题会不会取消选中状态 default YES
*/
- (BOOL)menu:(WMZDropDownMenu *)menu dropIndexPathConnectInSection:(NSInteger)section{
    if (section == 1) {
        return YES;
    }
    return NO;
}

- (void)menu:(WMZDropDownMenu *)menu didSelectRowAtDropIndexPath:(WMZDropIndexPath *)dropIndexPath dataIndexPath:(NSIndexPath *)indexpath data:(WMZDropTree*)data{
    //手动更新二级联动数据
    if (dropIndexPath.section == 0) {
        if (dropIndexPath.row == 0) {
            NSArray *arr = [self classifyOne];
            if (arr.count == 0) {
                [menu closeWith:dropIndexPath row:indexpath.row data:data];
            }
            [menu updateData:[self classifyTwoWithSuperID:data.ID] ForRowAtDropIndexPath:dropIndexPath];
        }else{
            if (self.dataBlock) {
                self.dataBlock(@{@"type":data.otherData?:@""});
            }
        }
    }else if(dropIndexPath.section == 1){
        if (self.dataBlock) {
            self.dataBlock(@{@"sort":SafeStr(data.ID)});
        }
    }
}

- (void)menu:(WMZDropDownMenu *)menu customDefauultCollectionFootView:(WMZDropConfirmView *)confirmView{
    confirmView.showBorder = YES;
    confirmView.confirmBtn.backgroundColor = adaptAndDarkColor([UIColor colorMain], [UIColor colorMain]);//0xFFc254
    [confirmView.confirmBtn setTitleColor:adaptAndDarkColor([UIColor whiteColor], [UIColor whiteColor]) forState:UIControlStateNormal];
    
    confirmView.resetBtn.backgroundColor = adaptAndDarkColor([UIColor colorWhite], [UIColor colorBlack]);//0xFFc254
    [confirmView.resetBtn setTitleColor:adaptAndDarkColor([UIColor colorTextBlack], [UIColor colorTextBlackDark]) forState:UIControlStateNormal];
}


- (void)menu:(WMZDropDownMenu *)menu didSelectTitleInSection:(NSInteger)section btn:(WMZDropMenuBtn*)selectBtn networkBlock:(MenuAfterTime)block {
    if (self.titleSelect) {
        self.titleSelect(section, block);
    }
}


- (void)setClassifys:(NSArray<ZMainClassifyOneModel *> *)classifys {
    _classifys = classifys;
}

- (NSMutableArray *)classifyOne {
    _classifyOne = @[].mutableCopy;
    
    if (ValidArray(_classifys)) {
        [_classifys enumerateObjectsUsingBlock:^(ZMainClassifyOneModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            NSMutableDictionary *temp = @{}.mutableCopy;
            [temp setObject:obj.classify_id forKey:@"ID"];
            [temp setObject:obj.name forKey:@"name"];
            
            [_classifyOne addObject:temp];
        }];
    }
    
    return _classifyOne;
}


- (NSMutableArray *)classifyTwoWithSuperID:(NSString *)superID {
    NSMutableArray *classifyTwo = @[].mutableCopy;
    
    if (ValidArray(_classifys) && superID) {
        [_classifys enumerateObjectsUsingBlock:^(ZMainClassifyOneModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([obj.classify_id isEqualToString:superID]) {
                [obj.secondary enumerateObjectsUsingBlock:^(ZMainClassifyOneModel * _Nonnull superObj, NSUInteger superIdx, BOOL * _Nonnull superStop) {
                    NSMutableDictionary *temp = @{}.mutableCopy;
                    [temp setObject:superObj.classify_id forKey:@"ID"];
                    [temp setObject:superObj.name forKey:@"name"];
                    [temp setObject:superObj forKey:@"otherData"];
                    [classifyTwo addObject:temp];
                }];
            }
        }];
    }
    
    return classifyTwo;
}

- (NSMutableArray *)sortArr {
    if (!_sortArr) {
        _sortArr = @[@{@"name":@"综合排序", @"ID":@"0"},
        @{@"name":@"评分优先", @"ID":@"1"},
        @{@"name":@"销量优先", @"ID":@"2"},
        @{@"name":@"距离优先", @"ID":@"3"}].mutableCopy;
    }
    return _sortArr;
}
@end
