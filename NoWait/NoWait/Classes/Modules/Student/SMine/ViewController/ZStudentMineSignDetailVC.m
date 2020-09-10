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
@property (nonatomic,strong) UIButton *bottomBtn;
@property (nonatomic,strong) NSString *note_id;
@property (nonatomic,strong) NSTimer *nsTime;

@end
@implementation ZStudentMineSignDetailVC

- (void)dealloc {
    
    [self stopTimer];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self stopTimer];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setTableViewRefreshHeader];
    [self initCellConfigArr];
    [self refreshData];
}

- (void)initCellConfigArr {
    [super initCellConfigArr];
    
    if (ValidStr(self.note_id)) {
        for (ZSignInfoListModel *model in self.detailModel.list) {
            model.isNote = YES;
        }
    }
    
    if (self.detailModel.class_type && [self.detailModel.class_type intValue] == 2 &&([self.detailModel.now_progress intValue] + [self.detailModel.replenish_nums intValue] < [self.detailModel.total_progress intValue] && [[ZUserHelper sharedHelper].user.type intValue] == 2)) {
        [self.bottomBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self.view);
            make.bottom.equalTo(self.view.mas_bottom).offset(-safeAreaBottom());
            make.height.mas_equalTo(CGFloatIn750(80));
        }];
    }else{
        [self.bottomBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self.view);
            make.top.equalTo(self.view.mas_bottom);
            make.height.mas_equalTo(CGFloatIn750(80));
        }];
    }
    
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
        
        NSMutableArray *tempArr = @[@[@"已签课", [NSString stringWithFormat:@"%d节",[self.detailModel.now_progress intValue]]],
                             @[@"补签", [NSString stringWithFormat:@"%@节", SafeStr(self.detailModel.replenish_nums)]]].mutableCopy;
        if (!(self.detailModel.class_type && [self.detailModel.class_type intValue] == 2)) {
            [tempArr addObjectsFromArray:@[@[@"请假", [NSString stringWithFormat:@"%@节", SafeStr(self.detailModel.vacate_nums)]],
                                           @[@"旷课", [NSString stringWithFormat:@"%@节", SafeStr(self.detailModel.truancy_nums)]]]];
        }
        [tempArr addObject:@[@"待签课", [NSString stringWithFormat:@"%@节", SafeStr(self.detailModel.wait_progress)]]];
        
        if (ValidStr(self.note_id)) {
            tempArr = @[@[@"已签课", [NSString stringWithFormat:@"%d节",[self.detailModel.now_progress intValue]]],
            @[@"待签课", [NSString stringWithFormat:@"%@节", SafeStr(self.detailModel.wait_progress)]]].mutableCopy;
        }
        
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
        ZLineCellModel *sModel = ZLineCellModel.zz_lineCellModel_create(@"stuentTitle")
        .zz_titleLeft(self.detailModel.courses_name)
        .zz_fontLeft([UIFont boldFontContent])
        .zz_cellHeight(CGFloatIn750(90))
        .zz_lineHidden(YES)
        .zz_leftMultiLine(YES);
        
        ZCellConfig *titleCellConfig = [ZCellConfig cellConfigWithClassName:[ZBaseLineCell className] title:@"title" showInfoMethod:@selector(setModel:) heightOfCell:[ZBaseLineCell z_getCellHeight:sModel] cellType:ZCellTypeClass dataModel:sModel];
        
        [self.cellConfigArr addObject:titleCellConfig];
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
    [self.view addSubview:self.bottomBtn];
    [self.bottomBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.view.mas_bottom);
        make.height.mas_equalTo(CGFloatIn750(80));
    }];
    [self.iTableView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.bottom.equalTo(self.bottomBtn.mas_top);
        make.top.equalTo(self.view.mas_top).offset(10);
    }];
    
}

- (void)startTime:(NSString *)nums {
    _nsTime = [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(updateTime:) userInfo:nums repeats:YES];
}

-(void)updateTime:(NSTimer*) timer{
//    NSLog(@"参数为：%@",timer.userInfo);
    __weak typeof(self) weakSelf = self;
    [ZSignViewModel checkSign:@{@"nums":SafeStr(timer.userInfo),@"courses_class_id":SafeStr(self.courses_class_id),@"student_id":SafeStr(self.student_id)} completeBlock:^(BOOL isSuccess, ZSignInfoModel *addModel) {
        weakSelf.loading = NO;
        if (isSuccess) {
            [weakSelf refreshData];
            [weakSelf stopTimer];
            [[ZAlertQRCodeView sharedManager] removeFromSuperview];
            [ZAlertView setAlertWithTitle:@"教师已扫码签课" btnTitle:@"知道了" handlerBlock:^(NSInteger index) {
                [weakSelf stopTimer];
            }];
        }
        [weakSelf.iTableView tt_endRefreshing];
    }];
}

// 停止定时器
-(void)stopTimer{
    if (_nsTime) {
        [_nsTime invalidate];
    }
}

