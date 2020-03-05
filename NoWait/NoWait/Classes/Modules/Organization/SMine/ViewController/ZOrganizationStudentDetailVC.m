//
//  ZOrganizationStudentDetailVC.m
//  NoWait
//
//  Created by zhuang zhang on 2020/2/22.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZOrganizationStudentDetailVC.h"
#import "ZOriganizationTeachListCell.h"
#import "ZOriganizationTeachAddHeadImageCell.h"
#import "ZOrganizationLessonAddPhotosCell.h"
#import "ZOriganizationTextViewCell.h"
#import "ZOriganizationIDCardCell.h"
#import "ZOrganizationCampusTextLabelCell.h"
#import "ZMineStudentEvaListEvaOrderDesCell.h"
#import "ZOriganizationTeachHeadImageCell.h"

#import "ZBaseUnitModel.h"
#import "ZAlertDataSinglePickerView.h"
#import "ZAlertDataPickerView.h"

#import "ZOrganizationCampusManageAddLabelVC.h"
#import "ZOrganizationTeacherLessonSelectVC.h"
#import "ZOrganizationStudentSignDetailVC.h"
#import "ZOrganizationStudentUpStarVC.h"

@interface ZOrganizationStudentDetailVC ()
@property (nonatomic,strong) UIButton *bottomBtn;
@property (nonatomic,strong) UIButton *navRightBtn;
@end

@implementation ZOrganizationStudentDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNavigation];
    [self initCellConfigArr];
}


