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

#import "ZAlertClassCheckBoxView.h"

#import "ZOriganizationClassViewModel.h"

@interface ZTeacherClassReportFormVC ()
@property (nonatomic,strong) ZTeacherClassReportFormTopView *formTopView;
@property (nonatomic,strong) ZTeacherClassReportFormSectionView *sectionView;
@property (nonatomic,strong) ZTeacherClassReportFormDayView *dayView;
@property (nonatomic,strong) ZTeacherClassFormFilterView *filterView;

@property (nonatomic,strong) NSMutableArray *classArr;
@property (nonatomic,strong) ZOriganizationClassListModel *classModel;

@property (nonatomic,assign) NSInteger type;
@property (nonatomic,strong) NSString *beginDate;
@property (nonatomic,strong) NSString *endDate;
@property (nonatomic,strong) NSString *beginMouthDate;
@property (nonatomic,strong) NSString *endMouthDate;
@end

@implementation ZTeacherClassReportFormVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    __weak typeof(self) weakSelf = self;
    
    self.zChain_setNavTitle(@"班级报表")
    .zChain_setTableViewGary()
    .zChain_addRefreshHeader()
    .zChain_addLoadMoreFooter()
    .zChain_addEmptyDataDelegate()
    .zChain_updateDataSource(^{
        self.type = 0;
        
    }).zChain_resetMainView(^{
        self.view.backgroundColor = adaptAndDarkColor([UIColor colorGrayBG], [UIColor colorGrayBGDark]);
        
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
            make.height.mas_equalTo(CGFloatIn750(0));
        }];
        
        [self.iTableView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.bottom.right.equalTo(self.view);
            make.top.equalTo(self.dayView.mas_bottom);
        }];
    }).zChain_block_setUpdateCellConfigData(^(void (^update)(NSMutableArray *)) {
        [weakSelf.cellConfigArr removeAllObjects];
 
        DLog(@"---begin %@ --end%@",weakSelf.beginDate,weakSelf.endDate);
        
        for (int i = 0; i < weakSelf.dataSources.count; i++) {
            [weakSelf.cellConfigArr addObject:getGrayEmptyCellWithHeight(CGFloatIn750(20))];
            ZCellConfig *cellConfig = [ZCellConfig cellConfigWithClassName:[ZTeacherClassReportFormCell className] title:[ZTeacherClassReportFormCell className] showInfoMethod:@selector(setModel:) heightOfCell:[ZTeacherClassReportFormCell z_getCellHeight:nil] cellType:ZCellTypeClass dataModel:weakSelf.dataSources[i]];
            
            [weakSelf.cellConfigArr addObject:cellConfig];
            
        }
    });

    [self getClassData:^{
        if (ValidArray(weakSelf.classArr)) {
            weakSelf.classModel = weakSelf.classArr[0];
            weakSelf.formTopView.title = weakSelf.classModel.name;
            weakSelf.zChain_reload_Net();
        }
    }];
    
    [self setDayShow];
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
//            [ZAlertClassCheckBoxView setAlertName:@"选择班级" dataSources:weakSelf.classArr handlerBlock:^(NSInteger index, id model) {
//                weakSelf.classModel = model;
//                weakSelf.formTopView.title = weakSelf.classModel.name;
//                [weakSelf resetFilter];
//                weakSelf.zChain_reload_Net();
//            }];
        };
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
                    [ZAlertBeginAndEndTimeView setAlertName:@"选择开始日期" subName:@"选择结束时间" pickerMode:BRDatePickerModeYMD handlerBlock:^(NSDate *begin, NSDate *end) {
                        if (![weakSelf checkDate:begin end:end]) {
                            [TLUIUtility showInfoHint:@"开始时期不能大于结束日期"];
                            return;
                        }
                        
                        weakSelf.beginDate = [NSString stringWithFormat:@"%.0f",[[weakSelf getBeginDate:begin] timeIntervalSince1970]];
                        weakSelf.endDate = [NSString stringWithFormat:@"%.0f",[[weakSelf getEndDate:end] timeIntervalSince1970]];
                        
                        [weakSelf setDayShow];
                        
                        [weakSelf updateDayView];
                        weakSelf.zChain_reload_Net();
                    }];
                }else{
                    [ZAlertBeginAndEndTimeView setAlertName:@"选择开始日期" subName:@"选择结束时间" pickerMode:BRDatePickerModeYM handlerBlock:^(NSDate *begin, NSDate *end) {
                        if (![weakSelf checkDate:begin end:end]) {
                            [TLUIUtility showInfoHint:@"开始时期不能大于结束日期"];
                            return;
                        }
                        
                        weakSelf.beginMouthDate = [NSString stringWithFormat:@"%.0f",[begin timeIntervalSince1970]];
                        weakSelf.endMouthDate = [NSString stringWithFormat:@"%.0f",[end timeIntervalSince1970]];
                        [weakSelf setDayShow];
                        
                        [weakSelf updateDayView];
                        weakSelf.zChain_reload_Net();
                    }];
                }
            }else{
                [TLUIUtility showLoading:@""];
                weakSelf.type = index;
                [weakSelf setDayShow];
                [weakSelf updateDayView];
                weakSelf.zChain_reload_Net();
            }
        };
    }
    return _sectionView;
}

