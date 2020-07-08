//
//  ZCircleReleaseTextFieldCell.m
//  NoWait
//
//  Created by zhuang zhang on 2020/7/6.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZCircleReleaseTextFieldCell.h"
#import "ZPublicTool.h"

@interface ZCircleReleaseTextFieldCell ()<UITextFieldDelegate>
@property (nonatomic,strong) UITextField *inputTextField;

@property (nonatomic,strong) UIView *backContentView;
@end

@implementation ZCircleReleaseTextFieldCell

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
    self.contentView.backgroundColor = adaptAndDarkColor([UIColor colorGrayBG], [UIColor colorGrayBGDark]);
    [self.contentView addSubview:self.backContentView];
    
    [self.backContentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).offset(CGFloatIn750(0));
        make.right.equalTo(self.contentView.mas_right).offset(-CGFloatIn750(0));
        make.top.bottom.equalTo(self.contentView);
    }];
    
    [self.backContentView addSubview:self.inputTextField];
    [self.inputTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.backContentView.mas_left).offset(CGFloatIn750(44));
        make.top.bottom.equalTo(self.backContentView);
        make.right.equalTo(self.backContentView.mas_right).offset(-kCellContentSpace);
    }];
    
}

#pragma mark -懒加载
- (UIView *)backContentView {
    if (!_backContentView) {
        _backContentView = [[UIView alloc] init];
        _backContentView.layer.masksToBounds = YES;
        _backContentView.backgroundColor = adaptAndDarkColor([UIColor whiteColor], [UIColor colorBlackBGDark]);
    }
    return _backContentView;
}

- (UITextField *)inputTextField {
    if (!_inputTextField ) {
        _inputTextField = [[UITextField alloc] init];
        [_inputTextField setFont:[UIFont fontSmall]];
        _inputTextField.leftViewMode = UITextFieldViewModeAlways;
        [_inputTextField setBorderStyle:UITextBorderStyleNone];
        [_inputTextField setBackgroundColor:[UIColor clearColor]];
        [_inputTextField setReturnKeyType:UIReturnKeyDone];
        [_inputTextField setTextAlignment:NSTextAlignmentLeft];
        [_inputTextField setPlaceholder:@""];
        [_inputTextField setClearButtonMode:UITextFieldViewModeWhileEditing];
        [_inputTextField setTextColor:adaptAndDarkColor([UIColor colorTextGray], [UIColor colorTextGrayDark])];
        [_inputTextField setFont:[UIFont boldFontMax1Title]];
        _inputTextField.delegate = self;
        [_inputTextField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    }
    return _inputTextField;
}

#pragma mark --textField delegate
- (void)textFieldDidChange:(UITextField *)textField {
    [ZPublicTool textField:textField maxLenght:self.model.max > 0 ? self.model.max:20 type:self.model.formatterType];
 
    _model.content = textField.text;
    if (self.valueChangeBlock) {
        self.valueChangeBlock(textField.text);
    }
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
    
    _inputTextField.placeholder = model.placeholder;
    _inputTextField.text = model.content;
    _inputTextField.textAlignment = model.textAlignment;
    
}

@end
