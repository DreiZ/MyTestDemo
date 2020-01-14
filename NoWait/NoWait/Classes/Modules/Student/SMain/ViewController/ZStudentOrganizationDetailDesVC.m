//
//  ZStudentOrganizationDetailDesVC.m
//  NoWait
//
//  Created by zhuang zhang on 2020/1/8.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZStudentOrganizationDetailDesVC.h"
#import "ZCellConfig.h"

#import "ZSpaceEmptyCell.h"
#import "ZStudentOrganizationDetailBannerCell.h"
#import "ZStudentOrganizationDetailDesCell.h"
#import "ZStudentOrganizationLessonListCell.h"
#import "ZStudentOrganizationPersonnelMoreCell.h"
#import "ZStudentOrganizationPersonnelListCell.h"
#import "ZStudentOrganizationLessonMoreCell.h"


#import "ZStudentOrganizationLessonDetailVC.h"
#import "ZStudentStarStudentListVC.h"
#import "ZStudentStarCoachListVC.h"
#import "ZStudentStarCoachInfoVC.h"
#import "ZStudentStarStudentInfoVC.h"
//
//#import "ZStudentOrganizationLessonDetailVC.h"

@interface ZStudentOrganizationDetailDesVC ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic,strong) UITableView *iTableView;

