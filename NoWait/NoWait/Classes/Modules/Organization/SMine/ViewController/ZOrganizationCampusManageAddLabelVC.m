//
//  ZOrganizationCampusManageAddLabelVC.m
//  NoWait
//
//  Created by zhuang zhang on 2020/2/18.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZOrganizationCampusManageAddLabelVC.h"
#define btnHeight CGFloatIn750(54)
#define btnAddWidth CGFloatIn750(48)
#define leftX CGFloatIn750(30)
#define labelBack @"   X"

@interface ZOrganizationCampusManageAddLabelVC ()<UITextFieldDelegate>
@property (nonatomic,strong) UITextField *userNameTF;
@property (nonatomic,strong) UILabel *numLabel;
@property (nonatomic,strong) UIView *LabelView;
@property (nonatomic,strong) UIButton *addBtn;

@property (nonatomic,strong) NSMutableArray *labelArr;
@property (nonatomic,strong) NSMutableArray *btnArr;
@end

@implementation ZOrganizationCampusManageAddLabelVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNavigation];
    [self setMainView];
    [self setDataSource];
    [self setLabel];
}

- (void)setDataSource {
    _labelArr = @[].mutableCopy;
    _btnArr = @[].mutableCopy;
    if (self.list) {
        for (int i = 0; i < self.list.count; i++) {
            [self.labelArr addObject:self.list[i]];;
        }
    }
}

- (void)setNavigation {
    self.isHidenNaviBar = NO;
    [self.navigationItem setTitle:_navTitle? _navTitle: @"添加标签"];
    
    __weak typeof(self) weakSelf = self;
    UIButton *sureBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, CGFloatIn750(90), CGFloatIn750(50))];
    [sureBtn setTitle:@"完成" forState:UIControlStateNormal];
    [sureBtn setTitleColor:adaptAndDarkColor([UIColor colorTextGray], [UIColor colorTextGrayDark]) forState:UIControlStateNormal];
    [sureBtn.titleLabel setFont:[UIFont fontContent]];
    [sureBtn bk_addEventHandler:^(id sender) {
        if (weakSelf.handleBlock) {
            weakSelf.handleBlock(weakSelf.labelArr);
        }
        [weakSelf.navigationController popViewControllerAnimated:YES];
    } forControlEvents:UIControlEventTouchUpInside];
    [self.navigationItem setRightBarButtonItem:[[UIBarButtonItem alloc] initWithCustomView:sureBtn]];
}

- (void)setMainView {
    self.view.backgroundColor = adaptAndDarkColor([UIColor colorWhite], [UIColor colorBlackBGDark]);
    
    [self.view addSubview:self.LabelView];
    [self.LabelView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(self.view);
        make.height.mas_equalTo(CGFloatIn750(1));
    }];
    UIView *topLineView = [[UIView alloc] initWithFrame:CGRectZero];
    topLineView.backgroundColor = adaptAndDarkColor([UIColor colorGrayLine], [UIColor colorGrayLineDark]);
    [self.LabelView addSubview:topLineView];
    [topLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.LabelView);
        make.left.right.equalTo(self.view);
        make.height.mas_equalTo(0.5);
    }];
    
//    __weak typeof(self) weakSelf = self;
    UIView *hintView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGFloatIn750(30), CGFloatIn750(80))];

    _userNameTF  = [[UITextField alloc] init];
    _userNameTF.tag = 105;
