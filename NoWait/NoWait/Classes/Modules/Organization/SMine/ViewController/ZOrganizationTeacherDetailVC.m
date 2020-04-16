//
//  ZOrganizationTeacherDetailVC.m
//  NoWait
//
//  Created by zhuang zhang on 2020/2/19.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZOrganizationTeacherDetailVC.h"
#import "ZOriganizationTeachAddHeadImageCell.h"
#import "ZOrganizationLessonAddPhotosCell.h"
#import "ZOriganizationTextViewCell.h"
#import "ZOrganizationCampusTextLabelCell.h"
#import "ZOriganizationTeachHeadImageCell.h"
#import "ZMultiseriateContentLeftLineCell.h"
#import "ZOriganizationLessonModel.h"
#import "ZOrganizationTeacherAddVC.h"

@interface ZOrganizationTeacherDetailVC ()
@property (nonatomic,strong) UIButton *navRightBtn;

@end

@implementation ZOrganizationTeacherDetailVC
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self refreshData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNavigation];
    [self initCellConfigArr];
}

- (void)initCellConfigArr {
    [super initCellConfigArr];
    
    ZCellConfig *progressCellConfig = [ZCellConfig cellConfigWithClassName:[ZOriganizationTeachHeadImageCell className] title:[ZOriganizationTeachHeadImageCell className] showInfoMethod:@selector(setImage:) heightOfCell:[ZOriganizationTeachHeadImageCell z_getCellHeight:nil] cellType:ZCellTypeClass dataModel:imageFullUrl(self.addModel.image)];
    [self.cellConfigArr addObject:progressCellConfig];
    
    NSArray *textArr = @[@[@"真实姓名",SafeStr(self.addModel.real_name)],
                         @[@"昵称",SafeStr(self.addModel.nick_name)],
                         @[@"性别",[SafeStr(self.addModel.sex) intValue] == 1 ? @"男":@"女"],
                         @[@"手机号",SafeStr(self.addModel.phone)],
                         @[@"身份证号码",SafeStr(self.addModel.id_card)],
                         @[@"教师等级",[SafeStr(self.addModel.c_level) intValue] == 1 ? @"普通教师":@"明星教师"],
                        @[@"教师职称",SafeStr(self.addModel.position)],
                        @[@"任课课程",@""],
                        @[@"特长技能", @""]];
    
    for (int i = 0; i < textArr.count; i++) {
        if (i == 8 || i == 7) {
            ZBaseTextFieldCellModel *cellModel = [[ZBaseTextFieldCellModel alloc] init];
            cellModel.leftTitle = textArr[i][0];
            cellModel.isTextEnabled = NO;
            cellModel.isHiddenLine = YES;
            cellModel.cellWidth = KScreenWidth;
            cellModel.cellHeight = CGFloatIn750(108);
            cellModel.contBackMargin = CGFloatIn750(0);
            cellModel.contentSpace = CGFloatIn750(30);
            cellModel.leftFont = [UIFont boldFontTitle];
            cellModel.textColor = [UIColor colorTextGray];
            cellModel.textDarkColor = [UIColor colorTextGrayDark];
            if (i == 8) {
                cellModel.data = self.addModel.skills;
            }else{
                NSMutableArray *temp = @[].mutableCopy;
                for (ZOriganizationLessonListModel *tmodel in self.addModel.lessonList) {
                    [temp addObject:[NSString stringWithFormat:@"%@    %@元    %@元",tmodel.short_name,SafeStr(tmodel.price),ValidStr(tmodel.teacherPirce)?  SafeStr(tmodel.teacherPirce) : SafeStr(tmodel.price)]];
                }
                cellModel.data = temp;
            }
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
        mModel.rightTitle = self.addModel.des;
        ZCellConfig *textCellConfig = [ZCellConfig cellConfigWithClassName:[ZMultiseriateContentLeftLineCell className] title:mModel.cellTitle showInfoMethod:@selector(setMModel:) heightOfCell:[ZMultiseriateContentLeftLineCell z_getCellHeight:mModel] cellType:ZCellTypeClass dataModel:mModel];
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
        for (int j = 0; j < self.addModel.images_list.count; j++) {
            ZBaseUnitModel *model = [[ZBaseUnitModel alloc] init];
//            model.name = tempArr[j][0];
            if (j < self.addModel.images_list.count) {
                model.data = imageFullUrl(SafeStr(self.addModel.images_list[j]));
            }
            
            model.isEdit = NO;
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
    
    UIView *bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, CGFloatIn750(10) + safeAreaBottom())];
    bottomView.backgroundColor = adaptAndDarkColor([UIColor colorWhite], [UIColor colorBlackBGDark]);
    self.iTableView.tableFooterView = bottomView;
    
}

#pragma mark - lazy loading...
- (UIButton *)navRightBtn {
     if (!_navRightBtn) {
         __weak typeof(self) weakSelf = self;
         _navRightBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, CGFloatIn750(90), CGFloatIn750(50))];
         [_navRightBtn setTitle:@"编辑" forState:UIControlStateNormal];
         [_navRightBtn setTitleColor:adaptAndDarkColor([UIColor colorMain], [UIColor colorMainDark]) forState:UIControlStateNormal];
         [_navRightBtn.titleLabel setFont:[UIFont fontContent]];
         [_navRightBtn bk_whenTapped:^{
            ZOrganizationTeacherAddVC *avc = [[ZOrganizationTeacherAddVC alloc] init];
            avc.viewModel.addModel = weakSelf.addModel;
            avc.isEdit = YES;
            [weakSelf.navigationController pushViewController:avc animated:YES];
         }];
     }
     return _navRightBtn;
}


- (ZOriganizationTeacherAddModel *)addModel {
    if (!_addModel) {
        _addModel = [[ZOriganizationTeacherAddModel alloc] init];
    }
    return _addModel;
}


- (void)refreshData {
    __weak typeof(self) weakSelf = self;
    [ZOriganizationTeacherViewModel getStoresTeacherDetail:@{@"id":SafeStr(self.addModel.teacherID)} completeBlock:^(BOOL isSuccess, ZOriganizationTeacherAddModel *addModel) {
        if (isSuccess) {
            weakSelf.addModel = addModel;
            [weakSelf initCellConfigArr];
            [weakSelf.iTableView reloadData];
        }
    }];
}
@end
