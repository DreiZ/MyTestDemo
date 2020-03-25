//
//  ZOrganizationStudentUpStarVC.m
//  NoWait
//
//  Created by zhuang zhang on 2020/2/22.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZOrganizationStudentUpStarVC.h"
#import "ZOriganizationTeachListCell.h"
#import "ZOriganizationTeachAddHeadImageCell.h"
#import "ZOrganizationLessonAddPhotosCell.h"
#import "ZOriganizationTextViewCell.h"
#import "ZOriganizationIDCardCell.h"
#import "ZOrganizationCampusTextLabelCell.h"

#import "ZBaseUnitModel.h"
#import "ZAlertDataSinglePickerView.h"
#import "ZAlertDataPickerView.h"

#import "ZOrganizationCampusManageAddLabelVC.h"
#import "ZOrganizationTeacherLessonSelectVC.h"

@interface ZOrganizationStudentUpStarVC ()
@property (nonatomic,strong) UIButton *bottomBtn;

@end

@implementation ZOrganizationStudentUpStarVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNavigation];
    [self initCellConfigArr];
}

- (void)initCellConfigArr {
    [super initCellConfigArr];
    {
        ZCellConfig *topCellConfig = [ZCellConfig cellConfigWithClassName:[ZSpaceEmptyCell className] title:[ZSpaceEmptyCell className] showInfoMethod:@selector(setBackColor:) heightOfCell:CGFloatIn750(20) cellType:ZCellTypeClass dataModel:adaptAndDarkColor([UIColor colorWhite], [UIColor colorBlackBGDark])];
        [self.cellConfigArr addObject:topCellConfig];
        
        ZBaseSingleCellModel *model = [[ZBaseSingleCellModel alloc] init];
        model.leftTitle = @"学员风采";
        model.leftFont = [UIFont boldFontTitle];
        model.isHiddenLine = YES;
        model.cellHeight = CGFloatIn750(92);
        
        ZCellConfig *menuCellConfig = [ZCellConfig cellConfigWithClassName:[ZSingleLineCell className] title:model.cellTitle showInfoMethod:@selector(setModel:) heightOfCell:[ZSingleLineCell z_getCellHeight:model] cellType:ZCellTypeClass dataModel:model];
        
        [self.cellConfigArr addObject:menuCellConfig];
        
        ZCellConfig *textCellConfig = [ZCellConfig cellConfigWithClassName:[ZOriganizationTextViewCell className] title:model.cellTitle showInfoMethod:@selector(setIsBackColor:) heightOfCell:CGFloatIn750(274) cellType:ZCellTypeClass dataModel:@"yes"];
        
        [self.cellConfigArr addObject:textCellConfig];
        
        ZCellConfig *bottomCellConfig = [ZCellConfig cellConfigWithClassName:[ZSpaceEmptyCell className] title:[ZSpaceEmptyCell className] showInfoMethod:@selector(setBackColor:) heightOfCell:CGFloatIn750(40) cellType:ZCellTypeClass dataModel:adaptAndDarkColor([UIColor colorWhite], [UIColor colorBlackBGDark])];
        [self.cellConfigArr addObject:bottomCellConfig];
        
    }
    {
            ZBaseSingleCellModel *model = [[ZBaseSingleCellModel alloc] init];
            model.leftTitle = @"学员风采";
            model.leftFont = [UIFont boldFontTitle];
            model.isHiddenLine = YES;
            model.cellHeight = CGFloatIn750(92);
            
            ZCellConfig *menuCellConfig = [ZCellConfig cellConfigWithClassName:[ZSingleLineCell className] title:model.cellTitle showInfoMethod:@selector(setModel:) heightOfCell:[ZSingleLineCell z_getCellHeight:model] cellType:ZCellTypeClass dataModel:model];
            
            [self.cellConfigArr addObject:menuCellConfig];
        }
        
        {
            ZBaseMenuModel *model = [[ZBaseMenuModel alloc] init];
            
            NSMutableArray *menulist = @[].mutableCopy;
            for (int j = 0; j < 9; j++) {
                ZBaseUnitModel *model = [[ZBaseUnitModel alloc] init];
    //            model.name = tempArr[j][0];
    //            model.imageName = tempArr[j][1];
    //            model.uid = tempArr[j][2];
                [menulist addObject:model];
            }
            
            model.units = menulist;
            
            ZCellConfig *progressCellConfig = [ZCellConfig cellConfigWithClassName:[ZOrganizationLessonAddPhotosCell className] title:[ZOrganizationLessonAddPhotosCell className] showInfoMethod:@selector(setModel:) heightOfCell:[ZOrganizationLessonAddPhotosCell z_getCellHeight:menulist] cellType:ZCellTypeClass dataModel:model];
            [self.cellConfigArr addObject:progressCellConfig];
        }
   
}

