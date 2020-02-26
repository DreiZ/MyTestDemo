//
//  ZOrganizationAccountVC.m
//  NoWait
//
//  Created by zhuang zhang on 2020/2/26.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZOrganizationAccountVC.h"
#import "ZOriganizationStudentListCell.h"
#import "ZOrganizationRadiusCell.h"
#import "ZOrganizationAccountTopMainView.h"

#import "ZOrganizationSchoolAccountVC.h"

@interface ZOrganizationAccountVC ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic,strong) UITableView *iTableView;
@property (nonatomic,strong) ZOrganizationAccountTopMainView *topView;

@property (nonatomic,strong) NSMutableArray *dataSources;
@property (nonatomic,strong) NSMutableArray *cellConfigArr;

@end

@implementation ZOrganizationAccountVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNavigation];
    [self setDataSource];
    [self initCellConfigArr];
    [self setupMainView];
    [self.iTableView reloadData];
}

- (void)setDataSource {
    _dataSources = @[].mutableCopy;
    _cellConfigArr = @[].mutableCopy;
    
    [self initCellConfigArr];
}

- (void)initCellConfigArr {
    [_cellConfigArr removeAllObjects];
    
    ZCellConfig *topCellConfig = [ZCellConfig cellConfigWithClassName:[ZOrganizationRadiusCell className] title:[ZOrganizationRadiusCell className] showInfoMethod:@selector(setIsTop:) heightOfCell:CGFloatIn750(20) cellType:ZCellTypeClass dataModel:@"yes"];
    [self.cellConfigArr addObject:topCellConfig];
    
    ZBaseSingleCellModel *model = [[ZBaseSingleCellModel alloc] init];
    model.leftTitle = @"才玩俱乐部";
    model.rightTitle = @"￥120";
    model.rightImage = @"rightBlackArrowN";
    model.rightMargin = CGFloatIn750(40);
    model.cellHeight = CGFloatIn750(106);
    model.leftFont = [UIFont fontContent];
    model.rightFont = [UIFont fontContent];
    model.rightColor = [UIColor colorTextBlack];
    model.rightDarkColor = [UIColor colorTextBlackDark];
    
    ZCellConfig *textCellConfig = [ZCellConfig cellConfigWithClassName:[ZSingleLineCell className] title:[ZSingleLineCell className] showInfoMethod:@selector(setModel:) heightOfCell:[ZSingleLineCell z_getCellHeight:nil] cellType:ZCellTypeClass dataModel:model];
    [self.cellConfigArr addObject:textCellConfig];
  
    [self.cellConfigArr addObject:textCellConfig];
    [self.cellConfigArr addObject:textCellConfig];
    [self.cellConfigArr addObject:textCellConfig];
    [self.cellConfigArr addObject:textCellConfig];
    
    ZCellConfig *bottomCellConfig = [ZCellConfig cellConfigWithClassName:[ZOrganizationRadiusCell className] title:[ZOrganizationRadiusCell className] showInfoMethod:@selector(setIsTop:) heightOfCell:CGFloatIn750(20) cellType:ZCellTypeClass dataModel:@""];
    [self.cellConfigArr addObject:bottomCellConfig];
}

- (void)setNavigation {
    self.isHidenNaviBar = NO;
    [self.navigationItem setTitle:@"账户信息"];
}

- (void)setupMainView {
    self.view.backgroundColor = adaptAndDarkColor([UIColor colorGrayBG], [UIColor colorGrayBGDark]);
    
    
    [self.view addSubview:self.topView];
    [self.topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(self.view);
        make.height.mas_equalTo(CGFloatIn750(384));
    }];
    
    [self.view addSubview:self.iTableView];
    [_iTableView mas_makeConstraints:^(MASConstraintMaker *make) {
     make.left.equalTo(self.view.mas_left).offset(CGFloatIn750(30));
     make.right.equalTo(self.view.mas_right).offset(CGFloatIn750(-30));
     make.bottom.equalTo(self.view.mas_bottom).offset(-CGFloatIn750(0));
     make.top.equalTo(self.topView.mas_bottom).offset(CGFloatIn750(1));
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
        _iTableView.backgroundColor = adaptAndDarkColor([UIColor colorGrayBG], [UIColor colorGrayBGDark]);
    }
    return _iTableView;
}

- (ZOrganizationAccountTopMainView *)topView {
    if (!_topView) {
        _topView = [[ZOrganizationAccountTopMainView alloc] init];
        _topView.isSchool = NO;
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
    if ([cellConfig.title isEqualToString:@"ZOrganizationRadiusCell"]){
        ZOrganizationRadiusCell *enteryCell = (ZOrganizationRadiusCell *)cell;
        enteryCell.leftMargin = 0;
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
    if ([cellConfig.title isEqualToString:@"ZSingleLineCell"]) {
        ZOrganizationSchoolAccountVC *avc = [[ZOrganizationSchoolAccountVC alloc] init];
        [self.navigationController pushViewController:avc animated:YES];
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










