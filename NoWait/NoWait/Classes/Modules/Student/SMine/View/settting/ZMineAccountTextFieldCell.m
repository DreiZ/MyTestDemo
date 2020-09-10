//
//  ZMineAccountTextFieldCell.m
//  NoWait
//
//  Created by zhuang zhang on 2020/3/3.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZMineAccountTextFieldCell.h"
#import "ZLoginViewModel.h"

#define CountTimer 59
static NSUInteger myRetrieveTime = 59;
static NSTimer *retrieveTimer = nil;

@interface ZMineAccountTextFieldCell ()<UITextFieldDelegate>

@property (nonatomic,strong) UIButton *getCodeBtn;
@property (nonatomic,strong) UIView *getCodeView;
@property (nonatomic,strong) UIButton *pooCodeView;
@property (nonatomic,strong) UIView *backView;

@end

@implementation ZMineAccountTextFieldCell

-(void)setupView
{
    [super setupView];
    
    UIView *backView = [[UIView alloc] initWithFrame:CGRectZero];
    backView.backgroundColor = adaptAndDarkColor(HexColor(0xf5f9f8), HexColor(0x050908));
    ViewRadius(backView, [ZMineAccountTextFieldCell z_getCellHeight:nil]/2.0f);
    _backView = backView;
    [self.contentView addSubview:backView];
    [backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView.mas_right).offset(-CGFloatIn750(60));
        make.left.equalTo(self.contentView.mas_left).offset(CGFloatIn750(60));
        make.top.equalTo(self.contentView.mas_top);
        make.bottom.equalTo(self.contentView.mas_bottom);
    }];
    
    [self.contentView addSubview:self.inputTextField];
    [backView addSubview:self.getCodeView];
    
    [self.inputTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView.mas_right).offset(-CGFloatIn750(60));
        make.left.equalTo(self.contentView.mas_left).offset(CGFloatIn750(60));
        make.top.equalTo(self.contentView.mas_top);
        make.bottom.equalTo(self.contentView.mas_bottom);
    }];
    ViewRadius(self.inputTextField, [ZMineAccountTextFieldCell z_getCellHeight:nil]/2.0f);
    
    [self.getCodeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.backView.mas_right).offset(-CGFloatIn750(16));
        make.centerY.equalTo(self.inputTextField.mas_centerY);
        make.width.mas_equalTo(CGFloatIn750(184));
        make.top.bottom.equalTo(self.inputTextField);
    }];
    
    
    [self.contentView  addSubview:self.pooCodeView];
    [self.pooCodeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.backView.mas_right).offset(-CGFloatIn750(16));
        make.centerY.equalTo(self.inputTextField.mas_centerY);
        make.width.mas_equalTo(CGFloatIn750(148));
        make.height.mas_equalTo(CGFloatIn750(60));
    }];
    
    self.type = 0;
}


- (UITextField *)inputTextField {
    if (!_inputTextField ) {
        UIView *leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGFloatIn750(40), CGFloatIn750(40))];
        
        _inputTextField = [[UITextField alloc] init];
        [_inputTextField setFont:[UIFont fontContent]];
        _inputTextField.leftView = leftView;
        _inputTextField.leftViewMode = UITextFieldViewModeAlways;
        _inputTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
        [_inputTextField setBorderStyle:UITextBorderStyleNone];
        [_inputTextField setBackgroundColor:[UIColor clearColor]];
        [_inputTextField setReturnKeyType:UIReturnKeyDone];
        [_inputTextField setTextAlignment:NSTextAlignmentLeft];
        [_inputTextField setPlaceholder:@""];
        [_inputTextField setTextColor:adaptAndDarkColor([UIColor colorTextBlack], [UIColor colorTextBlackDark])];
        _inputTextField.backgroundColor = adaptAndDarkColor(HexColor(0xf5f9f8), HexColor(0x050908));
        _inputTextField.delegate = self;
        [_inputTextField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    }
    return _inputTextField;
}

