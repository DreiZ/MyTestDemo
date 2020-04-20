//
//  ZStudentStarCoachInfoVC.m
//  NoWait
//
//  Created by zhuang zhang on 2020/1/13.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZStudentStarCoachInfoVC.h"
#import "ZStudentDetailModel.h"

#import "ZStudentStarDetailHeadView.h"
#import "ZStudentStarDetailNav.h"

#import "ZBaseCell.h"
#import "ZStudentStarCoachInfoCell.h"
#import "ZStudentStarStudentSectionTitleCell.h"
#import "ZStudentLessonDetailLessonListCell.h"
#import "ZStudentStarInfoImageCell.h"
#import "ZStudentLessonOrderCompleteCell.h"
#import "ZStudentLessonDetailEvaListCell.h"
#import "ZStudentStarInfoCoachMoreEvaCell.h"
#import "ZSpaceEmptyCell.h"

#define kHeaderHeight (CGFloatIn750(418)+kTopHeight)

@interface ZStudentStarCoachInfoVC ()
@property (nonatomic,strong) ZStudentStarDetailHeadView *headerView;
@property (nonatomic,strong) ZStudentStarDetailNav *navgationView;

@end

@implementation ZStudentStarCoachInfoVC

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
    [self setupMainView];
    
    [self initCellConfigArr];
}


- (void)setupMainView {
    [super setupMainView];

    [self.view addSubview:self.navgationView];
    [self.navgationView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(self.view);
        make.height.mas_equalTo(kTopHeight);
    }];
    
    [self.iTableView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.navgationView.mas_top);
        make.left.right.equalTo(self.view);
        make.bottom.equalTo(self.view.mas_bottom).offset(-0);
    }];
    
    [self.view bringSubviewToFront:self.navgationView];
    
    [self.iTableView setContentInset:UIEdgeInsetsMake(kHeaderHeight+kStatusBarHeight, 0, 0, 0)];
    [self.iTableView addSubview:self.headerView];
}

#pragma mark - lazy loading...
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
        _navgationView.title = @"明星教师";
        _navgationView.backBlock = ^(NSInteger index) {
            [weakSelf.navigationController popViewControllerAnimated:YES];
        };
    }
    
    return _navgationView;
}


