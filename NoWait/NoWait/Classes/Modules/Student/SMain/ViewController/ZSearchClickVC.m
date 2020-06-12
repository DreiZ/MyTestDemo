//
//  ZSearchClickVC.m
//  NoWait
//
//  Created by zhuang zhang on 2020/4/8.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZSearchClickVC.h"
#import "ZSearchHistoryView.h"
#import "ZDBMainStore.h"


@interface ZSearchClickVC ()<UITextFieldDelegate>
@property (nonatomic,strong) ZSearchHistoryView *historyView;

@end

@implementation ZSearchClickVC

#pragma mark vc delegate-------------------
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.isHidenNaviBar = YES;
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    self.isHidenNaviBar = NO;
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNavigation];
}

- (void)setNavigation {
    self.isHidenNaviBar = YES;
    [self.navigationItem setTitle:self.navTitle];
}

- (void)setupMainView {
    [super setupMainView];
    
    [self.view addSubview:self.searchView];
    [self.searchView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).offset(kStatusBarHeight);
        make.left.right.equalTo(self.view);
        make.height.mas_equalTo(CGFloatIn750(88));
    }];
   
    [self.iTableView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(CGFloatIn750(0));
        make.right.equalTo(self.view.mas_right).offset(CGFloatIn750(-0));
        make.bottom.equalTo(self.view.mas_bottom).offset(-CGFloatIn750(0));
        make.top.equalTo(self.searchView.mas_bottom).offset(-CGFloatIn750(0));
    }];
    self.searchView.iTextField.placeholder = self.navTitle;
    
    [self.view addSubview:self.historyView];
    [self.historyView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.top.equalTo(self.searchView.mas_bottom).offset(-CGFloatIn750(0));
    }];
}

#pragma mark lazy loading...
- (ZSearchFieldView *)searchView {
    if (!_searchView) {
        __weak typeof(self) weakSelf = self;
        _searchView = [[ZSearchFieldView alloc] init];
        _searchView.iTextField.delegate = self;
        _searchView.textChangeBlock = ^(NSString *text) {
            [weakSelf valueChange:text];
        };
        _searchView.backBlock = ^{
            [weakSelf.navigationController popViewControllerAnimated:YES];
        };
        
        _searchView.searchBlock = ^(NSString *text) {
            [weakSelf searchClick:weakSelf.searchView.iTextField.text];
        };
    }
    return _searchView;
}

- (void)cancleBtnOnClick {
    [self.navigationController popViewControllerAnimated:YES];
}

- (ZSearchHistoryView *)historyView {
    if (!_historyView) {
        __weak typeof(self) weakSelf = self;
        _historyView = [[ZSearchHistoryView alloc] initWithFrame:CGRectMake(0, kTopHeight, KScreenWidth, KScreenHeight - kTopHeight)];
        _historyView.searchType = self.searchType;
        _historyView.searchBlock = ^(NSString * text) {
            weakSelf.searchView.iTextField.text = text;
            [weakSelf searchClick:text];
        };
    }
    return _historyView;;
}

#pragma mark - -textField delegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    [self searchClick:textField.text];
//    [self searchPoiByKeyword:textField.text];
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    self.historyView.hidden = YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField reason:(UITextFieldDidEndEditingReason)reason  API_AVAILABLE(ios(10.0)){
    self.historyView.hidden = YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
//    self.searhView.hidden = NO;
    self.historyView.hidden = NO;
    [self.historyView reloadHistoryData];
}

- (void)valueChange:(NSString *)text {
    
}

- (void)searchClick:(NSString *)text {
    [self.searchView.iTextField resignFirstResponder];
    
    if (ValidStr(text)) {
        __block ZHistoryModel *lmodel = [[ZHistoryModel alloc] init];
        lmodel.search_title = text;
        lmodel.search_type = self.searchType;
        __block BOOL isHad = NO;
        __block NSInteger index = 0;
        NSMutableArray *tempArr = [[ZDBMainStore shareManager] searchHistorysByID:self.searchType];
        [tempArr enumerateObjectsWithOptions:NSEnumerationReverse usingBlock:^(ZHistoryModel *obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([obj.search_title isEqualToString:lmodel.search_title]) {
                isHad = YES;
                index = idx;
            }
        }];
        
        if (isHad) {
            [tempArr removeObjectAtIndex:index];
            [tempArr insertObject:lmodel atIndex:0];
        }else{
            [tempArr insertObject:lmodel atIndex:0];
        }
        
        if (tempArr.count > 9) {
            [tempArr removeLastObject];
        }
        [[ZDBMainStore shareManager] updateHistorySearchs:tempArr];
    }
}
@end