- (UIView *)getCodeView {
    if (!_getCodeView) {
        //获取验证码
        _getCodeView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGFloatIn750(172+12), CGFloatIn750(70))];
        [_getCodeView addSubview:self.getCodeBtn];
        [self.getCodeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.right.bottom.equalTo(self.getCodeView);
            make.left.equalTo(self.getCodeView.mas_left).offset(CGFloatIn750(12));
        }];
    }
    return _getCodeView;
}


- (UIButton *)getCodeBtn {
    if (!_getCodeBtn) {
        __weak typeof(self) weakSelf = self;
        _getCodeBtn = [[UIButton alloc] initWithFrame:CGRectZero];
        [_getCodeBtn bk_addEventHandler:^(id sender) {
            if (weakSelf.getCodeBlock) {
                [weakSelf.inputTextField becomeFirstResponder];
                weakSelf.getCodeBlock(^(NSString *message) {
                    if (myRetrieveTime == CountTimer) {
                        [weakSelf.getCodeBtn setTitle:@"60秒" forState:UIControlStateDisabled];
                        [weakSelf startTimer];
                        weakSelf.getCodeBtn.enabled = NO;
                    }
                });
            }
        } forControlEvents:UIControlEventTouchUpInside];
        [_getCodeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
        [_getCodeBtn setTitleColor:adaptAndDarkColor([UIColor colorMain], [UIColor colorMainDark]) forState:UIControlStateNormal];
        [_getCodeBtn.titleLabel setFont:[UIFont fontContent]];
    }
    return _getCodeBtn;
}

- (void)startTime {
   if (myRetrieveTime == CountTimer) {
       [self.getCodeBtn setTitle:@"60秒" forState:UIControlStateDisabled];
       [self startTimer];
       self.getCodeBtn.enabled = NO;
   }
}


#pragma mark - -textField delegate
- (void)textFieldDidChange:(UITextField *)textField {
    [ZPublicTool textField:textField maxLenght:self.max > 0 ? self.max:20 type:self.formatterType];
 
    if (self.valueChangeBlock) {
        self.valueChangeBlock(textField.text);
    }
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    return [ZPublicTool textField:textField shouldChangeCharactersInRange:range replacementString:string type:self.formatterType];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self.inputTextField resignFirstResponder];
    return YES;
}

- (void)setFormatterType:(ZFormatterType)formatterType {
    _formatterType = formatterType;
    if (formatterType == ZFormatterTypeDecimal) {
        _inputTextField.keyboardType = UIKeyboardTypeDecimalPad;
    }else if (formatterType == ZFormatterTypeNumber) {
        _inputTextField.keyboardType = UIKeyboardTypeNumberPad;
    }else if (formatterType == ZFormatterTypePhoneNumber) {
        _inputTextField.keyboardType = UIKeyboardTypePhonePad;
    }else {
        _inputTextField.keyboardType = UIKeyboardTypeDefault;
    }
}


#pragma mark --按钮 click
- (void)startTimer {
    [retrieveTimer invalidate];
    retrieveTimer = nil;
    if (!retrieveTimer) {
        NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timerChange) userInfo:nil repeats:YES];
        retrieveTimer = timer;
        [[NSRunLoop mainRunLoop] addTimer:retrieveTimer forMode:NSRunLoopCommonModes];
    }
}

// 定时器方法
- (void)timerChange{
    if (myRetrieveTime == -1) {
        [retrieveTimer invalidate];
        retrieveTimer = nil;
        myRetrieveTime = CountTimer;
        self.getCodeBtn.enabled = YES;
        [self.getCodeBtn setTitle:@"获取验证码" forState:UIControlStateDisabled];
        return;
    }
    
    [self.getCodeBtn setTitle:[NSString stringWithFormat:@"%ld秒",myRetrieveTime] forState:UIControlStateDisabled];
    myRetrieveTime --;
}

