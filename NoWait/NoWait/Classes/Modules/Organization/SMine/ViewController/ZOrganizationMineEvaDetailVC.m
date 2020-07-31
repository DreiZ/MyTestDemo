//
//  ZOrganizationMineEvaDetailVC.m
//  NoWait
//
//  Created by zhuang zhang on 2020/3/20.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZOrganizationMineEvaDetailVC.h"
#import "ZOrganizationEvaListLessonCell.h"
#import "ZOrganizationEvaDetailTitleCell.h"
#import "ZOrganizationEvaListEvaTextViewCell.h"
#import "ZOrganizationEvaListEvaBtnCell.h"
#import "ZOrganizationEvaListReEvaCell.h"

#import "ZOrganizationEvaListCell.h"
#import "ZOriganizationOrderViewModel.h"

@interface ZOrganizationMineEvaDetailVC ()
@property (nonatomic,strong) ZOrderEvaDetailModel *detailModel;
@property (nonatomic,strong) NSString *stores_reply_text;
@property (nonatomic,strong) NSString *course_reply_text;
@property (nonatomic,strong) NSString *teacher_reply_text;

@end
@implementation ZOrganizationMineEvaDetailVC

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self refreshData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    [self setTableViewGaryBack];
    [self initCellConfigArr];
    UIView *tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, CGFloatIn750(220))];
    tableFooterView.backgroundColor = adaptAndDarkColor([UIColor colorWhite], [UIColor colorBlackBGDark]);
    
    self.iTableView.tableFooterView = tableFooterView;
}

- (void)initCellConfigArr {
    [super initCellConfigArr];
    if (!self.detailModel) {
        return;
    }
    _stores_reply_text = self.detailModel.stores_reply_desc;
    _course_reply_text = self.detailModel.courses_reply_desc;
    [self lessonEva];
    [self teacherEva];
    [self organizationEva];
    
    {
        [self.cellConfigArr addObject:getEmptyCellWithHeight(CGFloatIn750(100))];
        [self.cellConfigArr addObject:getGrayEmptyCellWithHeight(CGFloatIn750(40))];
        
        ZCellConfig *orderCellConfig = [ZCellConfig cellConfigWithClassName:[ZOrganizationEvaListLessonCell className] title:[ZOrganizationEvaListLessonCell className] showInfoMethod:@selector(setDetailModel:) heightOfCell:[ZOrganizationEvaListLessonCell z_getCellHeight:nil] cellType:ZCellTypeClass dataModel:self.detailModel];
        [self.cellConfigArr addObject:orderCellConfig];
        [self.cellConfigArr addObject:getGrayEmptyCellWithHeight(CGFloatIn750(40))];
    }
}

- (void)lessonEva {
    {
        ZCellConfig *orderCellConfig = [ZCellConfig cellConfigWithClassName:[ZOrganizationEvaDetailTitleCell className] title:[ZOrganizationEvaDetailTitleCell className] showInfoMethod:@selector(setData:) heightOfCell:[ZOrganizationEvaDetailTitleCell z_getCellHeight:nil] cellType:ZCellTypeClass dataModel:@{@"title":@"课程评价",@"star":SafeStr(self.detailModel.courses_comment_score)}];
         [self.cellConfigArr addObject:orderCellConfig];
     }
    if (ValidStr(self.detailModel.courses_comment_desc)) {
        ZLineCellModel *mModel = ZLineCellModel.zz_lineCellModel_create(@"title")
        .zz_fontLeft([UIFont fontContent])
        .zz_cellHeight(CGFloatIn750(60))
        .zz_leftMultiLine(YES)
        .zz_titleLeft(self.detailModel.courses_comment_desc)
        .zz_cellWidth(KScreenWidth - CGFloatIn750(60));
        
        ZCellConfig *textCellConfig = [ZCellConfig cellConfigWithClassName:[ZBaseLineCell className] title:mModel.cellTitle showInfoMethod:@selector(setModel:) heightOfCell:[ZBaseLineCell z_getCellHeight:mModel] cellType:ZCellTypeClass dataModel:mModel];
        [self.cellConfigArr addObject:textCellConfig];
     }
    if ([self.detailModel.course_is_reply intValue] == 0) {
        if (!self.listModel.isTeacher) {
            ZCellConfig *orderCellConfig = [ZCellConfig cellConfigWithClassName:[ZOrganizationEvaListEvaTextViewCell className] title:@"course_reply_text" showInfoMethod:nil heightOfCell:[ZOrganizationEvaListEvaTextViewCell z_getCellHeight:nil] cellType:ZCellTypeClass dataModel:nil];
            [self.cellConfigArr addObject:orderCellConfig];
            
            ZCellConfig *btnCellConfig = [ZCellConfig cellConfigWithClassName:[ZOrganizationEvaListEvaBtnCell className] title:@"course_reply" showInfoMethod:nil heightOfCell:[ZOrganizationEvaListEvaBtnCell z_getCellHeight:nil] cellType:ZCellTypeClass dataModel:nil];
            [self.cellConfigArr addObject:btnCellConfig];
        }
        
    }else{
        ZCellConfig *orderCellConfig = [ZCellConfig cellConfigWithClassName:[ZOrganizationEvaListReEvaCell className] title:[ZOrganizationEvaListReEvaCell className] showInfoMethod:@selector(setEvaDes:) heightOfCell:[ZOrganizationEvaListReEvaCell z_getCellHeight:SafeStr(self.detailModel.courses_reply_desc)] cellType:ZCellTypeClass dataModel:SafeStr(self.detailModel.courses_reply_desc)];
        [self.cellConfigArr addObject:orderCellConfig];
    }
    
    [self.cellConfigArr addObject:getEmptyCellWithHeight(CGFloatIn750(40))];
}


