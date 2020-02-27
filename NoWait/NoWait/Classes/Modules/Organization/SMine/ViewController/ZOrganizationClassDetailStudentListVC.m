//
//  ZOrganizationClassDetailStudentListVC.m
//  NoWait
//
//  Created by zhuang zhang on 2020/2/26.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZOrganizationClassDetailStudentListVC.h"
#import "ZOriganizationClassStudentListCell.h"

#import "ZOriganizationTopTitleView.h"
#import "ZOrganizationClassDetailStudentListAddVC.h"
@interface ZOrganizationClassDetailStudentListVC ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic,strong) UITableView *iTableView;
@property (nonatomic,strong) UIButton *navLeftBtn;

@property (nonatomic,strong) NSMutableArray *dataSources;
@property (nonatomic,strong) NSMutableArray *cellConfigArr;
@property (nonatomic,strong) ZOriganizationTopTitleView *topView;

@end

@implementation ZOrganizationClassDetailStudentListVC

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
    
    ZBaseCellModel *cellModel = [[ZBaseCellModel alloc] init];
    if (self.isOpen) {
        cellModel.data = @"";
    }
    
    ZCellConfig *textCellConfig = [ZCellConfig cellConfigWithClassName:[ZOriganizationClassStudentListCell className] title:cellModel.cellTitle showInfoMethod:@selector(setModel:) heightOfCell:[ZOriganizationClassStudentListCell z_getCellHeight:cellModel] cellType:ZCellTypeClass dataModel:cellModel];
    [self.cellConfigArr addObject:textCellConfig];
  
    [self.cellConfigArr addObject:textCellConfig];
    [self.cellConfigArr addObject:textCellConfig];
    [self.cellConfigArr addObject:textCellConfig];
    [self.cellConfigArr addObject:textCellConfig];
}

- (void)setNavigation {
    self.isHidenNaviBar = NO;
    [self.navigationItem setTitle:@"学员列表"];
    
    if (self.isOpen) {
        
    }else{
        [self.navigationItem setRightBarButtonItem:[[UIBarButtonItem alloc] initWithCustomView:self.navLeftBtn]] ;
    }
}

- (void)setupMainView {
    self.view.backgroundColor = adaptAndDarkColor([UIColor colorWhite], [UIColor colorBlackBGDark]);
    
    [self.view addSubview:self.topView];
    [self.topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(self.view);
        make.height.mas_equalTo(CGFloatIn750(90));
    }];
    
    [self.view addSubview:self.iTableView];
    [_iTableView mas_makeConstraints:^(MASConstraintMaker *make) {
     make.left.equalTo(self.view.mas_left).offset(CGFloatIn750(0));
     make.right.equalTo(self.view.mas_right).offset(CGFloatIn750(-0));
     make.bottom.equalTo(self.view.mas_bottom).offset(-CGFloatIn750(0));
     make.top.equalTo(self.topView.mas_bottom).offset(-CGFloatIn750(0));
    }];
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

- (ZOriganizationTopTitleView *)topView {
    if (!_topView) {
        _topView = [[ZOriganizationTopTitleView alloc] init];
        if (self.isOpen) {
            _topView.titleArr = @[@"姓名", @"上课进度", @"签到详情"];
        }else{
            _topView.titleArr = @[@"姓名", @"上课进度", @"签到详情" , @"操作"];
        }
    }
    return _topView;
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








