//
//  ZNumberCalculateView.m
//  NoWait
//
//  Created by zhuang zhang on 2020/6/4.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZNumberCalculateView.h"
#import "ZAlertView.h"

@interface ZNumberCalculateView()<UITextFieldDelegate>

@property (nonatomic, strong) UIView *contView;
/** 加 */
@property (nonatomic, strong) UIButton *addBtn;
/** 减 */
@property (nonatomic, strong) UIButton *reduceBtn;
/** 数值框 */
@property (nonatomic, strong) UITextField *numberText;
/** 记录数值 */
@property (nonatomic, copy) NSString *recordNum;

/** 减号分割线 */
@property (nonatomic, strong) UILabel *segmentReduce;
/** 加号分割线 */
@property (nonatomic, strong) UILabel *segmentAdd;
/** 加号分割线 */
@property (nonatomic, strong) UILabel *unitLabel;

//初始化数据
@property (nonatomic, assign) __block CGFloat numberWidth;

@property (nonatomic, assign) __block CGFloat numberHeight;

@property (nonatomic, strong) NSTimer *addTimer;

@property (nonatomic, strong) NSTimer *reduceTimer;

@end

#define numborderWidth 1
#define defaultMax 99999

@implementation ZNumberCalculateView


- (instancetype)initWithNumberWidth:(CGFloat)width height:(CGFloat)height {
    if (self = [super init]){
        self.numberWidth = width;
        self.numberHeight = height;
        [self setView];
    }
    return self;
}

- (void)setView{
    self.backgroundColor = adaptAndDarkColor([UIColor colorWhite], [UIColor colorBlackBGDark]);
    
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    _isShake = YES;
    _multipleNum = 1;
    _minNum = 0;
    _maxNum = defaultMax;
    
    [self addSubview:self.contView];
    [self.contView addSubview:self.numberText];
    [self.contView addSubview:self.reduceBtn];
    [self.contView addSubview:self.addBtn];
    [self.contView addSubview:self.segmentReduce];
    [self.contView addSubview:self.segmentAdd];

    [self.contView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(self.numberHeight);
        make.width.mas_equalTo(self.numberWidth);
        make.centerY.equalTo(self.mas_centerY);
        make.centerX.equalTo(self.mas_centerX);
    }];
    
    [self.addBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contView.mas_right);
        make.width.height.mas_equalTo(self.numberHeight);
        make.centerY.equalTo(self.contView.mas_centerY);
    }];
    
    [self.reduceBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contView.mas_left);
        make.width.height.mas_equalTo(self.numberHeight);
        make.centerY.equalTo(self.contView.mas_centerY);
    }];

    [self.numberText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contView.mas_centerY);
        make.right.equalTo(self.addBtn.mas_left);
        make.left.equalTo(self.reduceBtn.mas_right);
        make.height.mas_equalTo(self.numberHeight);
    }];


    [self.segmentReduce mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.reduceBtn.mas_right);
        make.top.bottom.equalTo(self.reduceBtn);
        make.width.mas_equalTo(0.5);
    }];

    [self.segmentAdd mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.addBtn.mas_left);
        make.top.bottom.equalTo(self.addBtn);
        make.width.mas_equalTo(0.5);
    }];

    _segmentReduce.backgroundColor = adaptAndDarkColor([UIColor colorGrayLine], [UIColor colorGrayLineDark]);
    _segmentAdd.backgroundColor = adaptAndDarkColor([UIColor colorGrayLine], [UIColor colorGrayLineDark]);
    
    UIButton *reduceTempBtn = [[UIButton alloc] initWithFrame:CGRectZero];
    [reduceTempBtn addTarget:self action:@selector(reduceNumberClick) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:reduceTempBtn];
    [reduceTempBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self);
        make.right.equalTo(self.reduceBtn.mas_right);
        make.left.equalTo(self.mas_left);
    }];
    //button长按事件
    UILongPressGestureRecognizer *reduceLongPress = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(reduceNumberLongClick:)];
    reduceLongPress.minimumPressDuration = 0.3;//定义按的时间
    [reduceTempBtn addGestureRecognizer:reduceLongPress];
    
    
    UIButton *addTempBtn = [[UIButton alloc] initWithFrame:CGRectZero];
    [addTempBtn addTarget:self action:@selector(addNumberClick) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:addTempBtn];
    [addTempBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self);
        make.left.equalTo(self.addBtn.mas_left);
        make.right.equalTo(self.mas_right);
    }];
    
    //button长按事件
    UILongPressGestureRecognizer *addLongPress = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(addNumberLongClick:)];
    addLongPress.minimumPressDuration = 0.3;//定义按的时间
    [addTempBtn addGestureRecognizer:addLongPress];
}

#pragma mark - lazy loading---
- (UIView *)contView {
    if (!_contView) {
        _contView = [[UIView alloc] init];
        ViewBorderRadius(_contView, CGFloatIn750(6), numborderWidth, adaptAndDarkColor([UIColor colorGrayLine], [UIColor colorGrayLineDark]));
    }
    return _contView;
}

