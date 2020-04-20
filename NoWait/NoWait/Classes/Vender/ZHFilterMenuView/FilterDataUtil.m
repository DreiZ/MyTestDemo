//
//  FilterDataUtil.m
//  ZHFilterMenuView
//
//  Created by 周亚楠 on 2019/12/19.
//  Copyright © 2019 Zhou. All rights reserved.
//

#import "FilterDataUtil.h"
#import "ZHFilterModel.h"

@interface FilterDataUtil ()
@property (nonatomic, strong) NSArray *dictArr;
@end

@implementation FilterDataUtil

- (NSMutableArray *)getTabDataByType:(FilterType)type
{
    NSMutableArray *dataArr = [NSMutableArray array];
    
//    NSMutableArray *areaArr = [NSMutableArray array];
    NSMutableArray *roomTypeArr = [NSMutableArray array];
    NSMutableArray *moreArr = [NSMutableArray array];
    NSMutableArray *sortArr = [NSMutableArray array];
//
//    ZHFilterModel *areaModel = [ZHFilterModel createFilterModelWithHeadTitle:@"城区" modelArr:[self getAddressDataByType:0] selectFirst:YES multiple:NO];
//    areaModel.selected = YES;
//    [areaArr addObject:areaModel];
//
//    [areaArr addObject:[ZHFilterModel createFilterModelWithHeadTitle:@"附近" modelArr:[self getAddressDataByType:1] selectFirst:NO multiple:NO]];
//
    [roomTypeArr addObject:[ZHFilterModel createFilterModelWithHeadTitle:@"机构分类" modelArr:[self getClassificationData] selectFirst:NO multiple:YES]];
    
    [moreArr addObject:[ZHFilterModel createFilterModelWithHeadTitle:@"营业时间" modelArr:[self getFiltrateDataByType:0] selectFirst:NO multiple:YES]];
    [moreArr addObject:[ZHFilterModel createFilterModelWithHeadTitle:@"价格区间" modelArr:[self getFiltrateDataByType:1] selectFirst:NO multiple:YES]];
    [moreArr addObject:[ZHFilterModel createFilterModelWithHeadTitle:@"品质" modelArr:[self getFiltrateDataByType:2] selectFirst:NO multiple:YES]];
    
    [sortArr addObject:[ZHFilterModel createFilterModelWithHeadTitle:@"" modelArr:[self getSortData] selectFirst:YES multiple:NO]];
    
//    [dataArr addObject:areaArr];
    if (type == FilterTypeFilterMain) {
        [dataArr addObject:roomTypeArr];
        [dataArr addObject:sortArr];
        [dataArr addObject:moreArr];
    }else if(type == FilterTypeISRent){
        [dataArr addObject:sortArr];
    }
    
    
    
    return dataArr;
}


- (NSArray *)getAddressDataByType:(NSInteger)type
{
    NSArray <NSArray *>*address = @[@[@"全城",@"鼓楼区",@"贾汪区",@"云龙区",@"泉山区",@"铜山区"],@[@"附近",@"500m",@"1km",@"3km",@"5km",@"10km"]].mutableCopy;
    NSMutableArray *infoArr = [NSMutableArray array];
    
    for (int i = 0; i < address[type].count; i++) {
        ZHFilterItemModel *model = [[ZHFilterItemModel alloc] init];
        model.selected = NO;             //标记选择状态
        model.name = address[type][i];              //名称
        [infoArr addObject:model];
    }
    
    
    return infoArr;
}

- (NSArray *)getClassificationData
{
    NSArray *classification = @[@"体育竞技",@"艺术舞蹈",@"兴趣爱好",@"其他分类"].mutableCopy;
    NSMutableArray *infoArr = [NSMutableArray array];
    
    for (int i = 0; i < classification.count; i++) {
        ZHFilterItemModel *model = [[ZHFilterItemModel alloc] init];
        model.selected = NO;             //标记选择状态
        model.name = classification[i];              //名称
        model.code = @"type";
        model.parentCode = [NSString stringWithFormat:@"%d",i+1];
        [infoArr addObject:model];
    }
    
    
    return infoArr;
}

- (NSArray *)getFiltrateDataByType:(NSInteger)type
{
    NSArray <NSArray *>*filtrate = @[@[@"工作日",@"周六",@"周天",@"周末",@"寒暑假"],@[@"0-100",@"100-500",@"500-1000",@"1000-2000",@"2000-5000",@"5000以上"]
    ,@[@"连锁机构",@"高分品质",]].mutableCopy;
       NSMutableArray *infoArr = [NSMutableArray array];
       
       for (int i = 0; i < filtrate[type].count; i++) {
           ZHFilterItemModel *model = [[ZHFilterItemModel alloc] init];
           model.selected = NO;             //标记选择状态
           model.name = filtrate[type][i];              //名称
           model.code = @"more";
           [infoArr addObject:model];
       }
       
       
       return infoArr;
}

- (NSArray *)getSortData
{
     NSArray *sortArr = @[@"综合排序",@"评分优先",@"销量优先",@"距离优先"].mutableCopy;
       NSMutableArray *infoArr = [NSMutableArray array];
       
       for (int i = 0; i < sortArr.count; i++) {
           ZHFilterItemModel *model = [[ZHFilterItemModel alloc] init];
           model.selected = NO;             //标记选择状态
           model.name = sortArr[i];              //名称
           model.code = @"sort";
           model.parentCode = [NSString stringWithFormat:@"%d",i];
           [infoArr addObject:model];
       }
    
    return infoArr;
}
@end
