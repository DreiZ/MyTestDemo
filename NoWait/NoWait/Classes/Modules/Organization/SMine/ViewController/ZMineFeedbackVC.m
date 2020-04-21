//
//  ZMineFeedbackVC.m
//  NoWait
//
//  Created by zhuang zhang on 2020/3/3.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZMineFeedbackVC.h"
#import "ZStudentLessonOrderMoreInputCell.h"
#import "ZAddPhotosCell.h"
#import "ZBaseUnitModel.h"
#import "ZFeedBackViewModel.h"

@interface ZMineFeedbackVC ()
@property (nonatomic,strong) UIView *footerView;
@property (nonatomic,strong) ZFeedBackViewModel *viewModel;
@property (nonatomic,strong) ZBaseTextViewCell *textCell;

@end

@implementation ZMineFeedbackVC


- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    if (_textCell) {
        [self.textCell.iTextView becomeFirstResponder];
    }
}


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
    
    [self.cellConfigArr addObject:getEmptyCellWithHeight(CGFloatIn750(20))];
    
    {
        ZBaseMenuModel *model = [[ZBaseMenuModel alloc] init];
        NSMutableArray *menulist = @[].mutableCopy;

        for (int j = 0; j < self.viewModel.model.images.count; j++) {
            ZBaseUnitModel *model = [[ZBaseUnitModel alloc] init];
            if (j < self.viewModel.model.images.count) {
                model.data = self.viewModel.model.images[j];
                model.uid = [NSString stringWithFormat:@"%d", j];
            }
            
            model.isEdit = YES;
            [menulist addObject:model];
        }
        model.name = @"添加图片";
        model.subName = @"选填";
        model.uid = @"2";
        model.units = menulist;

        ZCellConfig *progressCellConfig = [ZCellConfig cellConfigWithClassName:[ZAddPhotosCell className] title:[ZAddPhotosCell className] showInfoMethod:@selector(setModel:) heightOfCell:[ZAddPhotosCell z_getCellHeight:menulist] cellType:ZCellTypeClass dataModel:model];
        [self.cellConfigArr addObject:progressCellConfig];
    }
    
    {
        [self.cellConfigArr addObject:getEmptyCellWithHeight(CGFloatIn750(30))];
        
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
    
    NSArray *titleArr = @[@[@"手机号",self.viewModel.model.phone,@"phone",@11,[NSNumber numberWithInt:ZFormatterTypePhoneNumber]],@[@"联系人",self.viewModel.model.name,@"name",@20,[NSNumber numberWithInt:ZFormatterTypeAny]]];
    for (int i = 0; i < titleArr.count; i++) {
        ZBaseTextFieldCellModel *model = [[ZBaseTextFieldCellModel alloc] init];
        model.leftTitle = titleArr[i][0];
        model.content = titleArr[i][1];
        model.max = [titleArr[i][3] intValue];
        model.cellTitle = titleArr[i][2];
        model.formatterType = [titleArr[i][4] intValue];
        model.placeholder = @"选填";
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
        
        __weak typeof(self) weakSelf = self;
        [doneBtn bk_addEventHandler:^(id sender) {
            NSMutableDictionary *params = @{}.mutableCopy;
            if (ValidStr(weakSelf.viewModel.model.des)) {
                [params setObject:SafeStr(weakSelf.viewModel.model.des) forKey:@"desc_comment"];
            }else{
                [TLUIUtility showErrorHint:@"请输入反馈内容"];
                return ;
            }
            if (ValidStr(weakSelf.viewModel.model.phone)) {
                [params setObject:SafeStr(weakSelf.viewModel.model.phone) forKey:@"phone"];
            }
            if (ValidStr(weakSelf.viewModel.model.name)) {
                [params setObject:SafeStr(weakSelf.viewModel.model.name) forKey:@"name"];
            }
            //1：学员 2：教师 6：校区 8：机构
            if ([[ZUserHelper sharedHelper].user.type intValue] == 1) {
                [params setObject:@"1" forKey:@"type"];
            }
            if ([[ZUserHelper sharedHelper].user.type intValue] == 2) {
                [params setObject:@"2" forKey:@"type"];
            }
            if ([[ZUserHelper sharedHelper].user.type intValue] == 6 || [[ZUserHelper sharedHelper].user.type intValue] == 8) {
                [params setObject:@"3" forKey:@"type"];
            }
            [weakSelf updatePhotosStep1WithOtherParams:params];
        } forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _footerView;
}

#pragma mark - tableView ------delegate-----
- (void)zz_tableView:(UITableView *)tableView cell:(UITableViewCell *)cell cellForRowAtIndexPath:(NSIndexPath *)indexPath cellConfig:(ZCellConfig *)cellConfig {
    __weak typeof(self) weakSelf = self;
    
    if ([cellConfig.title isEqualToString:@"ZBaseTextViewCell"]){
        ZBaseTextViewCell *lcell = (ZBaseTextViewCell *)cell;
        lcell.valueBlock = ^(NSString *text) {
            weakSelf.viewModel.model.des = text;
        };
        _textCell = lcell;
    }else if ([cellConfig.title isEqualToString:@"ZAddPhotosCell"]){
        ZAddPhotosCell *tCell = (ZAddPhotosCell *)cell;
        tCell.seeBlock = ^(NSInteger index) {
            [[ZPhotoManager sharedManager] showBrowser:weakSelf.viewModel.model.images withIndex:index];
        } ;
        tCell.menuBlock = ^(NSInteger index, BOOL isAdd) {
            [weakSelf.iTableView endEditing:YES];
            if (isAdd) {
                [ZPhotoManager sharedManager].maxImageSelected = 2 - weakSelf.viewModel.model.images.count;
                
                [[ZPhotoManager sharedManager] showSelectMenu:^(NSArray<LLImagePickerModel *> *list) {
                    if (list && list.count > 0){;
                        for (LLImagePickerModel *model in list) {
                            [weakSelf.viewModel.model.images addObject:model.image];
                        }
                        [weakSelf initCellConfigArr];
                        [weakSelf.iTableView reloadData];
                    }
                }];
            }else{
                if (index < weakSelf.viewModel.model.images.count) {
                    [weakSelf.viewModel.model.images removeObjectAtIndex:index];
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


#pragma mark - 提交数据Z
- (NSInteger)checkIsHavePhotos {
    NSInteger index = 0;
    for (int i = 0; i < self.viewModel.model.images.count; i++) {
        id temp = self.viewModel.model.images[i];
        if ([temp isKindOfClass:[UIImage class]]) {
            index++;
        }else if ([temp isKindOfClass:[NSString class]]){
            NSString *tempStr = temp;
            if (tempStr.length > 0) {
                index++;
            }
        }
    }
    return index;
}

- (void)updatePhotosStep1WithOtherParams:(NSMutableDictionary *)otherDict {
    if ([self checkIsHavePhotos] > 0) {
        [TLUIUtility showLoading:@"上传图片中"];
        NSInteger tindex = 0;
        [self updatePhotosStep2WithImage:tindex otherParams:otherDict];
    }else{
        [self updateOtherDataWithParams:otherDict];
    }
}

 - (void)updatePhotosStep2WithImage:(NSInteger)index otherParams:(NSMutableDictionary *)otherDict {
     [self updatePhotosStep3WithImage:index otherParams:otherDict complete:^(BOOL isSuccess, NSInteger index) {
         if (index == self.viewModel.model.images.count-1) {
             [self updateOtherDataWithParams:otherDict];
         }else{
             index++;
             [self updatePhotosStep2WithImage:index otherParams:otherDict];
         }
    }];
}

- (void)updatePhotosStep3WithImage:(NSInteger)index otherParams:(NSMutableDictionary *)otherDict complete:(void(^)(BOOL, NSInteger))complete{
    [TLUIUtility showLoading:[NSString stringWithFormat:@"上传图片中 %ld/%ld",index+1,self.viewModel.model.images.count]];
    
    id temp = self.viewModel.model.images[index];
    UIImage *image;
    if ([temp isKindOfClass:[UIImage class]]) {
        image = temp;
    }else if ([temp isKindOfClass:[NSString class]]){
        complete(YES,index);
        return;
    }else{
        complete(YES,index);
        return;
    }
    if (!image) {
        complete(YES,index);
        return;
    }
    __weak typeof(self) weakSelf = self;
    [ZFeedBackViewModel uploadImageList:@{@"type":@"8",@"imageKey":@{@"file":image}} completeBlock:^(BOOL isSuccess, NSString *message) {
        if (isSuccess) {
            [weakSelf.viewModel.model.images replaceObjectAtIndex:index withObject:message];
            complete(YES,index);
        }else{
            [TLUIUtility hiddenLoading];
            [TLUIUtility showErrorHint:message];
        }
    }];
}


- (void)updateOtherDataWithParams:(NSMutableDictionary *)otherDict {
    if ([self checkIsHavePhotos] > 0) {
        NSMutableArray *photos = @[].mutableCopy;
        for (int i = 0; i < self.viewModel.model.images.count; i++) {
            NSString *temp = self.viewModel.model.images[i];
            if (ValidStr(temp)) {
                [photos addObject:temp];
            }
        }
        if (photos.count > 0) {
            [otherDict setObject:photos forKey:@"images"];
        }
    }
    
    
    [TLUIUtility showLoading:@"上传其他数据"];
    [ZFeedBackViewModel addFeedback:otherDict completeBlock:^(BOOL isSuccess, NSString *message) {
        [TLUIUtility hiddenLoading];
        if (isSuccess) {
            [TLUIUtility showSuccessHint:message];
            [self.navigationController popViewControllerAnimated:YES];
            return ;
        }else {
            [TLUIUtility showErrorHint:message];
        }
    }];
}
@end
