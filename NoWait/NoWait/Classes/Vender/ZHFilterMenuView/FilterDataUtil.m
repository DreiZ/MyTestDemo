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
    
    NSMutableArray *classArr = [NSMutableArray array];
//    NSMutableArray *moreArr = [NSMutableArray array];
    NSMutableArray *sortArr = [NSMutableArray array];
    ZHFilterModel *areaModel = [ZHFilterModel createFilterModelWithHeadTitle:@"体育竞技" modelArr:[self getClassificationData:@"0" classification:@[@"足球",@"篮球",@"排球",@"橄榄球"]] selectFirst:YES multiple:NO];
    areaModel.selected = YES;
    [classArr addObject:areaModel];
    
    [classArr addObject:[ZHFilterModel createFilterModelWithHeadTitle:@"舞蹈艺术" modelArr:[self getClassificationData:@"1" classification:@[@"瑜伽",@"机械舞",@"古典舞",@"蒙古舞"]] selectFirst:YES multiple:NO]];
    
    [sortArr addObject:[ZHFilterModel createFilterModelWithHeadTitle:@"" modelArr:[self getSortData] selectFirst:YES multiple:NO]];
    
    if (type == FilterTypeFilterMain) {
        [dataArr addObject:classArr];
        [dataArr addObject:sortArr];
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

- (NSArray *)getClassificationData:(NSString *)parentCode classification:(NSArray *)classification
{
    NSMutableArray *infoArr = [NSMutableArray array];
    for (int i = 0; i < classification.count; i++) {
        ZHFilterItemModel *model = [[ZHFilterItemModel alloc] init];
        model.selected = NO;             //标记选择状态
        model.name = classification[i];              //名称
        model.code = @"type";
        model.parentCode = parentCode;
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
