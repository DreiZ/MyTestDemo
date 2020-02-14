//
//  ZStudentMineEvaEditVC.m
//  NoWait
//
//  Created by zhuang zhang on 2020/1/14.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZStudentMineEvaEditVC.h"
#import "ZCellConfig.h"
#import "ZStudentMineModel.h"
#import "ZStudentMainModel.h"

#import "ZSpaceEmptyCell.h"
#import "ZMineStudentEvaListHadEvaCell.h"
#import "ZStudentLessonOrderIntroItemCell.h"
#import "ZStudentLessonOrderCompleteCell.h"
#import "ZStudentLessonOrderMoreInputCell.h"
#import "ZMineStudentEvaEditStarCell.h"
#import "ZMineStudentEvaEditUpdateImageCell.h"

@interface ZStudentMineEvaEditVC ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic,strong) UITableView *iTableView;

@property (nonatomic,strong) NSMutableArray *dataSources;
@property (nonatomic,strong) NSMutableArray *cellConfigArr;
@end
@implementation ZStudentMineEvaEditVC

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
    {
        //订单基本信息

        NSArray *lists = @[
                        @[@"课程：",@"暑期瑜伽班",[UIColor colorTextBlack]],
                        @[@"老师：",@"赵东来",[UIColor colorTextBlack]],@[@"开课时间：",@"2019-08-21",[UIColor colorTextBlack]]];
        
        NSMutableArray *mList = @[].mutableCopy;
        for (int i = 0; i < lists.count; i++) {
            ZStudentLessonOrderInfoCellModel *cModel = [[ZStudentLessonOrderInfoCellModel alloc] init];
            cModel.title = lists[i][0];
            cModel.subTitle = lists[i][1];
            cModel.subColor = lists[i][2];
            
            [mList addObject:cModel];
        }
        
        ZCellConfig *infoSpacCellConfig = [ZCellConfig cellConfigWithClassName:[ZSpaceEmptyCell className] title:[ZSpaceEmptyCell className] showInfoMethod:@selector(setBackColor:) heightOfCell:CGFloatIn750(30) cellType:ZCellTypeClass dataModel:adaptAndDarkColor([UIColor colorWhite], [UIColor colorBlackDarkBG])];
        [self.cellConfigArr addObject:infoSpacCellConfig];
        
        for (int i = 0; i < mList.count; i++) {
            ZCellConfig *spacCellConfig = [ZCellConfig cellConfigWithClassName:[ZStudentLessonOrderIntroItemCell className] title:[ZStudentLessonOrderIntroItemCell className] showInfoMethod:@selector(setModel:) heightOfCell:[ZStudentLessonOrderIntroItemCell z_getCellHeight:nil] cellType:ZCellTypeClass dataModel:mList[i]];
            [self.cellConfigArr addObject:spacCellConfig];
            ZCellConfig *infoBottomSpacCellConfig = [ZCellConfig cellConfigWithClassName:[ZSpaceEmptyCell className] title:[ZSpaceEmptyCell className] showInfoMethod:@selector(setBackColor:) heightOfCell:CGFloatIn750(10) cellType:ZCellTypeClass dataModel:adaptAndDarkColor([UIColor colorWhite], [UIColor colorBlackDarkBG])];
            [self.cellConfigArr addObject:infoBottomSpacCellConfig];
        }
        ZCellConfig *infoBottomSpacCellConfig = [ZCellConfig cellConfigWithClassName:[ZSpaceEmptyCell className] title:[ZSpaceEmptyCell className] showInfoMethod:@selector(setBackColor:) heightOfCell:CGFloatIn750(20) cellType:ZCellTypeClass dataModel:adaptAndDarkColor([UIColor colorWhite], [UIColor colorBlackDarkBG])];
        [self.cellConfigArr addObject:infoBottomSpacCellConfig];
        
        ZCellConfig *infoBottomBlackSpacCellConfig = [ZCellConfig cellConfigWithClassName:[ZSpaceEmptyCell className] title:[ZSpaceEmptyCell className] showInfoMethod:@selector(setBackColor:) heightOfCell:CGFloatIn750(20) cellType:ZCellTypeClass dataModel:adaptAndDarkColor([UIColor colorGrayBG], [UIColor colorBlackBG])];
        [self.cellConfigArr addObject:infoBottomBlackSpacCellConfig];
        
    }
    
   
    {
        ZStudentDetailOrderSubmitListModel *model = [[ZStudentDetailOrderSubmitListModel alloc] init];
               model.leftTitle = @"机构评价";
               
           ZCellConfig *menuCellConfig = [ZCellConfig cellConfigWithClassName:[ZStudentLessonOrderCompleteCell className] title:model.cellTitle showInfoMethod:@selector(setModel:) heightOfCell:[ZStudentLessonOrderCompleteCell z_getCellHeight:nil] cellType:ZCellTypeClass dataModel:model];
           [self.cellConfigArr addObject:menuCellConfig];
        {
            
            ZCellConfig *starSpace1CellConfig = [ZCellConfig cellConfigWithClassName:[ZSpaceEmptyCell className] title:[ZSpaceEmptyCell className] showInfoMethod:@selector(setBackColor:) heightOfCell:CGFloatIn750(30) cellType:ZCellTypeClass dataModel:adaptAndDarkColor([UIColor colorWhite], [UIColor colorBlackDarkBG])];
            [self.cellConfigArr addObject:starSpace1CellConfig];
            
            
            ZCellConfig *starCellConfig = [ZCellConfig cellConfigWithClassName:[ZMineStudentEvaEditStarCell className] title:[ZMineStudentEvaEditStarCell className] showInfoMethod:nil heightOfCell:[ZMineStudentEvaEditStarCell z_getCellHeight:nil] cellType:ZCellTypeClass dataModel:nil];
            [self.cellConfigArr addObject:starCellConfig];
            
            [self.cellConfigArr addObject:starSpace1CellConfig];

            
            ZCellConfig *star1CellConfig = [ZCellConfig cellConfigWithClassName:[ZMineStudentEvaEditStarCell className] title:[ZMineStudentEvaEditStarCell className] showInfoMethod:nil heightOfCell:[ZMineStudentEvaEditStarCell z_getCellHeight:nil] cellType:ZCellTypeClass dataModel:nil];
            [self.cellConfigArr addObject:star1CellConfig];
            [self.cellConfigArr addObject:starSpace1CellConfig];
        }
        
        ZCellConfig *moreIntputCellConfig = [ZCellConfig cellConfigWithClassName:[ZStudentLessonOrderMoreInputCell className] title:[ZStudentLessonOrderMoreInputCell className] showInfoMethod:@selector(setIsBackColor:) heightOfCell:[ZStudentLessonOrderMoreInputCell z_getCellHeight:nil] cellType:ZCellTypeClass dataModel:@"yes"];
        [self.cellConfigArr addObject:moreIntputCellConfig];
        
        
        
        ZCellConfig *uploadImageCellConfig = [ZCellConfig cellConfigWithClassName:[ZMineStudentEvaEditUpdateImageCell className] title:[ZMineStudentEvaEditUpdateImageCell className] showInfoMethod:nil heightOfCell:[ZMineStudentEvaEditUpdateImageCell z_getCellHeight:nil] cellType:ZCellTypeClass dataModel:nil];
        [self.cellConfigArr addObject:uploadImageCellConfig];

        
        ZCellConfig *iSpacCellConfig = [ZCellConfig cellConfigWithClassName:[ZSpaceEmptyCell className] title:[ZSpaceEmptyCell className] showInfoMethod:@selector(setBackColor:) heightOfCell:CGFloatIn750(40) cellType:ZCellTypeClass dataModel:adaptAndDarkColor([UIColor colorGrayBG], [UIColor colorBlackBG])];
        [self.cellConfigArr addObject:iSpacCellConfig];
    }
    
    {
         ZStudentDetailOrderSubmitListModel *model = [[ZStudentDetailOrderSubmitListModel alloc] init];
                model.leftTitle = @"教练评价";
                
            ZCellConfig *menuCellConfig = [ZCellConfig cellConfigWithClassName:[ZStudentLessonOrderCompleteCell className] title:model.cellTitle showInfoMethod:@selector(setModel:) heightOfCell:[ZStudentLessonOrderCompleteCell z_getCellHeight:nil] cellType:ZCellTypeClass dataModel:model];
            [self.cellConfigArr addObject:menuCellConfig];
         {
             
             ZCellConfig *starSpace1CellConfig = [ZCellConfig cellConfigWithClassName:[ZSpaceEmptyCell className] title:[ZSpaceEmptyCell className] showInfoMethod:@selector(setBackColor:) heightOfCell:CGFloatIn750(30) cellType:ZCellTypeClass dataModel:adaptAndDarkColor([UIColor colorWhite], [UIColor colorBlackDarkBG])];
             [self.cellConfigArr addObject:starSpace1CellConfig];
             
             
             ZCellConfig *starCellConfig = [ZCellConfig cellConfigWithClassName:[ZMineStudentEvaEditStarCell className] title:[ZMineStudentEvaEditStarCell className] showInfoMethod:nil heightOfCell:[ZMineStudentEvaEditStarCell z_getCellHeight:nil] cellType:ZCellTypeClass dataModel:nil];
             [self.cellConfigArr addObject:starCellConfig];
             
             [self.cellConfigArr addObject:starSpace1CellConfig];
         }
         
         ZCellConfig *moreIntputCellConfig = [ZCellConfig cellConfigWithClassName:[ZStudentLessonOrderMoreInputCell className] title:[ZStudentLessonOrderMoreInputCell className] showInfoMethod:@selector(setIsBackColor:) heightOfCell:[ZStudentLessonOrderMoreInputCell z_getCellHeight:nil] cellType:ZCellTypeClass dataModel:@"yes"];
         [self.cellConfigArr addObject:moreIntputCellConfig];
         
         
         
         ZCellConfig *uploadImageCellConfig = [ZCellConfig cellConfigWithClassName:[ZMineStudentEvaEditUpdateImageCell className] title:[ZMineStudentEvaEditUpdateImageCell className] showInfoMethod:nil heightOfCell:[ZMineStudentEvaEditUpdateImageCell z_getCellHeight:nil] cellType:ZCellTypeClass dataModel:nil];
         [self.cellConfigArr addObject:uploadImageCellConfig];

         
         ZCellConfig *iSpacCellConfig = [ZCellConfig cellConfigWithClassName:[ZSpaceEmptyCell className] title:[ZSpaceEmptyCell className] showInfoMethod:@selector(setBackColor:) heightOfCell:CGFloatIn750(40) cellType:ZCellTypeClass dataModel:adaptAndDarkColor([UIColor colorGrayBG], [UIColor colorBlackBG])];
         [self.cellConfigArr addObject:iSpacCellConfig];
    }
}


- (void)setNavigation {
    self.isHidenNaviBar = NO;
    [self.navigationItem setTitle:@"视频课程"];
}

- (void)setupMainView {
    [self.view addSubview:self.iTableView];
    [_iTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.bottom.equalTo(self.view.mas_bottom);
        make.top.equalTo(self.view.mas_top).offset(10);
    }];
}

#pragma mark lazy loading...
-(UITableView *)iTableView {
    if (!_iTableView) {
        _iTableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
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
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
            self.automaticallyAdjustsScrollViewInsets = NO;
#pragma clang diagnostic pop
        }
        _iTableView.showsVerticalScrollIndicator = NO;
        _iTableView.backgroundColor = [UIColor colorGrayBG];
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
    ZCellConfig *cellConfig = [_cellConfigArr objectAtIndex:indexPath.row];
    ZBaseCell *cell;
    cell = (ZBaseCell*)[cellConfig cellOfCellConfigWithTableView:tableView dataModel:cellConfig.dataModel];
    if ([cellConfig.title isEqualToString:@"ZSpaceEmptyCell"]){
        ZSpaceEmptyCell *enteryCell = (ZSpaceEmptyCell *)cell;
        
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