#pragma mark tableView -------datasource-----
- (void)zz_tableView:(UITableView *)tableView cell:(UITableViewCell *)cell cellForRowAtIndexPath:(NSIndexPath *)indexPath cellConfig:(ZCellConfig *)cellConfig
{
    if ([cellConfig.title isEqualToString:@"ZStudentLessonDetailLessonListCell"]){
        ZStudentLessonDetailLessonListCell *enteryCell = (ZStudentLessonDetailLessonListCell *)cell;
        enteryCell.isHiddenBottomLine = YES;
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
    [super initCellConfigArr];
    
    ZCellConfig *infoCellConfig = [ZCellConfig cellConfigWithClassName:[ZStudentStarCoachInfoCell  className] title:[ZStudentStarCoachInfoCell className] showInfoMethod:nil heightOfCell:[ZStudentStarCoachInfoCell z_getCellHeight:nil] cellType:ZCellTypeClass dataModel:nil];
    [self.cellConfigArr addObject:infoCellConfig];
    
    ZCellConfig *spacCellConfig = [ZCellConfig cellConfigWithClassName:[ZSpaceEmptyCell className] title:[ZSpaceEmptyCell className] showInfoMethod:@selector(setBackColor:) heightOfCell:CGFloatIn750(40) cellType:ZCellTypeClass dataModel:adaptAndDarkColor([UIColor colorGrayBG], [UIColor colorGrayBGDark])];
    [self.cellConfigArr addObject:spacCellConfig];
    
    {
        //教师介绍
        ZStudentDetailOrderSubmitListModel *model = [[ZStudentDetailOrderSubmitListModel alloc] init];
        model.leftTitle = @"教师介绍";
        model.isHiddenBottomLine = YES;
        ZCellConfig *menuCellConfig = [ZCellConfig cellConfigWithClassName:[ZStudentLessonOrderCompleteCell className] title:model.cellTitle showInfoMethod:@selector(setModel:) heightOfCell:[ZStudentLessonOrderCompleteCell z_getCellHeight:nil] cellType:ZCellTypeClass dataModel:model];
        [self.cellConfigArr addObject:menuCellConfig];
        
        NSMutableArray *list = @[].mutableCopy;
        NSArray *des = @[@"18年报名学习了瑜伽课程，并需取得了优异成绩",@"从业8年，技术精湛，为人和善，得过不少大奖，任驰骋，苏苏苏",@"参加比赛，国际荣誉无数"];
        for (int i = 0; i < des.count; i++) {
            ZStudentDetailDesListModel *model = [[ZStudentDetailDesListModel alloc] init];
            model.desSub = des[i];
            [list addObject:model];
        }
        
        ZCellConfig *lessonDesCellConfig = [ZCellConfig cellConfigWithClassName:[ZStudentLessonDetailLessonListCell className] title:[ZStudentLessonDetailLessonListCell className] showInfoMethod:@selector(setNoSpacelist:) heightOfCell:[ZStudentLessonDetailLessonListCell z_getCellHeight:list] cellType:ZCellTypeClass dataModel:list];
        [self.cellConfigArr addObject:lessonDesCellConfig];
        ZCellConfig *lessonFootCellConfig = [ZCellConfig cellConfigWithClassName:[ZSpaceEmptyCell className] title:[ZSpaceEmptyCell className] showInfoMethod:@selector(setBackColor:) heightOfCell:CGFloatIn750(20) cellType:ZCellTypeClass dataModel:adaptAndDarkColor([UIColor colorGrayBG], [UIColor colorBlackBGDark])];
           [self.cellConfigArr addObject:lessonFootCellConfig];
        
        
        ZCellConfig *spac1CellConfig = [ZCellConfig cellConfigWithClassName:[ZSpaceEmptyCell className] title:[ZSpaceEmptyCell className] showInfoMethod:@selector(setBackColor:) heightOfCell:CGFloatIn750(40) cellType:ZCellTypeClass dataModel:adaptAndDarkColor([UIColor colorGrayBG], [UIColor colorGrayBGDark])];
        [self.cellConfigArr addObject:spac1CellConfig];
    }
    {
        //教师评价
        ZStudentDetailOrderSubmitListModel *model = [[ZStudentDetailOrderSubmitListModel alloc] init];
        model.leftTitle = @"教师评价";
        model.isHiddenBottomLine = NO;
        ZCellConfig *menuCellConfig = [ZCellConfig cellConfigWithClassName:[ZStudentLessonOrderCompleteCell className] title:model.cellTitle showInfoMethod:@selector(setModel:) heightOfCell:[ZStudentLessonOrderCompleteCell z_getCellHeight:nil] cellType:ZCellTypeClass dataModel:model];
        [self.cellConfigArr addObject:menuCellConfig];
        
    

        NSArray *eva = @[@"挺好的，不错，坚持下来肯定有结果",
                        @"还不错，加油",@"要坚持下去，我自己坚持下来，效果很明显，加油吧少年，我们还要很长时间才能做出很好的效果",
                        @"加油不错",
        @"这家还不错，欢迎大家前来锻炼，教师小姐姐很漂亮，器材很新，很干净，很好看"];
        for (int i = 0; i < 5; i++) {
            ZStudentDetailEvaListModel *model = [[ZStudentDetailEvaListModel alloc] init];
            model.userImage = [NSString stringWithFormat:@"studentHeadImage%d",i%5 + 1];
            model.userName = @"天黑有灯";
            model.evaDes = eva[i%5];
            model.star = @"4.5";
            model.time = @"2019-10-23";
            ZCellConfig *lessonTitleCellConfig = [ZCellConfig cellConfigWithClassName:[ZStudentLessonDetailEvaListCell className] title:[ZStudentLessonDetailEvaListCell className] showInfoMethod:@selector(setModel:) heightOfCell:[ZStudentLessonDetailEvaListCell z_getCellHeight:model] cellType:ZCellTypeClass dataModel:model];
            [self.cellConfigArr addObject:lessonTitleCellConfig];
        }
        
        
        ZCellConfig *moreEvaCellConfig = [ZCellConfig cellConfigWithClassName:[ZStudentStarInfoCoachMoreEvaCell className] title:[ZStudentStarInfoCoachMoreEvaCell className] showInfoMethod:@selector(setTitle:) heightOfCell:[ZStudentStarInfoCoachMoreEvaCell z_getCellHeight:nil] cellType:ZCellTypeClass dataModel:@"查看全部评价"];
        [self.cellConfigArr addObject:moreEvaCellConfig];
        
        ZCellConfig *spac1CellConfig = [ZCellConfig cellConfigWithClassName:[ZSpaceEmptyCell className] title:[ZSpaceEmptyCell className] showInfoMethod:@selector(setBackColor:) heightOfCell:CGFloatIn750(40) cellType:ZCellTypeClass dataModel:adaptAndDarkColor([UIColor colorGrayBG], [UIColor colorGrayBGDark])];
               [self.cellConfigArr addObject:spac1CellConfig];
    }
    
    
    {
        //练习相册
        ZCellConfig *title2CellConfig = [ZCellConfig cellConfigWithClassName:[ZStudentStarStudentSectionTitleCell className] title:[ZStudentStarStudentSectionTitleCell className] showInfoMethod:@selector(setTitle:) heightOfCell:[ZStudentStarStudentSectionTitleCell z_getCellHeight:nil] cellType:ZCellTypeClass dataModel:@"练习相册"];
         [self.cellConfigArr addObject:title2CellConfig];
         
         for (int i = 0; i < 18; i++) {
            ZStudentDetailContentListModel *model = [[ZStudentDetailContentListModel alloc] init];
            model.image = [NSString stringWithFormat:@"studentDetailInfo%u",arc4random_uniform(5)];
            ZCellConfig *lessonCellConfig = [ZCellConfig cellConfigWithClassName:[ZStudentStarInfoImageCell className] title:[ZStudentStarInfoImageCell className] showInfoMethod:@selector(setModel:) heightOfCell:[ZStudentStarInfoImageCell z_getCellHeight:nil] cellType:ZCellTypeClass dataModel:model];
            [self.cellConfigArr addObject:lessonCellConfig];
        }
    }
    
    
    [self.iTableView reloadData];
}
@end

