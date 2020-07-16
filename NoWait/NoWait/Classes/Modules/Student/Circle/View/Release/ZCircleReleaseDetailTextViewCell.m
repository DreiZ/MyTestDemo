//
//  ZCircleReleaseDetailTextViewCell.m
//  NoWait
//
//  Created by zhuang zhang on 2020/7/6.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZCircleReleaseDetailTextViewCell.h"

@interface ZCircleReleaseDetailTextViewCell ()<UITextViewDelegate>
@property (nonatomic,strong) UITextView *iTextView;
@property (nonatomic,strong) UILabel *thintLabel;
@property (nonatomic,strong) UIView *backView;

@end

@implementation ZCircleReleaseDetailTextViewCell

-(void)setupView
{
    [super setupView];
    
    [self.contentView addSubview:self.backView];
    [self.contentView addSubview:self.iTextView];
    
    [self.iTextView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).offset(CGFloatIn750(44));
        make.right.equalTo(self.contentView.mas_right).offset(CGFloatIn750(-48));
        make.top.equalTo(self.contentView.mas_top).offset(CGFloatIn750(20));
        make.bottom.equalTo(self.contentView.mas_bottom).offset(CGFloatIn750(-0));
    }];
    
    [self.backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.iTextView.mas_left).offset(CGFloatIn750(-0));
        make.right.equalTo(self.iTextView.mas_right).offset(CGFloatIn750(0));
        make.top.equalTo(self.iTextView.mas_top).offset(CGFloatIn750(-0));
        make.bottom.equalTo(self.iTextView.mas_bottom).offset(CGFloatIn750(0));
    }];
   
    [self.contentView addSubview:self.thintLabel];
    [self.thintLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.iTextView.mas_left).offset(CGFloatIn750(4));
        make.right.equalTo(self.contentView.mas_right).offset(CGFloatIn750(-30));
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
        
        [ZPublicTool textView:_iTextView lineSpacing:CGFloatIn750(14) font:[UIFont fontContent] textColor:nil];
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
        [_thintLabel setText:@"添加正文"];
    }
    return _thintLabel;
}

- (void)textViewDidChange:(UITextView *)textView {
    if (textView.text.length > 0) {
        _thintLabel.hidden = YES;
    }else {
        _thintLabel.hidden = NO;
    }
    
    [ZPublicTool textView:textView maxLenght:_max type:ZFormatterTypeAnyByte];
       
    if (self.textChangeBlock) {
        self.textChangeBlock(textView.text);
    }
    
    [ZPublicTool textView:textView lineSpacing:CGFloatIn750(14) font:[UIFont fontContent] textColor:nil];
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
    return CGFloatIn750(450);
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





