//
//  ZTeacherClassReportFormVC.m
//  NoWait
//
//  Created by zhuang zhang on 2020/9/14.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZTeacherClassReportFormVC.h"
#import "ZTeacherClassReportFormCell.h"
#import "ZTeacherClassReportFormTopView.h"
#import "ZTeacherClassReportFormSectionView.h"
#import "ZTeacherClassReportFormDayView.h"
#import "ZAlertBeginAndEndTimeView.h"
#import "ZTeacherClassFormFilterView.h"
#import "ZOriganizationClassViewModel.h"

@interface ZTeacherClassReportFormVC ()
@property (nonatomic,strong) ZTeacherClassReportFormTopView *formTopView;
@property (nonatomic,strong) ZTeacherClassReportFormSectionView *sectionView;
@property (nonatomic,strong) ZTeacherClassReportFormDayView *dayView;
@property (nonatomic,strong) ZTeacherClassFormFilterView *filterView;

@property (nonatomic,strong) NSMutableArray *classArr;
@property (nonatomic,strong) ZOriganizationClassListModel *classModel;

@end

@implementation ZTeacherClassReportFormVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    __weak typeof(self) weakSelf = self;
    self.zChain_setNavTitle(@"班级报表")
    .zChain_setTableViewGary()
    .zChain_resetMainView(^{
        [self.view addSubview:self.formTopView];
        [self.view addSubview:self.sectionView];
        [self.view addSubview:self.dayView];
        [self.formTopView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.equalTo(self.view);
            make.height.mas_equalTo(CGFloatIn750(80));
        }];
        [self.sectionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self.view);
            make.top.equalTo(self.formTopView.mas_bottom);
            make.height.mas_equalTo(CGFloatIn750(70));
        }];
        [self.dayView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self.view);
            make.top.equalTo(self.sectionView.mas_bottom);
            make.height.mas_equalTo(CGFloatIn750(60));
        }];
        
        [self.iTableView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.bottom.right.equalTo(self.view);
            make.top.equalTo(self.dayView.mas_bottom);
        }];
    }).zChain_block_setUpdateCellConfigData(^(void (^update)(NSMutableArray *)) {
        [weakSelf.cellConfigArr removeAllObjects];
        
        for (int i = 0; i < 10; i++) {
            [self.cellConfigArr addObject:getGrayEmptyCellWithHeight(CGFloatIn750(20))];
            ZCellConfig *cellConfig = [ZCellConfig cellConfigWithClassName:[ZTeacherClassReportFormCell className] title:[ZTeacherClassReportFormCell className] showInfoMethod:nil heightOfCell:[ZTeacherClassReportFormCell  z_getCellHeight:nil] cellType:ZCellTypeClass dataModel:nil];
            
            [self.cellConfigArr addObject:cellConfig];
            
        }
    });

    self.zChain_reload_ui();

    [self getClassData:^{
        if (ValidArray(weakSelf.classArr)) {
            weakSelf.classModel = weakSelf.classArr[0];
            weakSelf.formTopView.title = weakSelf.classModel.name;
        }
    }];
}

#pragma mark - lazy loading
- (ZTeacherClassReportFormTopView *)formTopView {
    if (!_formTopView) {
        __weak typeof(self) weakSelf = self;
        _formTopView = [[ZTeacherClassReportFormTopView alloc] init];
        _formTopView.moreBlock = ^(NSInteger index) {
            
            if (weakSelf.classArr) {
                if (weakSelf.classModel) {
                    weakSelf.filterView.model = weakSelf.classModel;
                }else{
                    if (ValidArray(weakSelf.classArr)) {
                        weakSelf.classModel = weakSelf.classArr[0];
                    }
                    weakSelf.filterView.model = weakSelf.classModel;
                }
                
                weakSelf.filterView.dataSources = weakSelf.classArr;
                [weakSelf.view addSubview:weakSelf.filterView];
            }else{
                weakSelf.classArr = @[].mutableCopy;
                [TLUIUtility showLoading:nil];
                [weakSelf getClassData:^{
                    [TLUIUtility hiddenLoading];
                    if (weakSelf.classModel) {
                        weakSelf.filterView.model = weakSelf.classModel;
                    }else{
                        if (ValidArray(weakSelf.classArr)) {
                            weakSelf.classModel = weakSelf.classArr[0];
                        }
                        weakSelf.filterView.model = weakSelf.classModel;
                    }
                    
                    weakSelf.filterView.dataSources = weakSelf.classArr;
                    [weakSelf.view addSubview:weakSelf.filterView];
                }];
            }
            
        };
        [_formTopView setTitle:@"傲视曲安雄班级"];
    }
    
    return _formTopView;
}

