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

#import "ZStudentMineOrderLessonEvaCell.h"
#import "ZMineStudentEvaListHadEvaCell.h"
#import "ZStudentLessonOrderIntroItemCell.h"
#import "ZStudentLessonOrderCompleteCell.h"
#import "ZStudentLessonOrderMoreInputCell.h"
#import "ZMineStudentEvaEditStarCell.h"

#import "ZOriganizationOrderViewModel.h"


@interface ZStudentMineEvaEditVC ()
@property (nonatomic,strong) ZOrderEvaModel *evaModel;
@property (nonatomic,strong) UIButton *bottomBtn;

@end

@implementation ZStudentMineEvaEditVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _evaModel = [[ZOrderEvaModel alloc] init];
    if (self.evaDetailModel) {
        _evaModel.courses_comment_score = self.evaDetailModel.courses_comment_score;
        _evaModel.stores_comment_score = self.evaDetailModel.stores_comment_score;
        _evaModel.teahcer_comment_score = self.evaDetailModel.teacher_comment_score;
        _evaModel.courses_comment_desc = self.evaDetailModel.courses_comment_desc;
        _evaModel.stores_comment_desc = self.evaDetailModel.stores_comment_desc;
        _evaModel.teacher_comment_desc = self.evaDetailModel.teacher_comment_desc;
    }else{
        _evaModel.courses_comment_score = @"5";
        _evaModel.stores_comment_score = @"5";
        _evaModel.teahcer_comment_score = @"5";
    }
    
    [self setNavigation];
    [self initCellConfigArr];
}

- (void)initCellConfigArr {
    [super initCellConfigArr];
    
    if (self.listModel) {
        ZCellConfig *infoSpacCellConfig = [ZCellConfig cellConfigWithClassName:[ZStudentMineOrderLessonEvaCell className] title:[ZStudentMineOrderLessonEvaCell className] showInfoMethod:@selector(setModel:) heightOfCell:[ZStudentMineOrderLessonEvaCell z_getCellHeight:nil] cellType:ZCellTypeClass dataModel:self.listModel];
       [self.cellConfigArr addObject:infoSpacCellConfig];
    }else if (self.listModel){
        ZCellConfig *infoSpacCellConfig = [ZCellConfig cellConfigWithClassName:[ZStudentMineOrderLessonEvaCell className] title:[ZStudentMineOrderLessonEvaCell className] showInfoMethod:@selector(setDetailModel:) heightOfCell:[ZStudentMineOrderLessonEvaCell z_getCellHeight:nil] cellType:ZCellTypeClass dataModel:self.detailModel];
         [self.cellConfigArr addObject:infoSpacCellConfig];
    }
    
    [self.cellConfigArr addObject:getEmptyCellWithHeight(CGFloatIn750(40))];
    
   
    {
        ZStudentDetailOrderSubmitListModel *model = [[ZStudentDetailOrderSubmitListModel alloc] init];
               model.leftTitle = @"课程评价";
        model.isHiddenBottomLine = YES;
           ZCellConfig *menuCellConfig = [ZCellConfig cellConfigWithClassName:[ZStudentLessonOrderCompleteCell className] title:model.cellTitle showInfoMethod:@selector(setModel:) heightOfCell:CGFloatIn750(36) cellType:ZCellTypeClass dataModel:model];
           [self.cellConfigArr addObject:menuCellConfig];
        
        {
            ZCellConfig *starCellConfig = [ZCellConfig cellConfigWithClassName:[ZMineStudentEvaEditStarCell className] title:@"lessonStar" showInfoMethod:nil heightOfCell:[ZMineStudentEvaEditStarCell z_getCellHeight:nil] cellType:ZCellTypeClass dataModel:nil];
            [self.cellConfigArr addObject:starCellConfig];
        }
        
        ZCellConfig *moreIntputCellConfig = [ZCellConfig cellConfigWithClassName:[ZStudentLessonOrderMoreInputCell className] title:@"lessonText" showInfoMethod:@selector(setIsBackColor:) heightOfCell:[ZStudentLessonOrderMoreInputCell z_getCellHeight:nil] cellType:ZCellTypeClass dataModel:nil];
        [self.cellConfigArr addObject:moreIntputCellConfig];
        
    
        [self.cellConfigArr addObject:getEmptyCellWithHeight(CGFloatIn750(20))];
    }
    
    {
        ZStudentDetailOrderSubmitListModel *model = [[ZStudentDetailOrderSubmitListModel alloc] init];
               model.leftTitle = @"教师评价";
        model.isHiddenBottomLine = YES;
           ZCellConfig *menuCellConfig = [ZCellConfig cellConfigWithClassName:[ZStudentLessonOrderCompleteCell className] title:model.cellTitle showInfoMethod:@selector(setModel:) heightOfCell:CGFloatIn750(36) cellType:ZCellTypeClass dataModel:model];
           [self.cellConfigArr addObject:menuCellConfig];
        
        {
            ZCellConfig *starCellConfig = [ZCellConfig cellConfigWithClassName:[ZMineStudentEvaEditStarCell className] title:@"teacherStar" showInfoMethod:nil heightOfCell:[ZMineStudentEvaEditStarCell z_getCellHeight:nil] cellType:ZCellTypeClass dataModel:nil];
            [self.cellConfigArr addObject:starCellConfig];
        }
        
        ZCellConfig *moreIntputCellConfig = [ZCellConfig cellConfigWithClassName:[ZStudentLessonOrderMoreInputCell className] title:@"teacherText" showInfoMethod:@selector(setIsBackColor:) heightOfCell:[ZStudentLessonOrderMoreInputCell z_getCellHeight:nil] cellType:ZCellTypeClass dataModel:nil];
        [self.cellConfigArr addObject:moreIntputCellConfig];
    
        [self.cellConfigArr addObject:getEmptyCellWithHeight(CGFloatIn750(20))];
    }
    
    
    {
        ZStudentDetailOrderSubmitListModel *model = [[ZStudentDetailOrderSubmitListModel alloc] init];
               model.leftTitle = @"校区评价";
        model.isHiddenBottomLine = YES;
           ZCellConfig *menuCellConfig = [ZCellConfig cellConfigWithClassName:[ZStudentLessonOrderCompleteCell className] title:model.cellTitle showInfoMethod:@selector(setModel:) heightOfCell:CGFloatIn750(36) cellType:ZCellTypeClass dataModel:model];
           [self.cellConfigArr addObject:menuCellConfig];
        
        {
            ZCellConfig *starCellConfig = [ZCellConfig cellConfigWithClassName:[ZMineStudentEvaEditStarCell className] title:@"schoolStar" showInfoMethod:nil heightOfCell:[ZMineStudentEvaEditStarCell z_getCellHeight:nil] cellType:ZCellTypeClass dataModel:nil];
            [self.cellConfigArr addObject:starCellConfig];
        }
        
        ZCellConfig *moreIntputCellConfig = [ZCellConfig cellConfigWithClassName:[ZStudentLessonOrderMoreInputCell className] title:@"schoolText" showInfoMethod:@selector(setIsBackColor:) heightOfCell:[ZStudentLessonOrderMoreInputCell z_getCellHeight:nil] cellType:ZCellTypeClass dataModel:nil];
        [self.cellConfigArr addObject:moreIntputCellConfig];
        
    
        [self.cellConfigArr addObject:getEmptyCellWithHeight(CGFloatIn750(20))];
    }
}


