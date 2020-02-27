//
//  ZOrganizationClassManageDetailVC.m
//  NoWait
//
//  Created by zhuang zhang on 2020/2/26.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZOrganizationClassManageDetailVC.h"
#import "ZTextFieldMultColCell.h"
#import "ZDatePickerView.h"

#import "ZOrganizationClassDetailStudentListVC.h"
#import "ZOrganizationClassDetailStudentListAddVC.h"

@interface ZOrganizationClassManageDetailVC ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic,strong) UITableView *iTableView;
@property (nonatomic,strong) UIButton *bottomBtn;
@property (nonatomic,strong) UIButton *navLeftBtn;

@property (nonatomic,strong) NSMutableArray *dataSources;
@property (nonatomic,strong) NSMutableArray *cellConfigArr;

@end

@implementation ZOrganizationClassManageDetailVC

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
    
    [self initCellConfigArr];
}

- (void)initCellConfigArr {
    [_cellConfigArr removeAllObjects];
    
    
    NSArray *textArr = @[@[@"校区名称", @"", @"", @"schoolName",@"才玩俱乐部"],
                         @[@"班级名称", @"", @"", @"className",@"初级班"],
                         @[@"班级人数", @"", @"", @"num",@"15/15人"],
                         @[@"班级状态", @"", @"", @"classStutas",@"待开课"],
                         @[@"课程名称", @"", @"", @"lessonName",@"学了就是小拳拳"],
                         @[@"教师名称", @"", @"", @"techerName",@"香香老师"],
                         @[@"开课日期", @"请选择开课日期", @"rightBlackArrowN", @"openTime",@""],
                         @[@"结课日期", @"节课日期", @"", @"endTime",@"2020.01.22"],
                         @[@"学员列表", @"查看", @"rightBlackArrowN", @"studentList",@"查看"],
                         @[@"上课时间", @"选择上课时间", @"rightBlackArrowN", @"beginTime",@""]];
    
    for (int i = 0; i < textArr.count; i++) {
        if ([textArr[i][3] isEqualToString:@"beginTime"]) {
            ZBaseTextFieldCellModel *cellModel = [[ZBaseTextFieldCellModel alloc] init];
            cellModel.leftTitle = textArr[i][0];
            cellModel.placeholder = textArr[i][1];
            cellModel.isTextEnabled = NO;
            cellModel.rightImage = textArr[i][2];
            cellModel.cellTitle = textArr[i][3];
            cellModel.content = textArr[i][4];
            cellModel.isHiddenLine = YES;
            cellModel.cellHeight = CGFloatIn750(108);
            cellModel.rightFont = [UIFont fontContent];
            cellModel.rightColor = [UIColor colorTextGray];
            cellModel.rightDarkColor = [UIColor colorTextGrayDark];
            
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
            cellModel.isTextEnabled = NO;
            cellModel.rightImage = textArr[i][2];
            cellModel.cellTitle = textArr[i][3];
            cellModel.content = textArr[i][4];
            cellModel.isHiddenLine = YES;
            cellModel.cellHeight = CGFloatIn750(108);
            cellModel.rightFont = [UIFont fontContent];
            cellModel.rightColor = [UIColor colorTextGray];
            cellModel.rightDarkColor = [UIColor colorTextGrayDark];
            
            ZCellConfig *textCellConfig = [ZCellConfig cellConfigWithClassName:[ZTextFieldCell className] title:cellModel.cellTitle showInfoMethod:@selector(setModel:) heightOfCell:[ZTextFieldCell z_getCellHeight:cellModel] cellType:ZCellTypeClass dataModel:cellModel];
            [self.cellConfigArr addObject:textCellConfig];
        }
    }
    
}

- (void)setNavigation {
    self.isHidenNaviBar = NO;
    [self.navigationItem setTitle:@"班级详情"];
    
    if (self.isOpen) {
        
    }else{
        [self.navigationItem setRightBarButtonItem:[[UIBarButtonItem alloc] initWithCustomView:self.navLeftBtn]] ;
    }
}

