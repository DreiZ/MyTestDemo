//
//  ZOrganizationCardSendAddStudentVC.m
//  NoWait
//
//  Created by zhuang zhang on 2020/6/23.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZOrganizationCardSendAddStudentVC.h"
#import "ZOrganizationCardAddStudentCell.h"
#import "ZOrganizationCardAddStudentListVC.h"
#import "ZOriganizationStudentViewModel.h"

#import "ZAlertView.h"

@interface ZOrganizationCardSendAddStudentVC ()<UITextFieldDelegate>
@property (nonatomic,strong) UITextField *userNameTF;
@property (nonatomic,strong) UIButton *addBtn;
@property (nonatomic,strong) UIButton *sendBtn;
@property (nonatomic,strong) UIView *bottomView;

@property (nonatomic,strong) ZOriganizationStudentListModel *studentModel;

@property (nonatomic,strong) NSMutableArray *studentArr;
@property (nonatomic,strong) NSMutableArray *btnArr;
@end

@implementation ZOrganizationCardSendAddStudentVC

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.userNameTF resignFirstResponder];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    __weak typeof(self) weakSelf = self;
    self.zChain_setNavTitle(@"添加学员")
    .zChain_resetMainView(^{
        UIButton *sureBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, CGFloatIn750(90), CGFloatIn750(50))];
        [sureBtn setTitle:@"选择" forState:UIControlStateNormal];
        [sureBtn setTitleColor:adaptAndDarkColor([UIColor colorMain], [UIColor colorMain]) forState:UIControlStateNormal];
        [sureBtn.titleLabel setFont:[UIFont fontContent]];
        [sureBtn bk_addEventHandler:^(id sender) {
            ZOrganizationCardAddStudentListVC *lvc = [[ZOrganizationCardAddStudentListVC alloc] init];
            lvc.studentArr = weakSelf.studentArr;
            lvc.handleBlock = ^(NSArray *ids) {
                for (int i = 0; i < ids.count; i++) {
                    ZOriganizationStudentListModel *model = ids[i];
                    [weakSelf.studentArr addObject:model];
                }
                if (weakSelf) {
                    weakSelf.zChain_reload_ui();
                }
            };
            [weakSelf.navigationController pushViewController:lvc animated:YES];
        } forControlEvents:UIControlEventTouchUpInside];
        [self.navigationItem setRightBarButtonItem:[[UIBarButtonItem alloc] initWithCustomView:sureBtn]];
        
        UILabel *hintLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        hintLabel.textColor = adaptAndDarkColor([UIColor colorTextBlack], [UIColor colorTextBlackDark]);
        hintLabel.text = @"卡券赠送至账号，同一手机账号下任意选择一名学员即可。";
        hintLabel.numberOfLines = 0;
        hintLabel.textAlignment = NSTextAlignmentLeft;
        [hintLabel setFont:[UIFont fontSmall]];
        [self.view addSubview:hintLabel];
        [hintLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.view.mas_left).offset(CGFloatIn750(30));
            make.right.equalTo(self.view.mas_right).offset(-CGFloatIn750(30));
            make.top.equalTo(self.view.mas_top).offset(20);
        }];
        
        [self.view addSubview:self.userNameTF];
        [self.userNameTF mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.view);
            make.right.equalTo(self.view.mas_right).offset(-CGFloatIn750(30));
            make.height.mas_equalTo(CGFloatIn750(100));
            make.top.equalTo(hintLabel.mas_bottom).offset(10);
        }];
        
        UIView *bottomLineView = [[UIView alloc] initWithFrame:CGRectZero];
        bottomLineView.backgroundColor = adaptAndDarkColor([UIColor colorGrayLine], [UIColor colorGrayLine]);
        [self.view addSubview:bottomLineView];
        [bottomLineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.userNameTF);
            make.left.right.equalTo(self.view);
            make.height.mas_equalTo(0.5);
        }];
        [self.view addSubview:self.bottomView];
        [self.bottomView addSubview:self.sendBtn];
        [self.sendBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.right.bottom.equalTo(self.bottomView);
        }];
        
        [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self.view);
            make.height.mas_equalTo(CGFloatIn750(88));
            make.bottom.equalTo(self.view.mas_bottom).offset(-safeAreaBottom());
        }];
        
        [self.iTableView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self.view);
            make.bottom.equalTo(self.bottomView.mas_top);
            make.top.equalTo(self.userNameTF.mas_bottom).offset(10);
        }];
    }).zChain_updateDataSource(^{
        self.studentArr = @[].mutableCopy;
        self.btnArr = @[].mutableCopy;
        if (self.list) {
            for (int i = 0; i < self.list.count; i++) {
                [self.studentArr addObject:self.list[i]];;
            }
        }
    }).zChain_block_setUpdateCellConfigData(^(void (^update)(NSMutableArray *)) {
        [weakSelf.cellConfigArr removeAllObjects];
        if(weakSelf.studentModel){
            ZLineCellModel *sModel = ZLineCellModel.zz_lineCellModel_create(@"searchStuent").zz_titleLeft(weakSelf.studentModel.name)
            .zz_imageLeft(weakSelf.studentModel.image)
            .zz_cellHeight(CGFloatIn750(80))
            .zz_imageLeftRadius(YES)
            .zz_imageLeftHeight(CGFloatIn750(60))
            .zz_setData(weakSelf.studentModel)
            .zz_titleRight(@"添加");
            
            ZCellConfig *titleCellConfig = [ZCellConfig cellConfigWithClassName:[ZBaseLineCell className] title:sModel.cellTitle showInfoMethod:@selector(setModel:) heightOfCell:[ZBaseLineCell z_getCellHeight:sModel] cellType:ZCellTypeClass dataModel:sModel];
            
            [weakSelf.cellConfigArr addObject:titleCellConfig];
        }else{
            [weakSelf.cellConfigArr addObject:getEmptyCellWithHeight(CGFloatIn750(80))];
        }

        [weakSelf.cellConfigArr addObject:getEmptyCellWithHeight(CGFloatIn750(40))];
        if (ValidArray(weakSelf.studentArr)) {
            ZLineCellModel *sModel = ZLineCellModel.zz_lineCellModel_create(@"stuentTitle")
            .zz_titleLeft(@"已添加用户")
            .zz_fontLeft([UIFont boldFontMaxTitle])
            .zz_cellHeight(CGFloatIn750(50))
            .zz_lineHidden(YES);
            
            ZCellConfig *titleCellConfig = [ZCellConfig cellConfigWithClassName:[ZBaseLineCell className] title:@"title" showInfoMethod:@selector(setModel:) heightOfCell:[ZBaseLineCell z_getCellHeight:sModel] cellType:ZCellTypeClass dataModel:sModel];
            
            [weakSelf.cellConfigArr addObject:titleCellConfig];
            
            ZCellConfig *menuCellConfig = [ZCellConfig cellConfigWithClassName:[ZOrganizationCardAddStudentCell className] title:@"ZOrganizationCardAddStudentCell" showInfoMethod:@selector(setList:) heightOfCell:[ZOrganizationCardAddStudentCell z_getCellHeight:weakSelf.studentArr] cellType:ZCellTypeClass dataModel:weakSelf.studentArr];
            
            [weakSelf.cellConfigArr addObject:menuCellConfig];
        }
    }).zChain_block_setConfigDidSelectRowAtIndexPath(^(UITableView *tabelView, NSIndexPath *indexPath, ZCellConfig *cellConfig) {
        if ([cellConfig.title isEqualToString:@"searchStuent"]) {
            if (cellConfig.dataModel) {
                ZLineCellModel *lineModel = cellConfig.dataModel;
                if ([weakSelf checkStudentIsSame:lineModel.data]) {
                    [weakSelf.userNameTF resignFirstResponder];
                    [ZAlertView setAlertWithTitle:@"该手机账号下已选择过学员" btnTitle:@"知道了" handlerBlock:^(NSInteger index) {
                        
                    }];
                }else{
                    [weakSelf.studentArr addObject:lineModel.data];
                }
                
                weakSelf.userNameTF.text = @"";
                weakSelf.studentModel = nil;
                if (weakSelf) {
                    weakSelf.zChain_reload_ui();
                }
            }
        }
    });
    
    self.zChain_reload_ui();
}