#pragma mark - lazy loading...
- (UIButton *)bottomBtn {
    if (!_bottomBtn) {
        __weak typeof(self) weakSelf = self;
        _bottomBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, CGFloatIn750(118), CGFloatIn750(50))];
        [_bottomBtn setTitle:@"补课" forState:UIControlStateNormal];

        [_bottomBtn setTitleColor:adaptAndDarkColor([UIColor colorWhite], [UIColor colorWhite]) forState:UIControlStateNormal];
        [_bottomBtn.titleLabel setFont:[UIFont fontContent]];
        [_bottomBtn setBackgroundColor:adaptAndDarkColor([UIColor colorMain], [UIColor colorMainDark]) forState:UIControlStateNormal];
        
        [_bottomBtn bk_addEventHandler:^(id sender) {
           [ZAlertView setAlertWithTitle:@"小提示" subTitle:[NSString stringWithFormat:@"如果当前正在上课,将会签课如果当前没在上课,将会补签"] leftBtnTitle:@"取消" rightBtnTitle:@"确定补签" handlerBlock:^(NSInteger index) {
               if (index == 1) {
                   [weakSelf teacherSign];
               }
           }];
        } forControlEvents:UIControlEventTouchUpInside];
    }
    return _bottomBtn;
}

#pragma mark tableView -------datasource-----
- (void)zz_tableView:(UITableView *)tableView cell:(UITableViewCell *)cell cellForRowAtIndexPath:(NSIndexPath *)indexPath cellConfig:(ZCellConfig *)cellConfig {
    if ([cellConfig.title isEqualToString:@"ZStudentMineSignDetailHandleCell"]){
        ZStudentMineSignDetailHandleCell *scell = (ZStudentMineSignDetailHandleCell *)cell;
        if (!ValidStr(self.note_id)) {
            scell.can_operation = self.detailModel.can_operation;
        }
        
        scell.handleBlock = ^(ZSignInfoListModel *model ,NSInteger signType) {
            if ([[ZUserHelper sharedHelper].user.type intValue] == 2) {
                [self teacherSign:model signType:signType];
            }else if ([[ZUserHelper sharedHelper].user.type intValue] == 1){
                if (ValidStr(self.note_id)) {
                    [self noteSign:model];
                }else{
                    [self getSignQrcode:@{@"courses_class_id":self.courses_class_id,@"student_id":SafeStr(self.student_id)} num:model.nums];
                }
            }
        };
    }
}


#pragma mark - handele data
- (void)getSignQrcode:(NSDictionary *)param num:(NSString *)num{
    __weak typeof(self) weakSelf = self;
    [ZOriganizationClassViewModel getSignQrcode:param completeBlock:^(BOOL isSuccess, id data) {
        weakSelf.loading = NO;
        if (isSuccess && data) {
            ZOriganizationStudentCodeAddModel *model = data;
            [weakSelf startTime:num];
            [ZAlertQRCodeView setAlertWithTitle:@"请教师扫码完成签课" qrCode:model.url handlerBlock:^(NSInteger index) {
                [weakSelf stopTimer];
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
    if (ValidStr(self.note_id)) {
        if (ValidStr(self.courses_class_id)) {
            [params setObject:SafeStr(self.note_id) forKey:@"note_id"];
        }
        [ZSignViewModel getNoteSignDetail:params completeBlock:^(BOOL isSuccess, ZSignInfoModel *addModel) {
            weakSelf.loading = NO;
            if (isSuccess) {
                weakSelf.detailModel = addModel;
                [weakSelf initCellConfigArr];
                [weakSelf.iTableView reloadData];
            }
            [weakSelf.iTableView tt_endRefreshing];
        }];
        return;
    }
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


- (void)noteSign:(ZSignInfoListModel *)model {
    NSMutableDictionary *param = @{}.mutableCopy;
    
    [param setObject:SafeStr(self.note_id) forKey:@"note_id"];
    [param setObject:model.nums forKey:@"nums"];
    

    [ZAlertView setAlertWithTitle:@"提示" subTitle:@"确定签课吗？" leftBtnTitle:@"取消" rightBtnTitle:@"确定" handlerBlock:^(NSInteger index) {
        if (index == 1) {
            [ZSignViewModel noteSign:param completeBlock:^(BOOL isSuccess, id data) {
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


- (void)teacherSign{
    NSMutableDictionary *param = @{}.mutableCopy;
    [param setObject:self.courses_class_id forKey:@"courses_class_id"];
    [param setObject:SafeStr(self.student_id) forKey:@"student"];
    [ZSignViewModel teacherBuSign:param completeBlock:^(BOOL isSuccess, id data) {
        if (isSuccess) {
            [TLUIUtility showSuccessHint:data];
            [self refreshData];
        }else{
            [TLUIUtility showErrorHint:data];
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
        if ([tempDict objectForKey:@"note_id"]) {
            routevc.note_id = tempDict[@"note_id"];
        }
        
    }
    
    [topViewController.navigationController pushViewController:routevc animated:YES];
}
@end