- (ZTeacherClassReportFormDayView *)dayView {
    if (!_dayView) {
        __weak typeof(self) weakSelf = self;
        _dayView = [[ZTeacherClassReportFormDayView alloc] init];
        _dayView.handleBlock = ^(NSInteger index) {
            if (weakSelf.type == 0) {
                weakSelf.beginDate = nil;
                weakSelf.endDate = nil;
            }else{
                weakSelf.beginMouthDate = nil;
                weakSelf.endMouthDate = nil;
            }
            [weakSelf updateDayView];
            weakSelf.zChain_reload_Net();
        };
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
            [weakSelf resetFilter];
            weakSelf.zChain_reload_Net();
        };
        
    }
    return _filterView;
}

#pragma mark - data handle
- (void)resetFilter {
//    _type = 0;
    [_sectionView setType:_type];
    
//    _beginDate = nil;
//    _endDate = nil;
//    _beginMouthDate = nil;
//    _endMouthDate = nil;
    
    [self updateDayView];
}

- (void)updateDayView {
    if (self.type == 0) {
        if (self.beginDate) {
            [self.dayView mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.left.right.equalTo(self.view);
                make.top.equalTo(self.sectionView.mas_bottom);
                make.height.mas_equalTo(CGFloatIn750(70));
            }];
        }else{
            [self.dayView mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.left.right.equalTo(self.view);
                make.top.equalTo(self.sectionView.mas_bottom);
                make.height.mas_equalTo(CGFloatIn750(0));
            }];
        }
    }else{
        if (self.beginMouthDate) {
            [self.dayView mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.left.right.equalTo(self.view);
                make.top.equalTo(self.sectionView.mas_bottom);
                make.height.mas_equalTo(CGFloatIn750(70));
            }];
        }else{
            [self.dayView mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.left.right.equalTo(self.view);
                make.top.equalTo(self.sectionView.mas_bottom);
                make.height.mas_equalTo(CGFloatIn750(0));
            }];
        }
    }
    
}

- (BOOL)checkDate:(NSDate *)begin  end:(NSDate *)end {
    if ([begin timeIntervalSince1970] > [end timeIntervalSince1970]) {
        return NO;
    }
    return YES;
}

- (void)setDayShow {
    if (self.type == 0) {
        [self.dayView setTime:[NSString stringWithFormat:@"%@ 至 %@",[self.beginDate timeStringWithFormatter:@"YYYY年MM月dd日"],[self.endDate timeStringWithFormatter:@"YYYY年MM月dd日"]]];
    }else{
        [self.dayView setTime:[NSString stringWithFormat:@"%@ 至 %@",[self.beginMouthDate timeStringWithFormatter:@"YYYY年MM月"],[self.endMouthDate timeStringWithFormatter:@"YYYY年MM月"]]];
    }
}


- (NSDate *)getBeginDate:(NSDate *)tdate {
    NSDate *date = tdate;
    
    NSTimeZone *gmt = [NSTimeZone timeZoneWithAbbreviation:@"GMT"];

    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier: NSCalendarIdentifierGregorian];

    [calendar setTimeZone:gmt];

    NSDateComponents *components = [calendar components:NSUIntegerMax fromDate:date];

//    components.day-=1;

    [components setHour:0];

    [components setMinute:0];

    [components setSecond: 0];

    NSDate *startDate = [calendar dateFromComponents:components];

    return [[NSDate alloc] initWithTimeIntervalSince1970:[startDate timeIntervalSince1970]-8*60*60];;
}


- (NSDate *)getEndDate:(NSDate *)date {
    NSTimeZone *gmt = [NSTimeZone timeZoneWithAbbreviation:@"GMT"];

    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier: NSCalendarIdentifierGregorian];

    [calendar setTimeZone:gmt];

    NSDateComponents *components = [calendar components:NSUIntegerMax fromDate:date];

//    components.day-=1;

    [components setHour:0];

    [components setMinute:0];

    [components setSecond: 0];

    NSDate *startDate = [calendar dateFromComponents:components];
    NSDate *endDate = [calendar dateByAddingUnit:NSCalendarUnitDay value:1 toDate:startDate options:0];
    
    return [[NSDate alloc] initWithTimeIntervalSince1970:[endDate timeIntervalSince1970]-8*60*60-2];
}