- (UIButton *)addBtn {
    if (!_addBtn) {
        __weak typeof(self) weakSelf = self;
        _addBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, CGFloatIn750(60), CGFloatIn750(50))];
        [_addBtn setTitle:@"验证" forState:UIControlStateNormal];
        [_addBtn setTitleColor:adaptAndDarkColor([UIColor colorMain], [UIColor colorMainDark]) forState:UIControlStateNormal];
        [_addBtn.titleLabel setFont:[UIFont fontSmall]];
        [_addBtn bk_addEventHandler:^(id sender) {
            [weakSelf getStudentCodeInfo];
             if (weakSelf) {
                    weakSelf.zChain_reload_ui();
                }
        } forControlEvents:UIControlEventTouchUpInside];
    }
    return _addBtn;
}

- (UIButton *)sendBtn {
    if (!_sendBtn) {
        __weak typeof(self) weakSelf = self;
        _sendBtn = [[UIButton alloc] initWithFrame:CGRectZero];
        [_sendBtn setTitle:@"完成" forState:UIControlStateNormal];
        [_sendBtn setTitleColor:[UIColor colorWhite] forState:UIControlStateNormal];
        [_sendBtn.titleLabel setFont:[UIFont fontContent]];
        [_sendBtn setBackgroundColor:adaptAndDarkColor([UIColor colorMain], [UIColor colorMainDark]) forState:UIControlStateNormal];
        [_sendBtn bk_addEventHandler:^(id sender) {
            if (weakSelf.studentArr && weakSelf.studentArr.count > 0) {
                if (weakSelf.handleBlock) {
                    weakSelf.handleBlock(weakSelf.studentArr);
                }
                [weakSelf.navigationController popViewControllerAnimated:YES];
            }else{
                [TLUIUtility showErrorHint:@"你还没有添加学员"];
            }
        } forControlEvents:UIControlEventTouchUpInside];
    }
    return _sendBtn;
}