- (void)initCellConfigArr {
    [super initCellConfigArr];
    
    ZCellConfig *progressCellConfig = [ZCellConfig cellConfigWithClassName:[ZOriganizationTeachHeadImageCell className] title:[ZOriganizationTeachHeadImageCell className] showInfoMethod:nil heightOfCell:[ZOriganizationTeachHeadImageCell z_getCellHeight:nil] cellType:ZCellTypeClass dataModel:nil];
    [self.cellConfigArr addObject:progressCellConfig];
    
    NSArray *textArr = @[@[@"真实姓名",@"黄渤"],
                         @[@"手机号",@"1923452384"],
                         @[@"性别",@"男"],
                         @[@"出生日期",@"2000年12月21日"],
                         @[@"身份证号码",@"32342352352342"],
                         @[@"所属校区",@"才玩俱乐部"],
                         @[@"报名日期",@"2000年12月21日"],
                         @[@"报名课程",@"拉丁舞"],
                         @[@"分配教师",@"哆咪屋"],
                         @[@"紧急联系人姓名",@"实得分"],
                         @[@"紧急联系人电话",@"12312412412"],
                         @[@"紧急联系人关系",@"父子"],
                         @[@"课程进度", @"10/23节"],
                         @[@"优惠明细", @"满减12"],
                         @[@"学员状态", @"已开课"],
                         @[@"开课日期", @"2000年12月21日"],
                         @[@"班级名称", @"瑜伽班"],
                         @[@"签到详情", @"查看"],
                         @[@"报名须知", @"查看"]];
    
    for (int i = 0; i < textArr.count; i++) {
       ZBaseTextFieldCellModel *cellModel = [[ZBaseTextFieldCellModel alloc] init];
        cellModel.leftTitle = textArr[i][0];
        cellModel.isTextEnabled = NO;
        cellModel.isHiddenLine = YES;
        cellModel.cellHeight = CGFloatIn750(108);
        cellModel.content = textArr[i][1];
        cellModel.textColor = [UIColor colorTextGray];
        cellModel.textDarkColor = [UIColor colorTextGrayDark];
        cellModel.leftContentWidth = CGFloatIn750(324);
        if (i == 17 || i == 18) {
            cellModel.rightImage = @"rightBlackArrowN";
            if (i == 17) {
                cellModel.cellTitle = @"sign";
            }
        }
        ZCellConfig *textCellConfig = [ZCellConfig cellConfigWithClassName:[ZTextFieldCell className] title:cellModel.cellTitle showInfoMethod:@selector(setModel:) heightOfCell:[ZTextFieldCell z_getCellHeight:cellModel] cellType:ZCellTypeClass dataModel:cellModel];
        [self.cellConfigArr addObject:textCellConfig];
        
        if(i == 11){
            ZCellConfig *topCellConfig = [ZCellConfig cellConfigWithClassName:[ZSpaceEmptyCell className] title:[ZSpaceEmptyCell className] showInfoMethod:@selector(setBackColor:) heightOfCell:CGFloatIn750(30) cellType:ZCellTypeClass dataModel:adaptAndDarkColor([UIColor colorWhite], [UIColor colorBlackBGDark])];
            [self.cellConfigArr addObject:topCellConfig];
              
            ZBaseSingleCellModel *model = [[ZBaseSingleCellModel alloc] init];
            model.isHiddenLine = NO;
            model.lineLeftMargin = CGFloatIn750(30);
            model.lineRightMargin = CGFloatIn750(30);
            model.cellHeight = CGFloatIn750(1);
              
          ZCellConfig *menuCellConfig = [ZCellConfig cellConfigWithClassName:[ZSingleLineCell className] title:model.cellTitle showInfoMethod:@selector(setModel:) heightOfCell:[ZSingleLineCell z_getCellHeight:model] cellType:ZCellTypeClass dataModel:model];
          [self.cellConfigArr addObject:menuCellConfig];
            
   
          ZCellConfig *bottomCellConfig = [ZCellConfig cellConfigWithClassName:[ZSpaceEmptyCell className] title:[ZSpaceEmptyCell className] showInfoMethod:@selector(setBackColor:) heightOfCell:CGFloatIn750(30) cellType:ZCellTypeClass dataModel:adaptAndDarkColor([UIColor colorWhite], [UIColor colorBlackBGDark])];
          [self.cellConfigArr addObject:bottomCellConfig];
        }
    }
    
    {
        ZCellConfig *topCellConfig = [ZCellConfig cellConfigWithClassName:[ZSpaceEmptyCell className] title:[ZSpaceEmptyCell className] showInfoMethod:@selector(setBackColor:) heightOfCell:CGFloatIn750(30) cellType:ZCellTypeClass dataModel:adaptAndDarkColor([UIColor colorWhite], [UIColor colorBlackBGDark])];
         [self.cellConfigArr addObject:topCellConfig];
           
         ZBaseSingleCellModel *model = [[ZBaseSingleCellModel alloc] init];
         model.isHiddenLine = NO;
         model.lineLeftMargin = CGFloatIn750(30);
         model.lineRightMargin = CGFloatIn750(30);
         model.cellHeight = CGFloatIn750(1);
           
       ZCellConfig *menuCellConfig = [ZCellConfig cellConfigWithClassName:[ZSingleLineCell className] title:model.cellTitle showInfoMethod:@selector(setModel:) heightOfCell:[ZSingleLineCell z_getCellHeight:model] cellType:ZCellTypeClass dataModel:model];
       [self.cellConfigArr addObject:menuCellConfig];
         

       ZCellConfig *bottomCellConfig = [ZCellConfig cellConfigWithClassName:[ZSpaceEmptyCell className] title:[ZSpaceEmptyCell className] showInfoMethod:@selector(setBackColor:) heightOfCell:CGFloatIn750(30) cellType:ZCellTypeClass dataModel:adaptAndDarkColor([UIColor colorWhite], [UIColor colorBlackBGDark])];
       [self.cellConfigArr addObject:bottomCellConfig];
    }
    
    {
        ZCellConfig *topCellConfig = [ZCellConfig cellConfigWithClassName:[ZSpaceEmptyCell className] title:[ZSpaceEmptyCell className] showInfoMethod:@selector(setBackColor:) heightOfCell:CGFloatIn750(20) cellType:ZCellTypeClass dataModel:adaptAndDarkColor([UIColor colorWhite], [UIColor colorBlackBGDark])];
        [self.cellConfigArr addObject:topCellConfig];
        
        ZBaseSingleCellModel *model = [[ZBaseSingleCellModel alloc] init];
        model.leftTitle = @"学习履历";
        model.leftFont = [UIFont boldFontTitle];
        model.isHiddenLine = YES;
        model.cellHeight = CGFloatIn750(52);
        
        ZCellConfig *menuCellConfig = [ZCellConfig cellConfigWithClassName:[ZSingleLineCell className] title:model.cellTitle showInfoMethod:@selector(setModel:) heightOfCell:[ZSingleLineCell z_getCellHeight:model] cellType:ZCellTypeClass dataModel:model];
        [self.cellConfigArr addObject:menuCellConfig];
      
        
        ZBaseMultiseriateCellModel *mModel = [[ZBaseMultiseriateCellModel alloc] init];
        mModel.rightFont = [UIFont fontContent];
        mModel.rightColor = adaptAndDarkColor([UIColor colorTextGray], [UIColor colorTextGrayDark]);
        mModel.singleCellHeight = CGFloatIn750(50);
        mModel.rightTitle = @"公司的风格就是金融家坡附近公婆奇偶陪伴是结算表是哦蓬勃是颇尔是富婆代表GV公司的风格就是金融家坡附近公婆奇偶陪伴是结算表是哦蓬勃是颇尔是富婆代表GV公司的风格就是金融家坡附近公婆奇偶陪伴是结算表是哦蓬勃是颇尔是富婆代表GV公司的风格就是金融家坡附近公婆奇偶陪伴是结算表是哦蓬勃是颇尔是富婆代表GV";
        ZCellConfig *textCellConfig = [ZCellConfig cellConfigWithClassName:[ZMultiseriateLineCell className] title:mModel.cellTitle showInfoMethod:@selector(setMModel:) heightOfCell:[ZMultiseriateLineCell z_getCellHeight:mModel] cellType:ZCellTypeClass dataModel:mModel];
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
            model.name = @"必选";
            [menulist addObject:model];
        }
        
        model.units = menulist;
        
        ZCellConfig *progressCellConfig = [ZCellConfig cellConfigWithClassName:[ZOrganizationLessonAddPhotosCell className] title:[ZOrganizationLessonAddPhotosCell className] showInfoMethod:@selector(setModel:) heightOfCell:[ZOrganizationLessonAddPhotosCell z_getCellHeight:menulist] cellType:ZCellTypeClass dataModel:model];
        [self.cellConfigArr addObject:progressCellConfig];
    }
}

