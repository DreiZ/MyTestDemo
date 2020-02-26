//
//  ZOrganizationTrachingScheduleNewClassVC.m
//  NoWait
//
//  Created by zhuang zhang on 2020/2/26.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZOrganizationTrachingScheduleNewClassVC.h"

#import "ZOrganizationTimeSelectVC.h"
#import "ZAlertDataCheckBoxView.h"
#import "ZTextFieldMultColCell.h"


@interface ZOrganizationTrachingScheduleNewClassVC ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic,strong) UITableView *iTableView;
@property (nonatomic,strong) UIButton *bottomBtn;

@property (nonatomic,strong) NSMutableArray *dataSources;
@property (nonatomic,strong) NSMutableArray *cellConfigArr;
@end

@implementation ZOrganizationTrachingScheduleNewClassVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNavigation];
    [self setDataSource];
    [self initCellConfigArr];
    [self setupMainView];
}

- (void)setDataSource {
    _dataSources = @[].mutableCopy;
    _cellConfigArr = @[].mutableCopy;
}

- (void)initCellConfigArr {
    [_cellConfigArr removeAllObjects];
    
    
    {
        NSArray *textArr = @[@[@"班级名称", @"请输入班级名称", @YES, @"", @"name"],
                             @[@"上课时间", @"选择", @NO, @"rightBlackArrowN", @"time"],
                             @[@"分配教师", @"选择", @NO, @"rightBlackArrowN",  @"teacher"]];
        
        for (int i = 0; i < textArr.count; i++) {
            if (i == 1) {
                ZBaseTextFieldCellModel *cellModel = [[ZBaseTextFieldCellModel alloc] init];
                cellModel.leftTitle = textArr[i][0];
                cellModel.placeholder = textArr[i][1];
                cellModel.isTextEnabled = [textArr[i][2] boolValue];
                cellModel.rightImage = textArr[i][3];
                cellModel.cellTitle = textArr[i][4];
                cellModel.isHiddenLine = YES;
                cellModel.cellHeight = CGFloatIn750(116);
                cellModel.textColor = [UIColor colorTextGray];
                cellModel.leftContentWidth = CGFloatIn750(260);
                
                NSMutableArray *multArr = @[].mutableCopy;
                
                NSArray *tempArr = @[@[@"周一 | ", @"12:00~14:00   12:00~14:00   12:00~14:00   12:00~14:00   12:00~14:00"],@[@"周一 | ", @"12:00~14:00   12:00~14:00   12:00~14:00   12:00~14:00   12:00~14:00"]];
                for (int j = 0; j < tempArr.count; j++) {
                    ZBaseMultiseriateCellModel *mModel = [[ZBaseMultiseriateCellModel alloc] init];
                    mModel.cellWidth = KScreenWidth - cellModel.leftContentWidth - cellModel.leftMargin - cellModel.rightMargin - cellModel.contentSpace * 2;
                    mModel.rightFont = [UIFont fontSmall];
                    mModel.leftFont = [UIFont fontSmall];
                    mModel.rightColor = [UIColor colorTextGray];
                    mModel.leftColor = [UIColor colorTextGray];
                    mModel.rightDarkColor = [UIColor colorTextGrayDark];
                    mModel.leftDarkColor = [UIColor colorTextGrayDark];
                    mModel.singleCellHeight = CGFloatIn750(44);
                    mModel.rightTitle = tempArr[j][1];
                    mModel.leftTitle = tempArr[j][0];
                    mModel.leftContentSpace = CGFloatIn750(4);
                    mModel.rightContentSpace = CGFloatIn750(4);
                    mModel.leftMargin = CGFloatIn750(2);
                    mModel.rightMargin = CGFloatIn750(2);
                    mModel.isHiddenLine = YES;
                    
                    [multArr addObject:mModel];
                }
                cellModel.data = multArr;
                
                ZCellConfig *textCellConfig = [ZCellConfig cellConfigWithClassName:[ZTextFieldMultColCell className] title:cellModel.cellTitle showInfoMethod:@selector(setModel:) heightOfCell:[ZTextFieldMultColCell z_getCellHeight:cellModel] cellType:ZCellTypeClass dataModel:cellModel];
                [self.cellConfigArr addObject:textCellConfig];
            }else{
                ZBaseTextFieldCellModel *cellModel = [[ZBaseTextFieldCellModel alloc] init];
                cellModel.leftTitle = textArr[i][0];
                cellModel.placeholder = textArr[i][1];
                cellModel.isTextEnabled = [textArr[i][2] boolValue];
                cellModel.rightImage = textArr[i][3];
                cellModel.cellTitle = textArr[i][4];
                cellModel.isHiddenLine = YES;
                cellModel.cellHeight = CGFloatIn750(116);
                cellModel.textColor = [UIColor colorTextGray];
                
                ZCellConfig *textCellConfig = [ZCellConfig cellConfigWithClassName:[ZTextFieldCell className] title:cellModel.cellTitle showInfoMethod:@selector(setModel:) heightOfCell:[ZTextFieldCell z_getCellHeight:cellModel] cellType:ZCellTypeClass dataModel:cellModel];
                [self.cellConfigArr addObject:textCellConfig];
            }
        }
    }
    
}


