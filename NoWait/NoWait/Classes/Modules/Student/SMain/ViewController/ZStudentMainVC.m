//
//  ZStudentMainVC.m
//  NoWait
//
//  Created by zhuang zhang on 2020/1/3.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZStudentMainVC.h"
#import "ZStudentMainTopSearchView.h"

#import "ZStudentBannerCell.h"
#import "ZStudentMainEnteryCell.h"
#import "ZStudentMainPhotoWallCell.h"

#define KSearchTopViewHeight  CGFloatIn750(88)

@interface ZStudentMainVC ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic,strong) UITableView *iTableView;
@property (nonatomic,strong) ZStudentMainTopSearchView *searchView;

@property (nonatomic,strong) NSMutableArray *cellConfigArr;
@property (nonatomic,strong) NSMutableArray *enteryArr;
@property (nonatomic,strong) NSMutableArray *photoWallArr;

@end

@implementation ZStudentMainVC

- (id)init
{
    if (self = [super init]) {
        initTabBarItem(self.tabBarItem, LOCSTR(@"首页"), @"record_normal", @"record_highlighted");
        self.analyzeTitle = @"首页";
    }
    return self;
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
}


- (void)setData {
    _cellConfigArr = @[].mutableCopy;
    _enteryArr = @[].mutableCopy;
    _photoWallArr = @[].mutableCopy;
    
    NSArray *entryArr = @[@[@"体育竞技",@"studentMainSports"],@[@"艺术舞蹈",@"studentMainArt"],@[@"兴趣爱好",@"studentMainHobby"],@[@"其他",@"studentMainMore"],@[@"体育竞技",@"studentMainSports"],@[@"艺术舞蹈",@"studentMainArt"],@[@"兴趣爱好",@"studentMainHobby"],@[@"其他",@"studentMainMore"]];
    
    for (int i = 0; i < entryArr.count; i++) {
        ZStudentEnteryItemModel *model = [[ZStudentEnteryItemModel alloc] init];
        model.imageName = entryArr[i][1];
        model.name = entryArr[i][0];
        [_enteryArr addObject:model];
        
    }
    
    for (int i = 0; i < 2; i++) {
        ZStudentPhotoWallItemModel *photoWallModel = [[ZStudentPhotoWallItemModel alloc] init];
        photoWallModel.imageName = @"serverTopbg";
        [_photoWallArr addObject:photoWallModel];
    }
    
    [self resetData];
}


- (void)resetData {
    [_cellConfigArr removeAllObjects];
    
    ZCellConfig *topCellConfig = [ZCellConfig cellConfigWithClassName:[ZStudentBannerCell className] title:@"ZStudentBannerCell" showInfoMethod:nil heightOfCell:[ZStudentBannerCell z_getCellHeight:nil] cellType:ZCellTypeClass dataModel:nil];
    [self.cellConfigArr addObject:topCellConfig];
    
    ZCellConfig *enteryCellConfig = [ZCellConfig cellConfigWithClassName:[ZStudentMainEnteryCell className] title:@"ZStudentMainEnteryCell" showInfoMethod:@selector(setChannelList:) heightOfCell:[ZStudentMainEnteryCell z_getCellHeight:nil] cellType:ZCellTypeClass dataModel:_enteryArr];
    [self.cellConfigArr addObject:enteryCellConfig];
    
    ZCellConfig *photoWallCellConfig = [ZCellConfig cellConfigWithClassName:[ZStudentMainPhotoWallCell className] title:@"ZStudentMainPhotoWallCell" showInfoMethod:@selector(setChannelList:) heightOfCell:[ZStudentMainPhotoWallCell z_getCellHeight:_photoWallArr] cellType:ZCellTypeClass dataModel:_photoWallArr];
    [self.cellConfigArr addObject:photoWallCellConfig];
    
    
}

- (void)setupMainView {
    self.view.backgroundColor = KWhiteColor;
    
    [self.view addSubview:self.searchView];
    [self.searchView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(self.view);
        make.height.mas_equalTo(KSearchTopViewHeight + kStatusBarHeight);
    }];
    
    
    [self.view addSubview:self.iTableView];
    [self.iTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.searchView.mas_bottom).offset(1);
        make.left.right.equalTo(self.view);
        make.bottom.equalTo(self.view.mas_bottom).offset(-kTabBarHeight);
    }];
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

- (ZStudentMainTopSearchView *)searchView {
    if (!_searchView) {
//        __weak typeof(self) weakSelf = self;
        _searchView = [[ZStudentMainTopSearchView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, KSearchTopViewHeight+kStatusBarHeight)];
    }
    return _searchView;
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
    
}



#pragma mark - scrollview delegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    // 获取到tableView偏移量
    CGFloat Offset_y = scrollView.contentOffset.y;
    // 下拉 纵向偏移量变小 变成负的
   
    [self.searchView updateWithOffset:Offset_y];
}
@end
