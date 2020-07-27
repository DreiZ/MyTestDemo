//
//  ZStudentLessonCoachListVC.m
//  NoWait
//
//  Created by zhuang zhang on 2020/4/20.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZStudentLessonCoachListVC.h"
#import "ZOriganizationTeacherViewModel.h"

@interface ZStudentLessonCoachListVC ()

@end

@implementation ZStudentLessonCoachListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.navigationItem setTitle:@"教师"];
}

#pragma mark - 数据处理
- (void)refreshData {
    self.currentPage = 1;
    self.loading = YES;
    [self refreshHeadData:[self setPostCommonData]];
}

- (void)refreshHeadData:(NSDictionary *)param {
    __weak typeof(self) weakSelf = self;
    [ZOriganizationTeacherViewModel getLessonTeacherList:param completeBlock:^(BOOL isSuccess, ZOriganizationTeacherListNetModel *data) {
        weakSelf.loading = NO;
        if (isSuccess && data) {
            [weakSelf.dataSources removeAllObjects];
            [weakSelf.dataSources addObjectsFromArray:data.list];
            [weakSelf initCellConfigArr];
            [weakSelf.iCollectionView reloadData];
            
            [weakSelf.iCollectionView tt_endRefreshing];
            if (data && [data.total integerValue] <= weakSelf.currentPage * 10) {
                [weakSelf.iCollectionView tt_removeLoadMoreFooter];
            }else{
                [weakSelf.iCollectionView tt_endLoadMore];
            }
        }else{
            [weakSelf.iCollectionView reloadData];
            [weakSelf.iCollectionView tt_endRefreshing];
            [weakSelf.iCollectionView tt_removeLoadMoreFooter];
        }
    }];
}

- (void)refreshMoreData {
    self.currentPage++;
    self.loading = YES;
    NSMutableDictionary *param = [self setPostCommonData];
    
    __weak typeof(self) weakSelf = self;
    [ZOriganizationTeacherViewModel getLessonTeacherList:param completeBlock:^(BOOL isSuccess, ZOriganizationTeacherListNetModel *data) {
        weakSelf.loading = NO;
        if (isSuccess && data) {
            [weakSelf.dataSources removeAllObjects];
            [weakSelf.dataSources addObjectsFromArray:data.list];
            [weakSelf initCellConfigArr];
            [weakSelf.iCollectionView reloadData];
            
            [weakSelf.iCollectionView tt_endRefreshing];
            if (data && [data.total integerValue] <= weakSelf.currentPage * 10) {
                [weakSelf.iCollectionView tt_removeLoadMoreFooter];
            }else{
                [weakSelf.iCollectionView tt_endLoadMore];
            }
        }else{
            [weakSelf.iCollectionView reloadData];
            [weakSelf.iCollectionView tt_endRefreshing];
            [weakSelf.iCollectionView tt_removeLoadMoreFooter];
        }
    }];
}

- (NSMutableDictionary *)setPostCommonData {
    NSMutableDictionary *param = @{@"page":[NSString stringWithFormat:@"%ld",self.currentPage]}.mutableCopy;
       [param setObject:self.lesson_id forKey:@"course_id"];
//       [param setObject:@"0" forKey:@"status"];
    return param;
}
@end

#pragma mark - RouteHandler
@interface ZStudentLessonCoachListVC (RouteHandler)<SJRouteHandler>

@end

@implementation ZStudentLessonCoachListVC (RouteHandler)

+ (NSString *)routePath {
    return ZRoute_main_coachList;
}

+ (void)handleRequest:(SJRouteRequest *)request topViewController:(UIViewController *)topViewController completionHandler:(SJCompletionHandler)completionHandler {
    ZStudentLessonCoachListVC *routevc = [[ZStudentLessonCoachListVC alloc] init];
    if (request.prts && [request.prts isKindOfClass:[NSDictionary class]]) {
        NSDictionary *tempDict = request.prts;
        if ([tempDict objectForKey:@"lesson_id"]) {
            routevc.lesson_id = tempDict[@"lesson_id"];
        }
        if ([tempDict objectForKey:@"stores_id"]) {
            routevc.stores_id = tempDict[@"stores_id"];
        }
        
        if ([tempDict objectForKey:@"type"]) {
            routevc.type = [tempDict[@"type"] intValue];
        }
    }
    
    [topViewController.navigationController pushViewController:routevc animated:YES];
}
@end
