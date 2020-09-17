//
//  ZStudentMainClassificationListVC.m
//  NoWait
//
//  Created by zhuang zhang on 2020/8/29.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZStudentMainClassificationListVC.h"
#import "ZStudentClassificationLeftCell.h"
#import "ZStudentMainEntryClassListItemCell.h"
#import "ZStudentMainViewModel.h"

@interface ZStudentMainClassificationListVC ()<UITableViewDelegate, UITableViewDataSource,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (nonatomic,strong) UICollectionView *iCollectionView;
@property (nonatomic,strong) UIView *safeCollectionFooterView;

@property (nonatomic,strong) NSMutableArray *rightDataArr;
@property (nonatomic,strong) NSArray *classify;
@end

@implementation ZStudentMainClassificationListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    __weak typeof(self) weakSelf = self;
    [self setNavigation];
    [self initCellConfigArr];
    self.iTableView.delegate = self;
    [self setTableViewGaryBack];
    
    [self.iTableView reloadData];
    [self.iCollectionView reloadData];
    
    if (ValidArray(self.classify)) {
        [self getCategoryList:^(BOOL state) {
            [weakSelf.iTableView reloadData];
            [weakSelf.iCollectionView reloadData];
        }];
    }
}

- (void)setDataSource {
    [super setDataSource];
    
    _rightDataArr = @[].mutableCopy;
    
    _classify = [ZStudentMainViewModel mainClassifyOneData];
    
    for (int i = 0; i < _classify.count; i++) {
        ZMainClassifyOneModel *model = _classify[i];
        if (i == 0) {
            model.isSelected = YES;
        }
        [self.dataSources addObject:model];
    }
}

- (void)initCellConfigArr {
    [super initCellConfigArr];
    
    for (int i = 0; i < self.dataSources.count; i++) {
        ZMainClassifyOneModel *model = self.dataSources[i];
        
        ZCellConfig *channelCellConfig = [ZCellConfig cellConfigWithClassName:[ZStudentClassificationLeftCell className] title:[ZStudentClassificationLeftCell className] showInfoMethod:@selector(setModel:) heightOfCell:[ZStudentClassificationLeftCell z_getCellHeight:nil] cellType:ZCellTypeClass dataModel:model];
        [self.cellConfigArr addObject:channelCellConfig];
    }
}

- (NSMutableArray *)rightDataArr {
    _rightDataArr = nil;
    for (int i = 0; i < self.dataSources.count; i++) {
        ZMainClassifyOneModel *model = self.dataSources[i];
        if (model.isSelected) {
            _rightDataArr = model.secondary;
        }
    }
    return _rightDataArr;
}

- (void)setNavigation {
    self.isHidenNaviBar = NO;
    [self.navigationItem setTitle:@"分类"];
}

- (void)setupMainView {
    [super setupMainView];;
    
    [self.iTableView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view);
        make.width.mas_equalTo(CGFloatIn750(200));
        make.bottom.equalTo(self.view.mas_bottom);
        make.top.equalTo(self.view.mas_top).offset(0);
    }];
    
    [self.view addSubview:self.iCollectionView];
    [self.iCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view);
        make.left.equalTo(self.iTableView.mas_right);
        make.bottom.equalTo(self.view.mas_bottom);
        make.top.equalTo(self.view.mas_top).offset(0);
    }];
}

#pragma mark lazy loading...
#pragma mark - lazy loading...
- (UICollectionView *)iCollectionView {
    if (!_iCollectionView) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
        
        _iCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, KScreenHeight) collectionViewLayout:flowLayout];
        _iCollectionView.backgroundColor = adaptAndDarkColor([UIColor colorWhite], [UIColor colorBlackBGDark]);
        _iCollectionView.dataSource = self;
        _iCollectionView.delegate = self;
        _iCollectionView.scrollEnabled = YES;
        _iCollectionView.showsHorizontalScrollIndicator = NO;
        _iCollectionView.showsVerticalScrollIndicator = NO;
        [_iCollectionView registerClass:[ZStudentMainEntryClassListItemCell class] forCellWithReuseIdentifier:[ZStudentMainEntryClassListItemCell className]];
    }
    
    return _iCollectionView;
}

- (UIView *)safeCollectionFooterView {
    if (!_safeCollectionFooterView) {
        _safeCollectionFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, safeAreaBottom())];
        _safeCollectionFooterView.backgroundColor = adaptAndDarkColor([UIColor colorWhite], [UIColor colorBlackBGDark]);
    }
    return _safeCollectionFooterView;
}


