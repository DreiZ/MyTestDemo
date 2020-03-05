//
//  ZOrganizationTeacherDetailVC.m
//  NoWait
//
//  Created by zhuang zhang on 2020/2/19.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZOrganizationTeacherDetailVC.h"
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

@interface ZOrganizationTeacherDetailVC ()
@property (nonatomic,strong) UIButton *bottomBtn;
@property (nonatomic,strong) UIButton *navRightBtn;

@end

@implementation ZOrganizationTeacherDetailVC

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
                         @[@"昵称",@"苦涩的黄渤"],
                         @[@"性别",@"男"],
                         @[@"手机号",@"1923452384"],
                         @[@"身份证号码",@"32342352352342"],
                        @[@"任课校区",@"才玩俱乐部"],
                        @[@"教师等级",@"普通教师"],
                        @[@"教师职称",@"哆咪屋"],
                        @[@"任课课程",@""],
                        @[@"特长技能", @"名字特长"]];
    
    for (int i = 0; i < textArr.count; i++) {
        if (i == 9) {
            ZBaseTextFieldCellModel *cellModel = [[ZBaseTextFieldCellModel alloc] init];
            cellModel.leftTitle = textArr[i][0];
            cellModel.isTextEnabled = NO;
            cellModel.isHiddenLine = YES;
            cellModel.cellHeight = CGFloatIn750(108);
            cellModel.contBackMargin = CGFloatIn750(0);
            cellModel.contentSpace = CGFloatIn750(30);
            cellModel.leftFont = [UIFont boldFontTitle];
            cellModel.textColor = [UIColor colorTextGray];
            cellModel.textDarkColor = [UIColor colorTextGrayDark];
            cellModel.data = @[@"哆咪屋  147元  230元",@"哆咪屋  147元  230元",@"哆咪屋  147元  230元",@"免哆咪屋  147元  230元",@"哆咪屋  147元  230元"];
            ZCellConfig *textCellConfig = [ZCellConfig cellConfigWithClassName:[ZOrganizationCampusTextLabelCell className] title:@"content" showInfoMethod:@selector(setModel:) heightOfCell:[ZOrganizationCampusTextLabelCell z_getCellHeight:cellModel] cellType:ZCellTypeClass dataModel:cellModel];
            [self.cellConfigArr addObject:textCellConfig];
        }else{
            ZBaseTextFieldCellModel *cellModel = [[ZBaseTextFieldCellModel alloc] init];
            cellModel.leftTitle = textArr[i][0];
            cellModel.isTextEnabled = NO;
            cellModel.isHiddenLine = YES;
            cellModel.cellHeight = CGFloatIn750(108);
            cellModel.content = textArr[i][1];
            cellModel.textColor = [UIColor colorTextGray];
            cellModel.textDarkColor = [UIColor colorTextGrayDark];
            ZCellConfig *textCellConfig = [ZCellConfig cellConfigWithClassName:[ZTextFieldCell className] title:@"content" showInfoMethod:@selector(setModel:) heightOfCell:[ZTextFieldCell z_getCellHeight:cellModel] cellType:ZCellTypeClass dataModel:cellModel];
            [self.cellConfigArr addObject:textCellConfig];
        }
    }
    
    {
        ZCellConfig *topCellConfig = [ZCellConfig cellConfigWithClassName:[ZSpaceEmptyCell className] title:[ZSpaceEmptyCell className] showInfoMethod:@selector(setBackColor:) heightOfCell:CGFloatIn750(20) cellType:ZCellTypeClass dataModel:adaptAndDarkColor([UIColor colorWhite], [UIColor colorBlackBGDark])];
        [self.cellConfigArr addObject:topCellConfig];
        
        ZBaseSingleCellModel *model = [[ZBaseSingleCellModel alloc] init];
        model.leftTitle = @"教师简介";
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
        model.leftTitle = @"教师相册";
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
    [self.navigationItem setTitle:@"教师"];
    
    [self.navigationItem setRightBarButtonItem:[[UIBarButtonItem alloc] initWithCustomView:self.navRightBtn]];
}

- (void)setupMainView {
    [super setupMainView];
    
    UIView *bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, CGFloatIn750(160))];
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
        [_bottomBtn setTitle:@"保存" forState:UIControlStateNormal];
        [_bottomBtn setTitleColor:[UIColor colorWhite] forState:UIControlStateNormal];
        [_bottomBtn.titleLabel setFont:[UIFont fontContent]];
        [_bottomBtn setBackgroundColor:[UIColor  colorMain] forState:UIControlStateNormal];
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
