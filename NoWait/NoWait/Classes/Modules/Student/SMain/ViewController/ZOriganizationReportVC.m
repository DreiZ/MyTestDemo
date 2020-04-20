//
//  ZOriganizationReportVC.m
//  NoWait
//
//  Created by zhuang zhang on 2020/3/31.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZOriganizationReportVC.h"
#import "ZMultiseriateContentLeftLineCell.h"
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
    [self refreshHeadData:@{}];
    [self initCellConfigArr];
    [self.iTableView reloadData];
}

- (void)setNavigation {
    self.isHidenNaviBar = NO;
    
    [self.navigationItem setTitle:@"举报"];
}

- (void)setDataSource {
    [super setDataSource];
    
}

- (void)initCellConfigArr {
    [super initCellConfigArr];
    
    {
        ZBaseMultiseriateCellModel *model = [[ZBaseMultiseriateCellModel alloc] init];
        model.rightTitle = self.sTitle;
        model.isHiddenLine = YES;
        model.leftTitle = @"举报";
        model.cellWidth = KScreenWidth - CGFloatIn750(60);
        model.singleCellHeight = CGFloatIn750(78);
        model.cellHeight = CGFloatIn750(80);
        model.lineSpace = CGFloatIn750(2);
        model.rightFont = [UIFont boldFontContent];
        model.leftFont = [UIFont fontContent];
        model.rightColor = [UIColor colorTextBlack];
        model.rightDarkColor =  [UIColor colorTextBlackDark];
        model.leftColor = [UIColor colorTextGray];
        model.leftDarkColor =  [UIColor colorTextGrayDark];
        
        ZCellConfig *menuCellConfig = [ZCellConfig cellConfigWithClassName:[ZMultiseriateContentLeftLineCell className] title:model.cellTitle showInfoMethod:@selector(setMModel:) heightOfCell:[ZMultiseriateContentLeftLineCell z_getCellHeight:model] cellType:ZCellTypeClass dataModel:model];
        
        [self.cellConfigArr  addObject:menuCellConfig];
    }
    
    {
        ZBaseMultiseriateCellModel *model = [[ZBaseMultiseriateCellModel alloc] init];
        model.leftTitle = @"选择你想要举报的类型";
        model.isHiddenLine = YES;
        model.cellWidth = KScreenWidth - CGFloatIn750(60);
        model.singleCellHeight = CGFloatIn750(78);
        model.cellHeight = CGFloatIn750(80);
        model.lineSpace = CGFloatIn750(2);
        model.leftFont = [UIFont fontContent];
        
        ZCellConfig *menuCellConfig = [ZCellConfig cellConfigWithClassName:[ZMultiseriateContentLeftLineCell className] title:model.cellTitle showInfoMethod:@selector(setMModel:) heightOfCell:[ZMultiseriateContentLeftLineCell z_getCellHeight:model] cellType:ZCellTypeClass dataModel:model];
        
        [self.cellConfigArr  addObject:menuCellConfig];
    }
    
    ZCellConfig *menuCellConfig = [ZCellConfig cellConfigWithClassName:[ZStudentLabelCell className] title:@"label" showInfoMethod:@selector(setTitleArr:) heightOfCell:[ZStudentLabelCell z_getCellHeight:self.dataSources] cellType:ZCellTypeClass dataModel:self.dataSources];
    
    [self.cellConfigArr  addObject:menuCellConfig];
    
    
    {
        ZBaseSingleCellModel *model = [[ZBaseSingleCellModel alloc] init];
        model.leftTitle = @"补充说明(140字以为)";
        model.leftFont = [UIFont boldFontContent];
        model.isHiddenLine = YES;
        model.cellHeight = CGFloatIn750(92);
        
        ZCellConfig *menuCellConfig = [ZCellConfig cellConfigWithClassName:[ZSingleLineCell className] title:model.cellTitle showInfoMethod:@selector(setModel:) heightOfCell:[ZSingleLineCell z_getCellHeight:model] cellType:ZCellTypeClass dataModel:model];
        
        [self.cellConfigArr addObject:menuCellConfig];
        
        ZCellConfig *textCellConfig = [ZCellConfig cellConfigWithClassName:[ZOriganizationTextViewCell className] title:@"ZOriganizationTextViewCell" showInfoMethod:@selector(setIsBackColor:) heightOfCell:CGFloatIn750(274) cellType:ZCellTypeClass dataModel:@"yes"];
        
        [self.cellConfigArr addObject:textCellConfig];
    }
}
#pragma mark - setview
- (void)setupMainView {
    [super setupMainView];
    
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
}


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
        [_bottomBtn bk_whenTapped:^{
            [weakSelf addReport];
        }];
    }
    return _bottomBtn;
}

- (void)zz_tableView:(UITableView *)tableView cell:(UITableViewCell *)cell cellForRowAtIndexPath:(NSIndexPath *)indexPath cellConfig:(ZCellConfig *)cellConfig {
    __weak typeof(self) weakSelf = self;
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
}


- (void)refreshHeadData:(NSDictionary *)param {
    __weak typeof(self) weakSelf = self;
    [ZStudentMainViewModel getComplaintType:param completeBlock:^(BOOL isSuccess, ZComplaintNetModel *data) {
        weakSelf.loading = NO;
        if (isSuccess && data) {
            [weakSelf.dataSources removeAllObjects];
            [weakSelf.dataSources addObjectsFromArray:data.list];
            [weakSelf initCellConfigArr];
            [weakSelf.iTableView reloadData];
        }else{
            [weakSelf.iTableView reloadData];
        }
    }];
}


- (void)addReport{
    __weak typeof(self) weakSelf = self;
    [ZAlertView setAlertWithTitle:@"提示" subTitle:[NSString stringWithFormat:@"确定举报 %@ %@",self.sTitle,self.model.type] leftBtnTitle:@"取消" rightBtnTitle:@"确定" handlerBlock:^(NSInteger index) {
        NSMutableDictionary *param = @{}.mutableCopy;
        if (self.stores_id) {
            [param setObject:self.stores_id forKey:@"stores_id"];
            [param setObject:@"2" forKey:@"object"];
        }
        if (self.course_id) {
            [param setObject:self.course_id forKey:@"course_id"];
            [param setObject:@"1" forKey:@"object"];
        }
        if (ValidStr(self.des)) {
            [param setObject:self.des forKey:@"desc"];
        }
            
        [param setObject:self.model.complaintId forKey:@"type"];
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

