//
//  ZCircleReleaseAddLabelVC.m
//  NoWait
//
//  Created by zhuang zhang on 2020/7/7.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZCircleReleaseAddLabelVC.h"
#import "ZCircleReleaseAddLabelListCell.h"
#import "ZCircleReleaseRecommendLabelListCell.h"
#import "ZCircleReleaseViewModel.h"
#import "ZCircleReleaseModel.h"
#import "ZAlertView.h"

@interface ZCircleReleaseAddLabelVC ()<UITextFieldDelegate>
@property (nonatomic,strong) UITextField *userNameTF;
@property (nonatomic,strong) UIButton *addBtn;

@property (nonatomic,strong) NSMutableArray *labelList;
@property (nonatomic,strong) NSMutableArray *hotList;
@end

@implementation ZCircleReleaseAddLabelVC

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.userNameTF resignFirstResponder];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    __weak typeof(self) weakSelf = self;
    self.zChain_setNavTitle(@"添加标签")
    .zChain_resetMainView(^{
        
        UIButton *sureBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, CGFloatIn750(90), CGFloatIn750(50))];
        [sureBtn setTitle:@"完成" forState:UIControlStateNormal];
        [sureBtn setTitleColor:adaptAndDarkColor([UIColor colorMain], [UIColor colorMain]) forState:UIControlStateNormal];
        [sureBtn.titleLabel setFont:[UIFont fontContent]];
        [sureBtn bk_addEventHandler:^(id sender) {
            if (weakSelf.labelList && weakSelf.labelList.count > 0) {
                if (weakSelf.handleBlock) {
                    weakSelf.handleBlock(weakSelf.labelList);
                }
                [weakSelf.navigationController popViewControllerAnimated:YES];
            }else{
                [TLUIUtility showErrorHint:@"你还没有添加标签"];
            }
        } forControlEvents:UIControlEventTouchUpInside];
        [self.navigationItem setRightBarButtonItem:[[UIBarButtonItem alloc] initWithCustomView:sureBtn]];
        
        [self.view addSubview:self.userNameTF];
        [self.userNameTF mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.view);
            make.right.equalTo(self.view.mas_right).offset(-CGFloatIn750(30));
            make.height.mas_equalTo(CGFloatIn750(100));
            make.top.equalTo(self.view.mas_top).offset(20);
        }];
        
        UIView *bottomLineView = [[UIView alloc] initWithFrame:CGRectZero];
        bottomLineView.backgroundColor = adaptAndDarkColor([UIColor colorGrayLine], [UIColor colorGrayLine]);
        [self.view addSubview:bottomLineView];
        [bottomLineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.userNameTF);
            make.left.right.equalTo(self.view);
            make.height.mas_equalTo(0.5);
        }];
        
        [self.iTableView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self.view);
            make.bottom.equalTo(self.view.mas_bottom);
            make.top.equalTo(self.userNameTF.mas_bottom).offset(10);
        }];
    }).zChain_updateDataSource(^{
        self.labelList = @[].mutableCopy;
        self.hotList = @[].mutableCopy;
        if (self.list) {
            for (int i = 0; i < self.list.count; i++) {
                [self.labelList addObject:self.list[i]];;
            }
        }
    }).zChain_block_setUpdateCellConfigData(^(void (^update)(NSMutableArray *)) {
        [self.cellConfigArr removeAllObjects];

        [self.cellConfigArr addObject:getEmptyCellWithHeight(CGFloatIn750(40))];
        if (ValidArray(self.labelList)) {
            ZLineCellModel *sModel = ZLineCellModel.zz_lineCellModel_create(@"stuentTitle")
            .zz_titleLeft(@"已选标签")
            .zz_fontLeft([UIFont boldFontMaxTitle])
            .zz_cellHeight(CGFloatIn750(38))
            .zz_lineHidden(YES);
            
            ZCellConfig *titleCellConfig = [ZCellConfig cellConfigWithClassName:[ZBaseLineCell className] title:@"title" showInfoMethod:@selector(setModel:) heightOfCell:[ZBaseLineCell z_getCellHeight:sModel] cellType:ZCellTypeClass dataModel:sModel];
            
            [self.cellConfigArr addObject:titleCellConfig];
            
            ZCellConfig *menuCellConfig = [ZCellConfig cellConfigWithClassName:[ZCircleReleaseAddLabelListCell className] title:@"ZCircleReleaseAddLabelListCell" showInfoMethod:@selector(setList:) heightOfCell:[ZCircleReleaseAddLabelListCell z_getCellHeight:self.labelList] cellType:ZCellTypeClass dataModel:self.labelList];
            
            [self.cellConfigArr addObject:menuCellConfig];
            [self.cellConfigArr addObject:getEmptyCellWithHeight(CGFloatIn750(20))];
        }
        {
            ZLineCellModel *sModel = ZLineCellModel.zz_lineCellModel_create(@"stuentTitle")
            .zz_titleLeft(@"推荐标签")
            .zz_fontLeft([UIFont boldFontMaxTitle])
            .zz_cellHeight(CGFloatIn750(38))
            .zz_lineHidden(YES);
            
            ZCellConfig *titleCellConfig = [ZCellConfig cellConfigWithClassName:[ZBaseLineCell className] title:@"title" showInfoMethod:@selector(setModel:) heightOfCell:[ZBaseLineCell z_getCellHeight:sModel] cellType:ZCellTypeClass dataModel:sModel];
            
            [self.cellConfigArr addObject:titleCellConfig];
            
            ZCellConfig *menuCellConfig = [ZCellConfig cellConfigWithClassName:[ZCircleReleaseRecommendLabelListCell className] title:@"ZCircleReleaseRecommendLabelListCell" showInfoMethod:@selector(setList:) heightOfCell:[ZCircleReleaseRecommendLabelListCell z_getCellHeight:self.hotList] cellType:ZCellTypeClass dataModel:self.hotList];
            
            [self.cellConfigArr addObject:menuCellConfig];
        }
    }).zChain_block_setCellConfigForRowAtIndexPath(^(UITableView *tableView, NSIndexPath *indexPath, UITableViewCell *cell, ZCellConfig *cellConfig) {
        if ([cellConfig.title isEqualToString:@"ZCircleReleaseRecommendLabelListCell"]) {
            ZCircleReleaseRecommendLabelListCell *lcell = (ZCircleReleaseRecommendLabelListCell *)cell;
            lcell.selectBlock = ^(ZCircleReleaseTagModel * model) {
                if (self.labelList.count >= 5) {
                    [TLUIUtility showInfoHint:@"最多添加5个标签"];
                    return;
                }
                if (![self checkLabelIsSame:model]) {
                    [self.labelList addObject:model];
                    self.zChain_reload_ui();
                }else{
                    [TLUIUtility showInfoHint:@"已添加了该标签"];
                }
            };
        }else if([cellConfig.title isEqualToString:@"ZCircleReleaseAddLabelListCell"]){
            ZCircleReleaseAddLabelListCell *lcell = (ZCircleReleaseAddLabelListCell *)cell;
            lcell.selectBlock = ^(ZCircleReleaseTagModel *model) {
                if (model) {
                    for (int i = 0; i < self.labelList.count; i++) {
                        ZCircleReleaseTagModel *smodel = self.labelList[i];
                        if ([smodel.tag_name isEqualToString:model.tag_name]) {
                            [self.labelList removeObjectAtIndex:i];
                        }
                    }
                    
                    self.zChain_reload_ui();
                }
            };
        }
    });
    [self getRecommondTags];
    self.zChain_reload_ui();
}