- (UIView *)bottomView {
    if (!_bottomView) {
        _bottomView = [[UIView alloc] init];
        _bottomView.layer.masksToBounds = YES;
        _bottomView.backgroundColor = adaptAndDarkColor([UIColor colorMain], [UIColor colorMainDark]);
    }
    return _bottomView;
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
        [_userNameTF setPlaceholder:@"请输入手机号,相同的账号只会赠送一次"];
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
    [ZPublicTool textField:textField maxLenght:11 type:ZFormatterTypeAny];
//    self.userNameTF.text = textField.text;
    if (textField.text.length == 11) {
        [self getStudentCodeInfo];
    }else{
        self.studentModel = nil;
        self.zChain_reload_ui();
    }
}

- (void)getStudentCodeInfo{
    __weak typeof(self) weakSelf = self;
    [ZOriganizationStudentViewModel getStudentCodeInfo:@{@"phone":SafeStr(self.userNameTF.text)} completeBlock:^(BOOL isSuccess, ZOriganizationStudentListModel *data) {
        weakSelf.loading = NO;
        if (isSuccess && data) {
            weakSelf.studentModel = data;
            if (weakSelf) {
                    weakSelf.zChain_reload_ui();
                }
        }
    }];
}

- (BOOL)checkStudentIsSame:(ZOriganizationStudentListModel*)model {
    __block BOOL isSame = NO;
    [self.studentArr enumerateObjectsUsingBlock:^(ZOriganizationStudentListModel *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([model.code_id isEqualToString:obj.code_id]) {
            isSame = YES;
        }
    }];
    return isSame;
}
@end