- (void)setType:(NSInteger)type {
    _type = type;
    if (type == 2) {//图形验证码
        self.getCodeView.hidden = YES;
        self.pooCodeView.hidden = NO;
        [self.inputTextField mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.pooCodeView.mas_left).offset(-CGFloatIn750(20));
            make.left.equalTo(self.contentView.mas_left).offset(CGFloatIn750(60));
            make.top.equalTo(self.contentView.mas_top);
            make.bottom.equalTo(self.contentView.mas_bottom);
        }];
    }else if (type == 1){//验证码
        self.getCodeView.hidden = NO;
        self.pooCodeView.hidden = YES;
        [self.inputTextField mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.getCodeView.mas_left).offset(-CGFloatIn750(20));
            make.left.equalTo(self.contentView.mas_left).offset(CGFloatIn750(60));
            make.top.equalTo(self.contentView.mas_top);
            make.bottom.equalTo(self.contentView.mas_bottom);
        }];
    }else if (type == 3){
        self.getCodeView.hidden = YES;
        self.pooCodeView.hidden = YES;
        [self.inputTextField setSecureTextEntry:YES];
        [self.inputTextField mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.contentView.mas_right).offset(-CGFloatIn750(60));
            make.left.equalTo(self.contentView.mas_left).offset(CGFloatIn750(60));
            make.top.equalTo(self.contentView.mas_top);
            make.bottom.equalTo(self.contentView.mas_bottom);
        }];
    }else{
        self.getCodeView.hidden = YES;
        self.pooCodeView.hidden = YES;
        [self.inputTextField mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.contentView.mas_right).offset(-CGFloatIn750(60));
            make.left.equalTo(self.contentView.mas_left).offset(CGFloatIn750(60));
            make.top.equalTo(self.contentView.mas_top);
            make.bottom.equalTo(self.contentView.mas_bottom);
        }];
    }
}

- (void)setPlaceholder:(NSString *)placeholder {
    _placeholder = placeholder;
    _inputTextField.placeholder = placeholder;
}

- (UIButton *)pooCodeView{
    if (!_pooCodeView) {
        __weak typeof(self) weakSelf = self;
       _pooCodeView = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 188, 28)];
       [_pooCodeView setTitle:@"图形验证码" forState:UIControlStateNormal];
       [_pooCodeView setTitleColor:adaptAndDarkColor([UIColor colorMain], [UIColor colorMainDark]) forState:UIControlStateNormal];
       [_pooCodeView.titleLabel setFont:[UIFont fontSmall]];
       [_pooCodeView bk_addEventHandler:^(id sender) {
           [weakSelf.inputTextField becomeFirstResponder];
           [weakSelf getImageCode];
       } forControlEvents:UIControlEventTouchUpInside];
    }
    return _pooCodeView;
}

- (void)setCodeImage:(UIImage *)codeImage {
    _codeImage = codeImage;
    if (codeImage) {
        [self.pooCodeView setTitle:@"" forState:UIControlStateNormal];
        [self.pooCodeView setBackgroundImage:codeImage forState:UIControlStateNormal];
    }
}

- (void)getImageCode {
    __weak typeof(self) weakSelf = self;
    [ZLoginViewModel imageCodeWith:@"" block:^(BOOL isSuccess, id message) {
        if (isSuccess) {
            [weakSelf.pooCodeView setTitle:@"" forState:UIControlStateNormal];
            ZImageCodeBackModel *model = message;
            NSString *str = model.img;
            str = [str stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
            str = [str stringByReplacingOccurrencesOfString:@"\r" withString:@""];
            str = [str stringByReplacingOccurrencesOfString:@"\n" withString:@""];
            str = [str substringFromIndex:@"data:image/png;base64,".length];
            NSString *encodedImageStr = str;
            NSData *decodedImgData = [[NSData alloc] initWithBase64EncodedString:encodedImageStr options:NSDataBase64DecodingIgnoreUnknownCharacters];
            UIImage *image = [UIImage imageWithData:decodedImgData];
            [weakSelf.pooCodeView setBackgroundImage:image forState:UIControlStateNormal];
            
            if (weakSelf.imageCodeBlock) {
                weakSelf.imageCodeBlock(model.ckey);
            }
        }else{
            if ([message isKindOfClass:[NSString class]]) {
                [TLUIUtility showErrorHint:message];
            }
        }
    }];
}

+(CGFloat)z_getCellHeight:(id)sender {
    return CGFloatIn750(100);
}
@end
