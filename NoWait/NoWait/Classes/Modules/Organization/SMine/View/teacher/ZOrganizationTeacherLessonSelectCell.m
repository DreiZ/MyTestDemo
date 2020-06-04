//
//  ZOrganizationTeacherLessonSelectCell.m
//  NoWait
//
//  Created by zhuang zhang on 2020/2/21.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZOrganizationTeacherLessonSelectCell.h"

@interface ZOrganizationTeacherLessonSelectCell ()<UITextFieldDelegate>
@property (nonatomic,strong) UIView *contView;

@property (nonatomic,strong) UILabel *nameLabel;
@property (nonatomic,strong) UILabel *priceLabel;
@property (nonatomic,strong) UILabel *unitLabel;

@property (nonatomic,strong) UIImageView *leftImageView;
@property (nonatomic,strong) UITextField *inputTextField;
@property (nonatomic,strong) UIButton *selectedBtn;

@end

@implementation ZOrganizationTeacherLessonSelectCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupView];
    }
    return self;
}

-(void)setupView {
    [super setupView];
    self.contentView.backgroundColor = adaptAndDarkColor([UIColor colorGrayBG],[UIColor colorGrayBGDark]);
    
    [self.contentView addSubview:self.contView];
    [self.contView addSubview:self.nameLabel];
    [self.contView addSubview:self.priceLabel];
    [self.contView addSubview:self.unitLabel];
    [self.contView addSubview:self.leftImageView];
    [self.contView addSubview:self.inputTextField];
    
    [self.contView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.contentView);
        make.left.equalTo(self.mas_left).offset(CGFloatIn750(0));
        make.right.equalTo(self.mas_right).offset(-CGFloatIn750(0));
    }];
    
    [self.leftImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contView.mas_left).offset(CGFloatIn750(30));
        make.centerY.equalTo(self.mas_centerY);
        make.height.width.mas_equalTo(CGFloatIn750(36));
    }];
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.leftImageView.mas_right).offset(CGFloatIn750(20));
        make.centerY.equalTo(self.contView.mas_centerY);
        make.right.equalTo(self.contView.mas_centerX).offset(-CGFloatIn750(70));
    }];
    
    [self.priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contView.mas_centerX).offset(CGFloatIn750(70));
        make.centerY.equalTo(self.nameLabel.mas_centerY);
    }];
    
    [self.unitLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contView.mas_centerY);
        make.right.equalTo(self.contView.mas_right).offset(-CGFloatIn750(30));
    }];
    
    [self.inputTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contView.mas_centerY);
        make.right.equalTo(self.unitLabel.mas_left).offset(-CGFloatIn750(20));
        make.height.mas_equalTo(CGFloatIn750(80));
    }];
    
    [self.contView addSubview:self.selectedBtn];
    [self.selectedBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.equalTo(self.contView);
        make.right.equalTo(self.inputTextField.mas_left);
    }];
}

- (void)btnLong:(id)sender {
//    if (self.handleBlock) {
//        self.handleBlock(@"1");
//    }
}
#pragma mark -Getter
- (UITextField *)inputTextField {
    if (!_inputTextField ) {
        _inputTextField = [[UITextField alloc] init];
        [_inputTextField setFont:[UIFont fontContent]];
        _inputTextField.leftViewMode = UITextFieldViewModeAlways;
        [_inputTextField setBorderStyle:UITextBorderStyleNone];
        [_inputTextField setBackgroundColor:[UIColor clearColor]];
        [_inputTextField setReturnKeyType:UIReturnKeyDone];
        [_inputTextField setTextAlignment:NSTextAlignmentRight];
        [_inputTextField setPlaceholder:@"教师带课价格"];
        _inputTextField.keyboardType = UIKeyboardTypeDecimalPad;
        [_inputTextField setTextColor:adaptAndDarkColor([UIColor colorTextBlack], [UIColor colorTextBlackDark])];
        _inputTextField.delegate = self;
        [_inputTextField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    }
    return _inputTextField;
}

- (UIView *)contView {
    if (!_contView) {
        _contView = [[UIView alloc] init];
        _contView.layer.masksToBounds = YES;
        _contView.backgroundColor = adaptAndDarkColor([UIColor colorWhite], [UIColor colorBlackBGDark]);
    }
    return _contView;
}


- (UILabel *)nameLabel {
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _nameLabel.textColor = adaptAndDarkColor([UIColor colorTextBlack],[UIColor colorTextBlackDark]);
        _nameLabel.numberOfLines = 1;
        _nameLabel.textAlignment = NSTextAlignmentLeft;
        [_nameLabel setFont:[UIFont fontContent]];
        [_nameLabel setAdjustsFontSizeToFitWidth:YES];
    }
    return _nameLabel;
}


