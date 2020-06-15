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
#import "ZOriganizationLessonModel.h"
#import "ZOrganizationTeacherAddVC.h"
#import "ZTeacherLessonDetailListVC.h"

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
        if ([textArr[i][0] isEqualToString:@"特长技能"] || [textArr[i][0] isEqualToString:@"任课课程"]) {
            ZBaseTextFieldCellModel *cellModel = [[ZBaseTextFieldCellModel alloc] init];
            cellModel.leftTitle = textArr[i][0];
            cellModel.isTextEnabled = YES;
            cellModel.isHiddenLine = YES;
            cellModel.cellWidth = KScreenWidth;
            cellModel.cellHeight = CGFloatIn750(86);
            cellModel.contBackMargin = CGFloatIn750(0);
            cellModel.contentSpace = CGFloatIn750(30);
            cellModel.leftFont = [UIFont fontContent];
            cellModel.textColor = [UIColor colorTextGray];
            cellModel.textDarkColor = [UIColor colorTextGrayDark];
            if ([textArr[i][0] isEqualToString:@"特长技能"]) {
                cellModel.data = self.addModel.skills;
            }else{
                NSMutableArray *temp = @[].mutableCopy;
                for (ZOriganizationLessonListModel *tmodel in self.addModel.lessonList) {
                    [temp addObject:[NSString stringWithFormat:@"%@  %@元    %@元",tmodel.short_name,SafeStr(tmodel.price),ValidStr(tmodel.teacherPirce)?  SafeStr(tmodel.teacherPirce) : SafeStr(tmodel.price)]];
                }
                cellModel.data = temp;
            }
            ZCellConfig *textCellConfig = [ZCellConfig cellConfigWithClassName:[ZOrganizationCampusTextLabelCell className] title:@"labelCell" showInfoMethod:@selector(setModel:) heightOfCell:[ZOrganizationCampusTextLabelCell z_getCellHeight:cellModel] cellType:ZCellTypeClass dataModel:cellModel];
            [self.cellConfigArr addObject:textCellConfig];
        }else{
            ZLineCellModel *model = ZLineCellModel.zz_lineCellModel_create(@"content")
            .zz_titleLeft(textArr[i][0])
            .zz_titleRight(textArr[i][1])
            .zz_rightMultiLine(YES)
            .zz_cellHeight(CGFloatIn750(88))
            .zz_lineHidden(YES);
            
            ZCellConfig *menuCellConfig = [ZCellConfig cellConfigWithClassName:[ZBaseLineCell className] title:model.cellTitle showInfoMethod:@selector(setModel:) heightOfCell:[ZBaseLineCell z_getCellHeight:model] cellType:ZCellTypeClass dataModel:model];
            
            [self.cellConfigArr  addObject:menuCellConfig];
        }
    }
    
    {
        [self.cellConfigArr addObject:getEmptyCellWithHeight(CGFloatIn750(20))];
        
        ZBaseSingleCellModel *model = [[ZBaseSingleCellModel alloc] init];
        model.leftTitle = @"教师简介";
        model.leftFont = [UIFont boldFontContent];
        model.isHiddenLine = YES;
        model.cellHeight = CGFloatIn750(52);
        
        ZCellConfig *menuCellConfig = [ZCellConfig cellConfigWithClassName:[ZSingleLineCell className] title:model.cellTitle showInfoMethod:@selector(setModel:) heightOfCell:[ZSingleLineCell z_getCellHeight:model] cellType:ZCellTypeClass dataModel:model];
        [self.cellConfigArr addObject:menuCellConfig];
      
        ZLineCellModel *mModel = ZLineCellModel.zz_lineCellModel_create(@"des")
        .zz_colorLeft([UIColor colorTextGray])
        .zz_colorDarkLeft([UIColor colorTextGrayDark])
        .zz_cellHeight(CGFloatIn750(50))
        .zz_titleLeft(self.addModel.des)
        .zz_leftMultiLine(YES);
        
        ZCellConfig *textCellConfig = [ZCellConfig cellConfigWithClassName:[ZBaseLineCell className] title:mModel.cellTitle showInfoMethod:@selector(setModel:) heightOfCell:[ZBaseLineCell z_getCellHeight:mModel] cellType:ZCellTypeClass dataModel:mModel];
        [self.cellConfigArr addObject:textCellConfig];
        
        [self.cellConfigArr addObject:getEmptyCellWithHeight(CGFloatIn750(40))];
    }
    
    {
        ZBaseSingleCellModel *model = [[ZBaseSingleCellModel alloc] init];
        model.leftTitle = @"教师相册";
        model.leftFont = [UIFont boldFontContent];
        model.isHiddenLine = YES;
        model.cellHeight = CGFloatIn750(92);
        
        ZCellConfig *menuCellConfig = [ZCellConfig cellConfigWithClassName:[ZSingleLineCell className] title:model.cellTitle showInfoMethod:@selector(setModel:) heightOfCell:[ZSingleLineCell z_getCellHeight:model] cellType:ZCellTypeClass dataModel:model];
        
        [self.cellConfigArr addObject:menuCellConfig];
    }
    
    if (ValidArray(self.addModel.images_list)) {
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

#pragma mark - tableview
- (void)zz_tableView:(UITableView *)tableView cell:(UITableViewCell *)cell cellForRowAtIndexPath:(NSIndexPath *)indexPath cellConfig:(ZCellConfig *)cellConfig {
    if ([cellConfig.title isEqualToString:[ZOriganizationTeachHeadImageCell className]]) {
        ZOriganizationTeachHeadImageCell *lcell = (ZOriganizationTeachHeadImageCell *)cell;
        __weak typeof(self) weakSelf = self;
        lcell.isTeacher = NO;
        lcell.handleBlock = ^(NSInteger index) {
            if (index == 0) {
                if (ValidClass(weakSelf.addModel.image, [UIImage class]) || ValidStr(weakSelf.addModel.image)) {
                    [[ZPhotoManager sharedManager] showBrowser:@[weakSelf.addModel.image] withIndex:0];
                }
            }else{
                ZTeacherLessonDetailListVC *lvc = [[ZTeacherLessonDetailListVC alloc] init];
                lvc.teacher_id = weakSelf.addModel.teacherID;
                [weakSelf.navigationController pushViewController:lvc animated:YES];
            }
        };
    }else if([cellConfig.title isEqualToString:@"labelCell"]){
        ZOrganizationCampusTextLabelCell *lcell = (ZOrganizationCampusTextLabelCell *)cell;
        lcell.arrowImageView.hidden = YES;
    }
    
}

- (void)zz_tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath cellConfig:(ZCellConfig *)cellConfig {
    if ([cellConfig.title isEqualToString:@"ZOriganizationTeachHeadImageCell"]) {
        
    }
}

#pragma mark - lazy loading...
- (UIButton *)navRightBtn {
     if (!_navRightBtn) {
         __weak typeof(self) weakSelf = self;
         _navRightBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, CGFloatIn750(90), CGFloatIn750(50))];
         [_navRightBtn setTitle:@"编辑" forState:UIControlStateNormal];
         [_navRightBtn setTitleColor:adaptAndDarkColor([UIColor colorMain], [UIColor colorMainDark]) forState:UIControlStateNormal];
         [_navRightBtn.titleLabel setFont:[UIFont fontContent]];
         [_navRightBtn bk_addEventHandler:^(id sender) {
            ZOrganizationTeacherAddVC *avc = [[ZOrganizationTeacherAddVC alloc] init];
            avc.viewModel.addModel = weakSelf.addModel;
            avc.isEdit = YES;
            [weakSelf.navigationController pushViewController:avc animated:YES];
         } forControlEvents:UIControlEventTouchUpInside];
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
    self.loading = YES;
    [ZOriganizationTeacherViewModel getStoresTeacherDetail:@{@"id":SafeStr(self.addModel.teacherID)} completeBlock:^(BOOL isSuccess, ZOriganizationTeacherAddModel *addModel) {
        weakSelf.loading = NO;
        if (isSuccess) {
            weakSelf.addModel = addModel;
            [weakSelf initCellConfigArr];
            [weakSelf.iTableView reloadData];
        }
    }];
}
@end
