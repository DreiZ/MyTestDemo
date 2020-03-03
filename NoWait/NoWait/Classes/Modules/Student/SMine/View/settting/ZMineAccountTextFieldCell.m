//
//  ZMineAccountTextFieldCell.m
//  NoWait
//
//  Created by zhuang zhang on 2020/3/3.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZMineAccountTextFieldCell.h"

#define CountTimer 59
static NSUInteger myRetrieveTime = 59;
static NSTimer *retrieveTimer = nil;


@interface ZMineAccountTextFieldCell ()<UITextFieldDelegate>
@property (nonatomic,strong) UITextField *inputTextField;
@property (nonatomic,strong) UIButton *getCodeBtn;
@property (nonatomic,strong) UIView *getCodeView;

@end

@implementation ZMineAccountTextFieldCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupView];
    }
    return self;
}

-(void)setupView
{
    [super setupView];
    [self.contentView addSubview:self.inputTextField];
    [self.inputTextField addSubview:self.getCodeView];
    
    [self.inputTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView.mas_right).offset(-CGFloatIn750(60));
        make.left.equalTo(self.contentView.mas_left).offset(CGFloatIn750(60));
        make.top.equalTo(self.contentView.mas_top);
        make.bottom.equalTo(self.contentView.mas_bottom);
    }];
    ViewRadius(self.inputTextField, [ZMineAccountTextFieldCell z_getCellHeight:nil]/2.0f);
    
    [self.getCodeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.inputTextField.mas_right).offset(-CGFloatIn750(16));
        make.centerY.equalTo(self.inputTextField.mas_centerY);
        make.width.mas_equalTo(CGFloatIn750(184));
        make.top.bottom.equalTo(self.inputTextField);
    }];
}


- (UITextField *)inputTextField {
    if (!_inputTextField ) {
        UIView *leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGFloatIn750(40), CGFloatIn750(40))];
        
        _inputTextField = [[UITextField alloc] init];
        [_inputTextField setFont:[UIFont fontContent]];
        _inputTextField.leftView = leftView;
        _inputTextField.leftViewMode = UITextFieldViewModeAlways;
        [_inputTextField setBorderStyle:UITextBorderStyleNone];
        [_inputTextField setBackgroundColor:[UIColor clearColor]];
        [_inputTextField setReturnKeyType:UIReturnKeyDone];
        [_inputTextField setTextAlignment:NSTextAlignmentLeft];
        [_inputTextField setPlaceholder:@""];
        [_inputTextField setTextColor:adaptAndDarkColor([UIColor colorTextBlack], [UIColor colorTextBlackDark])];
        _inputTextField.backgroundColor = adaptAndDarkColor(HexColor(0xf5f9f8), HexColor(0xf5f9f8));
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
//        __weak typeof(self) weakSelf = self;
        _getCodeBtn = [[UIButton alloc] initWithFrame:CGRectZero];
        [_getCodeBtn bk_addEventHandler:^(id sender) {
            
//            NSMutableDictionary *params = @{@"ckey":weakSelf.loginViewModel.registerModel.ckey,@"captcha":weakSelf.loginViewModel.registerModel.code,@"phone":weakSelf.loginViewModel.registerModel.tel}.mutableCopy;
//            [self.loginViewModel codeWithParams:params block:^(BOOL isSuccess, id message) {
//               if (isSuccess) {
//                   [TLUIUtility showSuccessHint:message];
//                   [weakSelf.messageCodeTF becomeFirstResponder];
//                   DLog(@"login message %@",message);
//                   if (myRetrieveTime == CountTimer) {
//                       [weakSelf.getCodeBtn setTitle:@"60秒" forState:UIControlStateDisabled];
//                       [weakSelf startTimer];
//                       weakSelf.getCodeBtn.enabled = NO;
//                   }
//               }else{
//                   [TLUIUtility showErrorHint:message];
//               }
//            }];
            
        } forControlEvents:UIControlEventTouchUpInside];
        
        [_getCodeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
        [_getCodeBtn setTitleColor:[UIColor colorMain] forState:UIControlStateNormal];
        [_getCodeBtn.titleLabel setFont:[UIFont fontContent]];
    }
    return _getCodeBtn;
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

- (void)setIsCode:(BOOL)isCode {
    _isCode = isCode;
    self.getCodeView.hidden = !isCode;
}

- (void)setPlaceholder:(NSString *)placeholder {
    _placeholder = placeholder;
    _inputTextField.placeholder = placeholder;
}

+(CGFloat)z_getCellHeight:(id)sender {
    return CGFloatIn750(100);
}
@end
