//
//  ZBaseTextFieldCell.m
//  NoWait
//
//  Created by zhuang zhang on 2020/5/13.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZBaseTextFieldCell.h"

@interface ZBaseTextFieldCell ()

@end

@implementation ZBaseTextFieldCell
@synthesize model = _model;

- (void)setupView {
    [super setupView];
    [self.contentView addSubview:self.inputTextField];
    [self.inputTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_right);
    }];
    
    
    [self.contentView addSubview:self.inputLine];
    [self.inputLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(1);
        make.left.right.equalTo(self.inputTextField);
        make.top.equalTo(self.inputTextField.mas_bottom);
    }];
    
    [self bringSubviewToFront:self.bottomLineView];
}

#pragma mark - lazy loading
- (UIView *)inputLine {
    if (!_inputLine) {
        _inputLine = [[UIView alloc] init];
        _inputLine.layer.masksToBounds = YES;
        _inputLine.backgroundColor = adaptAndDarkColor([UIColor colorGrayLine], [UIColor colorGrayLine]);;
    }
    return _inputLine;
}

- (UITextField *)inputTextField {
    if (!_inputTextField ) {
        _inputTextField = [[UITextField alloc] init];
        [_inputTextField setFont:[UIFont fontContent]];
        _inputTextField.leftViewMode = UITextFieldViewModeAlways;
        [_inputTextField setBorderStyle:UITextBorderStyleNone];
        [_inputTextField setBackgroundColor:[UIColor clearColor]];
        [_inputTextField setReturnKeyType:UIReturnKeyDone];
        [_inputTextField setTextAlignment:NSTextAlignmentCenter];
        [_inputTextField setPlaceholder:@""];
        [_inputTextField setTextColor:adaptAndDarkColor([UIColor colorTextBlack], [UIColor colorTextBlackDark])];
        _inputTextField.delegate = self;
        [_inputTextField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    }
    return _inputTextField;
}


#pragma mark - -textField delegate
- (void)textFieldDidChange:(UITextField *)textField {
    [ZPublicTool textField:textField maxLenght:self.model.maxLength > 0 ? self.model.maxLength:20 type:self.model.formatterType];
 
    self.model.textContent = textField.text;
    if (self.valueChangeBlock) {
        self.valueChangeBlock(textField.text);
    }
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    return [ZPublicTool textField:textField shouldChangeCharactersInRange:range replacementString:string type:self.model.formatterType];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}


#pragma mark - fun
- (UIView *)setRightViewWith:(UIView *)leftTempView {
    UIView *rightTempView = nil;
    if (self.model.rightImage) {
        self.rightImageView.hidden = NO;
        if ([self.model.rightImage isKindOfClass:[UIImage class]]) {
            self.rightImageView.image = self.model.rightImage;
        }else if ([self.model.rightImage tt_isValidUrl]) {
            [self.rightImageView tt_setImageWithURL:[NSURL URLWithString:self.model.rightImage]];
        }else{
            self.rightImageView.image = [UIImage imageNamed:self.model.rightImage];
        }
        
        [self.rightImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.contentView.mas_right).offset(-self.model.rightMargin);
            if (self.model.rightImageH > 0.01f) {
                make.width.height.mas_equalTo(self.model.rightImageH);
            }else{
                make.width.mas_equalTo(CGFloatIn750(0));
            }
            if (self.model.isLeftMultiLine || self.model.isRightMultiLine) {
                make.centerY.equalTo(self.contentView.mas_top).offset(self.model.cellHeight/2.0);
            }else{
                make.centerY.equalTo(self.contentView.mas_centerY);
            }
        }];
        
        rightTempView = self.rightImageView;
    }
    
    if(ValidStr(self.model.rightSubTitle)){
        self.rightSubTitleLabel.hidden = NO;
        self.rightSubTitleLabel.text = self.model.rightSubTitle;
        self.rightSubTitleLabel.font = self.model.rightSubFont;
        self.rightSubTitleLabel.textColor = adaptAndDarkColor(self.model.rightSubColor, self.model.rightSubDarkColor);
        
        CGSize rightSubTitleSize = [self.model.rightSubTitle tt_sizeWithFont:self.model.rightSubFont];
        
        [self.rightSubTitleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            if (self.model.isLeftMultiLine && self.model.isRightMultiLine) {
                make.top.mas_equalTo(self.contentView.mas_top).offset((self.model.cellHeight - self.model.rightSubFont.lineHeight)/2.0);
            }else{
                make.centerY.equalTo(self.contentView.mas_centerY);
            }
            
            if (rightTempView) {
                make.right.equalTo(rightTempView.mas_left).offset(-self.model.rightContentSpace);
            }else{
                make.right.equalTo(self.contentView.mas_right).offset(-self.model.rightMargin);
            }
            
            make.width.mas_equalTo(rightSubTitleSize.width + 2);
        }];
        
        rightTempView = self.rightSubTitleLabel;
    }
    
    {
        self.inputTextField.hidden = NO;
        
        [self.inputTextField mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.contentView.mas_centerY);
            make.height.mas_equalTo(self.model.textFieldHeight);
            
            if (rightTempView) {
                make.right.equalTo(rightTempView.mas_left).offset(-self.model.rightContentSpace);
            }else{
                make.right.equalTo(self.contentView.mas_right).offset(-self.model.rightMargin);
            }
            
            if (leftTempView) {
                make.left.equalTo(leftTempView.mas_right).offset(self.model.leftContentSpace);
            }else{
                make.left.equalTo(self.contentView.mas_left).offset(self.model.leftMargin);
            }
        }];
        
        rightTempView = self.inputTextField;
    }
    return rightTempView;
}

- (void)setModel:(ZTextFieldModel *)model {
    [super setModel:model];
    _model = model;
    self.inputTextField.textColor = adaptAndDarkColor(model.textColor, model.textDarkColor);
    self.inputTextField.font = model.textFont;
    self.formatterType = model.formatterType;
    self.inputTextField.textAlignment = model.textAlignment;
    self.inputTextField.placeholder = model.placeholderText;
    self.inputTextField.text = model.textContent;
    self.inputTextField.enabled = model.isTextEnabled;
    self.inputLine.hidden = model.isHiddenInputLine;
}
@end