@property (nonatomic,strong) NSMutableArray *dataSources;
@property (nonatomic,strong) NSMutableArray *cellConfigArr;
@end
@implementation ZStudentOrganizationDetailDesVC

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
    [self.cellConfigArr removeAllObjects];
    
    ZCellConfig *bannerCellConfig = [ZCellConfig cellConfigWithClassName:[ZStudentOrganizationDetailBannerCell className] title:[ZStudentOrganizationDetailBannerCell className] showInfoMethod:nil heightOfCell:[ZStudentOrganizationDetailBannerCell z_getCellHeight:nil] cellType:ZCellTypeClass dataModel:nil];
    [self.cellConfigArr addObject:bannerCellConfig];
    
    ZCellConfig *desCellConfig = [ZCellConfig cellConfigWithClassName:[ZStudentOrganizationDetailDesCell className] title:[ZStudentOrganizationDetailDesCell className] showInfoMethod:nil heightOfCell:[ZStudentOrganizationDetailDesCell z_getCellHeight:nil] cellType:ZCellTypeClass dataModel:nil];
    [self.cellConfigArr addObject:desCellConfig];
    
    {
        ZCellConfig *spacCellConfig = [ZCellConfig cellConfigWithClassName:[ZSpaceEmptyCell className] title:[ZSpaceEmptyCell className] showInfoMethod:@selector(setBackColor:) heightOfCell:CGFloatIn750(20) cellType:ZCellTypeClass dataModel:KBackColor];
        [self.cellConfigArr addObject:spacCellConfig];
        
        ZStudentDetailOrderSubmitListModel *moreModel = [[ZStudentDetailOrderSubmitListModel alloc] init];
        moreModel.leftTitle = @"明星教练";
        ZCellConfig *lessonMoreCellConfig = [ZCellConfig cellConfigWithClassName:[ZStudentOrganizationPersonnelMoreCell className] title:@"moreStarCoach" showInfoMethod:@selector(setModel:) heightOfCell:[ZStudentOrganizationPersonnelMoreCell z_getCellHeight:nil] cellType:ZCellTypeClass dataModel:moreModel];
        [self.cellConfigArr addObject:lessonMoreCellConfig];
        
        NSArray *entryArr = @[@[@"赵忠",@"wallhaven4"],@[@"张丽",@"wallhaven4"],@[@"马克",@"wallhaven4"],@[@"张丽",@"wallhaven4"],@[@"张思思",@"wallhaven4"],@[@"许倩倩",@"wallhaven4"],@[@"吴楠",@"wallhaven4"],@[@"闫晶晶",@"wallhaven4"]];
        
        NSMutableArray *peoples = @[].mutableCopy;
        for (int i = 0; i < entryArr.count; i++) {
            ZStudentDetailPersonnelModel *model = [[ZStudentDetailPersonnelModel alloc] init];
            model.image = entryArr[i][1];
            model.name = entryArr[i][0];
            model.skill = entryArr[i][0];
            [peoples addObject:model];
        }
        
        ZCellConfig *coachCellConfig = [ZCellConfig cellConfigWithClassName:[ZStudentOrganizationPersonnelListCell className] title:@"starCoach" showInfoMethod:@selector(setPeopleslList:) heightOfCell:[ZStudentOrganizationPersonnelListCell z_getCellHeight:peoples] cellType:ZCellTypeClass dataModel:peoples];
        [self.cellConfigArr addObject:coachCellConfig];
    }
    
    {
        ZCellConfig *spacCellConfig = [ZCellConfig cellConfigWithClassName:[ZSpaceEmptyCell className] title:[ZSpaceEmptyCell className] showInfoMethod:@selector(setBackColor:) heightOfCell:CGFloatIn750(20) cellType:ZCellTypeClass dataModel:KBackColor];
        [self.cellConfigArr addObject:spacCellConfig];
        
        ZStudentDetailOrderSubmitListModel *moreModel = [[ZStudentDetailOrderSubmitListModel alloc] init];
        moreModel.leftTitle = @"明星学员";
        ZCellConfig *lessonMoreCellConfig = [ZCellConfig cellConfigWithClassName:[ZStudentOrganizationPersonnelMoreCell className] title:@"moreStarStudent" showInfoMethod:@selector(setModel:) heightOfCell:[ZStudentOrganizationPersonnelMoreCell z_getCellHeight:nil] cellType:ZCellTypeClass dataModel:moreModel];
        [self.cellConfigArr addObject:lessonMoreCellConfig];
        
        NSArray *entryArr = @[@[@"赵忠",@"wallhaven4"],@[@"张丽",@"wallhaven4"],@[@"马克",@"wallhaven4"],@[@"张丽",@"wallhaven4"],@[@"张思思",@"wallhaven4"],@[@"许倩倩",@"wallhaven4"],@[@"吴楠",@"wallhaven4"],@[@"闫晶晶",@"wallhaven4"]];
        
        NSMutableArray *peoples = @[].mutableCopy;
        for (int i = 0; i < entryArr.count; i++) {
            ZStudentDetailPersonnelModel *model = [[ZStudentDetailPersonnelModel alloc] init];
            model.image = entryArr[i][1];
            model.name = entryArr[i][0];
            model.skill = entryArr[i][0];
            [peoples addObject:model];
        }
        
        ZCellConfig *coachCellConfig = [ZCellConfig cellConfigWithClassName:[ZStudentOrganizationPersonnelListCell className] title:@"starStudent" showInfoMethod:@selector(setPeopleslList:) heightOfCell:[ZStudentOrganizationPersonnelListCell z_getCellHeight:peoples] cellType:ZCellTypeClass dataModel:peoples];
        [self.cellConfigArr addObject:coachCellConfig];
    }
    
    {
        ZCellConfig *spacCellConfig = [ZCellConfig cellConfigWithClassName:[ZSpaceEmptyCell className] title:[ZSpaceEmptyCell className] showInfoMethod:@selector(setBackColor:) heightOfCell:CGFloatIn750(20) cellType:ZCellTypeClass dataModel:KBackColor];
        [self.cellConfigArr addObject:spacCellConfig];
        
        
        ZCellConfig *lessonMoreCellConfig = [ZCellConfig cellConfigWithClassName:[ZStudentOrganizationPersonnelMoreCell className] title:[ZStudentOrganizationPersonnelMoreCell className] showInfoMethod:nil heightOfCell:[ZStudentOrganizationPersonnelMoreCell z_getCellHeight:nil] cellType:ZCellTypeClass dataModel:nil];
        [self.cellConfigArr addObject:lessonMoreCellConfig];
        
        ZCellConfig *lessonCellConfig = [ZCellConfig cellConfigWithClassName:[ZStudentOrganizationLessonListCell className] title:[ZStudentOrganizationLessonListCell className] showInfoMethod:nil heightOfCell:[ZStudentOrganizationLessonListCell z_getCellHeight:nil] cellType:ZCellTypeClass dataModel:nil];
        [self.cellConfigArr addObject:lessonCellConfig];
        [self.cellConfigArr addObject:lessonCellConfig];
        [self.cellConfigArr addObject:lessonCellConfig];
        [self.cellConfigArr addObject:lessonCellConfig];
        [self.cellConfigArr addObject:lessonCellConfig];
        [self.cellConfigArr addObject:lessonCellConfig];
        [self.cellConfigArr addObject:lessonCellConfig];
        [self.cellConfigArr addObject:lessonCellConfig];
        
        ZCellConfig *moreCellConfig = [ZCellConfig cellConfigWithClassName:[ZStudentOrganizationLessonMoreCell className] title:[ZStudentOrganizationLessonMoreCell className] showInfoMethod:@selector(setMoreTitle:) heightOfCell:[ZStudentOrganizationLessonMoreCell z_getCellHeight:nil] cellType:ZCellTypeClass dataModel:@"初学者课程"];
        [self.cellConfigArr addObject:moreCellConfig];
    }
}

