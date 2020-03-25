//
//  ZMineFeedbackVC.m
//  NoWait
//
//  Created by zhuang zhang on 2020/3/3.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZMineFeedbackVC.h"
#import "ZStudentLessonOrderMoreInputCell.h"
#import "ZOrganizationLessonAddPhotosCell.h"
#import "ZBaseUnitModel.h"
#import "ZFeedBackViewModel.h"

@interface ZMineFeedbackVC ()
@property (nonatomic,strong) UIView *footerView;
@property (nonatomic,strong) ZFeedBackViewModel *viewModel;

@end

@implementation ZMineFeedbackVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNavigation];
    [self initCellConfigArr];
    self.iTableView.tableFooterView = self.footerView;
    [self.iTableView reloadData];
}

- (void)setDataSource {
    [super setDataSource];
    
    self.viewModel = [[ZFeedBackViewModel alloc] init];
    [self.viewModel.model.images addObject:@""];
    [self.viewModel.model.images addObject:@""];
}

- (void)initCellConfigArr {
    [super initCellConfigArr];
    ZBaseTextFieldCellModel *model = [[ZBaseTextFieldCellModel alloc] init];
    model.leftMargin = CGFloatIn750(40);
    model.rightMargin = CGFloatIn750(40);
    model.contentSpace = CGFloatIn750(20);
    model.placeholder = @"请描述您的问题（必填）";
    model.textAlignment = NSTextAlignmentLeft;
    model.isHiddenLine = NO;
    model.max = 300;
    model.cellHeight = CGFloatIn750(300);
    model.textFont = [UIFont fontContent];
    model.subTitleColor = [UIColor colorGrayBG];
    model.subTitleDarkColor = [UIColor colorGrayBGDark];
    model.rightColor = [UIColor colorTextGray];
    model.rightDarkColor = [UIColor colorTextGrayDark];
    model.content = self.viewModel.model.des;

    ZCellConfig *moreIntputCellConfig = [ZCellConfig cellConfigWithClassName:[ZBaseTextViewCell className] title:[ZBaseTextViewCell className] showInfoMethod:@selector(setModel:) heightOfCell:[ZBaseTextViewCell z_getCellHeight:model] cellType:ZCellTypeClass dataModel:model];
    [self.cellConfigArr addObject:moreIntputCellConfig];
    
    ZCellConfig *coachSpaceCellConfig = [ZCellConfig cellConfigWithClassName:[ZSpaceEmptyCell className] title:[ZSpaceEmptyCell className] showInfoMethod:@selector(setBackColor:) heightOfCell:CGFloatIn750(20) cellType:ZCellTypeClass dataModel:adaptAndDarkColor([UIColor colorWhite], [UIColor colorBlackBGDark])];
    [self.cellConfigArr addObject:coachSpaceCellConfig];
    
    {
        ZBaseMenuModel *model = [[ZBaseMenuModel alloc] init];
        NSMutableArray *menulist = @[].mutableCopy;

        for (int j = 0; j < 2; j++) {
            ZBaseUnitModel *model = [[ZBaseUnitModel alloc] init];
            if (j < self.viewModel.model.images.count) {
                model.data = self.viewModel.model.images[j];
                model.uid = [NSString stringWithFormat:@"%d", j];
            }
            model.name = @"选填";
        //            model.imageName = tempArr[j][1];
        //            model.uid = tempArr[j][2];
            [menulist addObject:model];
        }

        model.units = menulist;

        ZCellConfig *progressCellConfig = [ZCellConfig cellConfigWithClassName:[ZOrganizationLessonAddPhotosCell className] title:[ZOrganizationLessonAddPhotosCell className] showInfoMethod:@selector(setModel:) heightOfCell:[ZOrganizationLessonAddPhotosCell z_getCellHeight:menulist] cellType:ZCellTypeClass dataModel:model];
        [self.cellConfigArr addObject:progressCellConfig];
    }
    
    {
        ZCellConfig *coachSpaceCellConfig = [ZCellConfig cellConfigWithClassName:[ZSpaceEmptyCell className] title:[ZSpaceEmptyCell className] showInfoMethod:@selector(setBackColor:) heightOfCell:CGFloatIn750(30) cellType:ZCellTypeClass dataModel:adaptAndDarkColor([UIColor colorWhite], [UIColor colorBlackBGDark])];
        [self.cellConfigArr addObject:coachSpaceCellConfig];
        
        ZBaseSingleCellModel *model = [[ZBaseSingleCellModel alloc] init];
        model.leftTitle = @"请输入联系人信息（选填）";
        model.isHiddenLine = NO;
        model.lineLeftMargin = CGFloatIn750(30);
        model.lineRightMargin = CGFloatIn750(30);
        model.cellHeight = CGFloatIn750(110);
        model.leftFont = [UIFont boldFontTitle];
        model.cellHeight = CGFloatIn750(40);
        
        ZCellConfig *menuCellConfig = [ZCellConfig cellConfigWithClassName:[ZSingleLineCell className] title:model.cellTitle showInfoMethod:@selector(setModel:) heightOfCell:[ZSingleLineCell z_getCellHeight:model] cellType:ZCellTypeClass dataModel:model];
        
        [self.cellConfigArr addObject:menuCellConfig];
    }
    
    NSArray *titleArr = @[@[@"手机号",self.viewModel.model.phone,@"phone"],@[@"联系人",self.viewModel.model.name,@"name"]];
    for (int i = 0; i < titleArr.count; i++) {
        ZBaseTextFieldCellModel *model = [[ZBaseTextFieldCellModel alloc] init];
        model.leftTitle = titleArr[i][0];
        model.content = titleArr[i][1];
        model.leftFont = [UIFont fontContent];
        model.leftContentWidth = CGFloatIn750(126);
        model.isHiddenInputLine = YES;
        model.textAlignment = NSTextAlignmentRight;
        model.cellHeight = CGFloatIn750(106);
        if (i == titleArr.count - 1) {
            model.isHiddenLine = YES;
        }
        
        ZCellConfig *menuCellConfig = [ZCellConfig cellConfigWithClassName:[ZTextFieldCell className] title:model.cellTitle showInfoMethod:@selector(setModel:) heightOfCell:[ZTextFieldCell z_getCellHeight:model] cellType:ZCellTypeClass dataModel:model];
        [self.cellConfigArr addObject:menuCellConfig];
    }
}


