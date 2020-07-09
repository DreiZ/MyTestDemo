//
//  ZOrganizationLessonAddImageCell.m
//  NoWait
//
//  Created by zhuang zhang on 2020/2/19.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZOrganizationLessonAddImageCell.h"
@interface ZOrganizationLessonAddImageCell ()<UITextFieldDelegate>

@property (nonatomic,strong) UILabel *titleLabel;
@property (nonatomic,strong) UIImageView *leftImageView;
@property (nonatomic,strong) UIImageView *contImageView;

@property (nonatomic,strong) UITextField *nameTextField;
@property (nonatomic,strong) UITextField *abbTextField;
@property (nonatomic,strong) UIView *backContentView;
@end

@implementation ZOrganizationLessonAddImageCell

-(void)setupView {
    [super setupView];
    self.contentView.backgroundColor = adaptAndDarkColor([UIColor colorWhite],[UIColor colorBlackBGDark]);
    
    UIView *contBackView = [[UIView alloc] initWithFrame:CGRectZero];
    contBackView.backgroundColor = adaptAndDarkColor([UIColor colorGrayBG], [UIColor colorGrayBGDark]);
    ViewRadius(contBackView, CGFloatIn750(16));
    
    [self.contentView addSubview:contBackView];
    [contBackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView.mas_centerY);
        make.left.equalTo(self.contentView.mas_left).offset(CGFloatIn750(30));
        make.width.mas_equalTo(CGFloatIn750(240));
        make.height.mas_equalTo(CGFloatIn750(160));
    }];
    
    [contBackView addSubview:self.leftImageView];
    [contBackView addSubview:self.contImageView];
    [contBackView addSubview:self.backContentView];
    [self.backContentView addSubview:self.titleLabel];
    
    [self.backContentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(CGFloatIn750(40));
        make.left.right.bottom.equalTo(self.contImageView);
    }];
    
    [self.contImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(contBackView);
    }];
    self.contImageView.hidden = YES;
    
    [self.leftImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.contImageView.mas_centerX);
        make.centerY.equalTo(self.contImageView.mas_centerY).offset(CGFloatIn750(-20));
        make.width.height.mas_equalTo(CGFloatIn750(40));
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.backContentView);
    }];
    
    UIView *lineView = [[UIView alloc] init];
    lineView.backgroundColor = adaptAndDarkColor([UIColor colorWithHexString:@"bbbbbb"], [UIColor colorWithHexString:@"999999"]);
    [self.leftImageView addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.leftImageView);
        make.centerY.equalTo(self.leftImageView.mas_centerY);
        make.height.mas_equalTo(CGFloatIn750(4));
    }];
    
    UIView *lineView1 = [[UIView alloc] init];
    lineView1.backgroundColor = adaptAndDarkColor([UIColor colorWithHexString:@"bbbbbb"], [UIColor colorWithHexString:@"999999"]);
    [self.leftImageView addSubview:lineView1];
    [lineView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.leftImageView);
        make.centerX.equalTo(self.leftImageView.mas_centerX);
        make.width.mas_equalTo(CGFloatIn750(4));
    }];

    
    [self.contentView addSubview:self.nameTextField];
    [self.contentView addSubview:self.abbTextField];
    
    UIView *nameLineView = [[UIView alloc] initWithFrame:CGRectZero];
    nameLineView.backgroundColor = adaptAndDarkColor([UIColor colorGrayLine], [UIColor colorGrayLineDark]);
    [self.nameTextField addSubview:nameLineView];
    [nameLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.nameTextField);
        make.height.mas_equalTo(0.5);
    }];
    
    UIView *abbLineView = [[UIView alloc] initWithFrame:CGRectZero];
    abbLineView.backgroundColor = adaptAndDarkColor([UIColor colorGrayLine], [UIColor colorGrayLineDark]);
    [self.abbTextField addSubview:abbLineView];
    [abbLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.abbTextField);
        make.height.mas_equalTo(0.5);
    }];
    
    [self.nameTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contImageView.mas_right).offset(CGFloatIn750(20));
        make.right.equalTo(self.contentView.mas_right).offset(-CGFloatIn750(30));
        make.height.mas_equalTo(CGFloatIn750(64));
        make.bottom.equalTo(self.contImageView.mas_centerY);
    }];
    
    [self.abbTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contImageView.mas_right).offset(CGFloatIn750(20));
        make.right.equalTo(self.contentView.mas_right).offset(-CGFloatIn750(30));
        make.height.mas_equalTo(CGFloatIn750(64));
        make.bottom.equalTo(self.contImageView.mas_bottom);
    }];
    
    __weak typeof(self) weakSelf = self;
    UIButton *imagBtn = [[UIButton alloc] initWithFrame:CGRectZero];
    [imagBtn bk_addEventHandler:^(id sender) {
        if (weakSelf.imageBlock) {
            weakSelf.imageBlock(0);
        }
    } forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:imagBtn];
    [imagBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contImageView);
    }];
}


#pragma mark - Getter
- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _titleLabel.textColor = adaptAndDarkColor([UIColor colorWhite],[UIColor colorTextGray1]);
        _titleLabel.text = @"上传课程封面";
        _titleLabel.numberOfLines = 1;
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        [_titleLabel setFont:[UIFont fontMin]];
    }
    return _titleLabel;
}