- (void)setNavigation {
    self.isHidenNaviBar = NO;
    [self.navigationItem setTitle:@"学员详情"];
    
    [self.navigationItem setRightBarButtonItem:[[UIBarButtonItem alloc] initWithCustomView:self.navRightBtn]];
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
- (UIButton *)navRightBtn {
     if (!_navRightBtn) {
//         __weak typeof(self) weakSelf = self;
         _navRightBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, CGFloatIn750(90), CGFloatIn750(50))];
         [_navRightBtn setTitle:@"编辑" forState:UIControlStateNormal];
         [_navRightBtn setTitleColor:[UIColor colorMain] forState:UIControlStateNormal];
         [_navRightBtn.titleLabel setFont:[UIFont fontSmall]];
         [_navRightBtn bk_whenTapped:^{
            
         }];
     }
     return _navRightBtn;
}
  
- (UIButton *)bottomBtn {
    if (!_bottomBtn) {
        __weak typeof(self) weakSelf = self;
        _bottomBtn = [[UIButton alloc] initWithFrame:CGRectZero];
        _bottomBtn.layer.masksToBounds = YES;
        _bottomBtn.layer.cornerRadius = CGFloatIn750(40);
        [_bottomBtn setTitle:@"升级明星学员" forState:UIControlStateNormal];
        [_bottomBtn setTitleColor:[UIColor colorWhite] forState:UIControlStateNormal];
        [_bottomBtn.titleLabel setFont:[UIFont fontContent]];
        [_bottomBtn setBackgroundColor:[UIColor  colorMain] forState:UIControlStateNormal];
        [_bottomBtn bk_whenTapped:^{
            ZOrganizationStudentUpStarVC *uvc = [[ZOrganizationStudentUpStarVC alloc] init];
            [weakSelf.navigationController pushViewController:uvc animated:YES];
        }];
    }
    return _bottomBtn;
}

#pragma mark tableView -------datasource-----
- (void)zz_tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath cellConfig:(ZCellConfig *)cellConfig {
    if ([cellConfig.title isEqualToString:@"sign"]) {
        ZOrganizationStudentSignDetailVC *dvc = [[ZOrganizationStudentSignDetailVC alloc] init];
        [self.navigationController pushViewController:dvc animated:YES];
    }else if ([cellConfig.title isEqualToString:@"address"]){
       
    }
}

@end
