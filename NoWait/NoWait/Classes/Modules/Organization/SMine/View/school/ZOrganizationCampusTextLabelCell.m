//
//  ZOrganizationCampusTextLabelCell.m
//  NoWait
//
//  Created by zhuang zhang on 2020/2/17.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZOrganizationCampusTextLabelCell.h"
#import "ZPublicTool.h"
#define btnHeight CGFloatIn750(56)
#define btnAddWidth CGFloatIn750(40)
#define leftX CGFloatIn750(20)

@interface ZOrganizationCampusTextLabelCell ()<UITextFieldDelegate>
@property (nonatomic,strong) UILabel *subTitleLabel;
@property (nonatomic,strong) UILabel *leftTitleLabel;

@property (nonatomic,strong) UITextField *inputTextField;
@property (nonatomic,strong) UIView *bottomLineView;
@property (nonatomic,strong) UIView *inputLine;
@property (nonatomic,strong) UIImageView *arrowImageView;
@property (nonatomic,strong) UIView *backContentView;

@property (nonatomic,strong) NSMutableArray *hotSearchBtn;
@property (nonatomic,strong) NSArray *hotProductArr;
@property (nonatomic,strong) UIView *topView;
@property (nonatomic,strong) UIView *labelView;
@end

@implementation ZOrganizationCampusTextLabelCell

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
    _hotSearchBtn = @[].mutableCopy;
    _hotSearchBtn = @[].mutableCopy;
    self.contentView.backgroundColor = adaptAndDarkColor([UIColor colorGrayBG], [UIColor colorGrayBGDark]);
    [self.contentView addSubview:self.backContentView];
    
    [self.backContentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).offset(CGFloatIn750(30));
        make.right.equalTo(self.contentView.mas_right).offset(-CGFloatIn750(30));
        make.top.bottom.equalTo(self.contentView);
    }];
    
    [self.backContentView addSubview:self.topView];
    [self.topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.backContentView.mas_left).offset(CGFloatIn750(0));
        make.right.equalTo(self.backContentView.mas_right).offset(-CGFloatIn750(0));
        make.top.equalTo(self.backContentView);
        make.height.mas_equalTo(CGFloatIn750(108));
    }];
    
    
    [self.topView addSubview:self.leftTitleLabel];
    [self.leftTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.topView.mas_centerY);
        make.left.equalTo(self.topView.mas_left).offset(kCellLeftMargin);
    }];
    
    [self.topView addSubview:self.subTitleLabel];
    [self.subTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.topView.mas_centerY);
        make.left.equalTo(self.leftTitleLabel.mas_right).offset(CGFloatIn750(8));
    }];
    
    [self.topView addSubview:self.arrowImageView];
    [self.arrowImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.topView.mas_centerY);
        make.right.equalTo(self.topView.mas_right).offset(-CGFloatIn750(20));
        make.width.mas_equalTo(CGFloatIn750(10));
        make.height.mas_equalTo(CGFloatIn750(18));
    }];
    
    [self.topView addSubview:self.inputTextField];
    [self.inputTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.subTitleLabel.mas_right).offset(kCellContentSpace);
        make.height.mas_equalTo(CGFloatIn750(52));
        make.right.equalTo(self.arrowImageView.mas_left).offset(-kCellContentSpace);
        make.centerY.equalTo(self.subTitleLabel.mas_centerY);
    }];
    
    
    [self.topView addSubview:self.inputLine];
    [self.inputLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(1);
        make.left.right.equalTo(self.inputTextField);
        make.top.equalTo(self.inputTextField.mas_bottom);
    }];

    [self.backContentView addSubview:self.labelView];
    [self.labelView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.subTitleLabel.mas_right).offset(CGFloatIn750(20));
        make.right.equalTo(self.backContentView.mas_right).offset(-CGFloatIn750(0));
        make.top.bottom.equalTo(self.backContentView);
//        make.height.mas_equalTo(CGFloatIn750(108));
    }];

    [self.contentView addSubview:self.bottomLineView];
    [self.bottomLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.backContentView);
        make.height.mas_equalTo(0.5);
    }];
    
    
}

#pragma mark -懒加载
- (UIView *)topView {
    if (!_topView) {
        _topView = [[UIView alloc] init];
        _topView.layer.masksToBounds = YES;
        _topView.backgroundColor = adaptAndDarkColor([UIColor whiteColor], [UIColor colorBlackBGDark]);
    }
    return _topView;
}

- (UIView *)labelView {
    if (!_labelView) {
        _labelView = [[UIView alloc] init];
        _labelView.layer.masksToBounds = YES;
        _labelView.backgroundColor = adaptAndDarkColor([UIColor whiteColor], [UIColor colorBlackBGDark]);
    }
    return _labelView;
}