//    _userNameTF.clearButtonMode = UITextFieldViewModeAlways;
    _userNameTF.leftViewMode = UITextFieldViewModeAlways;
    _userNameTF.leftView = hintView;
    [_userNameTF setTextAlignment:NSTextAlignmentLeft];
    [_userNameTF setFont:[UIFont fontContent]];
    [_userNameTF setBorderStyle:UITextBorderStyleNone];
    [_userNameTF setBackgroundColor:[UIColor clearColor]];
    [_userNameTF setReturnKeyType:UIReturnKeyDone];
    [_userNameTF setPlaceholder:@"输入自定义标签，最多5个字"];
    _userNameTF.delegate = self;
    [_userNameTF addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    _userNameTF.backgroundColor = adaptAndDarkColor([UIColor colorWhite], [UIColor colorBlackBGDark]);
    _userNameTF.keyboardType = UIKeyboardTypeDefault;
    _userNameTF.textColor = adaptAndDarkColor([UIColor colorTextBlack], [UIColor colorTextBlackDark]);
//    ViewShadowRadius(_userNameTF, CGFloatIn750(24), CGSizeMake(2, 2), 0.5, [UIColor colorGrayBG]);
    _userNameTF.rightView = self.addBtn;
    _userNameTF.rightViewMode = UITextFieldViewModeAlways;

    [self.view addSubview:self.userNameTF];
    [self.userNameTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view);
        make.right.equalTo(self.view.mas_right).offset(-CGFloatIn750(90));
        make.height.mas_equalTo(CGFloatIn750(100));
        make.top.equalTo(self.LabelView.mas_bottom).offset(20);
    }];
    
    [self.view addSubview:self.numLabel];
    [self.numLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view.mas_right).offset(-CGFloatIn750(20));
        make.centerY.equalTo(self.userNameTF.mas_centerY);
    }];
    
    UIView *bottomLineView = [[UIView alloc] initWithFrame:CGRectZero];
    bottomLineView.backgroundColor = adaptAndDarkColor([UIColor colorGrayLine], [UIColor colorGrayLine]);
    [self.view addSubview:bottomLineView];
    [bottomLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.userNameTF);
        make.left.right.equalTo(self.view);
        make.height.mas_equalTo(0.5);
    }];
}

- (UIView *)LabelView {
    if (!_LabelView) {
        _LabelView = [[UIView alloc] init];
    }
    
    return _LabelView;
}

- (UIButton *)addBtn {
    if (!_addBtn) {
        __weak typeof(self) weakSelf = self;
        _addBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, CGFloatIn750(60), CGFloatIn750(50))];
        [_addBtn setTitle:@"添加" forState:UIControlStateNormal];
        [_addBtn setTitleColor:adaptAndDarkColor([UIColor colorMain], [UIColor colorMainDark]) forState:UIControlStateNormal];
        [_addBtn.titleLabel setFont:[UIFont fontSmall]];
        [_addBtn bk_addEventHandler:^(id sender) {
            if (weakSelf.userNameTF.text.length > 0) {
                [weakSelf.labelArr addObject:weakSelf.userNameTF.text];
                [weakSelf setLabel];
                weakSelf.userNameTF.text = @"";
                weakSelf.numLabel.text = [NSString stringWithFormat:@"%ld/%ld",weakSelf.userNameTF.text.length,weakSelf.max];
            }
        } forControlEvents:UIControlEventTouchUpInside];
    }
    return _addBtn;
}

- (UILabel *)numLabel {
    if (!_numLabel) {
        _numLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _numLabel.textColor = adaptAndDarkColor([UIColor colorTextGray],[UIColor colorTextGrayDark]);
        _numLabel.text = @"0/5";
        _numLabel.numberOfLines = 1;
        _numLabel.textAlignment = NSTextAlignmentRight;
        [_numLabel setFont:[UIFont fontMin]];
    }
    return _numLabel;
}

#pragma mark textField delegate ---------
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    return YES;
}


- (void)setLabel{
    [self.LabelView removeAllSubviews];
    
    if (!self.labelArr || self.labelArr.count == 0) {
        [self.LabelView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.top.right.equalTo(self.view);
            make.height.mas_equalTo([self getHeight]);
        }];
        return;
    }

    CGFloat maxWidth = KScreenWidth - 2 * leftX;
    CGFloat offSetX = leftX;
    CGFloat offSetY = CGFloatIn750(24);
    for (int i = 0; i< _labelArr.count; i++) {
        
        UIButton *btn = [self getHotSearchBtnItem:i];
        [btn setTitle:[NSString stringWithFormat:@"%@%@", _labelArr[i],labelBack] forState:UIControlStateNormal];
        [self.LabelView addSubview:btn];
        CGFloat width = [self getTheStringWidth:[NSString stringWithFormat:@"%@%@", _labelArr[i],labelBack] font:[UIFont systemFontOfSize:14]];
        width += btnAddWidth;
        if (offSetX+width > maxWidth) {
            offSetX = leftX;
            offSetY += CGFloatIn750(20) + btnHeight;
        }
        btn.frame = CGRectMake(offSetX, offSetY, width, btnHeight);
        offSetX += (width+leftX);
    }
    
    
    [self.LabelView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(self.view);
        make.height.mas_equalTo([self getHeight]);
    }];
}