- (void)teacherEva {
    {
         ZCellConfig *orderCellConfig = [ZCellConfig cellConfigWithClassName:[ZOrganizationEvaDetailTitleCell className] title:[ZOrganizationEvaDetailTitleCell className] showInfoMethod:@selector(setData:) heightOfCell:[ZOrganizationEvaDetailTitleCell z_getCellHeight:nil] cellType:ZCellTypeClass dataModel:@{@"title":@"教师评价",@"star":SafeStr(self.detailModel.teacher_comment_score)}];
         [self.cellConfigArr addObject:orderCellConfig];
     }
     if (ValidStr(self.detailModel.teacher_comment_desc)) {
         ZLineCellModel *mModel = ZLineCellModel.zz_lineCellModel_create(@"title")
         .zz_fontLeft([UIFont fontContent])
         .zz_cellHeight(CGFloatIn750(60))
         .zz_leftMultiLine(YES)
         .zz_titleLeft(self.detailModel.teacher_comment_desc)
         .zz_cellWidth(KScreenWidth - CGFloatIn750(60));
         
         ZCellConfig *textCellConfig = [ZCellConfig cellConfigWithClassName:[ZBaseLineCell className] title:mModel.cellTitle showInfoMethod:@selector(setModel:) heightOfCell:[ZBaseLineCell z_getCellHeight:mModel] cellType:ZCellTypeClass dataModel:mModel];
         [self.cellConfigArr addObject:textCellConfig];
     }
    if ([self.detailModel.teacher_is_reply intValue] == 1) {
        ZCellConfig *orderCellConfig = [ZCellConfig cellConfigWithClassName:[ZOrganizationEvaListReEvaCell className] title:[ZOrganizationEvaListReEvaCell className] showInfoMethod:@selector(setEvaDes:) heightOfCell:[ZOrganizationEvaListReEvaCell z_getCellHeight:SafeStr(self.detailModel.teacher_reply_desc)] cellType:ZCellTypeClass dataModel:SafeStr(self.detailModel.teacher_reply_desc)];
        [self.cellConfigArr addObject:orderCellConfig];
    }else{
        if (self.listModel.isTeacher) {
            ZCellConfig *orderCellConfig = [ZCellConfig cellConfigWithClassName:[ZOrganizationEvaListEvaTextViewCell className] title:@"teacher_reply_text" showInfoMethod:nil heightOfCell:[ZOrganizationEvaListEvaTextViewCell z_getCellHeight:nil] cellType:ZCellTypeClass dataModel:nil];
            [self.cellConfigArr addObject:orderCellConfig];
            
            ZCellConfig *btnCellConfig = [ZCellConfig cellConfigWithClassName:[ZOrganizationEvaListEvaBtnCell className] title:@"teacher_reply" showInfoMethod:nil heightOfCell:[ZOrganizationEvaListEvaBtnCell z_getCellHeight:nil] cellType:ZCellTypeClass dataModel:nil];
            [self.cellConfigArr addObject:btnCellConfig];
        }
    }
    
    [self.cellConfigArr addObject:getEmptyCellWithHeight(40)];
}


