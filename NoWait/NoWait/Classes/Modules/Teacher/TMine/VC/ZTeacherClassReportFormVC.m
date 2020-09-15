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

@interface ZTeacherClassReportFormVC ()
@property (nonatomic,strong) ZTeacherClassReportFormTopView *formTopView;
@property (nonatomic,strong) ZTeacherClassReportFormSectionView *sectionView;
@property (nonatomic,strong) ZTeacherClassReportFormDayView *dayView;

@end

@implementation ZTeacherClassReportFormVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    __weak typeof(self) weakSelf = self;
    self.zChain_setNavTitle(@"班级报表")
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
}

#pragma mark - lazy loading
- (ZTeacherClassReportFormTopView *)formTopView {
    if (!_formTopView) {
        _formTopView = [[ZTeacherClassReportFormTopView alloc] init];
        _formTopView.moreBlock = ^(NSInteger index) {
            
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
                    //                    weakSelf.viewModel.addModel.limit_start = [NSString stringWithFormat:@"%ld",(long)[[NSDate dateFromComponents:begin] timeIntervalSince1970]];
                    //                    weakSelf.viewModel.addModel.limit_end = [NSString stringWithFormat:@"%ld",(long)[[NSDate dateFromComponents:end] timeIntervalSince1970]];
                    //
                    //                    [weakSelf initCellConfigArr];
                    //                    [weakSelf.iTableView reloadData];
                                    }];
                }else{
                    [ZAlertBeginAndEndTimeView setAlertName:@"选择开始日期" subName:@"选择结束时间"  pickerMode:BRDatePickerModeYM handlerBlock:^(NSDate *begin, NSDate *end) {
                    //                    weakSelf.viewModel.addModel.limit_start = [NSString stringWithFormat:@"%ld",(long)[[NSDate dateFromComponents:begin] timeIntervalSince1970]];
                    //                    weakSelf.viewModel.addModel.limit_end = [NSString stringWithFormat:@"%ld",(long)[[NSDate dateFromComponents:end] timeIntervalSince1970]];
                    //
                    //                    [weakSelf initCellConfigArr];
                    //                    [weakSelf.iTableView reloadData];
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