- (void)setNavigation {
    self.isHidenNaviBar = NO;
    [self.navigationItem setTitle:@"视频课程"];
}

- (void)setupMainView {
    [super setupMainView];
    
    [self.view addSubview:self.bottomBtn];
    [self.bottomBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.height.mas_equalTo(CGFloatIn750(88));
        make.bottom.equalTo(self.view.mas_bottom).offset(-safeAreaBottom());
    }];
    
    [self.iTableView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.bottom.equalTo(self.bottomBtn.mas_top);
        make.top.equalTo(self.view.mas_top).offset(10);
    }];
}


- (UIButton *)bottomBtn {
    if (!_bottomBtn) {
        __weak typeof(self) weakSelf = self;
        _bottomBtn = [[ZButton alloc] initWithFrame:CGRectZero];
        _bottomBtn.layer.masksToBounds = YES;
        [_bottomBtn setTitle:@"发布" forState:UIControlStateNormal];
        [_bottomBtn setTitleColor:[UIColor colorWhite] forState:UIControlStateNormal];
        [_bottomBtn.titleLabel setFont:[UIFont fontContent]];
        [_bottomBtn setBackgroundColor:adaptAndDarkColor([UIColor colorMain], [UIColor colorMainDark]) forState:UIControlStateNormal];
        [_bottomBtn bk_addEventHandler:^(id sender) {
            [weakSelf addEva];
        } forControlEvents:UIControlEventTouchUpInside];
    }
    return _bottomBtn;
}

