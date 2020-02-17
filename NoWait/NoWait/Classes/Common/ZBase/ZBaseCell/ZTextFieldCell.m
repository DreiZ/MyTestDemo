//
//  ZTextFieldCell.m
//  NoWait
//
//  Created by zhuang zhang on 2020/1/16.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZTextFieldCell.h"
#import "ZPublicTool.h"

@interface ZTextFieldCell ()<UITextFieldDelegate>
@property (nonatomic,strong) UILabel *subTitleLabel;
@property (nonatomic,strong) UILabel *leftTitleLabel;

@property (nonatomic,strong) UITextField *inputTextField;
@property (nonatomic,strong) UIView *bottomLineView;
@property (nonatomic,strong) UIView *inputLine;

@end

@implementation ZTextFieldCell

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
    [self.contentView addSubview:self.leftTitleLabel];
    [self.leftTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView.mas_centerY);
        make.left.equalTo(self.contentView.mas_left).offset(kCellLeftMargin);
    }];
    
    [self.contentView addSubview:self.subTitleLabel];
    [self.subTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView.mas_centerY);
        make.left.equalTo(self.leftTitleLabel.mas_right).offset(CGFloatIn750(8));
    }];
    
    [self.contentView addSubview:self.inputTextField];
    [self.inputTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.subTitleLabel.mas_right).offset(kCellContentSpace);
        make.height.mas_equalTo(CGFloatIn750(52));
        make.right.equalTo(self.contentView.mas_right).offset(-kCellRightMargin);
        make.centerY.equalTo(self.subTitleLabel.mas_centerY);
    }];
    
    
    [self.contentView addSubview:self.inputLine];
    [self.inputLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(1);
        make.left.right.equalTo(self.inputTextField);
        make.top.equalTo(self.inputTextField.mas_bottom);
    }];
    
    
    [self.contentView addSubview:self.bottomLineView];
    [self.bottomLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.contentView);
        make.height.mas_equalTo(0.5);
    }];
}

#pragma mark -懒加载
- (UIView *)inputLine {
    if (!_inputLine) {
        _inputLine = [[UIView alloc] init];
        _inputLine.layer.masksToBounds = YES;
        _inputLine.backgroundColor = [UIColor colorRedDefault];
    }
    return _inputLine;
}

- (UIView *)bottomLineView {
    if (!_bottomLineView) {
        _bottomLineView = [[UIView alloc] init];
        _bottomLineView.layer.masksToBounds = YES;
        _bottomLineView.backgroundColor = adaptAndDarkColor([UIColor colorGrayBG], [UIColor colorGrayBGDark]);
    }
    return _bottomLineView;
}

- (UILabel *)leftTitleLabel {
    if (!_leftTitleLabel) {
        _leftTitleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _leftTitleLabel.textColor = adaptAndDarkColor([UIColor colorTextBlack], [UIColor colorTextBlackDark]);
        _leftTitleLabel.text = @"";
        _leftTitleLabel.numberOfLines = 0;
        _leftTitleLabel.textAlignment = NSTextAlignmentLeft;
        [_leftTitleLabel setFont:[UIFont systemFontOfSize:CGFloatIn750(30)]];
    }
    return _leftTitleLabel;
}

- (UILabel *)subTitleLabel {
    if (!_subTitleLabel) {
        _subTitleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _subTitleLabel.textColor = adaptAndDarkColor([UIColor colorTextBlack], [UIColor colorTextBlackDark]);
        _subTitleLabel.text = @"";
        _subTitleLabel.numberOfLines = 0;
        _subTitleLabel.textAlignment = NSTextAlignmentLeft;
        [_subTitleLabel setFont:[UIFont systemFontOfSize:CGFloatIn750(30)]];
    }
    return _subTitleLabel;
}


- (UITextField *)inputTextField {
    if (!_inputTextField ) {
        _inputTextField = [[UITextField alloc] init];
        [_inputTextField setFont:[UIFont fontSmall]];
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
#pragma mark --textField delegate
- (void)textFieldDidChange:(UITextField *)textField {
    [ZPublicTool textField:textField maxLenght:self.model.max > 0 ? self.model.max:20 type:self.model.formatterType];
 
    _model.content = textField.text;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    return [ZPublicTool textField:textField shouldChangeCharactersInRange:range replacementString:string type:self.model.formatterType];
}

+ (CGFloat)z_getCellHeight:(id)sender {
    ZBaseTextFieldCellModel *model = sender;
    if (!model) {
        return kCellNormalHeight;
    }
    return model.cellHeight;
}


#pragma mark -setModel
- (void)setModel:(ZBaseTextFieldCellModel *)model {
    _model = model;
    self.formatterType = model.formatterType;
    
    _leftTitleLabel.text = model.leftTitle;
    _subTitleLabel.text = model.subTitle;
    
    _subTitleLabel.font = model.subTitleFont;
    _subTitleLabel.textColor = model.subTitleColor;
    
    _leftTitleLabel.textColor = model.leftColor;
    _leftTitleLabel.font = model.leftFont;
    
    _inputTextField.font = model.textFont;
    _inputTextField.textColor = model.textColor;
    
    _inputTextField.placeholder = model.placeholder;
    _inputTextField.text = model.content;
    _inputTextField.textAlignment = model.textAlignment;
    _bottomLineView.hidden = model.isHiddenLine;
    _inputLine.hidden = model.isHiddenInputLine;
    
    [self.bottomLineView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.contentView);
        make.height.mas_equalTo(0.5);
        make.left.equalTo(self.contentView.mas_left).offset(model.lineLeftMargin);
        make.right.equalTo(self.contentView.mas_right).offset(-model.lineRightMargin);
    }];
    
    if (model.leftContentWidth > 0) {
        [self.leftTitleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.contentView.mas_centerY);
            make.left.equalTo(self.contentView.mas_left).offset(model.leftMargin);
            make.width.mas_equalTo(model.leftContentWidth);
        }];
    }else{
        CGSize titleSize = [model.leftTitle tt_sizeWithFont:model.textFont];
        [self.leftTitleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.contentView.mas_centerY);
            make.left.equalTo(self.contentView.mas_left).offset(model.leftMargin);
            make.width.mas_equalTo(titleSize.width + 2);
        }];
    }
    
    if (model.subTitle) {
        self.subTitleLabel.hidden = NO;
        CGSize titleSize = [model.subTitle tt_sizeWithFont:model.textFont];
        [self.subTitleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.contentView.mas_centerY);
            make.left.equalTo(self.leftTitleLabel.mas_right).offset(model.contentSpace);
            make.width.mas_equalTo(titleSize.width + 2);
        }];
        [self.inputTextField mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.subTitleLabel.mas_right).offset(model.contentSpace);
            make.height.mas_equalTo(model.textFieldHeight);
            make.right.equalTo(self.contentView.mas_right).offset(-model.rightMargin);
            make.centerY.equalTo(self.subTitleLabel.mas_centerY);
        }];
    }else{
        self.subTitleLabel.hidden = YES;
        [self.inputTextField mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.leftTitleLabel.mas_right).offset(model.contentSpace);
            make.height.mas_equalTo(model.textFieldHeight);
            make.right.equalTo(self.contentView.mas_right).offset(-model.rightMargin);
            make.centerY.equalTo(self.subTitleLabel.mas_centerY);
        }];
    }
}

- (void)setFormatterType:(ZFormatterType)formatterType {
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
@end


