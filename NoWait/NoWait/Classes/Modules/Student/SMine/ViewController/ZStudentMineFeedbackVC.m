//
//  ZStudentMineFeedbackVC.m
//  NoWait
//
//  Created by zhuang zhang on 2020/1/15.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZStudentMineFeedbackVC.h"

@interface ZStudentMineFeedbackVC ()<UITextViewDelegate>
@property (nonatomic,strong) UITextView *iTextView;
@property (nonatomic,strong) UILabel *hintLabel;
@property (nonatomic,strong) UIView *footerView;

@end

@implementation ZStudentMineFeedbackVC

- (instancetype)init {
    self = [super init];
    if (self) {
        self.analyzeTitle = @"意见反馈";
    }
    return self;
}

-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.iTextView resignFirstResponder];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initMainView];
}

#pragma mark 初始化view
- (void)initMainView {
    self.view.backgroundColor = KAdaptAndDarkColor(KBackColor, K2eBackColor);
    
    [self.navigationItem setTitle:LOCSTR(@"意见反馈")];
    
    
    
    UILabel *hintLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    hintLabel.textColor = KFont6Color;
    hintLabel.text = @"意见反馈";
    hintLabel.numberOfLines = 0;
    hintLabel.textAlignment = NSTextAlignmentLeft;
    [hintLabel setFont:[UIFont systemFontOfSize:CGFloatIn750(26)]];
    [self.view addSubview:hintLabel];
    [hintLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(CGFloatIn750(20));
        make.top.equalTo(self.view.mas_top).offset(CGFloatIn750(34));
    }];
    
    
    UIView *contBackView = [[UIView alloc] init];
    contBackView.backgroundColor = [UIColor whiteColor];
    contBackView.layer.masksToBounds = YES;
    contBackView.layer.cornerRadius = 3.0f;
    contBackView.layer.borderColor = KLineColor.CGColor;
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
    
    [self.view addSubview:self.footerView];
    [self.footerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.equalTo(self.view);
        make.height.mas_equalTo(200);
    }];
}


- (UITextView *)iTextView {
    if (!_iTextView) {
        _iTextView = [[UITextView alloc] initWithFrame:CGRectMake(CGFloatIn750(20), 0, KScreenWidth - CGFloatIn750(40), 118)];
        _iTextView.delegate = self;
        _iTextView.backgroundColor = [UIColor whiteColor];
        [_iTextView setFont:[UIFont systemFontOfSize:CGFloatIn750(26)]];
    }
    return _iTextView;
}


- (UILabel *)hintLabel {
    if (!_hintLabel) {
        _hintLabel = [[UILabel alloc] init];
        [_hintLabel setTextColor:KAdaptAndDarkColor(KFont9Color, KFont3Color)];
        [_hintLabel setFont:[UIFont systemFontOfSize:CGFloatIn750(26)]];
        [_hintLabel setText:@"您有什么意见要反馈给我们？"];
    }
    return _hintLabel;
}



- (void)textViewDidChange:(UITextView *)textView {
    NSInteger _isMaxLength = 500;
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

-(UIView *)footerView {
    if (!_footerView) {
        _footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, 200)];
        _footerView.backgroundColor = KAdaptAndDarkColor(KBackColor, K2eBackColor);
        
        UIButton *doneBtn = [[UIButton alloc] initWithFrame:CGRectZero];
        doneBtn.layer.masksToBounds = YES;
        doneBtn.layer.cornerRadius = CGFloatIn750(40);
        [doneBtn setTitle:@"提交" forState:UIControlStateNormal];
        [doneBtn setBackgroundColor:KMainColor forState:UIControlStateNormal];
        [doneBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [doneBtn setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
        [doneBtn.titleLabel setFont:[UIFont systemFontOfSize:CGFloatIn750(32)]];
        [_footerView addSubview:doneBtn ];
        [doneBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(CGFloatIn750(80));
            make.left.equalTo(self.footerView.mas_left).offset(CGFloatIn750(20));
            make.right.equalTo(self.footerView.mas_right).offset(-CGFloatIn750(20));
            make.bottom.equalTo(self.footerView.mas_bottom).offset(-CGFloatIn750(100));
        }];
        
        __weak typeof(self) weakSelf = self;
        [doneBtn bk_addEventHandler:^(id sender) {
            if (weakSelf.iTextView.text && weakSelf.iTextView.text.length > 0) {
                if (weakSelf.iTextView.text.length < 5) {
                    [TLUIUtility showErrorHint:@"意见太少了，不能少有5个字符"];
                    return ;
                }
//                [TLUIUtility showLoading:nil];
//                [ZMIneViewModel saveProposalContentWith:weakSelf.iTextView.text completeBlock:^(BOOL isSuccess, NSString *message) {
//                    [TLUIUtility hiddenLoading];
//                    if (isSuccess) {
//                        [TLUIUtility showSuccessHint:message];
//
//                        [weakSelf.navigationController popViewControllerAnimated:YES];
//                    }else{
//                        [TLUIUtility showErrorHint:message];
//                    }
//                }];
            }else{
                [TLUIUtility showErrorHint:@"意见不能为空"];
            }
            
        } forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _footerView;
}

@end