- (void)setNavigation {
    self.isHidenNaviBar = NO;
    [self.navigationItem setTitle:@"环境"];
}

- (void)setupMainView {
    self.view.backgroundColor = KBackColor;
    
    [self.view addSubview:self.iTableView];
    [_iTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.bottom.equalTo(self.view.mas_bottom).offset(-CGFloatIn750(100));
        make.top.equalTo(self.view.mas_top).offset(1);
    }];
}

#pragma mark lazy loading...
-(UITableView *)iTableView {
    if (!_iTableView) {
        _iTableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _iTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _iTableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
        _iTableView.showsHorizontalScrollIndicator = NO;
        _iTableView.showsVerticalScrollIndicator = NO;
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
    }
    return _iTableView;
}

#pragma mark tableView -------datasource-----
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _cellConfigArr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    __weak typeof(self) weakSelf = self;
    
    ZCellConfig *cellConfig = [_cellConfigArr objectAtIndex:indexPath.row];
    ZBaseCell *cell;
    cell = (ZBaseCell*)[cellConfig cellOfCellConfigWithTableView:tableView dataModel:cellConfig.dataModel];
    if ([cellConfig.title isEqualToString:@"starStudent"]){
        ZStudentOrganizationPersonnelListCell *lcell = (ZStudentOrganizationPersonnelListCell *)cell;
        lcell.menuBlock = ^(ZStudentDetailPersonnelModel *model) {
            ZStudentStarStudentInfoVC *ivc = [[ZStudentStarStudentInfoVC alloc] init];
            [weakSelf.navigationController pushViewController:ivc animated:YES];
        };
 
    }else if ([cellConfig.title isEqualToString:@"starCoach"]){
        ZStudentOrganizationPersonnelListCell *lcell = (ZStudentOrganizationPersonnelListCell *)cell;
        lcell.menuBlock = ^(ZStudentDetailPersonnelModel *model) {
            ZStudentStarCoachInfoVC *ivc = [[ZStudentStarCoachInfoVC alloc] init];
            [weakSelf.navigationController pushViewController:ivc animated:YES];
        };
        
        
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
    if ([cellConfig.title isEqualToString:@"ZStudentOrganizationLessonListCell"]) {
        ZStudentOrganizationLessonDetailVC *lessond_vc = [[ZStudentOrganizationLessonDetailVC alloc] init];
        
        [self.navigationController pushViewController:lessond_vc animated:YES];
    }else if ([cellConfig.title isEqualToString:@"moreStarStudent"]){
        ZStudentStarStudentListVC *lvc = [[ZStudentStarStudentListVC alloc] init];
        [self.navigationController pushViewController:lvc animated:YES];
    }else if ([cellConfig.title isEqualToString:@"moreStarCoach"]){
        ZStudentStarCoachListVC *lvc = [[ZStudentStarCoachListVC alloc] init];
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
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
}
@end