- (NSString *)getMonthFirstDayWith:(NSString *)dateStr{
    
    NSDateFormatter *format=[[NSDateFormatter alloc] init];
    [format setDateFormat:@"yyyy-MM-dd"];
    NSDate *newDate=[format dateFromString:dateStr];
    double interval = 0;
    NSDate *firstDate = nil;
    NSDate *lastDate = nil;
    NSCalendar *calendar = [NSCalendar currentCalendar];

    BOOL OK = [calendar rangeOfUnit:NSCalendarUnitMonth startDate:& firstDate interval:&interval forDate:newDate];
    
    if (OK) {
        lastDate = [firstDate dateByAddingTimeInterval:interval - 1];
    }else {
        return @"";
    }

    NSDateFormatter *myDateFormatter = [[NSDateFormatter alloc] init];
    [myDateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *firstString = [myDateFormatter stringFromDate: firstDate];
    return firstString;
}


- (NSString *)getMonthLastDayWith:(NSString *)dateStr{
    NSDateFormatter *format=[[NSDateFormatter alloc] init];
    [format setDateFormat:@"yyyy-MM-dd"];
    NSDate *newDate=[format dateFromString:dateStr];
    double interval = 0;
    NSDate *firstDate = nil;
    NSDate *lastDate = nil;
    NSCalendar *calendar = [NSCalendar currentCalendar];

    BOOL OK = [calendar rangeOfUnit:NSCalendarUnitMonth startDate:& firstDate interval:&interval forDate:newDate];
    
    if (OK) {
        lastDate = [firstDate dateByAddingTimeInterval:interval - 1];
    }else {
        return @"";
    }

    NSDateFormatter *myDateFormatter = [[NSDateFormatter alloc] init];
    [myDateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *lastString = [myDateFormatter stringFromDate: lastDate];
    return lastString;
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

- (void)refreshData {
    self.currentPage = 1;
    self.loading = YES;
    [self refreshHeadData:[self setPostCommonData]];
}

- (void)refreshHeadData:(NSDictionary *)param {
    __weak typeof(self) weakSelf = self;
    [ZOriganizationClassViewModel getMyClassSignReportList:param completeBlock:^(BOOL isSuccess, ZOriganizationReportListNetModel *data) {
        weakSelf.loading = NO;
        [TLUIUtility hiddenLoading];
        if (isSuccess && data) {
            [weakSelf.dataSources removeAllObjects];
            [weakSelf.dataSources addObjectsFromArray:data.list];
            
            if (weakSelf) {
                    weakSelf.zChain_reload_ui();
                }
            
            [weakSelf.iTableView tt_endRefreshing];
            if (data && [data.total integerValue] <= weakSelf.currentPage * 10) {
                [weakSelf.iTableView tt_removeLoadMoreFooter];
            }else{
                [weakSelf.iTableView tt_endLoadMore];
            }
        }else{
            [weakSelf.iTableView reloadData];
            [weakSelf.iTableView tt_endRefreshing];
            [weakSelf.iTableView tt_removeLoadMoreFooter];
        }
    }];
}

- (void)refreshMoreData {
    self.currentPage++;
    self.loading = YES;
    NSMutableDictionary *param = [self setPostCommonData];
    
    __weak typeof(self) weakSelf = self;
     [ZOriganizationClassViewModel getMyClassSignReportList:param completeBlock:^(BOOL isSuccess, ZOriganizationReportListNetModel *data) {
        weakSelf.loading = NO;
         [TLUIUtility hiddenLoading];
        if (isSuccess && data) {
            [weakSelf.dataSources addObjectsFromArray:data.list];
            
            if (weakSelf) {
                    weakSelf.zChain_reload_ui();
                }
            
            [weakSelf.iTableView tt_endRefreshing];
            if (data && [data.total integerValue] <= weakSelf.currentPage * 10) {
                [weakSelf.iTableView tt_removeLoadMoreFooter];
            }else{
                [weakSelf.iTableView tt_endLoadMore];
            }
        }else{
            [weakSelf.iTableView reloadData];
            [weakSelf.iTableView tt_endRefreshing];
            [weakSelf.iTableView tt_removeLoadMoreFooter];
        }
    }];
}

- (NSMutableDictionary *)setPostCommonData {
    NSMutableDictionary *param = @{@"page":[NSString stringWithFormat:@"%ld",self.currentPage]}.mutableCopy;
    [param setObject:[NSString stringWithFormat:@"%d",10] forKey:@"page_size"];
    if (self.classModel) {
        [param setObject:SafeStr(self.classModel.classID) forKey:@"class_id"];
    }
    if (self.type != 0) {
        [param setObject:@"2" forKey:@"date_type"];
    }else{
        [param setObject:@"1" forKey:@"date_type"];
    }
    
    if (self.type != 0) {
        if (self.beginMouthDate && self.endMouthDate) {
            [param setObject:self.beginMouthDate forKey:@"start_date"];
            [param setObject:self.endMouthDate forKey:@"end_date"];
        }else{
            [param removeObjectForKey:@"start_date"];
            [param removeObjectForKey:@"end_date"];
        }
    }else{
        if (self.beginDate && self.endDate) {
            [param setObject:self.beginDate forKey:@"start_date"];
            [param setObject:self.endDate forKey:@"end_date"];
        }else{
            [param removeObjectForKey:@"start_date"];
            [param removeObjectForKey:@"end_date"];
        }
    }
    
    return param;
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
