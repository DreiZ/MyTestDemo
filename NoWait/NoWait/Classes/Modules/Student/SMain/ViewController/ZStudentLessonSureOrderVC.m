//
//  ZStudentLessonSureOrderVC.m
//  NoWait
//
//  Created by zhuang zhang on 2020/1/10.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZStudentLessonSureOrderVC.h"
#import "ZStudentLessonOrderSuccessVC.h"

#import "ZCellConfig.h"
#import "ZStudentDetailModel.h"

#import "ZSpaceEmptyCell.h"
#import "ZStudentLessonOrderNormalCell.h"
#import "ZStudentLessonDetailLessonListCell.h"
#import "ZStudentLessonSectionTitleCell.h"

@interface ZStudentLessonSureOrderVC ()
@property (nonatomic,strong) UIButton *bottomBtn;

@end

@implementation ZStudentLessonSureOrderVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initCellConfigArr];
}

- (void)initCellConfigArr {
    [super initCellConfigArr];
    
    [self.cellConfigArr addObject:getGrayEmptyCellWithHeight(CGFloatIn750(8))];
    
    NSArray *titleArr = @[@"课程", @"优惠券", @"金额总计", @"联系方式"];
    NSArray *rightTitleArr = @[@"单人瑜伽", @"新客户立减20元", @"340元", @"18811933223"];
    NSArray *rightArrowArr = @[@"", @"rightBlackArrowN", @"", @""];
    NSArray *rightColorArr = @[[UIColor colorTextGray], [UIColor colorTextGray], [UIColor colorRedDefault], [UIColor colorTextGray]];
    NSArray *cellTitleArr = @[@"lesson", @"you", @"price",@"tel"];
    
    for (int i = 0; i < titleArr.count; i++) {
        ZStudentDetailOrderSubmitListModel *model = [[ZStudentDetailOrderSubmitListModel alloc] init];
        model.leftTitle = titleArr[i];
        model.rightTitle = rightTitleArr[i];
        model.rightColor = rightColorArr[i];
        model.cellTitle = cellTitleArr[i];
        model.rightImage = rightArrowArr[i];
        
        ZCellConfig *menuCellConfig = [ZCellConfig cellConfigWithClassName:[ZStudentLessonOrderNormalCell className] title:model.cellTitle showInfoMethod:@selector(setModel:) heightOfCell:[ZStudentLessonOrderNormalCell z_getCellHeight:nil] cellType:ZCellTypeClass dataModel:model];
        [self.cellConfigArr addObject:menuCellConfig];

    }
    
    ZCellConfig *spacSectionCellConfig = [ZCellConfig cellConfigWithClassName:[ZSpaceEmptyCell className] title:[ZSpaceEmptyCell className] showInfoMethod:@selector(setBackColor:) heightOfCell:CGFloatIn750(20) cellType:ZCellTypeClass dataModel:adaptAndDarkColor([UIColor colorGrayBG], [UIColor colorGrayBGDark])];
    [self.cellConfigArr addObject:spacSectionCellConfig];
    
    //须知
    ZStudentDetailSectionModel *model = [[ZStudentDetailSectionModel alloc] init];
    model.title = @"须知";
    model.isShowRight = NO;
    ZCellConfig *lessonTitleCellConfig = [ZCellConfig cellConfigWithClassName:[ZStudentLessonSectionTitleCell className] title:[ZStudentLessonSectionTitleCell className] showInfoMethod:@selector(setModel:) heightOfCell:[ZStudentLessonSectionTitleCell z_getCellHeight:nil] cellType:ZCellTypeClass dataModel:model];
    [self.cellConfigArr addObject:lessonTitleCellConfig];
    
    NSMutableArray *list = @[].mutableCopy;
    NSArray <NSArray *>*des = @[@[@"预约须知",@"提前一天预约"], @[@"退款须知",@"购买后20天内免费，30天后退款费80%"],@[@"退款人",@"打分数档搭嘎搭嘎"]];
    for (int i = 0; i < des.count; i++) {
        ZStudentDetailDesListModel *model = [[ZStudentDetailDesListModel alloc] init];
        model.desTitle = des[i][0];
        model.desSub = des[i][1];
        [list addObject:model];
    }
    
    ZCellConfig *lessonDesCellConfig = [ZCellConfig cellConfigWithClassName:[ZStudentLessonDetailLessonListCell className] title:[ZStudentLessonDetailLessonListCell className] showInfoMethod:@selector(setList:) heightOfCell:[ZStudentLessonDetailLessonListCell z_getCellHeight:list] cellType:ZCellTypeClass dataModel:list];
    [self.cellConfigArr addObject:lessonDesCellConfig];
}


- (void)setNavigation {
    self.isHidenNaviBar = NO;
    [self.navigationItem setTitle:@"确认订单"];
}

- (void)setupMainView {
    [super setupMainView];
    
    UIView *bottomView = [[UIView alloc] initWithFrame:CGRectZero];
    bottomView.backgroundColor = adaptAndDarkColor([UIColor colorGrayBG], [UIColor colorGrayBGDark]);
    [self.view addSubview:bottomView];
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(CGFloatIn750(140));
        make.left.right.bottom.equalTo(self.view);
    }];
    
    [bottomView addSubview:self.bottomBtn];
    [self.bottomBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(bottomView.mas_top);
        make.left.equalTo(bottomView.mas_left).offset(CGFloatIn750(60));
        make.right.equalTo(bottomView.mas_right).offset(CGFloatIn750(-60));
        make.height.mas_equalTo(CGFloatIn750(80));
    }];

    [self.iTableView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.bottom.equalTo(bottomView.mas_top);
        make.top.equalTo(self.view.mas_top).offset(0);
    }];
}

#pragma mark lazy loading...
- (UIButton *)bottomBtn {
    if (!_bottomBtn) {
        __weak typeof(self) weakSelf = self;
        _bottomBtn = [[UIButton alloc] initWithFrame:CGRectZero];
        _bottomBtn.layer.masksToBounds = YES;
        _bottomBtn.layer.cornerRadius = CGFloatIn750(40);
        [_bottomBtn setTitle:@"去支付" forState:UIControlStateNormal];
        [_bottomBtn setTitleColor:[UIColor colorWhite] forState:UIControlStateNormal];
        [_bottomBtn.titleLabel setFont:[UIFont boldSystemFontOfSize:CGFloatIn750(38)]];
        [_bottomBtn setBackgroundColor:adaptAndDarkColor([UIColor colorMain], [UIColor colorMainDark]) forState:UIControlStateNormal];
        [_bottomBtn bk_whenTapped:^{
            ZStudentLessonOrderSuccessVC *successvc = [[ZStudentLessonOrderSuccessVC alloc] init];
            [weakSelf.navigationController pushViewController:successvc animated:YES];
        }];
    }
    return _bottomBtn;
}

@end

