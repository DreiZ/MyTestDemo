//
//  ZBaseTextViewCell.m
//  NoWait
//
//  Created by zhuang zhang on 2020/3/3.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZBaseTextViewCell.h"

@interface ZBaseTextViewCell ()<UITextViewDelegate>

@property (nonatomic,strong) UILabel *thintLabel;
@property (nonatomic,strong) UIView *backView;

@end

@implementation ZBaseTextViewCell

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
    
    [self.contentView addSubview:self.backView];
    [self.contentView addSubview:self.iTextView];
    
    [self.iTextView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).offset(CGFloatIn750(40));
        make.right.equalTo(self.contentView.mas_right).offset(CGFloatIn750(-40));
        make.top.equalTo(self.contentView.mas_top).offset(CGFloatIn750(20));
        make.bottom.equalTo(self.contentView.mas_bottom).offset(CGFloatIn750(-30));
    }];
    
    [self.backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.iTextView.mas_left).offset(CGFloatIn750(-10));
        make.right.equalTo(self.iTextView.mas_right).offset(CGFloatIn750(10));
        make.top.equalTo(self.iTextView.mas_top).offset(CGFloatIn750(-10));
        make.bottom.equalTo(self.iTextView.mas_bottom).offset(CGFloatIn750(10));
    }];
   
    [self.contentView addSubview:self.thintLabel];
    [self.thintLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.iTextView.mas_left).offset(CGFloatIn750(14));
        make.right.equalTo(self.iTextView.mas_right).offset(CGFloatIn750(-20));
        make.top.equalTo(self.iTextView.mas_top).offset(CGFloatIn750(12));
    }];
    
    self.backView.hidden = YES;
}

- (UIView *)backView {
    if (!_backView) {
        _backView = [[UIView alloc] init];
        _backView.layer.masksToBounds = YES;
        _backView.layer.cornerRadius = 4;
        _backView.backgroundColor = adaptAndDarkColor([UIColor colorGrayBG], [UIColor colorGrayBGDark]);
    }
    return _backView;
}

- (UITextView *)iTextView {
    if (!_iTextView) {
        _iTextView = [[UITextView alloc] init];
        _iTextView.delegate = self;
        _iTextView.backgroundColor = adaptAndDarkColor([UIColor colorWhite], [UIColor colorBlackBGDark]);
        [_iTextView setFont:[UIFont fontSmall]];
        _iTextView.textColor = adaptAndDarkColor([UIColor colorTextBlack], [UIColor colorTextBlackDark]);
    }
    return _iTextView;
}


- (UILabel *)thintLabel {
    if (!_thintLabel) {
        _thintLabel = [[UILabel alloc] init];
        _thintLabel.numberOfLines = 0;
        _thintLabel.textAlignment = NSTextAlignmentLeft;
        [_thintLabel setTextColor:adaptAndDarkColor([UIColor colorTextGray1], [UIColor colorTextGray1Dark])];
        [_thintLabel setFont:[UIFont fontSmall]];
        [_thintLabel setText:@"介绍一下任课老师吧"];
    }
    return _thintLabel;
}

- (void)textViewDidChange:(UITextView *)textView {
    NSInteger _isMaxLength = self.model.max;
    if (textView.text.length > 0) {
        _thintLabel.hidden = YES;
    }else {
        _thintLabel.hidden = NO;
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
    if (self.valueBlock) {
        self.valueBlock(textView.text);
    }
//    _model.des = textView.text;
}

+ (CGFloat)z_getCellHeight:(id)sender {
    ZBaseTextFieldCellModel *model = sender;
    if (model) {
        return model.cellHeight;
    }
    return CGFloatIn750(194);
}


- (void)setFormatterType:(ZFormatterType)formatterType {
    if (formatterType == ZFormatterTypeDecimal) {
        _iTextView.keyboardType = UIKeyboardTypeDecimalPad;
    }else if (formatterType == ZFormatterTypeNumber) {
        _iTextView.keyboardType = UIKeyboardTypeNumberPad;
    }else if (formatterType == ZFormatterTypePhoneNumber) {
        _iTextView.keyboardType = UIKeyboardTypePhonePad;
    }else {
        _iTextView.keyboardType = UIKeyboardTypeDefault;
    }
}

- (void)setModel:(ZBaseTextFieldCellModel *)model {
    _model = model;
    
    [self.iTextView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).offset(model.leftMargin);
        make.right.equalTo(self.contentView.mas_right).offset(-model.rightMargin);
        make.top.equalTo(self.contentView.mas_top).offset(model.contentSpace);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-model.contentSpace);
    }];
    
    self.iTextView.textColor = adaptAndDarkColor(model.textColor, model.textDarkColor);
    self.iTextView.font = model.textFont;
    self.thintLabel.font = model.textFont;
    self.thintLabel.textColor = adaptAndDarkColor(model.rightColor, model.rightDarkColor);
    self.iTextView.backgroundColor = adaptAndDarkColor(model.subTitleColor, model.subTitleDarkColor);
    self.backView.backgroundColor = adaptAndDarkColor(model.subTitleColor, model.subTitleDarkColor);
    self.thintLabel.text = model.placeholder;
    
    if (model.isHiddenLine) {
        _backView.hidden = YES;
    }else{
        _backView.hidden = NO;
    }
    self.iTextView.text = _model.content;
    if (model.content.length > 0) {
        self.thintLabel.hidden = YES;
    }else{
        self.thintLabel.hidden = NO;
    }
}
@end




