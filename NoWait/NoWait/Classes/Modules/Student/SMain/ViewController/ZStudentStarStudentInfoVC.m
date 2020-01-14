//
//  ZStudentStarStudentInfoVC.m
//  NoWait
//
//  Created by zhuang zhang on 2020/1/13.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZStudentStarStudentInfoVC.h"
#import "ZStudentDetailModel.h"

#import "ZStudentStarDetailHeadView.h"
#import "ZStudentStarDetailNav.h"

#import "ZBaseCell.h"
#import "ZStudentStarStudentInfoCell.h"
#import "ZStudentStarStudentSectionTitleCell.h"
#import "ZStudentLessonDetailLessonListCell.h"
#import "ZStudentStarInfoImageCell.h"
#import "ZSpaceEmptyCell.h"

#define kHeaderHeight (CGFloatIn750(418)+kTopHeight)

@interface ZStudentStarStudentInfoVC ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic,strong) UITableView *iTableView;
@property (nonatomic,strong) ZStudentStarDetailHeadView *headerView;
@property (nonatomic,strong) ZStudentStarDetailNav *navgationView;

@property (nonatomic,strong) NSMutableArray *cellConfigArr;

@end

@implementation ZStudentStarStudentInfoVC

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.isHidenNaviBar = YES;
    

    [self.navigationController setNavigationBarHidden:YES animated:YES];
}


- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setData];
    [self setupMainView];
    
    [self initCellConfigArr];
}


- (void)setData {
    _cellConfigArr = @[].mutableCopy;
}


- (void)setupMainView {
    self.view.backgroundColor = KWhiteColor;

    [self.view addSubview:self.navgationView];
    [self.navgationView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(self.view);
        make.height.mas_equalTo(kTopHeight);
    }];
    
    [self.view addSubview:self.iTableView];
    
    [self.iTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.navgationView.mas_top);
        make.left.right.equalTo(self.view);
        make.bottom.equalTo(self.view.mas_bottom).offset(-0);
    }];
    
    [self.view bringSubviewToFront:self.navgationView];
    
    [self.iTableView setContentInset:UIEdgeInsetsMake(kHeaderHeight+kStatusBarHeight, 0, 0, 0)];
    [self.iTableView addSubview:self.headerView];
}

#pragma mark - lazy loading...
-(UITableView *)iTableView {
    if (!_iTableView) {
        _iTableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
        _iTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
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
        _iTableView.backgroundColor = KBackColor;
        _iTableView.delegate = self;
        _iTableView.dataSource = self;
        
    }
    return _iTableView;
}

- (ZStudentStarDetailHeadView *)headerView {
    if (!_headerView) {
//        __weak typeof(self) weakSelf = self;
        _headerView = [[ZStudentStarDetailHeadView alloc] initWithFrame:CGRectMake(0, -kHeaderHeight-kStatusBarHeight, KScreenWidth, kHeaderHeight+kStatusBarHeight)];
    }
    return _headerView;
}

- (ZStudentStarDetailNav *)navgationView {
    if (!_navgationView) {
        __weak typeof(self) weakSelf = self;
        _navgationView = [[ZStudentStarDetailNav alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, kTopHeight)];
        _navgationView.backBlock = ^(NSInteger index) {
            [weakSelf.navigationController popViewControllerAnimated:YES];
        };
    }
    
    return _navgationView;
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
    if ([cellConfig.title isEqualToString:@"ZSpaceCell"]) {
        
    }
}



#pragma mark - scrollview delegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    // 获取到tableView偏移量
    CGFloat Offset_y = scrollView.contentOffset.y;
    // 下拉 纵向偏移量变小 变成负的
    if ( Offset_y < -(kTopHeight)) {
    // 拉伸后图片的高度
    CGFloat totalOffset = - Offset_y;
    // 拉伸后图片位置
    _headerView.frame = CGRectMake(0, Offset_y, KScreenWidth, totalOffset);
    }else{
      _headerView.frame = CGRectMake(0, Offset_y, KScreenWidth, kTopHeight);
    }
    
    [_headerView updateSubViewFrame];
}


