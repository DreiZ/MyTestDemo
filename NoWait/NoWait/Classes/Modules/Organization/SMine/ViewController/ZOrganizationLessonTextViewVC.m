//
//  ZOrganizationLessonTextViewVC.m
//  NoWait
//
//  Created by zhuang zhang on 2020/3/11.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZOrganizationLessonTextViewVC.h"

@interface ZOrganizationLessonTextViewVC ()<UITextViewDelegate>
@property (nonatomic,strong) UITextView *iTextView;
@property (nonatomic,strong) UILabel *hintLabel;
@property (nonatomic,strong) UIButton *rightNavBtn;

@end

@implementation ZOrganizationLessonTextViewVC

-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.iTextView resignFirstResponder];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initMainView];
    self.iTextView.text = self.content;
}

#pragma mark - 初始化view
- (void)initMainView {
    self.view.backgroundColor = adaptAndDarkColor([UIColor colorGrayBG], [UIColor colorGrayBGDark]);
    
    [self.navigationItem setTitle:self.navTitle];
    [self.navigationItem setRightBarButtonItem:[[UIBarButtonItem alloc] initWithCustomView:self.rightNavBtn]];
    
    
    UILabel *hintLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    hintLabel.textColor = [UIColor colorTextGray];
    hintLabel.text = self.navTitle;
    hintLabel.numberOfLines = 0;
    hintLabel.textAlignment = NSTextAlignmentLeft;
    [hintLabel setFont:[UIFont fontSmall]];
    [self.view addSubview:hintLabel];
    [hintLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(CGFloatIn750(20));
        make.top.equalTo(self.view.mas_top).offset(CGFloatIn750(34));
    }];
    
    
    UIView *contBackView = [[UIView alloc] init];
    contBackView.backgroundColor = adaptAndDarkColor([UIColor colorWhite], [UIColor colorBlackBGDark]);
    contBackView.layer.masksToBounds = YES;
    contBackView.layer.cornerRadius = 3.0f;
    contBackView.layer.borderColor = isDarkModel()? [UIColor colorGrayLineDark].CGColor:[UIColor colorGrayLine].CGColor;
    contBackView.layer.borderWidth = 0.5;
    [self.view addSubview:contBackView];
    [contBackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(CGFloatIn750(20));
        make.right.equalTo(self.view.mas_right).offset(CGFloatIn750(-20));
        make.top.equalTo(hintLabel.mas_bottom).offset(CGFloatIn750(20));
        make.height.mas_equalTo(CGFloatIn750(412));
    }];
    
    [self.view addSubview:self.iTextView];
    [self.iTextView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(contBackView.mas_left).offset(CGFloatIn750(20));
        make.right.equalTo(contBackView.mas_right).offset(CGFloatIn750(-20));
        make.top.equalTo(contBackView.mas_top).offset(CGFloatIn750(10));
        make.bottom.equalTo(contBackView.mas_bottom).offset(CGFloatIn750(-10));
    }];
    
    [self.iTextView addSubview:self.hintLabel];
    [self.hintLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.iTextView.mas_left).offset(CGFloatIn750(6));
        make.top.equalTo(self.iTextView.mas_top).offset(CGFloatIn750(16));
    }];
    
    if (ValidStr(self.content)) {
        self.hintLabel.hidden = YES;
    }
}


- (UIButton *)rightNavBtn {
    if (!_rightNavBtn) {
        __weak typeof(self) weakSelf = self;
        _rightNavBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, CGFloatIn750(90), CGFloatIn750(50))];
        [_rightNavBtn setTitle:@"提交" forState:UIControlStateNormal];
        [_rightNavBtn setTitleColor:[UIColor colorMain] forState:UIControlStateNormal];
        [_rightNavBtn.titleLabel setFont:[UIFont fontContent]];
        [_rightNavBtn bk_addEventHandler:^(id sender) {
            if (weakSelf.handleBlock) {
                weakSelf.handleBlock(weakSelf.iTextView.text);
                [weakSelf.navigationController popViewControllerAnimated:YES];
            }
        } forControlEvents:UIControlEventTouchUpInside];
    }
    return _rightNavBtn;
}


- (UITextView *)iTextView {
    if (!_iTextView) {
        _iTextView = [[UITextView alloc] initWithFrame:CGRectMake(CGFloatIn750(20), 0, KScreenWidth - CGFloatIn750(40), 118)];
        _iTextView.delegate = self;
        _iTextView.backgroundColor = adaptAndDarkColor([UIColor colorWhite], [UIColor colorBlackBGDark]);
        [_iTextView setFont:[UIFont fontSmall]];
    }
    return _iTextView;
}


- (UILabel *)hintLabel {
    if (!_hintLabel) {
        _hintLabel = [[UILabel alloc] init];
        [_hintLabel setTextColor:adaptAndDarkColor([UIColor colorTextGray1], [UIColor colorTextGray1Dark])];
        [_hintLabel setFont:[UIFont fontSmall]];
        [_hintLabel setText:self.hintStr];
    }
    return _hintLabel;
}



- (void)textViewDidChange:(UITextView *)textView {
    NSInteger _isMaxLength = self.max;
    if (textView.text.length > 0) {
        _hintLabel.hidden = YES;
    }else {
        _hintLabel.hidden = NO;
    }
    if (textView.text.length > _isMaxLength) {
        [TLUIUtility showErrorHint:@"输入内容超出限制"];
        NSString *str = textView.text;
        NSInteger length = _isMaxLength - 1;
        if (str.length <= length) {
            length = str.length - 1;
        }
        str = [str substringToIndex:length];
        textView.text = str;
    }
}
@end