#pragma mark - collectionview delegate
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.rightDataArr.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ZStudentMainEntryClassListItemCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:[ZStudentMainEntryClassListItemCell className] forIndexPath:indexPath];
    ZMainClassifyOneModel *model = self.rightDataArr[indexPath.row];
    cell.titleLabel.text = model.name;
    [cell.imageView tt_setImageWithURL:[NSURL URLWithString:model.imageName] placeholderImage:[UIImage imageNamed:@"main_more"]];

    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    ZMainClassifyOneModel *model = self.rightDataArr[indexPath.row];
    routePushVC(ZRoute_main_classification, @{@"name":SafeStr(model.name),@"type":SafeStr(model.classify_id)}, nil);
}


-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(CGFloatIn750(20), CGFloatIn750(10), CGFloatIn750(20), CGFloatIn750(10));
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return CGFloatIn750(10);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return CGFloatIn750(10);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    CGSize cellSize =  CGSizeMake((KScreenWidth-CGFloatIn750(200) - CGFloatIn750(20+20))/3.0f-1.0f, (KScreenWidth-CGFloatIn750(200) - CGFloatIn750(20+20))/3.0f+CGFloatIn750(30));
    return cellSize;
}

#pragma mark - collectionview handle
-(void)zz_collectionView:(UICollectionView *)collectionView cell:(UICollectionViewCell *)cell cellForItemAtIndexPath:(NSIndexPath *)indexPath cellConfig:(ZCellConfig *)cellConfig{
    
}

- (void)zz_collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath cellConfig:(ZCellConfig *)cellConfig{
}

#pragma mark tableView -------datasource-----
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.cellConfigArr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ZCellConfig *cellConfig = [self.cellConfigArr objectAtIndex:indexPath.row];
        ZBaseCell *cell;
    cell = (ZBaseCell*)[cellConfig cellOfCellConfigWithTableView:tableView dataModel:cellConfig.dataModel];
    return cell;
}

#pragma mark tableView ------delegate-----
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    ZCellConfig *cellConfig = self.cellConfigArr[indexPath.row];
    CGFloat cellHeight =  cellConfig.heightOfCell;
    return cellHeight;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    
    return nil;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    ZCellConfig *cellConfig = [self.cellConfigArr objectAtIndex:indexPath.row];
    if ([cellConfig.title isEqualToString:@"ZStudentClassificationLeftCell"]) {
        ZMainClassifyOneModel *smodel = cellConfig.dataModel;
        
        for (int i = 0; i < self.dataSources.count; i++) {
            ZMainClassifyOneModel *model = self.dataSources[i];
            if ([smodel.classify_id isEqualToString:model.classify_id]) {
                model.isSelected = YES;
            }else{
                model.isSelected = NO;
            }
        }
        
        [self initCellConfigArr];
        [self.iTableView reloadData];
        [self.iCollectionView scrollToTop];
        [self.iCollectionView reloadData];
    }
}


- (void)getCategoryList:(void(^)(BOOL))complete {
    __weak typeof(self) weakSelf = self;
    [ZStudentMainViewModel getCategoryList:@{} completeBlock:^(BOOL isSuccess, id data) {
        if (isSuccess) {
            ZMainClassifyNetModel *model = data;
            NSMutableArray *classifyArr = @[].mutableCopy;
            [classifyArr addObjectsFromArray:model.list];
            [classifyArr enumerateObjectsUsingBlock:^(ZMainClassifyOneModel *obj, NSUInteger idx, BOOL * _Nonnull stop) {
                [obj.secondary enumerateObjectsUsingBlock:^(ZMainClassifyOneModel *sobj, NSUInteger idx, BOOL * _Nonnull stop) {
                    sobj.superClassify_id = obj.classify_id;
                }];
            }];
            if (ValidArray(classifyArr)) {
                weakSelf.classify = classifyArr;
            }
            if (complete) {
                complete(YES);
            }
        }else{
            if (complete) {
                complete(NO);
            }
        }
    }];
}
@end


#pragma mark - RouteHandler
@interface ZStudentMainClassificationListVC (RouteHandler)<SJRouteHandler>

@end

@implementation ZStudentMainClassificationListVC (RouteHandler)

+ (NSString *)routePath {
    return ZRoute_main_classificationList;
}

+ (void)handleRequest:(SJRouteRequest *)request topViewController:(UIViewController *)topViewController completionHandler:(SJCompletionHandler)completionHandler {
    ZStudentMainClassificationListVC *routevc = [[ZStudentMainClassificationListVC alloc] init];
    [topViewController.navigationController pushViewController:routevc animated:YES];
}
@end