#pragma mark - 设置数据

- (void)initCellConfigArr {
    [self.cellConfigArr removeAllObjects];
    
    ZCellConfig *infoCellConfig = [ZCellConfig cellConfigWithClassName:[ZStudentStarStudentInfoCell  className] title:[ZStudentStarStudentInfoCell className] showInfoMethod:nil heightOfCell:[ZStudentStarStudentInfoCell z_getCellHeight:nil] cellType:ZCellTypeClass dataModel:nil];
    [self.cellConfigArr addObject:infoCellConfig];
    
    ZCellConfig *spacCellConfig = [ZCellConfig cellConfigWithClassName:[ZSpaceEmptyCell className] title:[ZSpaceEmptyCell className] showInfoMethod:@selector(setBackColor:) heightOfCell:CGFloatIn750(40) cellType:ZCellTypeClass dataModel:KBackColor];
    [self.cellConfigArr addObject:spacCellConfig];
    
    ZCellConfig *title1CellConfig = [ZCellConfig cellConfigWithClassName:[ZStudentStarStudentSectionTitleCell className] title:[ZStudentStarStudentSectionTitleCell className] showInfoMethod:@selector(setTitle:) heightOfCell:[ZStudentStarStudentSectionTitleCell z_getCellHeight:nil] cellType:ZCellTypeClass dataModel:@"学习履历"];
    [self.cellConfigArr addObject:title1CellConfig];
    
    NSMutableArray *list = @[].mutableCopy;
    NSArray *des = @[@"18年报名学习了瑜伽课程，并需取得了优异成绩",@"从业8年，技术精湛，为人和善，得过不少大奖，任驰骋，苏苏苏",@"参加比赛，国际荣誉无数"];
    for (int i = 0; i < des.count; i++) {
        ZStudentDetailDesListModel *model = [[ZStudentDetailDesListModel alloc] init];
        model.desSub = des[i];
        [list addObject:model];
    }
    
    ZCellConfig *lessonDesCellConfig = [ZCellConfig cellConfigWithClassName:[ZStudentLessonDetailLessonListCell className] title:[ZStudentLessonDetailLessonListCell className] showInfoMethod:@selector(setList:) heightOfCell:[ZStudentLessonDetailLessonListCell z_getCellHeight:list] cellType:ZCellTypeClass dataModel:list];
    [_cellConfigArr addObject:lessonDesCellConfig];
    
    
    ZCellConfig *spac1CellConfig = [ZCellConfig cellConfigWithClassName:[ZSpaceEmptyCell className] title:[ZSpaceEmptyCell className] showInfoMethod:@selector(setBackColor:) heightOfCell:CGFloatIn750(40) cellType:ZCellTypeClass dataModel:KBackColor];
    [self.cellConfigArr addObject:spac1CellConfig];
    
    ZCellConfig *title2CellConfig = [ZCellConfig cellConfigWithClassName:[ZStudentStarStudentSectionTitleCell className] title:[ZStudentStarStudentSectionTitleCell className] showInfoMethod:@selector(setTitle:) heightOfCell:[ZStudentStarStudentSectionTitleCell z_getCellHeight:nil] cellType:ZCellTypeClass dataModel:@"练习相册"];
    [self.cellConfigArr addObject:title2CellConfig];
    
    for (int i = 0; i < 18; i++) {
       ZStudentDetailContentListModel *model = [[ZStudentDetailContentListModel alloc] init];
       model.image = [NSString stringWithFormat:@"studentDetailInfo%u",arc4random_uniform(5)];
       ZCellConfig *lessonCellConfig = [ZCellConfig cellConfigWithClassName:[ZStudentStarInfoImageCell className] title:[ZStudentStarInfoImageCell className] showInfoMethod:@selector(setModel:) heightOfCell:[ZStudentStarInfoImageCell z_getCellHeight:nil] cellType:ZCellTypeClass dataModel:model];
       [self.cellConfigArr addObject:lessonCellConfig];
   }
    [self.iTableView reloadData];
}
@end

