//
//  ZStudentMineSignDetailVC.m
//  NoWait
//
//  Created by zhuang zhang on 2020/1/15.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZStudentMineSignDetailVC.h"
#import "ZAlertQRCodeView.h"
#import "ZStudentMineSignDetailHandleCell.h"
#import "ZSignViewModel.h"
#import "ZSignModel.h"
#import "ZOriganizationClassViewModel.h"
#import "ZAlertView.h"

@interface ZStudentMineSignDetailVC ()
@property (nonatomic,strong) ZSignInfoModel *detailModel;

@end
@implementation ZStudentMineSignDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setTableViewRefreshHeader];
    [self initCellConfigArr];
    [self refreshData];
}

- (void)initCellConfigArr {
    [super initCellConfigArr];
    
    {
        ZBaseSingleCellModel *model = [[ZBaseSingleCellModel alloc] init];
        model.leftTitle = @"上课进度";
        model.rightTitle = [NSString stringWithFormat:@"%d/%@节",[self.detailModel.now_progress intValue] + [self.detailModel.replenish_nums intValue],SafeStr(self.detailModel.total_progress)];
        model.isHiddenLine = NO;
        model.lineLeftMargin = CGFloatIn750(30);
        model.lineRightMargin = CGFloatIn750(30);
        model.cellHeight = CGFloatIn750(110);
        model.leftFont = [UIFont boldFontTitle];
        
        ZCellConfig *menuCellConfig = [ZCellConfig cellConfigWithClassName:[ZSingleLineCell className] title:model.cellTitle showInfoMethod:@selector(setModel:) heightOfCell:[ZSingleLineCell z_getCellHeight:model] cellType:ZCellTypeClass dataModel:model];
        
        [self.cellConfigArr addObject:menuCellConfig];
    }
    {
        ZCellConfig *topCellConfig = [ZCellConfig cellConfigWithClassName:[ZSpaceEmptyCell className] title:@"top" showInfoMethod:@selector(setBackColor:) heightOfCell:CGFloatIn750(10)cellType:ZCellTypeClass dataModel:adaptAndDarkColor([UIColor colorWhite], [UIColor colorBlackBGDark])];
        
        [self.cellConfigArr addObject:topCellConfig];
        
        NSArray *tempArr = @[@[@"已签课", [NSString stringWithFormat:@"%d节",[self.detailModel.now_progress intValue]]],
                             @[@"补签", [NSString stringWithFormat:@"%@节", self.detailModel.replenish_nums]]
                             ,@[@"请假", [NSString stringWithFormat:@"%@节", self.detailModel.vacate_nums]],
                             @[@"旷课", [NSString stringWithFormat:@"%@节", self.detailModel.truancy_nums]],
                             @[@"待签课", [NSString stringWithFormat:@"%@节", self.detailModel.wait_progress]]];
        for (int i = 0; i < tempArr.count; i++) {
            ZBaseSingleCellModel *model = [[ZBaseSingleCellModel alloc] init];
            model.leftTitle = tempArr[i][0];
            model.rightTitle = tempArr[i][1];
            model.leftMargin = CGFloatIn750(30);
            model.isHiddenLine = YES;
            model.cellHeight = CGFloatIn750(66);
            model.leftFont = [UIFont fontContent];
            
            ZCellConfig *menuCellConfig = [ZCellConfig cellConfigWithClassName:[ZSingleLineCell className] title:model.cellTitle showInfoMethod:@selector(setModel:) heightOfCell:[ZSingleLineCell z_getCellHeight:model] cellType:ZCellTypeClass dataModel:model];
            
            [self.cellConfigArr addObject:menuCellConfig];
        }
        
        ZCellConfig *bottomCellConfig = [ZCellConfig cellConfigWithClassName:[ZSpaceEmptyCell className] title:@"top" showInfoMethod:@selector(setBackColor:) heightOfCell:CGFloatIn750(20) cellType:ZCellTypeClass dataModel:adaptAndDarkColor([UIColor colorWhite], [UIColor colorBlackBGDark])];
        [self.cellConfigArr addObject:bottomCellConfig];
    }
    
    ZCellConfig *spaceCellConfig = [ZCellConfig cellConfigWithClassName:[ZSpaceEmptyCell className] title:@"top" showInfoMethod:@selector(setBackColor:) heightOfCell:CGFloatIn750(30) cellType:ZCellTypeClass dataModel:adaptAndDarkColor([UIColor colorGrayBG], [UIColor colorGrayBGDark])];
    
    [self.cellConfigArr addObject:spaceCellConfig];
    
    
    {
       ZBaseSingleCellModel *model = [[ZBaseSingleCellModel alloc] init];
       model.leftTitle = self.detailModel.courses_name;
       model.isHiddenLine = NO;
       model.lineLeftMargin = CGFloatIn750(30);
       model.lineRightMargin = CGFloatIn750(30);
       model.cellHeight = CGFloatIn750(110);
       model.leftFont = [UIFont boldFontContent];
       
       ZCellConfig *menuCellConfig = [ZCellConfig cellConfigWithClassName:[ZSingleLineCell className] title:model.cellTitle showInfoMethod:@selector(setModel:) heightOfCell:[ZSingleLineCell z_getCellHeight:model] cellType:ZCellTypeClass dataModel:model];
       
       [self.cellConfigArr addObject:menuCellConfig];
   }
   {
       [self.cellConfigArr addObject:getEmptyCellWithHeight(CGFloatIn750(10))];
       
       for (int i = 0; i < self.detailModel.list.count; i++) {
           ZCellConfig *menuCellConfig = [ZCellConfig cellConfigWithClassName:[ZStudentMineSignDetailHandleCell className] title:@"ZStudentMineSignDetailHandleCell" showInfoMethod:@selector(setModel:) heightOfCell:CGFloatIn750(76) cellType:ZCellTypeClass dataModel:self.detailModel.list[i]];
           
           [self.cellConfigArr addObject:menuCellConfig];
       }
       
       [self.cellConfigArr addObject:getEmptyCellWithHeight(CGFloatIn750(20))];
   }
}