- (void)organizationEva {
    {
         ZCellConfig *orderCellConfig = [ZCellConfig cellConfigWithClassName:[ZOrganizationEvaDetailTitleCell className] title:[ZOrganizationEvaDetailTitleCell className] showInfoMethod:@selector(setData:) heightOfCell:[ZOrganizationEvaDetailTitleCell z_getCellHeight:nil] cellType:ZCellTypeClass dataModel:@{@"title":@"校区评价",@"star":SafeStr(self.detailModel.stores_comment_score)}];
         [self.cellConfigArr addObject:orderCellConfig];
     }
     if (ValidStr(self.detailModel.stores_comment_desc)) {
         ZLineCellModel *mModel = ZLineCellModel.zz_lineCellModel_create(@"title")
         .zz_fontLeft([UIFont fontContent])
         .zz_cellHeight(CGFloatIn750(60))
         .zz_leftMultiLine(YES)
         .zz_titleLeft(self.detailModel.stores_comment_desc)
         .zz_cellWidth(KScreenWidth - CGFloatIn750(60));
         
         ZCellConfig *textCellConfig = [ZCellConfig cellConfigWithClassName:[ZBaseLineCell className] title:mModel.cellTitle showInfoMethod:@selector(setModel:) heightOfCell:[ZBaseLineCell z_getCellHeight:mModel] cellType:ZCellTypeClass dataModel:mModel];
         [self.cellConfigArr addObject:textCellConfig];
     }
    
     if ([self.detailModel.stores_is_reply intValue] == 0) {
         if (!self.listModel.isTeacher) {
             ZCellConfig *orderCellConfig = [ZCellConfig cellConfigWithClassName:[ZOrganizationEvaListEvaTextViewCell className] title:@"stores_reply_text" showInfoMethod:nil heightOfCell:[ZOrganizationEvaListEvaTextViewCell z_getCellHeight:nil] cellType:ZCellTypeClass dataModel:nil];
             [self.cellConfigArr addObject:orderCellConfig];
             
             ZCellConfig *btnCellConfig = [ZCellConfig cellConfigWithClassName:[ZOrganizationEvaListEvaBtnCell className] title:@"stores_reply" showInfoMethod:nil heightOfCell:[ZOrganizationEvaListEvaBtnCell z_getCellHeight:nil] cellType:ZCellTypeClass dataModel:nil];
             [self.cellConfigArr addObject:btnCellConfig];
         }
         
     }else{
         ZCellConfig *orderCellConfig = [ZCellConfig cellConfigWithClassName:[ZOrganizationEvaListReEvaCell className] title:[ZOrganizationEvaListReEvaCell className] showInfoMethod:@selector(setEvaDes:) heightOfCell:[ZOrganizationEvaListReEvaCell z_getCellHeight:SafeStr(self.detailModel.stores_reply_desc)] cellType:ZCellTypeClass dataModel:SafeStr(self.detailModel.stores_reply_desc)];
         [self.cellConfigArr addObject:orderCellConfig];
     }
}

- (void)setNavigation {
    self.isHidenNaviBar = NO;
    [self.navigationItem setTitle:@"评价详情"];
}

- (void)setupMainView {
    [super setupMainView];
    
    [self.iTableView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.bottom.equalTo(self.view.mas_bottom);
        make.top.equalTo(self.view.mas_top).offset(10);
    }];
}

#pragma mark - tableview
- (void)zz_tableView:(UITableView *)tableView cell:(UITableViewCell *)cell cellForRowAtIndexPath:(NSIndexPath *)indexPath cellConfig:(ZCellConfig *)cellConfig {
    __weak typeof(self) weakSelf = self;
    if ([cellConfig.title isEqualToString:@"ZOrganizationEvaListLessonCell"]){
        ZOrganizationEvaListLessonCell *lcell = (ZOrganizationEvaListLessonCell *)cell;
        lcell.contentView.backgroundColor = adaptAndDarkColor([UIColor colorGrayBG], [UIColor colorGrayBGDark]);
        lcell.contView.backgroundColor = adaptAndDarkColor([UIColor colorGrayBG], [UIColor colorGrayBGDark]);
    }else if([cellConfig.title isEqualToString:@"course_reply_text"]){
        ZOrganizationEvaListEvaTextViewCell *tCell = (ZOrganizationEvaListEvaTextViewCell *)cell;
        tCell.content = self.course_reply_text;
        tCell.max = 200;
        tCell.textChangeBlock = ^(NSString * text) {
            weakSelf.course_reply_text = text;
        };
    }else if([cellConfig.title isEqualToString:@"stores_reply_text"]){
        ZOrganizationEvaListEvaTextViewCell *tCell = (ZOrganizationEvaListEvaTextViewCell *)cell;
        tCell.content = self.stores_reply_text;
        tCell.max = 200;
        tCell.textChangeBlock = ^(NSString * text) {
            weakSelf.stores_reply_text = text;
        };
    }else if([cellConfig.title isEqualToString:@"teacher_reply_text"]){
        ZOrganizationEvaListEvaTextViewCell *tCell = (ZOrganizationEvaListEvaTextViewCell *)cell;
        tCell.content = self.teacher_reply_text;
        tCell.max = 200;
        tCell.textChangeBlock = ^(NSString * text) {
            weakSelf.teacher_reply_text = text;
        };
    }else if([cellConfig.title isEqualToString:@"course_reply"]){
        ZOrganizationEvaListEvaBtnCell *tCell = (ZOrganizationEvaListEvaBtnCell *)cell;
        tCell.evaBlock = ^(NSInteger index) {
            [weakSelf replyWityType:@"1"];
        };
    }else if([cellConfig.title isEqualToString:@"stores_reply"]){
        ZOrganizationEvaListEvaBtnCell *tCell = (ZOrganizationEvaListEvaBtnCell *)cell;
        tCell.evaBlock = ^(NSInteger index) {
            [weakSelf replyWityType:@"3"];
        };
    }else if([cellConfig.title isEqualToString:@"teacher_reply"]){
        ZOrganizationEvaListEvaBtnCell *tCell = (ZOrganizationEvaListEvaBtnCell *)cell;
        tCell.evaBlock = ^(NSInteger index) {
            [weakSelf replyWityType:@"2"];
        };
    }
}

