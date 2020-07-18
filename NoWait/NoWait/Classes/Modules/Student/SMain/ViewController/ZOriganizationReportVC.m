//
//  ZOriganizationReportVC.m
//  NoWait
//
//  Created by zhuang zhang on 2020/3/31.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZOriganizationReportVC.h"
#import "ZStudentLabelCell.h"
#import "ZAlertView.h"
#import "ZStudentMainViewModel.h"
#import "ZStudentMainModel.h"
#import "ZOriganizationTextViewCell.h"

@interface ZOriganizationReportVC ()
@property (nonatomic,strong) NSString *des;
@property (nonatomic,strong) ZComplaintModel *model;
@property (nonatomic,strong) UIButton *bottomBtn;

@end

@implementation ZOriganizationReportVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    __weak typeof(self) weakSelf = self;
    self.zChain_setNavTitle(@"举报")
    .zChain_resetMainView(^{
        [self.iTableView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.view);
        }];
        
        UIView *bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, CGFloatIn750(120))];
        [bottomView addSubview:self.bottomBtn];
        [self.bottomBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(bottomView.mas_left).offset(CGFloatIn750(40));
            make.right.equalTo(bottomView.mas_right).offset(-CGFloatIn750(40));
            make.bottom.equalTo(bottomView.mas_bottom);
            make.height.mas_offset(CGFloatIn750(80));
        }];
        self.iTableView.tableFooterView = bottomView;
    }).zChain_block_setRefreshHeaderNet(^{
        __weak typeof(self) weakSelf = self;
        [ZStudentMainViewModel getComplaintType:@{} completeBlock:^(BOOL isSuccess, ZComplaintNetModel *data) {
            weakSelf.loading = NO;
            if (isSuccess && data) {
                [weakSelf.dataSources removeAllObjects];
                [weakSelf.dataSources addObjectsFromArray:data.list];
                
                weakSelf.zChain_reload_ui();
            }else{
                [weakSelf.iTableView reloadData];
            }
        }];
    }).zChain_block_setUpdateCellConfigData(^(void (^update)(NSMutableArray *)) {
        [weakSelf.cellConfigArr removeAllObjects];
        {
            ZLineCellModel *model = ZLineCellModel.zz_lineCellModel_create(@"title")
            .zz_cellHeight(CGFloatIn750(80))
            .zz_fontLeft([UIFont fontContent])
            .zz_titleLeft(@"举报")
            .zz_fontRight([UIFont boldFontContent])
            .zz_titleRight(self.sTitle)
            .zz_alignmentRight(NSTextAlignmentLeft);
            
            ZCellConfig *menuCellConfig = [ZCellConfig cellConfigWithClassName:[ZBaseLineCell className] title:model.cellTitle showInfoMethod:@selector(setModel:) heightOfCell:[ZBaseLineCell z_getCellHeight:model] cellType:ZCellTypeClass dataModel:model];

            [self.cellConfigArr  addObject:menuCellConfig];
        }
        
        {
            ZLineCellModel *model = ZLineCellModel.zz_lineCellModel_create(@"title")
            .zz_cellHeight(CGFloatIn750(80))
            .zz_fontLeft([UIFont fontContent])
            .zz_titleLeft(@"选择你想要举报的类型");
            
            ZCellConfig *menuCellConfig = [ZCellConfig cellConfigWithClassName:[ZBaseLineCell className] title:model.cellTitle showInfoMethod:@selector(setModel:) heightOfCell:[ZBaseLineCell z_getCellHeight:model] cellType:ZCellTypeClass dataModel:model];

            [self.cellConfigArr  addObject:menuCellConfig];
        }
        
        ZCellConfig *menuCellConfig = [ZCellConfig cellConfigWithClassName:[ZStudentLabelCell className] title:@"label" showInfoMethod:@selector(setTitleArr:) heightOfCell:[ZStudentLabelCell z_getCellHeight:self.dataSources] cellType:ZCellTypeClass dataModel:self.dataSources];
        
        [self.cellConfigArr  addObject:menuCellConfig];
        {
            ZLineCellModel *model = ZLineCellModel.zz_lineCellModel_create(@"title")
            .zz_cellHeight(CGFloatIn750(92))
            .zz_fontLeft([UIFont fontContent])
            .zz_titleLeft(@"补充说明(140字以为)");
            
            ZCellConfig *menuCellConfig = [ZCellConfig cellConfigWithClassName:[ZBaseLineCell className] title:model.cellTitle showInfoMethod:@selector(setModel:) heightOfCell:[ZBaseLineCell z_getCellHeight:model] cellType:ZCellTypeClass dataModel:model];
            [self.cellConfigArr  addObject:menuCellConfig];
            
            ZCellConfig *textCellConfig = [ZCellConfig cellConfigWithClassName:[ZOriganizationTextViewCell className] title:@"ZOriganizationTextViewCell" showInfoMethod:@selector(setIsBackColor:) heightOfCell:CGFloatIn750(274) cellType:ZCellTypeClass dataModel:@"yes"];
            [self.cellConfigArr addObject:textCellConfig];
        }
    }).zChain_block_setCellConfigForRowAtIndexPath(^(UITableView *tableView, NSIndexPath *indexPath, UITableViewCell *cell, ZCellConfig *cellConfig) {
        if ([cellConfig.title isEqualToString:@"label"]) {
            ZStudentLabelCell *lcell = (ZStudentLabelCell *)cell;
            lcell.handleBlock = ^(ZComplaintModel *model) {
                weakSelf.model = model;
            };
        }else if ([cellConfig.title isEqualToString:@"ZOriganizationTextViewCell"]) {
            ZOriganizationTextViewCell *lcell = (ZOriganizationTextViewCell *)cell;
            lcell.max = 140;
            lcell.hint = @"选填";
            lcell.content = self.des;
            lcell.textChangeBlock = ^(NSString * text) {
                weakSelf.des = text;
            };
        }
    });
    
    self.zChain_reload_Net();
}