- (UITextField *)numberText {
    if (!_numberText) {
        _numberText = [[UITextField alloc] init];
        _numberText.text = [NSString stringWithFormat:@"%ld",_showNum];
        _numberText.userInteractionEnabled = YES;
        _numberText.textColor = adaptAndDarkColor([UIColor colorTextBlack], [UIColor colorTextBlackDark]);
        _numberText.font = [UIFont systemFontOfSize:14];
        _numberText.keyboardType = UIKeyboardTypeNumberPad;
        _numberText.textAlignment = NSTextAlignmentCenter;
        _numberText.delegate = self;
        [_numberText addTarget:self action:@selector(textNumberChange:) forControlEvents:UIControlEventEditingChanged];
    }
    return _numberText;
}


- (UILabel *)unitLabel {
    if (!_unitLabel) {
        _unitLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _unitLabel.textColor = adaptAndDarkColor([UIColor colorTextGray], [UIColor colorTextGrayDark]);
        _unitLabel.numberOfLines = 1;
        _unitLabel.textAlignment = NSTextAlignmentLeft;
        [_unitLabel setFont:[UIFont fontSmall]];
    }
    return _unitLabel;
}


-(UIButton *)reduceBtn {
    if (!_reduceBtn) {
        _reduceBtn = [[UIButton alloc] init];
        [_reduceBtn setImage:[UIImage imageNamed:@"btn_num_minus"] forState:UIControlStateNormal];
        [_reduceBtn addTarget:self action:@selector(reduceNumberClick) forControlEvents:UIControlEventTouchUpInside];
        //button长按事件
        UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(reduceNumberLongClick:)];

        longPress.minimumPressDuration = 0.3;//定义按的时间
        [_reduceBtn addGestureRecognizer:longPress];
    }
    return _reduceBtn;;
}

-(UIButton *)addBtn {
    if (!_addBtn) {
        _addBtn = [[UIButton alloc] init];
        [_addBtn setImage:[UIImage imageNamed:@"btn_num_add"] forState:UIControlStateNormal];
        [_addBtn addTarget:self action:@selector(addNumberClick) forControlEvents:UIControlEventTouchUpInside];
        //button长按事件
        UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(addNumberLongClick:)];

        longPress.minimumPressDuration = 0.3;//定义按的时间
        [_addBtn addGestureRecognizer:longPress];
    }
    return _addBtn;;
}

- (UILabel *)segmentReduce {
    if (!_segmentReduce) {
        _segmentReduce = [[UILabel alloc] init];
    }
    return _segmentReduce;
}

- (UILabel *)segmentAdd {
    if (!_segmentAdd) {
        _segmentAdd = [[UILabel alloc] init];
    }
    return _segmentAdd;
}


#pragma mark - funcation
/** 减 */
- (void)reduceNumberClick{
    [_numberText resignFirstResponder];
    
    if ([_numberText.text integerValue] <= _minNum){
        _numberText.text = [NSString stringWithFormat:@"%ld",(long)_minNum];
        [self shakeAnimation];
        return;
    }
    
    _numberText.text = [NSString stringWithFormat:@"%ld",(long)[_numberText.text integerValue] - _multipleNum];
    
    [self callBackResultNumber:_numberText.text.integerValue];
}


-(void)reduceNumberLongClick:(UILongPressGestureRecognizer*)gestureRecognizer{
  if([gestureRecognizer state] == UIGestureRecognizerStateBegan){
      _reduceTimer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(reduceNumberClick) userInfo:nil repeats:YES];
  }else if([gestureRecognizer state] == UIGestureRecognizerStateEnded){
      [self cleanTimer];
  }
}


/** 加 */
- (void)addNumberClick{
    [_numberText resignFirstResponder];
    
    if (_numberText.text.integerValue < _maxNum) {
        _numberText.text = [NSString stringWithFormat:@"%ld",(long)[_numberText.text integerValue] + _multipleNum];
    }else{
        _numberText.text = [NSString stringWithFormat:@"%ld",(long)_maxNum];
        [self shakeAnimation];
    }
    
    [self callBackResultNumber:_numberText.text.integerValue];
}

-(void)addNumberLongClick:(UILongPressGestureRecognizer*)gestureRecognizer{
  if([gestureRecognizer state] == UIGestureRecognizerStateBegan){
      _addTimer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(addNumberClick) userInfo:nil repeats:YES];
  }else if([gestureRecognizer state] == UIGestureRecognizerStateEnded){
      [self cleanTimer];
  }
}


/// 清除定时器
- (void)cleanTimer{
    if (_addTimer.isValid) {
        [_addTimer invalidate] ;
        _addTimer = nil;
    }
    
    if (_reduceTimer.isValid) {
        [_reduceTimer invalidate] ;
        _reduceTimer = nil;
    }
}


/** 数值变化 */
- (void)textNumberChange:(UITextField *)textField{
    if (textField.text.integerValue < _minNum) {
        [self alertMessage:@"您输入的数量小于最小值，请重新输入"];
        textField.text = @"";
    }
    
    if (textField.text.integerValue > _maxNum) {
        [self alertMessage:@"您输入的数量大于最大值，请重新输入"];
        textField.text = @"";
        return;
    }
}

