//
//  ZOrganizationStudentSelectVC.m
//  NoWait
//
//  Created by zhuang zhang on 2020/4/10.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZOrganizationStudentSelectVC.h"

@interface ZOrganizationStudentSelectVC ()
@property (nonatomic,strong) UIButton *selectBtn;

@end

@implementation ZOrganizationStudentSelectVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.isEdit = YES;
    // Do any additional setup after loading the view.
}


- (void)initCellConfigArr {
    
    
    for (int i = 0; i < self.dataSources.count; i++) {
        ZOriganizationStudentListModel *model = self.dataSources[i];
        model.isEdit = YES;
        [_ids enumerateObjectsWithOptions:NSEnumerationReverse usingBlock:^(ZOriganizationStudentListModel *obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([obj.studentID isEqualToString:model.studentID]) {
                model.isSelected = YES;
                [_ids removeObjectAtIndex:idx];
            }
        }];
    }
    [super initCellConfigArr];
}




- (void)setupMainView {
    [super setupMainView];
    [self.bottomView addSubview:self.selectBtn];
    [self.selectBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.bottomView);
    }];
}

- (UIButton *)selectBtn {
    if (!_selectBtn) {
        __weak typeof(self) weakSelf = self;
        _selectBtn = [[ZButton alloc] initWithFrame:CGRectZero];
        [_selectBtn setTitle:@"确定" forState:UIControlStateNormal];
        [_selectBtn setTitleColor:[UIColor colorWhite] forState:UIControlStateNormal];
        [_selectBtn.titleLabel setFont:[UIFont fontContent]];
        [_selectBtn setBackgroundColor:adaptAndDarkColor([UIColor colorMain], [UIColor colorMainDark]) forState:UIControlStateNormal];
        [_selectBtn bk_addEventHandler:^(id sender) {
            NSArray *ids = [weakSelf getSelectedData];
            if (ids && ids.count > 0) {
                if (self.bottomBlock) {
                    self.bottomBlock(ids);
                }
                [self.navigationController popViewControllerAnimated:YES];
            }else{
                [TLUIUtility showErrorHint:@"你还没有选中"];
            }
        } forControlEvents:UIControlEventTouchUpInside];
    }
    return _selectBtn;
}


- (void)setIsEdit:(BOOL)isEdit {
    super.isEdit = YES;
    if (isEdit) {
        self.navRightBtn.backgroundColor = adaptAndDarkColor([UIColor whiteColor], [UIColor colorBlackBGDark]);
        [self.navRightBtn setTitle:@"全选" forState:UIControlStateNormal];
        [self.navRightBtn setTitleColor:adaptAndDarkColor([UIColor colorMain], [UIColor colorMainDark]) forState:UIControlStateNormal];
        [self.navLeftBtn setTitle:@"取消" forState:UIControlStateNormal];
        [self.navLeftBtn setImage:nil forState:UIControlStateNormal];
        

        [self.bottomView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self.view);
            make.height.mas_equalTo(CGFloatIn750(88));
            make.bottom.equalTo(self.view.mas_bottom).offset(CGFloatIn750(-safeAreaBottom()));
        }];
        [self.iTableView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.view.mas_left).offset(CGFloatIn750(30));
            make.right.equalTo(self.view.mas_right).offset(CGFloatIn750(-30));
            make.bottom.equalTo(self.bottomView.mas_top).offset(-CGFloatIn750(0));
            make.top.equalTo(self.filterView.mas_bottom).offset(-CGFloatIn750(20));
        }];
    }else{
        [self.navRightBtn setTitle:@"添加" forState:UIControlStateNormal];
        self.navRightBtn.backgroundColor = adaptAndDarkColor([UIColor colorMain], [UIColor colorMainDark]);
        [self.navRightBtn setTitleColor:[UIColor colorWhite] forState:UIControlStateNormal];
        
        [self.navLeftBtn setTitle:@"" forState:UIControlStateNormal];
        [self.navLeftBtn setImage:[UIImage imageNamed:isDarkModel() ? @"navleftBackDark":@"navleftBack"] forState:UIControlStateNormal];
        
        [self.bottomView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self.view);
            make.height.mas_equalTo(CGFloatIn750(88));
            make.top.equalTo(self.view.mas_bottom).offset(CGFloatIn750(safeAreaBottom()));
        }];
        [self.iTableView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.view.mas_left).offset(CGFloatIn750(30));
            make.right.equalTo(self.view.mas_right).offset(CGFloatIn750(-30));
            make.bottom.equalTo(self.view.mas_bottom).offset(-CGFloatIn750(0));
            make.top.equalTo(self.filterView.mas_bottom).offset(-CGFloatIn750(20));
        }];
    }
    
    [self selectDataEdit:isEdit];
}

- (void)leftBtnOnClick {
    [self.navigationController popViewControllerAnimated:YES];
}
@end
