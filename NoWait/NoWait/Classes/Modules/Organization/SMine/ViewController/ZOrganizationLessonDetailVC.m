//
//  ZOrganizationLessonDetailVC.m
//  NoWait
//
//  Created by zhuang zhang on 2020/2/25.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZOrganizationLessonDetailVC.h"
#import "ZOrganizationLessonDetailHeaderCell.h"
#import "ZOrganizationLessonDetailPriceCell.h"


@interface ZOrganizationLessonDetailVC ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic,strong) UITableView *iTableView;
@property (nonatomic,strong) UIButton *navLeftBtn;
@property (nonatomic,strong) UIView *topNavView;

@property (nonatomic,strong) NSMutableArray *cellConfigArr;

@end

@implementation ZOrganizationLessonDetailVC

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.isHidenNaviBar = YES;
    
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setData];
    [self setupMainView];
    [self setCellData];
}

- (void)setData {
    _cellConfigArr = @[].mutableCopy;
}

- (void)setupMainView {
    [self.view addSubview:self.iTableView];
    
    [self.iTableView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.view.mas_left).offset(20);
        make.left.top.right.equalTo(self.view);
        make.bottom.equalTo(self.view.mas_bottom).offset(-kTabBarHeight);
    }];
    
    [self.view addSubview:self.topNavView];
    [self.topNavView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(self.view);
        make.height.mas_equalTo(kTopHeight);
    }];
    
    [self.view addSubview:self.navLeftBtn];
    [self.navLeftBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(CGFloatIn750(50));
        make.left.equalTo(self.view.mas_left).offset(CGFloatIn750(30));
        make.bottom.equalTo(self.topNavView.mas_bottom).offset(-CGFloatIn750(17));
    }];
}

#pragma mark - lazy loading...
-(UITableView *)iTableView {
    if (!_iTableView) {
        _iTableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
        _iTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _iTableView.showsVerticalScrollIndicator = NO;
        _iTableView.showsHorizontalScrollIndicator = NO;
        _iTableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
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
            self.automaticallyAdjustsScrollViewInsets = NO;
        }
        _iTableView.backgroundColor = adaptAndDarkColor([UIColor colorWhite], [UIColor colorBlackBGDark]);
        _iTableView.delegate = self;
        _iTableView.dataSource = self;
        
    }
    return _iTableView;
}

- (UIButton *)navLeftBtn {
    if (!_navLeftBtn) {
        __weak typeof(self) weakSelf = self;
        _navLeftBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, CGFloatIn750(50), CGFloatIn750(50))];
        [_navLeftBtn setBackgroundColor:[UIColor colorGrayBG] forState:UIControlStateNormal];
        [_navLeftBtn setImage:[UIImage imageNamed:@"navleftBack"] forState:UIControlStateNormal];
        ViewRadius(_navLeftBtn, CGFloatIn750(25));
        [_navLeftBtn bk_whenTapped:^{
            [weakSelf.navigationController popViewControllerAnimated:YES];
        }];
    }
    return _navLeftBtn;
}

- (UIView *)topNavView {
    if (!_topNavView) {
        _topNavView = [[UIView alloc] init];
        _topNavView.backgroundColor = [UIColor colorMain];
        _topNavView.alpha = 0;
    }
    return _topNavView;
}

#pragma mark - tableView -------datasource-----
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _cellConfigArr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    __weak typeof(self) weakSelf = self;
    
    ZCellConfig *cellConfig = [_cellConfigArr objectAtIndex:indexPath.row];
    ZBaseCell *cell;
    cell = (ZBaseCell*)[cellConfig cellOfCellConfigWithTableView:tableView dataModel:cellConfig.dataModel];
//    ZOrganizationCampusManagementVC
   if ([cellConfig.title isEqualToString:@"ZOrganizationMenuCell"]){
       
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
//    ZCellConfig *cellConfig = [_cellConfigArr objectAtIndex:indexPath.row];
//    if ([cellConfig.title isEqualToString:@"ZStudentOrganizationLessonListCell"]) {
//        ZStudentOrganizationLessonDetailVC *lessond_vc = [[ZStudentOrganizationLessonDetailVC alloc] init];
//
//        [self.navigationController pushViewController:lessond_vc animated:YES];
//    }else if ([cellConfig.title isEqualToString:@"moreStarStudent"]){
//        ZStudentStarStudentListVC *lvc = [[ZStudentStarStudentListVC alloc] init];
//        [self.navigationController pushViewController:lvc animated:YES];
//    }else if ([cellConfig.title isEqualToString:@"moreStarCoach"]){
//        ZStudentStarCoachListVC *lvc = [[ZStudentStarCoachListVC alloc] init];
//        [self.navigationController pushViewController:lvc animated:YES];
//    }
}