- (void)setNavigation {
    self.isHidenNaviBar = NO;
    [self.navigationItem setTitle:@"升级明星学员"];
}

- (void)setupMainView {
    [super setupMainView];
    
    UIView *bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, CGFloatIn750(140))];
    bottomView.backgroundColor = adaptAndDarkColor([UIColor colorWhite], [UIColor colorBlackBGDark]);
    self.iTableView.tableFooterView = bottomView;
    
    [bottomView addSubview:self.bottomBtn];
    [self.bottomBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(bottomView.mas_left).offset(CGFloatIn750(60));
        make.right.equalTo(bottomView.mas_right).offset(CGFloatIn750(-60));
        make.height.mas_equalTo(CGFloatIn750(80));
        make.centerY.equalTo(bottomView.mas_centerY);
    }];
}

#pragma mark lazy loading...
- (UIButton *)bottomBtn {
    if (!_bottomBtn) {
        __weak typeof(self) weakSelf = self;
        _bottomBtn = [[UIButton alloc] initWithFrame:CGRectZero];
        _bottomBtn.layer.masksToBounds = YES;
        _bottomBtn.layer.cornerRadius = CGFloatIn750(40);
        [_bottomBtn setTitle:@"保存" forState:UIControlStateNormal];
        [_bottomBtn setTitleColor:[UIColor colorWhite] forState:UIControlStateNormal];
        [_bottomBtn.titleLabel setFont:[UIFont fontContent]];
        [_bottomBtn setBackgroundColor:adaptAndDarkColor([UIColor colorMain], [UIColor colorMainDark]) forState:UIControlStateNormal];
        [_bottomBtn bk_whenTapped:^{
            
        }];
    }
    return _bottomBtn;
}

#pragma mark tableView -------datasource-----
- (void)zz_tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath cellConfig:(ZCellConfig *)cellConfig {
    if ([cellConfig.title isEqualToString:@"sex"]) {
        NSMutableArray *items = @[].mutableCopy;
        NSArray *temp = @[@"男",@"女"];
        for (int i = 0; i < temp.count; i++) {
           ZAlertDataItemModel *model = [[ZAlertDataItemModel alloc] init];
           model.name = temp[i];
           [items addObject:model];
        }
        
        [ZAlertDataSinglePickerView setAlertName:@"性别选择" items:items handlerBlock:^(NSInteger index) {
           
        }];
    }else if ([cellConfig.title isEqualToString:@"address"]){
        NSMutableArray *items = @[].mutableCopy;
        NSArray *temp = @[@"徐州"];
        for (int i = 0; i < temp.count; i++) {
           ZAlertDataItemModel *model = [[ZAlertDataItemModel alloc] init];
           model.name = temp[i];
           
           NSMutableArray *subItems = @[].mutableCopy;
           
           NSArray *temp = @[@"篮球",@"排球",@"乒乓球",@"足球"];
           for (int i = 0; i < temp.count; i++) {
               ZAlertDataItemModel *model = [[ZAlertDataItemModel alloc] init];
               model.name = temp[i];
               [subItems addObject:model];
           }
           model.ItemArr = subItems;
           [items addObject:model];
        }
        [ZAlertDataPickerView setAlertName:@"校区选择" items:items handlerBlock:^(NSInteger index, NSInteger subIndex) {
           
        }];
    }else if ([cellConfig.title isEqualToString:@"class"]) {
        NSMutableArray *items = @[].mutableCopy;
        NSArray *temp = @[@"初级教师",@"高级教师"];
        for (int i = 0; i < temp.count; i++) {
            ZAlertDataItemModel *model = [[ZAlertDataItemModel alloc] init];
            model.name = temp[i];
            [items addObject:model];
        }
        
        [ZAlertDataSinglePickerView setAlertName:@"教师等级" items:items handlerBlock:^(NSInteger index) {
            
        }];
    }else if ([cellConfig.title isEqualToString:@"skill"]) {
        ZOrganizationCampusManageAddLabelVC *avc = [[ZOrganizationCampusManageAddLabelVC alloc] init];
        
        [self.navigationController pushViewController:avc animated:YES];
    }else if ([cellConfig.title isEqualToString:@"lesson"]) {
        ZOrganizationTeacherLessonSelectVC *avc = [[ZOrganizationTeacherLessonSelectVC alloc] init];
        
        [self.navigationController pushViewController:avc animated:YES];
    }
}

@end