#pragma mark - setview
- (UIButton *)bottomBtn {
    if (!_bottomBtn) {
        __weak typeof(self) weakSelf = self;
        _bottomBtn = [[UIButton alloc] initWithFrame:CGRectZero];
        _bottomBtn.layer.masksToBounds = YES;
        [_bottomBtn setTitle:@"举报" forState:UIControlStateNormal];
        [_bottomBtn setTitleColor:[UIColor colorWhite] forState:UIControlStateNormal];
        [_bottomBtn.titleLabel setFont:[UIFont fontContent]];
        [_bottomBtn setBackgroundColor:adaptAndDarkColor([UIColor colorMain], [UIColor colorMainDark]) forState:UIControlStateNormal];
        ViewRadius(_bottomBtn, CGFloatIn750(40));
        [_bottomBtn bk_addEventHandler:^(id sender) {
            [weakSelf addReport];
        } forControlEvents:UIControlEventTouchUpInside];
    }
    return _bottomBtn;
}

- (void)addReport{
    __weak typeof(self) weakSelf = self;
    [ZAlertView setAlertWithTitle:@"提示" subTitle:[NSString stringWithFormat:@"确定举报(%@) %@",self.sTitle,self.model.type] leftBtnTitle:@"取消" rightBtnTitle:@"确定" handlerBlock:^(NSInteger index) {
        NSMutableDictionary *param = @{}.mutableCopy;
        if (self.stores_id) {
            [param setObject:self.stores_id forKey:@"stores_id"];
            [param setObject:@"2" forKey:@"object"];
            if (ValidStr(self.des)) {
                [param setObject:self.des forKey:@"desc"];
            }
        }
        if (self.course_id) {
            [param setObject:self.course_id forKey:@"course_id"];
            [param setObject:@"1" forKey:@"object"];
            if (ValidStr(self.des)) {
                [param setObject:self.des forKey:@"desc"];
            }
        }
        [param setObject:self.model.complaintId forKey:@"type"];
        if (self.dynamic) {
            [param setObject:self.dynamic forKey:@"dynamic"];
            if (ValidStr(self.des)) {
                [param setObject:self.des forKey:@"explain"];
            }
            
            [TLUIUtility showLoading:nil];
            [ZStudentMainViewModel addDynamicComplaint:param completeBlock:^(BOOL isSuccess, id data) {
                [TLUIUtility hiddenLoading];
                if (isSuccess && data) {
    //                        [TLUIUtility showAlertWithTitle:data];
                    [TLUIUtility showSuccessHint:data];
                    [weakSelf.navigationController popViewControllerAnimated:YES];
                }else{
                    [TLUIUtility showErrorHint:data];
                }
            }];
            return;
        }
        
            
        
        [TLUIUtility showLoading:nil];
        [ZStudentMainViewModel addComplaint:param completeBlock:^(BOOL isSuccess, id data) {
            [TLUIUtility hiddenLoading];
            if (isSuccess && data) {
//                        [TLUIUtility showAlertWithTitle:data];
                [TLUIUtility showSuccessHint:data];
                [weakSelf.navigationController popViewControllerAnimated:YES];
            }else{
                [TLUIUtility showErrorHint:data];
            }
        }];
    }];
}
@end