-(void)textFieldDidBeginEditing:(UITextField *)textField{
    _recordNum = textField.text;
    textField.text = @"";
}

-(void)textFieldDidEndEditing:(UITextField *)textField{
    
    if (textField.text.length == 0) {
        textField.text = _recordNum;
    }
    
    if (textField.text.integerValue/_multipleNum == 0) {//输入小于基本倍数值 更改为倍数数值/若想在minNum为0的情况下输入小于倍数值的时候 更改为0 增加为0时的else内判断即可（如 倍数值为3，键入1 需求更改为0数值的情况下）
        textField.text=[NSString stringWithFormat:@"%ld",_multipleNum];
    }else{
        textField.text=[NSString stringWithFormat:@"%ld",(long)(textField.text.integerValue/_multipleNum)*_multipleNum];
    }
    
    [self callBackResultNumber:textField.text.integerValue];
}

- (void)callBackResultNumber:(NSInteger)number{
    if (self.resultNumber) {
        self.resultNumber(number);
    }
}

/** 限制输入数字 */
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    return [self validateNumber:string];
}

- (BOOL)validateNumber:(NSString*)number {
    BOOL res = YES;
    NSCharacterSet* tmpSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789"];
    int i = 0;
    while (i < number.length) {
        NSString * string = [number substringWithRange:NSMakeRange(i, 1)];
        NSRange range = [string rangeOfCharacterFromSet:tmpSet];
        if (range.length == 0) {
            res = NO;
            break;
        }
        i++;
    }
    return res;
}

/** 抖动动画 */
- (void)shakeAnimation
{
    if (_isShake) {
        CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"position.x"];
        //获取当前View的position坐标
        CGFloat positionX = self.contView.layer.position.x;
        //设置抖动的范围
        animation.values = @[@(positionX-4),@(positionX),@(positionX+4)];
        //动画重复的次数
        animation.repeatCount = 3;
        //动画时间
        animation.duration = 0.07;
        //设置自动反转
        animation.autoreverses = YES;
        [self.contView.layer addAnimation:animation forKey:nil];
    }
}

/** 提示 */
- (void)alertMessage:(NSString *)message
{
    [ZAlertView setAlertWithTitle:message btnTitle:@"确定" handlerBlock:^(NSInteger index) {
        
    }];
}

/** setter getter */
- (void)setShowNum:(NSInteger)showNum{
    _showNum = showNum;
    _numberText.text = [NSString stringWithFormat:@"%ld",showNum];
}

- (void)setResetShowNum:(NSInteger)resetShowNum{
    _resetShowNum = resetShowNum;
    _numberText.text = [NSString stringWithFormat:@"%ld",resetShowNum];
    [self callBackResultNumber:resetShowNum];
}

- (void)setMultipleNum:(NSInteger)multipleNum{
    _multipleNum = multipleNum;
}

- (void)setMinNum:(NSInteger)minNum{
    if (minNum < 0) {
        minNum = 0;
    }
    _minNum = minNum;
}

- (void)setMaxNum:(NSInteger)maxNum{
    _maxNum = maxNum;
}

- (NSInteger)currentNumber{
    return _numberText.text.integerValue;
}

- (void)setCanText:(BOOL)canText{
    _canText = canText;
    _numberText.userInteractionEnabled = _canText;
}

- (void)setIsShake:(BOOL)isShake{
    _isShake = isShake;
}

- (void)setHidBorder:(BOOL)hidBorder{
    _hidBorder = hidBorder;
    
    if (hidBorder) {
        _segmentReduce.backgroundColor = [UIColor clearColor];
        _segmentAdd.backgroundColor = [UIColor clearColor];
        self.contView.layer.borderColor = [UIColor clearColor].CGColor;
    }
}

- (void)setNumCornerRadius:(CGFloat)numCornerRadius{
    _numCornerRadius = numCornerRadius;
    self.contView.layer.masksToBounds = YES;
    self.contView.layer.cornerRadius = _numCornerRadius;
}

- (void)setNumBorderColor:(UIColor *)numBorderColor{
    _numBorderColor = numBorderColor;
    
    _segmentReduce.backgroundColor = _numBorderColor;
    _segmentAdd.backgroundColor = _numBorderColor;
    self.contView.layer.borderColor = _numBorderColor.CGColor;
}

- (void)setButtonColor:(UIColor *)buttonColor{
    _buttonColor = buttonColor;
    
    _reduceBtn.backgroundColor =_buttonColor;
    _addBtn.backgroundColor =_buttonColor;
}

- (void)setNumTextColor:(UIColor *)numTextColor{
    _numTextColor = numTextColor;
    _numberText.textColor = numTextColor;
}

- (void)setNumTextFont:(UIFont *)numTextFont{
    _numTextFont = numTextFont;
    _numberText.font=numTextFont;
}

- (void)setUnit:(NSString *)unit {
    self.unitLabel.text = unit;
    self.numberText.rightView = self.unitLabel;
    self.numberText.rightViewMode = UITextFieldViewModeAlways;
}

- (void)dealloc {
    [self cleanTimer];
}
@end