#pragma mark - tableview
- (void)zz_tableView:(UITableView *)tableView cell:(UITableViewCell *)cell cellForRowAtIndexPath:(NSIndexPath *)indexPath cellConfig:(ZCellConfig *)cellConfig {
    __weak typeof(self) weakSelf = self;
    if ([cellConfig.title isEqualToString:@"lessonStar"]) {
        ZMineStudentEvaEditStarCell *lcell = (ZMineStudentEvaEditStarCell *)cell;
        lcell.handleBlock = ^(CGFloat index) {
            weakSelf.evaModel.courses_comment_score = [NSString stringWithFormat:@"%ld",(long)(index * 10 / 2)];
        };
    }else if ([cellConfig.title isEqualToString:@"lessonText"]) {
        ZStudentLessonOrderMoreInputCell *lcell = (ZStudentLessonOrderMoreInputCell *)cell;
        lcell.max = 200;
        lcell.hint = @"说说您的看法";
        lcell.content = self.evaModel.courses_comment_desc;
        lcell.textChangeBlock = ^(NSString *text) {
            weakSelf.evaModel.courses_comment_desc = text;
        };
    }else if ([cellConfig.title isEqualToString:@"teacherStar"]) {
        ZMineStudentEvaEditStarCell *lcell = (ZMineStudentEvaEditStarCell *)cell;
        lcell.handleBlock = ^(CGFloat index) {
            weakSelf.evaModel.teahcer_comment_score = [NSString stringWithFormat:@"%ld",(long)(index * 10 / 2)];
        };
    }else if ([cellConfig.title isEqualToString:@"teacherText"]) {
        ZStudentLessonOrderMoreInputCell *lcell = (ZStudentLessonOrderMoreInputCell *)cell;
        lcell.max = 200;
        lcell.hint = @"说说您的看法";
        lcell.content = self.evaModel.teacher_comment_desc;
        lcell.textChangeBlock = ^(NSString *text) {
            weakSelf.evaModel.teacher_comment_desc = text;
        };
    }else if ([cellConfig.title isEqualToString:@"schoolStar"]) {
        ZMineStudentEvaEditStarCell *lcell = (ZMineStudentEvaEditStarCell *)cell;
        lcell.handleBlock = ^(CGFloat index) {
            weakSelf.evaModel.stores_comment_score = [NSString stringWithFormat:@"%ld",(long)(index * 10 / 2)];
        };
    }else if ([cellConfig.title isEqualToString:@"schoolText"]) {
        ZStudentLessonOrderMoreInputCell *lcell = (ZStudentLessonOrderMoreInputCell *)cell;
        lcell.max = 200;
        lcell.content = self.evaModel.stores_comment_desc;
        lcell.hint = @"说说您的看法";
        lcell.textChangeBlock = ^(NSString *text) {
            weakSelf.evaModel.stores_comment_desc = text;
        };
    }
}

- (void)addEva {
    NSMutableDictionary *params = @{}.mutableCopy;
    if (self.detailModel) {
        [params setObject:self.detailModel.stores_id forKey:@"stores_id"];
        [params setObject:self.detailModel.order_id forKey:@"order_id"];
    }else if (self.listModel){
        [params setObject:self.listModel.stores_id forKey:@"stores_id"];
        [params setObject:self.listModel.order_id forKey:@"order_id"];
    }else{
        [params setObject:self.evaDetailModel.stores_id forKey:@"stores_id"];
        [params setObject:self.evaDetailModel.order_id forKey:@"order_id"];
    }
    
    [params setObject:self.evaModel.stores_comment_score forKey:@"stores_comment_score"];
    [params setObject:self.evaModel.teahcer_comment_score forKey:@"teacher_comment_score"];
    [params setObject:self.evaModel.courses_comment_score forKey:@"courses_comment_score"];
    
    if (self.evaModel.stores_comment_desc) {
        [params setObject:self.evaModel.stores_comment_desc forKey:@"stores_comment_desc"];
    }
    if (self.evaModel.teacher_comment_desc) {
        [params setObject:self.evaModel.teacher_comment_desc forKey:@"teacher_comment_desc"];
    }
    if (self.evaModel.courses_comment_desc) {
        [params setObject:self.evaModel.courses_comment_desc forKey:@"courses_comment_desc"];
    }
    
    [ZOriganizationOrderViewModel evaOrder:params completeBlock:^(BOOL isSuccess, id data) {
        if (isSuccess) {
            [TLUIUtility showSuccessHint:data];
            [self.navigationController popViewControllerAnimated:YES];
        }else{
            [TLUIUtility showErrorHint:data];
        }
    }];
}
@end