- (UIView *)backContentView {
    if (!_backContentView) {
        _backContentView = [[UIView alloc] init];
        _backContentView.layer.masksToBounds = YES;
        _backContentView.backgroundColor = adaptAndDarkColor([UIColor whiteColor], [UIColor colorBlackBGDark]);
    }
    return _backContentView;
}


- (UIView *)inputLine {
    if (!_inputLine) {
        _inputLine = [[UIView alloc] init];
        _inputLine.layer.masksToBounds = YES;
        _inputLine.backgroundColor = [UIColor colorRedDefault];
    }
    return _inputLine;
}

- (UIImageView *)arrowImageView {
    if (!_arrowImageView) {
        _arrowImageView = [[UIImageView alloc] init];
        _arrowImageView.image = isDarkModel() ? [UIImage imageNamed:@"rightBlackArrowDarkN"] :  [UIImage imageNamed:@"rightBlackArrowN"];
    }
    return _arrowImageView;
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
        [_leftTitleLabel setFont:[UIFont fontTitle]];
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
        [_subTitleLabel setFont:[UIFont fontContent]];
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
        [_inputTextField setClearButtonMode:UITextFieldViewModeWhileEditing];
        [_inputTextField setTextColor:adaptAndDarkColor([UIColor colorTextBlack], [UIColor colorTextBlackDark])];
        [_inputTextField setFont:[UIFont fontContent]];
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
        return CGFloatIn750(108);
    }
    if (model.data && [model.data isKindOfClass:[NSArray class]]) {
        NSArray *_hotProductArr = (NSArray *)model.data;
        CGSize titleSize = [model.leftTitle tt_sizeWithFont:[UIFont fontTitle]];
        CGFloat labelWidth = KScreenWidth - 2 * model.contBackMargin - leftX - (kCellContentSpace +titleSize.width+2 );
        
        CGFloat maxWidth = labelWidth - leftX ;
        CGFloat offSetX = labelWidth - leftX;
        CGFloat offSetY = CGFloatIn750(28);
        for (int i = 0; i < _hotProductArr.count; i++) {
            NSString *btnTitle = _hotProductArr[i];
            CGFloat width =  [btnTitle tt_sizeWithFont:[UIFont fontContent]].width;
            width += btnAddWidth;
            if (maxWidth - offSetX + width > maxWidth) {
                offSetX = labelWidth - leftX;
                offSetY += CGFloatIn750(20) + btnHeight;
            }
            offSetX += (-leftX-width);
        }
        
        return offSetY + btnHeight + CGFloatIn750(28);
    }else {
        return CGFloatIn750(108);
    }
}


