//
//  ZOrganizationEvaListEvaTextViewCell.m
//  NoWait
//
//  Created by zhuang zhang on 2020/3/20.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZOrganizationEvaListEvaTextViewCell.h"

@interface ZOrganizationEvaListEvaTextViewCell ()<UITextViewDelegate>
@property (nonatomic,strong) UITextView *iTextView;
@property (nonatomic,strong) UILabel *thintLabel;
@property (nonatomic,strong) UIView *backView;

@end

@implementation ZOrganizationEvaListEvaTextViewCell

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
        make.left.equalTo(self.contentView.mas_left).offset(CGFloatIn750(58));
        make.right.equalTo(self.contentView.mas_right).offset(CGFloatIn750(-40));
        make.top.equalTo(self.contentView.mas_top).offset(CGFloatIn750(38));
        make.bottom.equalTo(self.contentView.mas_bottom).offset(CGFloatIn750(-0));
    }];
    
    [self.backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.iTextView.mas_left).offset(CGFloatIn750(-10));
        make.right.equalTo(self.iTextView.mas_right).offset(CGFloatIn750(10));
        make.top.equalTo(self.iTextView.mas_top).offset(CGFloatIn750(-10));
        make.bottom.equalTo(self.iTextView.mas_bottom).offset(CGFloatIn750(10));
    }];
   
    [self.contentView addSubview:self.thintLabel];
    [self.thintLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.iTextView.mas_left).offset(CGFloatIn750(4));
        make.right.equalTo(self.contentView.mas_right).offset(CGFloatIn750(-30));
        make.top.equalTo(self.iTextView.mas_top).offset(CGFloatIn750(12));
    }];
    
    UIView *bottomLineView = [[UIView alloc] initWithFrame:CGRectZero];
    bottomLineView.backgroundColor = adaptAndDarkColor([UIColor colorTextBlackDark], [UIColor colorTextBlack]);
    [self.contentView addSubview:bottomLineView];
    [bottomLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.iTextView.mas_left).offset(-CGFloatIn750(8));
        make.top.equalTo(self.iTextView.mas_top).offset(CGFloatIn750(12));
        make.width.mas_equalTo(3);
        make.height.mas_equalTo(CGFloatIn750(48));
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
        [_thintLabel setText:@"说点什么吧~"];
    }
    return _thintLabel;
}

- (void)textViewDidChange:(UITextView *)textView {
    NSInteger _isMaxLength = _max > 0 ? _max : 300;
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
    if (self.textChangeBlock) {
        self.textChangeBlock(textView.text);
    }
}

- (void)setContent:(NSString *)content {
    _content = content;
    _iTextView.text = content;
    if (ValidStr(content)) {
        self.thintLabel.hidden = YES;
    }else{
        self.thintLabel.hidden = NO;
    }
}

- (void)setHint:(NSString *)hint {
    _hint = hint;
    _thintLabel.text = hint;
}

+ (CGFloat)z_getCellHeight:(id)sender {
    return CGFloatIn750(80 + 38);
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

@end




