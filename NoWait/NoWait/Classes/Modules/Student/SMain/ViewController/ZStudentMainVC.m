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
#import "ZStudentMainOrganizationListCell.h"
#import "ZStudentMainFiltrateSectionView.h"

#import "ZStudentOrganizationDetailVC.h"
#import "ZStudentOrganizationDetailDesVC.h"
#import "ZStudentClassificationListVC.h"

#import "ZPhoneAlertView.h"
#import "ZServerCompleteAlertView.h"
#import "ZAlertUpdateAppView.h"
#import "ZAlertView.h"
#import "ZAlertImageView.h"

#define KSearchTopViewHeight  CGFloatIn750(88)

@interface ZStudentMainVC ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic,strong) ZStudentMainTopSearchView *searchView;
@property (nonatomic,strong) ZStudentMainFiltrateSectionView *sectionView;

@property (nonatomic,strong) NSMutableArray *enteryArr;
@property (nonatomic,strong) NSMutableArray *photoWallArr;

@end

@implementation ZStudentMainVC

- (id)init
{
    if (self = [super init]) {
        initTabBarItem(self.tabBarItem, LOCSTR(@"首页"), @"tabBarMain", @"tabBarMain_highlighted");
        self.analyzeTitle = @"首页";
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.isHidenNaviBar = YES;
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initCellConfigArr];
}

- (void)setDataSource {
    [super setDataSource];
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
        if (i == 0) {
            photoWallModel.imageName = @"http://wx3.sinaimg.cn/mw600/0076BSS5ly1gclaeqajz8j30u00u0wjk.jpg";
        }else{
            photoWallModel.imageName = @"http://wx3.sinaimg.cn/mw600/0076BSS5ly1gcla1o85kjj30u011in4r.jpg";
        }
        [_photoWallArr addObject:photoWallModel];
    }
}

- (void)initCellConfigArr {
    [super initCellConfigArr];
    
    NSMutableArray *sectionArr = @[].mutableCopy;
    ZStudentBannerModel *model = [[ZStudentBannerModel alloc] init];
    model.image = @"http://wx4.sinaimg.cn/mw600/0076BSS5ly1gck7hzkurrj30zk0lfai4.jpg";
    ZCellConfig *topCellConfig = [ZCellConfig cellConfigWithClassName:[ZStudentBannerCell className] title:@"ZStudentBannerCell" showInfoMethod:@selector(setList:) heightOfCell:[ZStudentBannerCell z_getCellHeight:nil] cellType:ZCellTypeClass dataModel:@[model,model]];
    [sectionArr addObject:topCellConfig];
    
    ZCellConfig *enteryCellConfig = [ZCellConfig cellConfigWithClassName:[ZStudentMainEnteryCell className] title:@"ZStudentMainEnteryCell" showInfoMethod:@selector(setChannelList:) heightOfCell:[ZStudentMainEnteryCell z_getCellHeight:nil] cellType:ZCellTypeClass dataModel:_enteryArr];
    [sectionArr addObject:enteryCellConfig];
    
    ZCellConfig *photoWallCellConfig = [ZCellConfig cellConfigWithClassName:[ZStudentMainPhotoWallCell className] title:@"ZStudentMainPhotoWallCell" showInfoMethod:@selector(setChannelList:) heightOfCell:[ZStudentMainPhotoWallCell z_getCellHeight:_photoWallArr] cellType:ZCellTypeClass dataModel:_photoWallArr];
    [sectionArr addObject:photoWallCellConfig];
    
    [self.cellConfigArr addObject:sectionArr];
    
    NSMutableArray *section1Arr = @[].mutableCopy;
    
    
    for (int i = 0; i < 10; i++) {
        ZStudentOrganizationListModel *model = [[ZStudentOrganizationListModel alloc] init];
        if (i%5 == 0) {
            model.image = @"http://wx2.sinaimg.cn/mw600/0076BSS5ly1gcl9l56hc7j30xc0m8gol.jpg";
        }else if ( i%5 == 1){
            model.image = @"http://wx4.sinaimg.cn/mw600/0076BSS5ly1gcl9enz0bcj318y0u0h0v.jpg";
        }else if ( i%5 == 2){
            model.image = @"http://wx4.sinaimg.cn/mw600/0076BSS5ly1gcl90ruhzpj30u011i44s.jpg";
        }else if ( i%5 == 3){
            model.image = @"http://wx1.sinaimg.cn/mw600/0076BSS5ly1gcl8kmicgrj318y0u0ae4.jpg";
        }else{
            model.image = @"http://wx1.sinaimg.cn/mw600/0076BSS5ly1gcl8abyp14j30u011g0yz.jpg";
                
        }
        
        ZCellConfig *orCellCon1fig = [ZCellConfig cellConfigWithClassName:[ZStudentMainOrganizationListCell className] title:@"ZStudentMainOrganizationListCell" showInfoMethod:@selector(setModel:) heightOfCell:[ZStudentMainOrganizationListCell z_getCellHeight:nil] cellType:ZCellTypeClass dataModel:model];
        [section1Arr addObject:orCellCon1fig];
    }
    [self.cellConfigArr addObject:section1Arr];
}