- (void)zz_tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath cellConfig:(ZCellConfig *)cellConfig {
    if ([cellConfig.title isEqualToString:@"ZOrganizationEvaListLessonCell"]) {
        if ([[ZUserHelper sharedHelper].user.type intValue] != 2) {
            ZOrderListModel *model = [[ZOrderListModel alloc] init];
            model.isStudent = NO;
            model.order_id = self.detailModel.order_id;
            routePushVC(ZRoute_org_orderDetail, model, nil);
        }
    }
}

#pragma mark - refresha
- (void)refreshData {
    __weak typeof(self) weakSelf = self;
    self.loading = YES;
    [ZOriganizationOrderViewModel getEvaDetail:@{@"order_id":SafeStr(self.listModel.order_id),@"stores_id":SafeStr([ZUserHelper sharedHelper].school.schoolID)} completeBlock:^(BOOL isSuccess, id data) {
        weakSelf.loading = NO;
        if (isSuccess) {
            weakSelf.detailModel = data;
            [weakSelf initCellConfigArr];
            [weakSelf.iTableView reloadData];
        }else{
            [TLUIUtility showErrorHint:data];
        }
    }];
}

- (void)replyWityType:(NSString *)type {
    NSMutableDictionary *params = @{}.mutableCopy;
    [params setObject:SafeStr(self.detailModel.stores_id) forKey:@"stores_id"];
    [params setObject:SafeStr(self.detailModel.order_id) forKey:@"order_id"];
    [params setObject:SafeStr(type) forKey:@"type"];
    if ([type isEqualToString:@"1"]) {
        if (!ValidStr(self.course_reply_text)) {
            [TLUIUtility showErrorHint:@"您还没有输入任何内容"];
            return;
        }
        [params setObject:SafeStr(self.course_reply_text) forKey:@"desc"];
    }else if ([type isEqualToString:@"3"]){
        if (!ValidStr(self.stores_reply_text)) {
            [TLUIUtility showErrorHint:@"您还没有输入任何内容"];
            return;
        }
        [params setObject:SafeStr(self.stores_reply_text) forKey:@"desc"];
    }else if ([type isEqualToString:@"2"]){
        if (!ValidStr(self.teacher_reply_text)) {
            [TLUIUtility showErrorHint:@"您还没有输入任何内容"];
            return;
        }
        [params setObject:SafeStr(self.teacher_reply_text) forKey:@"desc"];
    }

    __weak typeof(self) weakSelf = self;
    [TLUIUtility showLoading:@""];
    [ZOriganizationOrderViewModel replyEvaOrder:params completeBlock:^(BOOL isSuccess, NSString *message) {
        [TLUIUtility hiddenLoading];
        if (isSuccess) {
            [TLUIUtility showSuccessHint:message];
            [weakSelf refreshData];
            return ;
        }else {
            [TLUIUtility showErrorHint:message];
        }
    }];
}
@end

#pragma mark - RouteHandler
@interface ZOrganizationMineEvaDetailVC (RouteHandler)<SJRouteHandler>

@end

@implementation ZOrganizationMineEvaDetailVC (RouteHandler)

+ (NSString *)routePath {
    return ZRoute_org_evaDetail;
}

+ (void)handleRequest:(SJRouteRequest *)request topViewController:(UIViewController *)topViewController completionHandler:(SJCompletionHandler)completionHandler {
    ZOrganizationMineEvaDetailVC *routevc = [[ZOrganizationMineEvaDetailVC alloc] init];
    if (request.prts) {
        routevc.listModel = request.prts;
    }
    [topViewController.navigationController pushViewController:routevc animated:YES];
}
@end
