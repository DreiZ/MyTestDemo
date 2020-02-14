//
//  ZStudentLessonOrderMoreInputCell.m
//  NoWait
//
//  Created by zhuang zhang on 2020/1/11.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZStudentLessonOrderMoreInputCell.h"
#import "NSString+Size.h"
#import "ZPublicTool.h"

@interface ZStudentLessonOrderMoreInputCell ()<UITextViewDelegate>
@property (nonatomic,strong) UITextView *iTextView;
@property (nonatomic,strong) UILabel *thintLabel;
@property (nonatomic,strong) UIView *backView;

@end

@implementation ZStudentLessonOrderMoreInputCell

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
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.backgroundColor = KAdaptAndDarkColor([UIColor colorWhite], K1aBackColor);
    self.clipsToBounds = YES;
    
    [self.contentView addSubview:self.backView];
    [self.contentView addSubview:self.iTextView];
    [self.iTextView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).offset(CGFloatIn750(30));
        make.right.equalTo(self.contentView.mas_right).offset(CGFloatIn750(-30));
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
        make.left.equalTo(self.contentView.mas_left).offset(CGFloatIn750(34));
        make.right.equalTo(self.contentView.mas_right).offset(CGFloatIn750(-30));
        make.top.equalTo(self.contentView.mas_top).offset(CGFloatIn750(30));
    }];
    
    self.backView.hidden = YES;
}

- (UIView *)backView {
    if (!_backView) {
        _backView = [[UIView alloc] init];
        _backView.layer.masksToBounds = YES;
        _backView.layer.cornerRadius = 4;
        _backView.backgroundColor = KAdaptAndDarkColor([UIColor colorGrayBG], [UIColor colorBlackBG]);
    }
    return _backView;
}

- (UITextView *)iTextView {
    if (!_iTextView) {
        _iTextView = [[UITextView alloc] init];
        _iTextView.delegate = self;
        _iTextView.backgroundColor = KAdaptAndDarkColor([UIColor colorWhite], K1aBackColor);
        [_iTextView setFont:[UIFont systemFontOfSize:CGFloatIn750(26)]];
        _iTextView.textColor = KAdaptAndDarkColor(KFont3Color, KFont9Color);
    }
    return _iTextView;
}


- (UILabel *)thintLabel {
    if (!_thintLabel) {
        _thintLabel = [[UILabel alloc] init];
        _thintLabel.numberOfLines = 0;
        _thintLabel.textAlignment = NSTextAlignmentLeft;
        [_thintLabel setTextColor:KAdaptAndDarkColor(KFont9Color, KFont6Color)];
        [_thintLabel setFont:[UIFont systemFontOfSize:CGFloatIn750(26)]];
        [_thintLabel setText:@"如果有其他说明，请填写在此处"];
    }
    return _thintLabel;
}

- (void)textViewDidChange:(UITextView *)textView {
    NSInteger _isMaxLength = 200;
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
//    _model.des = textView.text;
}

+ (CGFloat)z_getCellHeight:(id)sender {
    
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

- (void)setIsBackColor:(NSString *)isBackColor {
    _isBackColor = isBackColor;
    if (_isBackColor) {
        _iTextView.backgroundColor = KAdaptAndDarkColor([UIColor colorGrayBG], [UIColor colorBlackBG]);
        _backView.hidden = NO;
    }else{
        _iTextView.backgroundColor = KAdaptAndDarkColor([UIColor colorWhite], [UIColor colorGrayBG]);
        _backView.hidden = YES;
    }
}
@end