- (void)setNavigation {
    self.isHidenNaviBar = NO;
    [self.navigationItem setTitle:@"新增排课"];
}

- (void)setupMainView {
    
    UIView *bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, CGFloatIn750(170))];
    bottomView.backgroundColor = adaptAndDarkColor([UIColor colorWhite], [UIColor colorBlackBGDark]);
    [bottomView addSubview:self.bottomBtn];
    [self.bottomBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(bottomView.mas_left).offset(CGFloatIn750(60));
        make.right.equalTo(bottomView.mas_right).offset(CGFloatIn750(-60));
        make.height.mas_equalTo(CGFloatIn750(80));
        make.top.equalTo(bottomView.mas_top).offset(CGFloatIn750(20));
    }];
    
    [self.view addSubview:self.iTableView];
    [_iTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.bottom.equalTo(self.view.mas_bottom);
        make.top.equalTo(self.view.mas_top).offset(10);
    }];
    self.iTableView.tableFooterView = bottomView;
}

#pragma mark lazy loading...
-(UITableView *)iTableView {
    if (!_iTableView) {
        _iTableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _iTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _iTableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
        _iTableView.showsVerticalScrollIndicator = NO;
        _iTableView.showsHorizontalScrollIndicator = NO;
        if ([_iTableView respondsToSelector:@selector(contentInsetAdjustmentBehavior)]) {
            _iTableView.estimatedRowHeight = 0;
            _iTableView.estimatedSectionHeaderHeight = 0;
            _iTableView.estimatedSectionFooterHeight = 0;
            if (@available(iOS 11.0, *)) {
                _iTableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
            } else {
                // Fallback on earlier versions
            }
        } else {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
            self.automaticallyAdjustsScrollViewInsets = NO;
#pragma clang diagnostic pop
        }
        _iTableView.delegate = self;
        _iTableView.dataSource = self;
        _iTableView.backgroundColor = adaptAndDarkColor([UIColor colorWhite], [UIColor colorBlackBGDark]);
    }
    return _iTableView;
}


- (UIButton *)bottomBtn {
    if (!_bottomBtn) {
//        __weak typeof(self) weakSelf = self;
        _bottomBtn = [[UIButton alloc] initWithFrame:CGRectZero];
        _bottomBtn.layer.masksToBounds = YES;
        _bottomBtn.layer.cornerRadius = CGFloatIn750(40);
        [_bottomBtn setTitle:@"保存" forState:UIControlStateNormal];
        [_bottomBtn setTitleColor:[UIColor colorWhite] forState:UIControlStateNormal];
        [_bottomBtn.titleLabel setFont:[UIFont fontContent]];
        [_bottomBtn setBackgroundColor:[UIColor  colorMain] forState:UIControlStateNormal];
        [_bottomBtn bk_whenTapped:^{

        }];
    }
    return _bottomBtn;
}


#pragma mark tableView -------datasource-----
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _cellConfigArr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ZCellConfig *cellConfig = [_cellConfigArr objectAtIndex:indexPath.row];
    ZBaseCell *cell;
    cell = (ZBaseCell*)[cellConfig cellOfCellConfigWithTableView:tableView dataModel:cellConfig.dataModel];
    if ([cellConfig.title isEqualToString:@"ZSpaceEmptyCell"]){
//        ZSpaceEmptyCell *enteryCell = (ZSpaceEmptyCell *)cell;
        
    }
    return cell;
}

#pragma mark tableView ------delegate-----
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    ZCellConfig *cellConfig = _cellConfigArr[indexPath.row];
    CGFloat cellHeight =  cellConfig.heightOfCell;
    return cellHeight;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.01f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01f;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    ZCellConfig *cellConfig = [_cellConfigArr objectAtIndex:indexPath.row];
    if ([cellConfig.title isEqualToString:@"school"]) {
       
    }else if ([cellConfig.title isEqualToString:@"teacher"]) {
        [ZAlertDataCheckBoxView setAlertName:@"选择教练" handlerBlock:^(NSInteger index) {
            
        }];
    } else if ([cellConfig.title isEqualToString:@"lessonTime"]) {
        ZOrganizationTimeSelectVC *svc = [[ZOrganizationTimeSelectVC alloc] init];
        [self.navigationController pushViewController:svc animated:YES];
    }
    
    
}

#pragma mark vc delegate-------------------
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
}
@end