- (CGFloat) getTheStringWidth:(NSString *)str font:(UIFont *)font
{
    return  [str sizeWithAttributes:@{NSFontAttributeName: font}].width;
}

-(UIButton*) getHotSearchBtnItem:(NSInteger)index
{
    if (index >= _btnArr.count) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.tag = index;
        btn.titleLabel.font = [UIFont systemFontOfSize:14];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        btn.layer.cornerRadius = btnHeight/2.0;
        btn.layer.masksToBounds = YES;
        btn.backgroundColor = adaptAndDarkColor([UIColor colorMain], [UIColor colorMainDark]);
        [btn addTarget:self action:@selector(selectedBtnOnClick:) forControlEvents:UIControlEventTouchUpInside];
        
        [_btnArr addObject:btn];
    }
    
    return _btnArr[index];
}


- (void)selectedBtnOnClick:(UIButton *)sender {
    if (sender.tag < self.labelArr.count && self.labelArr.count == self.btnArr.count) {
        [self.labelArr removeObjectAtIndex:sender.tag];
        [self.btnArr removeObjectAtIndex:sender.tag];
        [self setLabel];
    }
}

- (CGFloat)getHeight {
    if (_labelArr.count == 0) {
        return 1;
    }
    CGFloat labelHeight = CGFloatIn750(24);
    CGFloat maxWidth = KScreenWidth - 2 * leftX;
    CGFloat offSetX = leftX;
    CGFloat offSetY = CGFloatIn750(24);
    for (int i = 0; i< _labelArr.count; i++) {
        CGFloat width = [self getTheStringWidth:[NSString stringWithFormat:@"%@%@", _labelArr[i],labelBack] font:[UIFont systemFontOfSize:14]];
        width += btnAddWidth;
        if (offSetX+width > maxWidth) {
            offSetX = leftX;
            offSetY += CGFloatIn750(20) + btnHeight;
        }
        offSetX += (width+leftX);
    }
    labelHeight = offSetY + btnHeight;
    return labelHeight;
}
#pragma mark - -textField delegate
- (void)textFieldDidChange:(UITextField *)textField {
    [ZPublicTool textField:textField maxLenght:self.max > 0 ? self.max:20 type:ZFormatterTypeAnyByte];
//    self.userNameTF.text = textField.text;
 
    self.numLabel.text = [NSString stringWithFormat:@"%ld/%ld",textField.text.length,self.max > 0 ? self.max:20];
}


- (void)traitCollectionDidChange:(UITraitCollection *)previousTraitCollection {
//    ViewShadowRadius(_userNameTF, CGFloatIn750(24), CGSizeMake(2, 2), 0.5, isDarkModel() ? [UIColor colorGrayBG] : [UIColor colorGrayBGDark]);
}
@end

#pragma mark - RouteHandler
@interface ZOrganizationCampusManageAddLabelVC (RouteHandler)<SJRouteHandler>

@end

@implementation ZOrganizationCampusManageAddLabelVC (RouteHandler)

+ (NSString *)routePath {
    return ZRoute_org_addLabel;
}

+ (void)handleRequest:(SJRouteRequest *)request topViewController:(UIViewController *)topViewController completionHandler:(SJCompletionHandler)completionHandler {
    ZOrganizationCampusManageAddLabelVC *routevc = [[ZOrganizationCampusManageAddLabelVC alloc] init];
    if (request.prts && [request.prts isKindOfClass:[NSDictionary class]]) {
        NSDictionary *tempDict = request.prts;
        if ([tempDict objectForKey:@"list"]) {
            routevc.list = tempDict[@"list"];
        }
        if ([tempDict objectForKey:@"max"]) {
            routevc.max = [tempDict[@"max"] intValue];
        }
        
        if ([tempDict objectForKey:@"navTitle"]) {
            routevc.navTitle = tempDict[@"navTitle"];
        }
    }
    
    routevc.handleBlock = ^(NSArray *list) {
        if (completionHandler) {
            completionHandler(list, nil);
        }
    };
    [topViewController.navigationController pushViewController:routevc animated:YES];
}
@end
