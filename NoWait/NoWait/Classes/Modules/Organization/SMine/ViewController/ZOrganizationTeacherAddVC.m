//
//  ZOrganizationTeacherAddVC.m
//  NoWait
//
//  Created by zhuang zhang on 2020/2/19.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZOrganizationTeacherAddVC.h"
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

@interface ZOrganizationTeacherAddVC ()
@property (nonatomic,strong) UIButton *bottomBtn;

@end

@implementation ZOrganizationTeacherAddVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNavigation];
    [self initCellConfigArr];
}


- (void)initCellConfigArr {
    [super initCellConfigArr];
    
    ZCellConfig *progressCellConfig = [ZCellConfig cellConfigWithClassName:[ZOriganizationTeachAddHeadImageCell className] title:[ZOriganizationTeachAddHeadImageCell className] showInfoMethod:nil heightOfCell:[ZOriganizationTeachAddHeadImageCell z_getCellHeight:nil] cellType:ZCellTypeClass dataModel:nil];
    [self.cellConfigArr addObject:progressCellConfig];
    
    NSArray *textArr = @[@[@"真实姓名", @"请输入真实姓名", @YES, @"", @"name"],
                         @[@"昵称", @"请输入昵称", @YES, @"", @"nikeName"],
                         @[@"性别", @"请选择性别", @NO, @"rightBlackArrowN", @"sex"],
                         @[@"手机号", @"请输入手机号", @YES, @"", @"phone"],
                         @[@"身份证号码", @"请输入身份号", @YES, @"", @"cid"],
                        @[@"任课校区", @"请选择校区", @NO, @"rightBlackArrowN", @"address"],
                        @[@"教师等级", @"请选择等级", @NO, @"rightBlackArrowN", @"class"],
                        @[@"教师职称", @"请输入教师职称", @YES, @"", @"title"],
                        @[@"任课课程", @"请选择课程", @NO, @"rightBlackArrowN", @"lesson"],
                        @[@"特长技能", @"请添加特长技能", @NO, @"rightBlackArrowN", @"skill"]];
    
    for (int i = 0; i < textArr.count; i++) {
        if (i == 9) {
            ZBaseTextFieldCellModel *cellModel = [[ZBaseTextFieldCellModel alloc] init];
            cellModel.leftTitle = textArr[i][0];
            cellModel.placeholder = textArr[i][1];
            cellModel.isTextEnabled = [textArr[i][2] boolValue];
            cellModel.rightImage = textArr[i][3];
            cellModel.isHiddenLine = YES;
            cellModel.cellHeight = CGFloatIn750(108);
            cellModel.contBackMargin = CGFloatIn750(0);
            cellModel.contentSpace = CGFloatIn750(30);
            cellModel.leftFont = [UIFont boldFontTitle];
            cellModel.data = @[@"免费停车",@"免费停车",@"免费停车",@"免费停车",@"免费停车"];
            ZCellConfig *textCellConfig = [ZCellConfig cellConfigWithClassName:[ZOrganizationCampusTextLabelCell className] title:textArr[i][4] showInfoMethod:@selector(setModel:) heightOfCell:[ZOrganizationCampusTextLabelCell z_getCellHeight:cellModel] cellType:ZCellTypeClass dataModel:cellModel];
            [self.cellConfigArr addObject:textCellConfig];
        }else{
            ZBaseTextFieldCellModel *cellModel = [[ZBaseTextFieldCellModel alloc] init];
            cellModel.leftTitle = textArr[i][0];
            cellModel.placeholder = textArr[i][1];
            cellModel.isTextEnabled = [textArr[i][2] boolValue];
            cellModel.rightImage = textArr[i][3];
            cellModel.isHiddenLine = YES;
            cellModel.cellHeight = CGFloatIn750(108);
            ZCellConfig *textCellConfig = [ZCellConfig cellConfigWithClassName:[ZTextFieldCell className] title:textArr[i][4] showInfoMethod:@selector(setModel:) heightOfCell:[ZTextFieldCell z_getCellHeight:cellModel] cellType:ZCellTypeClass dataModel:cellModel];
            [self.cellConfigArr addObject:textCellConfig];
            
            if (i == 4) {
                ZCellConfig *textCellConfig = [ZCellConfig cellConfigWithClassName:[ZOriganizationIDCardCell className] title:@"IDCard" showInfoMethod:nil heightOfCell:[ZOriganizationIDCardCell z_getCellHeight:nil] cellType:ZCellTypeClass dataModel:cellModel];
                [self.cellConfigArr addObject:textCellConfig];
            }
        }
    }
    
    {
        ZBaseSingleCellModel *model = [[ZBaseSingleCellModel alloc] init];
        model.leftTitle = @"教师简介";
        model.leftFont = [UIFont boldFontTitle];
        model.isHiddenLine = YES;
        model.cellHeight = CGFloatIn750(92);
        
        ZCellConfig *menuCellConfig = [ZCellConfig cellConfigWithClassName:[ZSingleLineCell className] title:model.cellTitle showInfoMethod:@selector(setModel:) heightOfCell:[ZSingleLineCell z_getCellHeight:model] cellType:ZCellTypeClass dataModel:model];
        
        [self.cellConfigArr addObject:menuCellConfig];
        
        ZCellConfig *textCellConfig = [ZCellConfig cellConfigWithClassName:[ZOriganizationTextViewCell className] title:model.cellTitle showInfoMethod:@selector(setIsBackColor:) heightOfCell:CGFloatIn750(274) cellType:ZCellTypeClass dataModel:@"yes"];
        
        [self.cellConfigArr addObject:textCellConfig];
        
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
            model.name = @"必选";
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
    [self.navigationItem setTitle:@"新增教师"];
}

- (void)setupMainView {
    [super setupMainView];
   
    [self.iTableView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(CGFloatIn750(0));
        make.right.equalTo(self.view.mas_right).offset(CGFloatIn750(-0));
        make.bottom.equalTo(self.view.mas_bottom).offset(-CGFloatIn750(0));
        make.top.equalTo(self.view.mas_top).offset(-CGFloatIn750(0));
    }];
    
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
- (void)zz_tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath cellConfig:(ZCellConfig *)cellConfig  {
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