- (void)setupMainView {
    self.view.backgroundColor = adaptAndDarkColor([UIColor colorWhite], [UIColor colorBlackBGDark]);
    
    if (self.isOpen) {
        [self.view addSubview:self.iTableView];
        
         [_iTableView mas_makeConstraints:^(MASConstraintMaker *make) {
             make.left.equalTo(self.view.mas_left).offset(CGFloatIn750(0));
             make.right.equalTo(self.view.mas_right).offset(CGFloatIn750(-0));
             make.bottom.equalTo(self.view.mas_bottom).offset(-CGFloatIn750(0));
             make.top.equalTo(self.view.mas_top).offset(-CGFloatIn750(0));
         }];
    }else{
        UIView *bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, CGFloatIn750(182))];
        bottomView.backgroundColor = adaptAndDarkColor([UIColor colorWhite], [UIColor colorBlackBGDark]);
        [self.view addSubview:bottomView];
        
        [bottomView addSubview:self.bottomBtn];
        [self.bottomBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(bottomView.mas_left).offset(CGFloatIn750(0));
            make.right.equalTo(bottomView.mas_right).offset(CGFloatIn750(0));
            make.height.mas_equalTo(CGFloatIn750(96));
            make.top.equalTo(bottomView.mas_top);
        }];
        
        [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.equalTo(self.view);
            make.height.mas_equalTo(CGFloatIn750(182));
        }];
        
        [self.view addSubview:self.iTableView];
         [_iTableView mas_makeConstraints:^(MASConstraintMaker *make) {
             make.left.equalTo(self.view.mas_left).offset(CGFloatIn750(0));
             make.right.equalTo(self.view.mas_right).offset(CGFloatIn750(-0));
             make.bottom.equalTo(bottomView.mas_top).offset(-CGFloatIn750(0));
             make.top.equalTo(self.view.mas_top).offset(-CGFloatIn750(0));
         }];
    }
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


- (UIButton *)navLeftBtn {
    if (!_navLeftBtn) {
        __weak typeof(self) weakSelf = self;
        _navLeftBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, CGFloatIn750(118), CGFloatIn750(50))];
        [_navLeftBtn setTitle:@"加入学员" forState:UIControlStateNormal];
        [_navLeftBtn setTitleColor:adaptAndDarkColor([UIColor colorWhite], [UIColor colorWhite]) forState:UIControlStateNormal];
        [_navLeftBtn.titleLabel setFont:[UIFont fontSmall]];
        [_navLeftBtn setBackgroundColor:[UIColor colorMain] forState:UIControlStateNormal];
        ViewRadius(_navLeftBtn, CGFloatIn750(25));
        [_navLeftBtn bk_whenTapped:^{
            ZOrganizationClassDetailStudentListAddVC *avc = [[ZOrganizationClassDetailStudentListAddVC alloc] init];
            [weakSelf.navigationController pushViewController:avc animated:YES];
        }];
    }
    return _navLeftBtn;
}

- (UIButton *)bottomBtn {
    if (!_bottomBtn) {
        __weak typeof(self) weakSelf = self;
        _bottomBtn = [[UIButton alloc] initWithFrame:CGRectZero];
        [_bottomBtn setTitle:@"立即开课" forState:UIControlStateNormal];
        [_bottomBtn setTitleColor:[UIColor colorWhite] forState:UIControlStateNormal];
        [_bottomBtn.titleLabel setFont:[UIFont fontContent]];
        [_bottomBtn setBackgroundColor:[UIColor colorMain] forState:UIControlStateNormal];
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
    if ([cellConfig.title isEqualToString:@"openTime"]) {
        if (!self.isOpen) {
            [ZDatePickerView showTimePickerInView:self.view date:[NSDate new] dateSelect:^(NSDate * date) {
                
            }];
        } 
    }else if ([cellConfig.title isEqualToString:@"studentList"]) {
        ZOrganizationClassDetailStudentListVC *lvc = [[ZOrganizationClassDetailStudentListVC  alloc] init];
        lvc.isOpen = self.isOpen;
        [self.navigationController pushViewController:lvc animated:YES];
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
    self.isHidenNaviBar = NO;
    
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
}

#pragma mark - -textField delegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    NSLog(@"donggggs-----");
//    [self searchPoiByKeyword:textField.text];
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
//    self.searhView.hidden = NO;
}

@end