#pragma mark -setModel
- (void)setModel:(ZBaseTextFieldCellModel *)model {
    _model = model;
    self.formatterType = model.formatterType;
    
    _leftTitleLabel.text = model.leftTitle;
    _leftTitleLabel.textColor = adaptAndDarkColor(model.leftColor, model.leftDarkColor);
    _leftTitleLabel.font = model.leftFont;
    
    _subTitleLabel.text = model.subTitle;
    _subTitleLabel.font = model.subTitleFont;
    _subTitleLabel.textColor = adaptAndDarkColor(model.subTitleColor, model.subTitleDarkColor);
 
    _inputTextField.font = model.textFont;
    _inputTextField.textColor = adaptAndDarkColor(model.textColor, model.textDarkColor);
    _inputTextField.placeholder = model.placeholder;
    _inputTextField.text = model.content;
    _inputTextField.textAlignment = model.textAlignment;
    _inputTextField.enabled = model.isTextEnabled;
    
    _bottomLineView.hidden = model.isHiddenLine;
    _inputLine.hidden = model.isHiddenInputLine;
    
    [self.backContentView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).offset(model.contBackMargin);
        make.right.equalTo(self.contentView.mas_right).offset(-model.contBackMargin);
        make.top.bottom.equalTo(self.contentView);
    }];

    
    [self.labelView removeAllSubviews];
    
    CGSize titleSize = [model.leftTitle tt_sizeWithFont:[UIFont fontTitle]];
    [self.leftTitleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.topView.mas_centerY);
        make.left.equalTo(self.topView.mas_left).offset(model.contentSpace);
        make.width.mas_equalTo(titleSize.width+2);
    }];
    
    if (!model.subTitle || model.subTitle.length == 0) {
        [self.subTitleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.topView.mas_centerY);
            make.left.equalTo(self.leftTitleLabel.mas_right).offset(CGFloatIn750(0));
            make.width.mas_equalTo(0);
        }];
    }else{
        CGSize subTitleSize = [model.subTitle tt_sizeWithFont:[UIFont fontContent]];
        [self.subTitleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.topView.mas_centerY);
            make.left.equalTo(self.leftTitleLabel.mas_right).offset(CGFloatIn750(8));
            make.width.mas_equalTo(subTitleSize.width+2);
        }];
    }
    
    
    [self.bottomLineView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.backContentView);
        make.height.mas_equalTo(0.5);
        make.left.equalTo(self.backContentView.mas_left).offset(model.lineLeftMargin);
        make.right.equalTo(self.backContentView.mas_right).offset(-model.lineRightMargin);
    }];

    if (model.isTextEnabled) {
        [self.inputTextField mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.topView.mas_left).offset(model.leftContentWidth);
            make.height.mas_equalTo(model.textFieldHeight);
            make.right.equalTo(self.arrowImageView.mas_right).offset(-model.contentSpace);
            make.centerY.equalTo(self.subTitleLabel.mas_centerY);
        }];
    }else{
        [self.inputTextField mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.topView.mas_left).offset(model.leftContentWidth);
            make.height.mas_equalTo(model.textFieldHeight);
            make.right.equalTo(self.arrowImageView.mas_right).offset(-model.contentSpace);
            make.centerY.equalTo(self.subTitleLabel.mas_centerY);
        }];
    }
    self.inputTextField.enabled = model.isTextEnabled;
    self.arrowImageView.hidden = model.isTextEnabled;
    
    if (model.data && [model.data isKindOfClass:[NSArray class]]) {
        self.labelView.hidden = NO;
        self.hotProductArr = (NSArray *)self.model.data;
        [self setHotProductArr:self.hotProductArr];
    }else{
        self.labelView.hidden = YES;
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


- (void)setHotProductArr:(NSArray *)hotProductArr {
    _hotProductArr = hotProductArr;
    
    [self.labelView removeAllSubviews];
    
    for (UIButton *btn in _hotSearchBtn) {
        [btn removeFromSuperview];
    }
    
    if (!hotProductArr || hotProductArr.count == 0) {
        return;
    }

    CGSize titleSize = [self.model.leftTitle tt_sizeWithFont:[UIFont fontTitle]];
    CGFloat labelWidth = KScreenWidth - 2 * self.model.contBackMargin - leftX - (kCellContentSpace + titleSize.width + 2);
    
    CGFloat maxWidth = labelWidth - leftX ;
    CGFloat offSetX = labelWidth - leftX - self.model.rightMargin;
    CGFloat offSetY = CGFloatIn750(28);
    for (int i = 0; i < _hotProductArr.count; i++) {
        
        UILabel *btn = [self getHotSearchBtnItem:i];
        btn.text = _hotProductArr[i];
        [self.labelView addSubview:btn];
        CGFloat width = [self getTheStringWidth:_hotProductArr[i] font:[UIFont fontContent]];
        width += btnAddWidth;
        if (maxWidth - offSetX + width > maxWidth) {
            offSetX = labelWidth - leftX - self.model.rightMargin;
            offSetY += CGFloatIn750(20) + btnHeight;
        }
        btn.frame = CGRectMake(offSetX - width, offSetY, width, btnHeight);
        offSetX += (-leftX-width);
    }
}

- (CGFloat)getTheStringWidth:(NSString *)str font:(UIFont *)font
{
    return  [str sizeWithAttributes:@{NSFontAttributeName: font}].width;
}

-(UILabel*)getHotSearchBtnItem:(NSInteger)index
{
    if (index >= _hotSearchBtn.count) {
        UILabel *btn = [[UILabel alloc] init];
        btn.tag = index;
        btn.font = [UIFont fontContent];
        btn.textAlignment = NSTextAlignmentCenter;
        btn.textColor = adaptAndDarkColor([UIColor colorTextGray], [UIColor colorTextGrayDark]);
        ViewRadius(btn, btnHeight/2.0);
        btn.backgroundColor = adaptAndDarkColor([UIColor colorGrayBG], [UIColor colorGrayBGDark]);
        [_hotSearchBtn addObject:btn];
        
    }
    
    return _hotSearchBtn[index];
}


- (void)selectedBtnOnClick:(UIButton *)sender {
    
}

#pragma mark - 处理一些特殊的情况，比如layer的CGColor、特殊的，明景和暗景造成的文字内容变化等等
-(void)traitCollectionDidChange:(UITraitCollection *)previousTraitCollection{
    [super traitCollectionDidChange:previousTraitCollection];
    self.arrowImageView.image = isDarkModel() ? [UIImage imageNamed:@"rightBlackArrowDarkN"] :  [UIImage imageNamed:@"rightBlackArrowN"];
}

@end