- (ZTeacherClassReportFormSectionView *)sectionView {
    if (!_sectionView) {
        __weak typeof(self) weakSelf = self;
        _sectionView = [[ZTeacherClassReportFormSectionView alloc] init];
        _sectionView.handleBlock = ^(NSInteger index) {
            if (index == 4) {
                if (weakSelf.sectionView.type == 0) {
                    [ZAlertBeginAndEndTimeView setAlertName:@"选择开始日期" subName:@"选择结束时间"  pickerMode:BRDatePickerModeYMD handlerBlock:^(NSDate *begin, NSDate *end) {
                        
                    }];
                }else{
                    [ZAlertBeginAndEndTimeView setAlertName:@"选择开始日期" subName:@"选择结束时间"  pickerMode:BRDatePickerModeYM handlerBlock:^(NSDate *begin, NSDate *end) {
                    
                    }];
                }
            }else{
                
            }
        };
        _sectionView.type = 1;
    }
    
    return _sectionView;
}

- (ZTeacherClassReportFormDayView *)dayView {
    if (!_dayView) {
        _dayView = [[ZTeacherClassReportFormDayView alloc] init];
    }
    
    return _dayView;
}


- (ZTeacherClassFormFilterView *)filterView {
    if (!_filterView) {
        __weak typeof(self) weakSelf = self;
        _filterView = [[ZTeacherClassFormFilterView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, KScreenHeight)];
        _filterView.handleBlock = ^(ZOriganizationClassListModel *model) {
            weakSelf.classModel = model;
            weakSelf.formTopView.title = weakSelf.classModel.name;
        };
        
    }
    return _filterView;
}


#pragma mark - 数据处理
- (void)getClassData:(void(^)(void))complete {
    __weak typeof(self) weakSelf = self;
    NSMutableDictionary *param = @{@"page":[NSString stringWithFormat:@"%d",1]}.mutableCopy;
    [param setObject:SafeStr([ZUserHelper sharedHelper].stores.stores_id) forKey:@"stores_id"];
    [param setObject:@"1000" forKey:@"page_size"];
    [param setObject:SafeStr([ZUserHelper sharedHelper].stores.teacher_id) forKey:@"teacher_id"];
    
    [ZOriganizationClassViewModel getTeacherClassList:param completeBlock:^(BOOL isSuccess, ZOriganizationClassListNetModel *data) {
        if (isSuccess && data) {
            weakSelf.classArr = @[].mutableCopy;
            [weakSelf.classArr removeAllObjects];
            [weakSelf.classArr addObjectsFromArray:data.list];
            complete();
        }
    }];
}
@end


#pragma mark - RouteHandler
@interface ZTeacherClassReportFormVC (RouteHandler)<SJRouteHandler>

@end

@implementation ZTeacherClassReportFormVC (RouteHandler)

+ (NSString *)routePath {
    return ZRoute_mine_classReportForm;
}

+ (void)handleRequest:(SJRouteRequest *)request topViewController:(UIViewController *)topViewController completionHandler:(SJCompletionHandler)completionHandler {
    ZTeacherClassReportFormVC *routevc = [[ZTeacherClassReportFormVC alloc] init];
//    if (request.prts) {
//        routevc.model = request.prts;
//    }
    [topViewController.navigationController pushViewController:routevc animated:YES];
}
@end