- (void)setupMainView {
    [super setupMainView];
    
    [self.view addSubview:self.searchView];
    [self.searchView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(self.view);
        make.height.mas_equalTo(KSearchTopViewHeight + kStatusBarHeight);
    }];
    
    [self.iTableView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.searchView.mas_bottom).offset(1);
        make.left.right.equalTo(self.view);
        make.bottom.equalTo(self.view.mas_bottom).offset(-kTabBarHeight);
    }];
}

#pragma mark - lazy loading
- (ZStudentMainTopSearchView *)searchView {
    if (!_searchView) {
//        __weak typeof(self) weakSelf = self;
        _searchView = [[ZStudentMainTopSearchView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, KSearchTopViewHeight+kStatusBarHeight)];
    }
    return _searchView;
}

- (ZStudentMainFiltrateSectionView *)sectionView {
    if (!_sectionView) {
        __weak typeof(self) weakSelf = self;
        _sectionView = [[ZStudentMainFiltrateSectionView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, CGFloatIn750(88))];
        _sectionView.backgroundColor = adaptAndDarkColor([UIColor colorWhite], [UIColor colorGrayLine]);
        _sectionView.titleSelect = ^(NSInteger index) {
            if (weakSelf.iTableView.contentOffset.y < [ZStudentBannerCell z_getCellHeight:nil] + [ZStudentMainEnteryCell z_getCellHeight:self.enteryArr] + [ZStudentMainPhotoWallCell z_getCellHeight:self.photoWallArr]) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [weakSelf.iTableView setContentOffset:CGPointMake(0, [ZStudentBannerCell z_getCellHeight:nil] + [ZStudentMainEnteryCell z_getCellHeight:weakSelf.enteryArr] + [ZStudentMainPhotoWallCell z_getCellHeight:weakSelf.photoWallArr]) animated:YES];
                });
                
            }
        };
    }
    return _sectionView;
}

#pragma mark - tableView -------datasource-----
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.cellConfigArr.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSArray *tempArr = self.cellConfigArr[section];
    return tempArr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ZCellConfig *cellConfig = [self.cellConfigArr[indexPath.section] objectAtIndex:indexPath.row];
    ZBaseCell *cell;
    __weak typeof(self) weakSelf = self;
    cell = (ZBaseCell*)[cellConfig cellOfCellConfigWithTableView:tableView dataModel:cellConfig.dataModel];
    if ([cellConfig.title isEqualToString:@"ZStudentMainEnteryCell"]) {
        ZStudentMainEnteryCell *lcell = (ZStudentMainEnteryCell *)cell;
        lcell.menuBlock = ^(ZStudentEnteryItemModel * model) {
            ZStudentClassificationListVC *lvc = [[ZStudentClassificationListVC alloc] init];
            lvc.vcTitle = @"舞蹈分类";
            [weakSelf.navigationController pushViewController:lvc animated:YES];
        };
    }

    return cell;
}

#pragma mark tableView ------delegate-----
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSArray *tempArr = self.cellConfigArr[indexPath.section];
    ZCellConfig *cellConfig = tempArr[indexPath.row];
    CGFloat cellHeight =  cellConfig.heightOfCell;
    return cellHeight;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 1) {
        return CGFloatIn750(88);
    }
    return 0.01f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01f;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section) {
        return self.sectionView;
    }
    return nil;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    [ZAlertImageView setAlertWithType:ZAlertTypeRepealSubscribeFail handlerBlock:^(NSInteger index) {
//        
//    }];
//
//    return;
//    [ZPhoneAlertView setAlertName:@"哈哈哈" detail:@"十多个哈啊烦得很" headImage:@"coachSelect1" tel:@"1882111232" handlerBlock:^(NSInteger index) {
//
//    }];
//    return;
//    [ZServerCompleteAlertView setAlertWithHandlerBlock:^(NSInteger index) {
//
//    }];
//    return;
//    [ZAlertView setAlertWithTitle:@"放顶顶顶" btnTitle:@"确定" handlerBlock:^(NSInteger index) {
//
//    }];
//    return;
    if (indexPath.section == 1) {
        [[ZUserHelper sharedHelper] checkLogin:^{
            ZStudentOrganizationDetailDesVC *dvc = [[ZStudentOrganizationDetailDesVC alloc] init];
            
            [self.navigationController pushViewController:dvc animated:YES];
        }];
        
    }
}

#pragma mark - scrollview delegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    // 获取到tableView偏移量
    CGFloat Offset_y = scrollView.contentOffset.y;
    // 下拉 纵向偏移量变小 变成负的
   
    [self.searchView updateWithOffset:Offset_y];
}

#pragma mark - 处理一些特殊的情况，比如layer的CGColor、特殊的，明景和暗景造成的文字内容变化等等
-(void)traitCollectionDidChange:(UITraitCollection *)previousTraitCollection{
    [super traitCollectionDidChange:previousTraitCollection];
    
    // darkmodel change
    [self setupDarkModel];
}

#pragma mark - setupDarkModel
- (void)setupDarkModel{
    if ([DarkModel isDarkMode]) {
//        [self darkType];
    }else{
//        [self lightType];
    }
}
@end