- (UILabel *)priceLabel {
    if (!_priceLabel) {
        _priceLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _priceLabel.textColor = adaptAndDarkColor([UIColor colorTextBlack],[UIColor colorTextBlackDark]);
        
        _priceLabel.numberOfLines = 1;
        _priceLabel.textAlignment = NSTextAlignmentRight;
        [_priceLabel setFont:[UIFont boldFontContent]];
    }
    return _priceLabel;
}

- (UILabel *)unitLabel {
    if (!_unitLabel) {
        _unitLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _unitLabel.textColor = adaptAndDarkColor([UIColor colorTextBlack],[UIColor colorTextBlackDark]);
        _unitLabel.numberOfLines = 1;
        _unitLabel.text = @"元";
        _unitLabel.textAlignment = NSTextAlignmentRight;
        [_unitLabel setFont:[UIFont fontContent]];
    }
    return _unitLabel;
}

- (UIImageView *)leftImageView {
    if (!_leftImageView) {
        _leftImageView = [[UIImageView alloc] init];
        _leftImageView.image = [UIImage imageNamed:@"unSelectedCycle"];
    }
    return _leftImageView;
}

- (UIButton *)selectedBtn {
    if (!_selectedBtn) {
        __weak typeof(self) weakSelf = self;
        _selectedBtn = [[UIButton alloc] init];
        [_selectedBtn bk_addEventHandler:^(id sender) {
            weakSelf.model.isSelected = !weakSelf.model.isSelected;
            
            if (!weakSelf.model.isSelected) {
                weakSelf.inputTextField.text = @"";
            }else{
                weakSelf.inputTextField.text = weakSelf.model.teacherPirce;
            }
            
            weakSelf.leftImageView.image = weakSelf.model.isSelected ? [UIImage imageNamed:@"selectedCycle"] : [UIImage imageNamed:@"unSelectedCycle"];
            
            if (weakSelf.selectedBlock) {
                weakSelf.selectedBlock();
            }
        } forControlEvents:UIControlEventTouchUpInside];
    }
    return _selectedBtn;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    return [ZPublicTool textField:textField shouldChangeCharactersInRange:range replacementString:string type:ZFormatterTypeDecimal];
}

- (void)textFieldDidChange:(UITextField *)textField {
    [ZPublicTool textField:textField maxLenght:10 type:ZFormatterTypeDecimal];
    
    if (self.handleBlock) {
        self.handleBlock(textField.text);
    }
    if (textField.text.length > 0) {
        self.model.isSelected = YES;
        _leftImageView.image = self.model.isSelected ? [UIImage imageNamed:@"selectedCycle"] : [UIImage imageNamed:@"unSelectedCycle"];

    }
}

- (void)setModel:(ZOriganizationLessonListModel *)model {
    _model = model;
    _nameLabel.text = model.short_name;
    _inputTextField.text = model.teacherPirce;
    _priceLabel.text = [NSString stringWithFormat:@"%@元",model.price];
    _leftImageView.image = model.isSelected ? [UIImage imageNamed:@"selectedCycle"] : [UIImage imageNamed:@"unSelectedCycle"];
}

+(CGFloat)z_getCellHeight:(id)sender {
    return CGFloatIn750(112);
}

@end