- (UIButton *)addBtn {
    if (!_addBtn) {
        __weak typeof(self) weakSelf = self;
        _addBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, CGFloatIn750(60), CGFloatIn750(50))];
        [_addBtn setTitle:@"添加" forState:UIControlStateNormal];
        [_addBtn setTitleColor:adaptAndDarkColor([UIColor colorMain], [UIColor colorMainDark]) forState:UIControlStateNormal];
        [_addBtn.titleLabel setFont:[UIFont fontSmall]];
        [_addBtn bk_addEventHandler:^(id sender) {
            if (self.labelList.count >= 5) {
                [TLUIUtility showInfoHint:@"最多添加5个标签"];
                return;
            }
            ZCircleReleaseTagModel *model = [[ZCircleReleaseTagModel alloc] init];
            model.tag_name = SafeStr(self.userNameTF.text);
            model.tag_id = @"";
            [weakSelf.labelList addObject:model];
             weakSelf.zChain_reload_ui();
        } forControlEvents:UIControlEventTouchUpInside];
    }
    return _addBtn;
}


- (UITextField *)userNameTF {
    if (!_userNameTF) {
    //    __weak typeof(self) weakSelf = self;
        UIView *hintView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGFloatIn750(30), CGFloatIn750(80))];

        _userNameTF  = [[UITextField alloc] init];
        _userNameTF.tag = 105;
        _userNameTF.leftViewMode = UITextFieldViewModeAlways;
        _userNameTF.leftView = hintView;
        [_userNameTF setTextAlignment:NSTextAlignmentLeft];
        [_userNameTF setFont:[UIFont fontContent]];
        [_userNameTF setBorderStyle:UITextBorderStyleNone];
        [_userNameTF setBackgroundColor:[UIColor clearColor]];
        [_userNameTF setReturnKeyType:UIReturnKeyDone];
        [_userNameTF setPlaceholder:@"请输入自定义标签，最多30个字节"];
        _userNameTF.delegate = self;
        [_userNameTF addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
        _userNameTF.backgroundColor = adaptAndDarkColor([UIColor colorWhite], [UIColor colorBlackBGDark]);
        _userNameTF.keyboardType = UIKeyboardTypeDefault;
        _userNameTF.textColor = adaptAndDarkColor([UIColor colorTextBlack], [UIColor colorTextBlackDark]);
        _userNameTF.rightView = self.addBtn;
        _userNameTF.rightViewMode = UITextFieldViewModeAlways;
    }
    return _userNameTF;
}

#pragma mark textField delegate ---------
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    return YES;
}


#pragma mark - -textField delegate
- (void)textFieldDidChange:(UITextField *)textField {
    [ZPublicTool textField:textField maxLenght:30 type:ZFormatterTypeAnyByte];
}

- (BOOL)checkLabelIsSame:(ZCircleReleaseTagModel*)model {
    __block BOOL isSame = NO;
    [self.labelList enumerateObjectsUsingBlock:^(ZCircleReleaseTagModel *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([model.tag_name isEqualToString:obj.tag_name]) {
            isSame = YES;
        }
    }];
    return isSame;
}

- (void)getRecommondTags{
    [ZCircleReleaseViewModel getDynamicTagList:@{} completeBlock:^(BOOL isSuccess, id data) {
        if (isSuccess && [data isKindOfClass:[ZCircleReleaseTagNetModel class]]) {
            ZCircleReleaseTagNetModel *model = (ZCircleReleaseTagNetModel *)data;
            [self.hotList removeAllObjects];
            [self.hotList addObjectsFromArray:model.list];
            self.zChain_reload_ui();
        }
    }];
}
@end