- (UITextField *)nameTextField {
    if (!_nameTextField ) {
        _nameTextField = [[UITextField alloc] init];
        [_nameTextField setFont:[UIFont boldFontContent]];
        _nameTextField.leftViewMode = UITextFieldViewModeAlways;
        [_nameTextField setBorderStyle:UITextBorderStyleNone];
        [_nameTextField setBackgroundColor:[UIColor clearColor]];
        [_nameTextField setReturnKeyType:UIReturnKeyDone];
        [_nameTextField setTextAlignment:NSTextAlignmentLeft];
        [_nameTextField setPlaceholder:@"请输入课程名称"];
        [_nameTextField setTextColor:adaptAndDarkColor([UIColor colorTextBlack], [UIColor colorTextBlackDark])];
        _nameTextField.delegate = self;
        [_nameTextField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    }
    return _nameTextField;
}

- (UITextField *)abbTextField {
    if (!_abbTextField ) {
        _abbTextField = [[UITextField alloc] init];
        [_abbTextField setFont:[UIFont boldFontContent]];
        _abbTextField.leftViewMode = UITextFieldViewModeAlways;
        [_abbTextField setBorderStyle:UITextBorderStyleNone];
        [_abbTextField setBackgroundColor:[UIColor clearColor]];
        [_abbTextField setReturnKeyType:UIReturnKeyDone];
        [_abbTextField setTextAlignment:NSTextAlignmentLeft];
        [_abbTextField setPlaceholder:@"请输入课程简称"];
        [_abbTextField setTextColor:adaptAndDarkColor([UIColor colorTextBlack], [UIColor colorTextBlackDark])];
        _abbTextField.delegate = self;
        [_abbTextField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    }
    return _abbTextField;
}


- (UIImageView *)leftImageView {
    if (!_leftImageView) {
        _leftImageView = [[UIImageView alloc] init];
    }
    return _leftImageView;
}

- (UIImageView *)contImageView {
    if (!_contImageView) {
        _contImageView = [[UIImageView alloc] init];
    }
    return _contImageView;
}

- (UIView *)backContentView {
    if (!_backContentView) {
        _backContentView = [[UIView alloc] init];
        _backContentView.backgroundColor = adaptAndDarkColor([UIColor colorBlack], [UIColor colorBlackBGDark]);

    }
    return _backContentView;
}

- (void)setImage:(id)image {
    _image = image;
    
    self.contImageView.hidden = NO;
    self.leftImageView.hidden = YES;
    if (!image) {
        self.contImageView.hidden = YES;
        self.leftImageView.hidden = NO;
    }else if ([image isKindOfClass:[UIImage class]]) {
//        self.contImageView.image = image;
        [LKUIUtils doubleAnimaitonWithImageView:self.contImageView toImage:image duration:0.8 animations:^{
            
        } completion:^{
            
        }];
    }else if ([image isKindOfClass:[NSString class]]){
        NSString *temp = image;
        if (temp.length > 0) {
            [LKUIUtils downloadShareImage:SafeStr(temp) complete:^(UIImage *image) {
                [LKUIUtils doubleAnimaitonWithImageView:self.contImageView toImage:image duration:0.8 animations:^{
                    
                } completion:^{
                    
                }];
            }];
//            [self.contImageView tt_setImageWithURL:[NSURL URLWithString:temp]];
        }else{
            self.contImageView.hidden = YES;
            self.leftImageView.hidden = NO;
        }
    }
}

+(CGFloat)z_getCellHeight:(id)sender {
    return CGFloatIn750(240);
}

- (void)setData:(NSDictionary *)data {
    _data = data;
    if ([data objectForKey:@"image"]) {
        self.image = data[@"image"];
    }else{
        self.image = nil;
    }
    
    if ([data objectForKey:@"edit"] && [data[@"edit"] intValue] == 1) {
        [_nameTextField setTextColor:adaptAndDarkColor([UIColor colorTextGray1], [UIColor colorTextGray1Dark])];
        [_abbTextField setTextColor:adaptAndDarkColor([UIColor colorTextGray1], [UIColor colorTextGray1Dark])];
        self.nameTextField.enabled = NO;
        self.abbTextField.enabled = NO;
    }else{
        [_nameTextField setTextColor:adaptAndDarkColor([UIColor colorTextBlack], [UIColor colorTextBlackDark])];
        [_abbTextField setTextColor:adaptAndDarkColor([UIColor colorTextBlack], [UIColor colorTextBlackDark])];
        self.nameTextField.enabled = YES;
        self.abbTextField.enabled = YES;
    }
    
    if ([data objectForKey:@"name"]) {
        _nameTextField.text = data[@"name"];
    }else{
        _nameTextField.text = @"";
    }
    
    if ([data objectForKey:@"subName"]) {
        _abbTextField.text = data[@"subName"];
    }else{
        _abbTextField.text = @"";
    }
}

#pragma mark - -textField delegate
- (void)textFieldDidChange:(UITextField *)textField {
    if (textField == _abbTextField) {
        [ZPublicTool textField:textField maxLenght:18 type:ZFormatterTypeAnyByte];
        if (self.valueChangeBlock) {
            self.valueChangeBlock(textField.text, 1);
        }
    }else{
        [ZPublicTool textField:textField maxLenght:60 type:ZFormatterTypeAnyByte];
        if (self.valueChangeBlock) {
            self.valueChangeBlock(textField.text, 0);
        }
    }
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    return [ZPublicTool textField:textField shouldChangeCharactersInRange:range replacementString:string type:ZFormatterTypeAnyByte];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

@end