#pragma mark - scrollview delegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    // 获取到tableView偏移量
    CGFloat Offset_y = scrollView.contentOffset.y;
    // 下拉 纵向偏移量变小 变成负的
   
    if (Offset_y > CGFloatIn750(420)) {
        self.topNavView.alpha = (Offset_y - CGFloatIn750(420))/CGFloatIn750(50);
    }else {
        self.topNavView.alpha = 0;
    }
}


#pragma mark - setDetailData
- (void)setCellData {
    [_cellConfigArr removeAllObjects];
    
    ZCellConfig *statisticsCellConfig = [ZCellConfig cellConfigWithClassName:[ZOrganizationLessonDetailHeaderCell className] title:[ZOrganizationLessonDetailHeaderCell className] showInfoMethod:nil heightOfCell:[ZOrganizationLessonDetailHeaderCell z_getCellHeight:nil] cellType:ZCellTypeClass dataModel:nil];
    [self.cellConfigArr addObject:statisticsCellConfig];
    
    ZCellConfig *priceCellConfig = [ZCellConfig cellConfigWithClassName:[ZOrganizationLessonDetailPriceCell className] title:[ZOrganizationLessonDetailPriceCell className] showInfoMethod:nil heightOfCell:[ZOrganizationLessonDetailPriceCell z_getCellHeight:nil] cellType:ZCellTypeClass dataModel:nil];
    [self.cellConfigArr addObject:priceCellConfig];
    
    {
        ZBaseSingleCellModel *model = [[ZBaseSingleCellModel alloc] init];
        model.leftTitle = @"多咪屋1号";
        model.rightTitle = @"才玩俱乐部";
        model.leftFont = [UIFont boldFontMax1Title];
        model.rightFont = [UIFont fontContent];
        
        ZCellConfig *menuCellConfig = [ZCellConfig cellConfigWithClassName:[ZSingleLineCell className] title:model.cellTitle showInfoMethod:@selector(setModel:) heightOfCell:[ZSingleLineCell z_getCellHeight:model] cellType:ZCellTypeClass dataModel:model];
        
        [self.cellConfigArr addObject:menuCellConfig];
    }
    
    {
        ZBaseSingleCellModel *model = [[ZBaseSingleCellModel alloc] init];
        model.leftTitle = @"我是过迷雾的全城";
        model.leftFont = [UIFont fontContent];
        
        ZCellConfig *menuCellConfig = [ZCellConfig cellConfigWithClassName:[ZSingleLineCell className] title:model.cellTitle showInfoMethod:@selector(setModel:) heightOfCell:[ZSingleLineCell z_getCellHeight:model] cellType:ZCellTypeClass dataModel:model];
        
        [self.cellConfigArr addObject:menuCellConfig];
    }
    
    
    {
        ZCellConfig *topCellConfig = [ZCellConfig cellConfigWithClassName:[ZSpaceEmptyCell className] title:[ZSpaceEmptyCell className] showInfoMethod:@selector(setBackColor:) heightOfCell:CGFloatIn750(20) cellType:ZCellTypeClass dataModel:adaptAndDarkColor([UIColor colorWhite], [UIColor colorBlackBGDark])];
        [_cellConfigArr addObject:topCellConfig];
        
        ZBaseSingleCellModel *model = [[ZBaseSingleCellModel alloc] init];
        model.leftTitle = @"单节课时";
        model.leftFont = [UIFont boldFontContent];
        model.cellHeight = CGFloatIn750(40);
        model.isHiddenLine = YES;
        
        ZCellConfig *menuCellConfig = [ZCellConfig cellConfigWithClassName:[ZSingleLineCell className] title:model.cellTitle showInfoMethod:@selector(setModel:) heightOfCell:[ZSingleLineCell z_getCellHeight:model] cellType:ZCellTypeClass dataModel:model];
        [self.cellConfigArr addObject:menuCellConfig];
        
        ZBaseSingleCellModel *model1 = [[ZBaseSingleCellModel alloc] init];
        model1.leftTitle = @"3小时/节";
        model1.leftFont = [UIFont fontContent];
        model.cellHeight = CGFloatIn750(40);
        model.isHiddenLine = YES;
        
        ZCellConfig *menu1CellConfig = [ZCellConfig cellConfigWithClassName:[ZSingleLineCell className] title:model1.cellTitle showInfoMethod:@selector(setModel:) heightOfCell:[ZSingleLineCell z_getCellHeight:model1] cellType:ZCellTypeClass dataModel:model1];
        [self.cellConfigArr addObject:menu1CellConfig];
        
        ZCellConfig *bottomCellConfig = [ZCellConfig cellConfigWithClassName:[ZSpaceEmptyCell className] title:[ZSpaceEmptyCell className] showInfoMethod:@selector(setBackColor:) heightOfCell:CGFloatIn750(20) cellType:ZCellTypeClass dataModel:adaptAndDarkColor([UIColor colorWhite], [UIColor colorBlackBGDark])];
        [_cellConfigArr addObject:bottomCellConfig];
    }
    
    {
        ZBaseSingleCellModel *model = [[ZBaseSingleCellModel alloc] init];
        model.cellHeight = CGFloatIn750(2);
        model.lineLeftMargin = CGFloatIn750(30);
        model.lineRightMargin = CGFloatIn750(30);
        model.isHiddenLine = NO;
        
        ZCellConfig *menuCellConfig = [ZCellConfig cellConfigWithClassName:[ZSingleLineCell className] title:model.cellTitle showInfoMethod:@selector(setModel:) heightOfCell:[ZSingleLineCell z_getCellHeight:model] cellType:ZCellTypeClass dataModel:model];
        [self.cellConfigArr addObject:menuCellConfig];
    }
        
    {
        ZCellConfig *topCellConfig = [ZCellConfig cellConfigWithClassName:[ZSpaceEmptyCell className] title:[ZSpaceEmptyCell className] showInfoMethod:@selector(setBackColor:) heightOfCell:CGFloatIn750(20) cellType:ZCellTypeClass dataModel:adaptAndDarkColor([UIColor colorWhite], [UIColor colorBlackBGDark])];
        [_cellConfigArr addObject:topCellConfig];
        
        ZBaseSingleCellModel *model = [[ZBaseSingleCellModel alloc] init];
        model.leftTitle = @"课程节数";
        model.leftFont = [UIFont boldFontContent];
        model.cellHeight = CGFloatIn750(40);
        model.isHiddenLine = YES;
        
        ZCellConfig *menuCellConfig = [ZCellConfig cellConfigWithClassName:[ZSingleLineCell className] title:model.cellTitle showInfoMethod:@selector(setModel:) heightOfCell:[ZSingleLineCell z_getCellHeight:model] cellType:ZCellTypeClass dataModel:model];
        [self.cellConfigArr addObject:menuCellConfig];
        
        ZBaseSingleCellModel *model1 = [[ZBaseSingleCellModel alloc] init];
        model1.leftTitle = @"24节";
        model1.leftFont = [UIFont fontContent];
        model.cellHeight = CGFloatIn750(40);
        model.isHiddenLine = YES;
        
        ZCellConfig *menu1CellConfig = [ZCellConfig cellConfigWithClassName:[ZSingleLineCell className] title:model1.cellTitle showInfoMethod:@selector(setModel:) heightOfCell:[ZSingleLineCell z_getCellHeight:model1] cellType:ZCellTypeClass dataModel:model1];
        [self.cellConfigArr addObject:menu1CellConfig];
        
        ZCellConfig *bottomCellConfig = [ZCellConfig cellConfigWithClassName:[ZSpaceEmptyCell className] title:[ZSpaceEmptyCell className] showInfoMethod:@selector(setBackColor:) heightOfCell:CGFloatIn750(20) cellType:ZCellTypeClass dataModel:adaptAndDarkColor([UIColor colorWhite], [UIColor colorBlackBGDark])];
        [_cellConfigArr addObject:bottomCellConfig];
    }
    {
        ZBaseSingleCellModel *model = [[ZBaseSingleCellModel alloc] init];
        model.cellHeight = CGFloatIn750(2);
        model.lineLeftMargin = CGFloatIn750(30);
        model.lineRightMargin = CGFloatIn750(30);
        model.isHiddenLine = NO;
        
        ZCellConfig *menuCellConfig = [ZCellConfig cellConfigWithClassName:[ZSingleLineCell className] title:model.cellTitle showInfoMethod:@selector(setModel:) heightOfCell:[ZSingleLineCell z_getCellHeight:model] cellType:ZCellTypeClass dataModel:model];
        [self.cellConfigArr addObject:menuCellConfig];
    }
    
    {
        ZBaseSingleCellModel *model = [[ZBaseSingleCellModel alloc] init];
        model.cellHeight = CGFloatIn750(80);
        model.isHiddenLine = YES;
        model.leftTitle = @"课程详情";
        model.leftFont = [UIFont boldFontContent];
        
        ZCellConfig *menuCellConfig = [ZCellConfig cellConfigWithClassName:[ZSingleLineCell className] title:model.cellTitle showInfoMethod:@selector(setModel:) heightOfCell:[ZSingleLineCell z_getCellHeight:model] cellType:ZCellTypeClass dataModel:model];
        [self.cellConfigArr addObject:menuCellConfig];
    }
    
    {
        ZBaseSingleCellModel *model = [[ZBaseSingleCellModel alloc] init];
        model.cellHeight = CGFloatIn750(80);
        model.isHiddenLine = YES;
        model.leftTitle = @"购买须知";
        model.leftFont = [UIFont fontSmall];
        model.isHiddenLine = NO;
        model.lineLeftMargin = CGFloatIn750(30);
        model.lineLeftMargin = CGFloatIn750(30);
        
        ZCellConfig *menuCellConfig = [ZCellConfig cellConfigWithClassName:[ZSingleLineCell className] title:model.cellTitle showInfoMethod:@selector(setModel:) heightOfCell:[ZSingleLineCell z_getCellHeight:model] cellType:ZCellTypeClass dataModel:model];
        [self.cellConfigArr addObject:menuCellConfig];
    }
    
    {
        ZBaseSingleCellModel *model = [[ZBaseSingleCellModel alloc] init];
        model.cellHeight = CGFloatIn750(80);
        model.isHiddenLine = YES;
        model.leftTitle = @"接受课程预约";
        model.leftFont = [UIFont boldFontContent];
        
        ZCellConfig *menuCellConfig = [ZCellConfig cellConfigWithClassName:[ZSingleLineCell className] title:model.cellTitle showInfoMethod:@selector(setModel:) heightOfCell:[ZSingleLineCell z_getCellHeight:model] cellType:ZCellTypeClass dataModel:model];
        [self.cellConfigArr addObject:menuCellConfig];
        
        NSArray *titleArr = @[@"体验课价格：￥89",@"单节体验时长：60分钟",@"可体验时间段：00:00 -24:00"];
        for (int i = 0; i < titleArr.count; i++) {
            ZBaseSingleCellModel *model = [[ZBaseSingleCellModel alloc] init];
            model.cellHeight = CGFloatIn750(80);
            model.isHiddenLine = YES;
            model.leftTitle = @"购买须知";
            model.leftFont = [UIFont fontSmall];
            
            ZCellConfig *menuCellConfig = [ZCellConfig cellConfigWithClassName:[ZSingleLineCell className] title:model.cellTitle showInfoMethod:@selector(setModel:) heightOfCell:[ZSingleLineCell z_getCellHeight:model] cellType:ZCellTypeClass dataModel:model];
            [self.cellConfigArr addObject:menuCellConfig];
        }
    }
    
    {
        ZBaseSingleCellModel *model = [[ZBaseSingleCellModel alloc] init];
        model.cellHeight = CGFloatIn750(2);
        model.lineLeftMargin = CGFloatIn750(30);
        model.lineRightMargin = CGFloatIn750(30);
        model.isHiddenLine = NO;
        
        ZCellConfig *menuCellConfig = [ZCellConfig cellConfigWithClassName:[ZSingleLineCell className] title:model.cellTitle showInfoMethod:@selector(setModel:) heightOfCell:[ZSingleLineCell z_getCellHeight:model] cellType:ZCellTypeClass dataModel:model];
        [self.cellConfigArr addObject:menuCellConfig];
    }
    
    {
        ZCellConfig *topCellConfig = [ZCellConfig cellConfigWithClassName:[ZSpaceEmptyCell className] title:[ZSpaceEmptyCell className] showInfoMethod:@selector(setBackColor:) heightOfCell:CGFloatIn750(20) cellType:ZCellTypeClass dataModel:adaptAndDarkColor([UIColor colorWhite], [UIColor colorBlackBGDark])];
        [_cellConfigArr addObject:topCellConfig];
        
        ZBaseSingleCellModel *model = [[ZBaseSingleCellModel alloc] init];
        model.leftTitle = @"课程有效期";
        model.leftFont = [UIFont boldFontContent];
        model.cellHeight = CGFloatIn750(40);
        model.isHiddenLine = YES;
        
        ZCellConfig *menuCellConfig = [ZCellConfig cellConfigWithClassName:[ZSingleLineCell className] title:model.cellTitle showInfoMethod:@selector(setModel:) heightOfCell:[ZSingleLineCell z_getCellHeight:model] cellType:ZCellTypeClass dataModel:model];
        [self.cellConfigArr addObject:menuCellConfig];
        
        ZBaseSingleCellModel *model1 = [[ZBaseSingleCellModel alloc] init];
        model1.leftTitle = @"1年";
        model1.leftFont = [UIFont fontContent];
        model.cellHeight = CGFloatIn750(40);
        model.isHiddenLine = YES;
        
        ZCellConfig *menu1CellConfig = [ZCellConfig cellConfigWithClassName:[ZSingleLineCell className] title:model1.cellTitle showInfoMethod:@selector(setModel:) heightOfCell:[ZSingleLineCell z_getCellHeight:model1] cellType:ZCellTypeClass dataModel:model1];
        [self.cellConfigArr addObject:menu1CellConfig];
        
        ZCellConfig *bottomCellConfig = [ZCellConfig cellConfigWithClassName:[ZSpaceEmptyCell className] title:[ZSpaceEmptyCell className] showInfoMethod:@selector(setBackColor:) heightOfCell:CGFloatIn750(20) cellType:ZCellTypeClass dataModel:adaptAndDarkColor([UIColor colorWhite], [UIColor colorBlackBGDark])];
        [_cellConfigArr addObject:bottomCellConfig];
    }
    {
        ZBaseSingleCellModel *model = [[ZBaseSingleCellModel alloc] init];
        model.cellHeight = CGFloatIn750(2);
        model.lineLeftMargin = CGFloatIn750(30);
        model.lineRightMargin = CGFloatIn750(30);
        model.isHiddenLine = NO;
        
        ZCellConfig *menuCellConfig = [ZCellConfig cellConfigWithClassName:[ZSingleLineCell className] title:model.cellTitle showInfoMethod:@selector(setModel:) heightOfCell:[ZSingleLineCell z_getCellHeight:model] cellType:ZCellTypeClass dataModel:model];
        [self.cellConfigArr addObject:menuCellConfig];
    }
    
    {
        ZCellConfig *topCellConfig = [ZCellConfig cellConfigWithClassName:[ZSpaceEmptyCell className] title:[ZSpaceEmptyCell className] showInfoMethod:@selector(setBackColor:) heightOfCell:CGFloatIn750(20) cellType:ZCellTypeClass dataModel:adaptAndDarkColor([UIColor colorWhite], [UIColor colorBlackBGDark])];
        [_cellConfigArr addObject:topCellConfig];
        
        ZBaseSingleCellModel *model = [[ZBaseSingleCellModel alloc] init];
        model.leftTitle = @"人满开课";
        model.leftFont = [UIFont boldFontContent];
        model.cellHeight = CGFloatIn750(40);
        model.isHiddenLine = YES;
        
        ZCellConfig *menuCellConfig = [ZCellConfig cellConfigWithClassName:[ZSingleLineCell className] title:model.cellTitle showInfoMethod:@selector(setModel:) heightOfCell:[ZSingleLineCell z_getCellHeight:model] cellType:ZCellTypeClass dataModel:model];
        [self.cellConfigArr addObject:menuCellConfig];

        
        ZCellConfig *bottomCellConfig = [ZCellConfig cellConfigWithClassName:[ZSpaceEmptyCell className] title:[ZSpaceEmptyCell className] showInfoMethod:@selector(setBackColor:) heightOfCell:CGFloatIn750(20) cellType:ZCellTypeClass dataModel:adaptAndDarkColor([UIColor colorWhite], [UIColor colorBlackBGDark])];
        [_cellConfigArr addObject:bottomCellConfig];
    }
    {
        ZBaseSingleCellModel *model = [[ZBaseSingleCellModel alloc] init];
        model.cellHeight = CGFloatIn750(2);
        model.lineLeftMargin = CGFloatIn750(30);
        model.lineRightMargin = CGFloatIn750(30);
        model.isHiddenLine = NO;
        
        ZCellConfig *menuCellConfig = [ZCellConfig cellConfigWithClassName:[ZSingleLineCell className] title:model.cellTitle showInfoMethod:@selector(setModel:) heightOfCell:[ZSingleLineCell z_getCellHeight:model] cellType:ZCellTypeClass dataModel:model];
        [self.cellConfigArr addObject:menuCellConfig];
    }
    
    {
        ZCellConfig *topCellConfig = [ZCellConfig cellConfigWithClassName:[ZSpaceEmptyCell className] title:[ZSpaceEmptyCell className] showInfoMethod:@selector(setBackColor:) heightOfCell:CGFloatIn750(20) cellType:ZCellTypeClass dataModel:adaptAndDarkColor([UIColor colorWhite], [UIColor colorBlackBGDark])];
        [_cellConfigArr addObject:topCellConfig];
        
        ZBaseSingleCellModel *model = [[ZBaseSingleCellModel alloc] init];
        model.leftTitle = @"固定开课时间";
        model.leftFont = [UIFont boldFontContent];
        model.cellHeight = CGFloatIn750(40);
        model.isHiddenLine = YES;
        
        ZCellConfig *menuCellConfig = [ZCellConfig cellConfigWithClassName:[ZSingleLineCell className] title:model.cellTitle showInfoMethod:@selector(setModel:) heightOfCell:[ZSingleLineCell z_getCellHeight:model] cellType:ZCellTypeClass dataModel:model];
        [self.cellConfigArr addObject:menuCellConfig];
        
        ZBaseSingleCellModel *model1 = [[ZBaseSingleCellModel alloc] init];
        model1.leftTitle = @"24节";
        model1.leftFont = [UIFont fontContent];
        model.cellHeight = CGFloatIn750(40);
        model.isHiddenLine = YES;
        
        ZCellConfig *menu1CellConfig = [ZCellConfig cellConfigWithClassName:[ZSingleLineCell className] title:model1.cellTitle showInfoMethod:@selector(setModel:) heightOfCell:[ZSingleLineCell z_getCellHeight:model1] cellType:ZCellTypeClass dataModel:model1];
        [self.cellConfigArr addObject:menu1CellConfig];
        
        ZCellConfig *bottomCellConfig = [ZCellConfig cellConfigWithClassName:[ZSpaceEmptyCell className] title:[ZSpaceEmptyCell className] showInfoMethod:@selector(setBackColor:) heightOfCell:CGFloatIn750(20) cellType:ZCellTypeClass dataModel:adaptAndDarkColor([UIColor colorWhite], [UIColor colorBlackBGDark])];
        [_cellConfigArr addObject:bottomCellConfig];
    }
    {
        ZBaseSingleCellModel *model = [[ZBaseSingleCellModel alloc] init];
        model.cellHeight = CGFloatIn750(2);
        model.lineLeftMargin = CGFloatIn750(30);
        model.lineRightMargin = CGFloatIn750(30);
        model.isHiddenLine = NO;
        
        ZCellConfig *menuCellConfig = [ZCellConfig cellConfigWithClassName:[ZSingleLineCell className] title:model.cellTitle showInfoMethod:@selector(setModel:) heightOfCell:[ZSingleLineCell z_getCellHeight:model] cellType:ZCellTypeClass dataModel:model];
        [self.cellConfigArr addObject:menuCellConfig];
    }
    [self.iTableView reloadData];
}
@end