- (void)setNavigation {
    self.isHidenNaviBar = NO;
    [self.navigationItem setTitle:@"意见反馈"];
}


-(UIView *)footerView {
    if (!_footerView) {
        _footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, 200)];
        _footerView.backgroundColor = adaptAndDarkColor([UIColor colorWhite], [UIColor colorBlackBGDark]);
        
        UIButton *doneBtn = [[UIButton alloc] initWithFrame:CGRectZero];
        doneBtn.layer.masksToBounds = YES;
        doneBtn.layer.cornerRadius = CGFloatIn750(40);
        [doneBtn setTitle:@"提交" forState:UIControlStateNormal];
        [doneBtn setBackgroundColor:adaptAndDarkColor([UIColor colorMain], [UIColor colorMainDark]) forState:UIControlStateNormal];
        [doneBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [doneBtn setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
        [doneBtn.titleLabel setFont:[UIFont fontTitle]];
        [_footerView addSubview:doneBtn ];
        [doneBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(CGFloatIn750(80));
            make.left.equalTo(self.footerView.mas_left).offset(CGFloatIn750(20));
            make.right.equalTo(self.footerView.mas_right).offset(-CGFloatIn750(20));
            make.top.equalTo(self.footerView.mas_top).offset(CGFloatIn750(100));
        }];
        
//        __weak typeof(self) weakSelf = self;
        [doneBtn bk_addEventHandler:^(id sender) {
//            if (weakSelf.iTextView.text && weakSelf.iTextView.text.length > 0) {
//                if (weakSelf.iTextView.text.length < 5) {
//                    [TLUIUtility showErrorHint:@"意见太少了，不能少有5个字符"];
//                    return ;
//                }
////                [TLUIUtility showLoading:nil];
////                [ZMIneViewModel saveProposalContentWith:weakSelf.iTextView.text completeBlock:^(BOOL isSuccess, NSString *message) {
////                    [TLUIUtility hiddenLoading];
////                    if (isSuccess) {
////                        [TLUIUtility showSuccessHint:message];
////
////                        [weakSelf.navigationController popViewControllerAnimated:YES];
////                    }else{
////                        [TLUIUtility showErrorHint:message];
////                    }
////                }];
//            }else{
//                [TLUIUtility showErrorHint:@"意见不能为空"];
//            }
            
        } forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _footerView;
}

#pragma mark tableView ------delegate-----
- (void)zz_tableView:(UITableView *)tableView cell:(UITableViewCell *)cell cellForRowAtIndexPath:(NSIndexPath *)indexPath cellConfig:(ZCellConfig *)cellConfig {
    __weak typeof(self) weakSelf = self;
    
    if ([cellConfig.title isEqualToString:@"ZOrganizationMenuCell"]){
        ZBaseTextViewCell *lcell = (ZBaseTextViewCell *)cell;
        lcell.valueBlock = ^(NSString *text) {
            weakSelf.viewModel.model.des = text;
        };
    }else if ([cellConfig.title isEqualToString:@"ZOrganizationLessonAddPhotosCell"]){
        ZOrganizationLessonAddPhotosCell *lcell = (ZOrganizationLessonAddPhotosCell *)cell;
        lcell.menuBlock = ^(NSInteger index, BOOL isAdd) {
            if (isAdd) {
                [[ZPhotoManager sharedManager] showCropOriginalSelectMenuWithCropSize:CGSizeMake(KScreenWidth, 2/3.0 * KScreenWidth) complete:^(NSArray<LLImagePickerModel *> *list) {
                    if (list && list.count > 0) {
                        if (index < weakSelf.viewModel.model.images.count) {
                            LLImagePickerModel *model = list[0];
                            [weakSelf.viewModel.model.images replaceObjectAtIndex:index withObject:model.image];
                            [weakSelf initCellConfigArr];
                            [weakSelf.iTableView reloadData];
                        }
                    }
                }];
            }else{
                if (index < weakSelf.viewModel.model.images.count) {
                    [weakSelf.viewModel.model.images replaceObjectAtIndex:index withObject:@""];
                    [weakSelf initCellConfigArr];
                    [weakSelf.iTableView reloadData];
                }
            }
        };
    }else if ([cellConfig.title isEqualToString:@"ZOrganizationMenuCell"]){
        ZBaseTextViewCell *lcell = (ZBaseTextViewCell *)cell;
        lcell.valueBlock = ^(NSString *text) {
            weakSelf.viewModel.model.des = text;
        };
    }else if ([cellConfig.title isEqualToString:@"phone"]){
        ZTextFieldCell *lcell = (ZTextFieldCell *)cell;
        lcell.valueChangeBlock = ^(NSString *text) {
            weakSelf.viewModel.model.phone = text;
        };
    }else if ([cellConfig.title isEqualToString:@"name"]){
        ZTextFieldCell *lcell = (ZTextFieldCell *)cell;
        lcell.valueChangeBlock = ^(NSString *text) {
            weakSelf.viewModel.model.name = text;
        };
    }
}

-(void)zz_tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath cellConfig:(ZCellConfig *)cellConfig {
     
     
}

@end