- (void)setNavigation {
    self.isHidenNaviBar = NO;
    [self.navigationItem setTitle:@"签课详情"];
}

- (void)setupMainView {
    [super setupMainView];
    [self.iTableView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.bottom.equalTo(self.view.mas_bottom);
        make.top.equalTo(self.view.mas_top).offset(10);
    }];
}

#pragma mark tableView -------datasource-----
- (void)zz_tableView:(UITableView *)tableView cell:(UITableViewCell *)cell cellForRowAtIndexPath:(NSIndexPath *)indexPath cellConfig:(ZCellConfig *)cellConfig {
    if ([cellConfig.title isEqualToString:@"ZStudentMineSignDetailHandleCell"]){
        ZStudentMineSignDetailHandleCell *scell = (ZStudentMineSignDetailHandleCell *)cell;
        scell.can_operation = self.detailModel.can_operation;
        scell.handleBlock = ^(ZSignInfoListModel *model ,NSInteger signType) {
            if ([[ZUserHelper sharedHelper].user.type intValue] == 2) {
                [self teacherSign:model signType:signType];
            }else if ([[ZUserHelper sharedHelper].user.type intValue] == 1){
                [self getSignQrcode:@{@"courses_class_id":self.courses_class_id}];
            }
        };
    }
}


#pragma mark - handele data
- (void)getSignQrcode:(NSDictionary *)param {
    __weak typeof(self) weakSelf = self;
    [ZOriganizationClassViewModel getSignQrcode:param completeBlock:^(BOOL isSuccess, id data) {
        weakSelf.loading = NO;
        if (isSuccess && data) {
            ZOriganizationStudentCodeAddModel *model = data;
            [ZAlertQRCodeView setAlertWithTitle:@"请教师扫码完成签课" qrCode:model.url handlerBlock:^(NSInteger index) {
                
            }];
           
        }else{
            [TLUIUtility showErrorHint:data];
        }
    }];
}

- (void)refreshData {
    __weak typeof(self) weakSelf = self;
    self.loading = YES;
    NSMutableDictionary *params = @{}.mutableCopy;
    if (ValidStr(self.courses_class_id)) {
        [params setObject:SafeStr(self.courses_class_id) forKey:@"courses_class_id"];
    }
    if (ValidStr(self.student_id)) {
        [params setObject:SafeStr(self.student_id) forKey:@"student_id"];
    }
    [ZSignViewModel getSignDetail:params completeBlock:^(BOOL isSuccess, ZSignInfoModel *addModel) {
        weakSelf.loading = NO;
        if (isSuccess) {
            weakSelf.detailModel = addModel;
            [weakSelf initCellConfigArr];
            [weakSelf.iTableView reloadData];
        }
        [weakSelf.iTableView tt_endRefreshing];
    }];
}

- (void)teacherSign:(ZSignInfoListModel *)model signType:(NSInteger )index{
    NSMutableDictionary *param = @{}.mutableCopy;
    [param setObject:self.courses_class_id forKey:@"courses_class_id"];
    if (index == 0) {
        [param setObject:@"2" forKey:@"type"];
    }else{
        [param setObject:@"3" forKey:@"type"];
    }
    [param setObject:@[@{@"student_id":SafeStr(self.student_id),@"nums":model.nums}] forKey:@"students"];
    
    NSString *notice = @"";
    if ([param objectForKey:@"type"]) {
        if ([param[@"type"] isEqualToString:@"2"]) {
            notice = [NSString stringWithFormat:@"确定为这位学员签课吗？"];
        }else if ([param[@"type"] isEqualToString:@"3"]) {
            notice = [NSString stringWithFormat:@"确定为这位学员补签吗？"];
        }
    }
    [ZAlertView setAlertWithTitle:@"提示" subTitle:notice leftBtnTitle:@"取消" rightBtnTitle:@"确定" handlerBlock:^(NSInteger index) {
        if (index == 1) {
            [ZSignViewModel teacherSign:param completeBlock:^(BOOL isSuccess, id data) {
                if (isSuccess) {
                    [TLUIUtility showSuccessHint:data];
                    [self refreshData];
                }else{
                    [TLUIUtility showErrorHint:data];
                }
            }];
        }
    }];
}

@end

#pragma mark - RouteHandler
@interface ZStudentMineSignDetailVC (RouteHandler)<SJRouteHandler>

@end

@implementation ZStudentMineSignDetailVC (RouteHandler)

+ (NSString *)routePath {
    return ZRoute_mine_signDetail;
}

+ (void)handleRequest:(SJRouteRequest *)request topViewController:(UIViewController *)topViewController completionHandler:(SJCompletionHandler)completionHandler {
    ZStudentMineSignDetailVC *routevc = [[ZStudentMineSignDetailVC alloc] init];
    if (request.prts && [request.prts isKindOfClass:[NSDictionary class]]) {
        NSDictionary *tempDict = request.prts;
        if ([tempDict objectForKey:@"courses_class_id"]) {
            routevc.courses_class_id = tempDict[@"courses_class_id"];
        }
        if ([tempDict objectForKey:@"student_id"]) {
            routevc.student_id = tempDict[@"student_id"];
        }
    }
    
    [topViewController.navigationController pushViewController:routevc animated:YES];
}
@end
