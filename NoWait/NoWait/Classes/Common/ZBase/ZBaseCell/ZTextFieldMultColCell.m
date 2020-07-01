//
//  ZTextFieldMultColCell.m
//  NoWait
//
//  Created by zhuang zhang on 2020/2/26.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZTextFieldMultColCell.h"
#import "ZPublicTool.h"
#import "ZMultiseriateContentLeftLineCell.h"

@interface ZTextFieldMultColCell ()<UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UILabel *subTitleLabel;
@property (nonatomic,strong) UILabel *leftTitleLabel;
@property (nonatomic,strong) UILabel *rightTitleLabel;

@property (nonatomic,strong) UITextField *inputTextField;
@property (nonatomic,strong) UIView *bottomLineView;
@property (nonatomic,strong) UIView *inputLine;
@property (nonatomic,strong) UIImageView *rightImageView;

@property (nonatomic,strong) UIView *multColView;
@property (nonatomic,strong) UITableView *iTableView;
@property (nonatomic,strong) NSMutableArray *cellConfigArr;
@property (nonatomic,strong) UIView *topView;
@property (nonatomic,strong) UIButton *selectBtn;

@end

@implementation ZTextFieldMultColCell

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
    
    self.cellConfigArr = @[].mutableCopy;
    
    [self.contentView addSubview:self.topView];
    [self.topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).offset(CGFloatIn750(0));
        make.right.equalTo(self.contentView.mas_right).offset(-CGFloatIn750(0));
        make.top.equalTo(self.contentView);
        make.height.mas_equalTo(CGFloatIn750(108));
    }];
    
    
    [self.contentView addSubview:self.leftTitleLabel];
    [self.leftTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.topView.mas_centerY);
        make.left.equalTo(self.contentView.mas_left).offset(kCellLeftMargin);
    }];
    
    [self.contentView addSubview:self.subTitleLabel];
    [self.subTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.topView.mas_centerY);
        make.left.equalTo(self.leftTitleLabel.mas_right).offset(CGFloatIn750(8));
    }];
    
    [self.contentView addSubview:self.rightImageView];
    [self.rightImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.topView.mas_centerY);
        make.right.equalTo(self.contentView.mas_right).offset(-kCellRightMargin);
        make.width.mas_equalTo(CGFloatIn750(10));
    }];
    
    [self.contentView addSubview:self.rightTitleLabel];
    [self.rightTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.topView.mas_centerY);
        make.right.equalTo(self.rightImageView.mas_left).offset(-kCellContentSpace);
    }];
    
    [self.contentView addSubview:self.inputTextField];
    [self.inputTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.subTitleLabel.mas_right).offset(kCellContentSpace);
        make.height.mas_equalTo(CGFloatIn750(52));
        make.right.equalTo(self.rightTitleLabel.mas_left).offset(-kCellContentSpace);
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
    
    [self.contentView addSubview:self.multColView];
    [self.multColView addSubview:self.iTableView];
    [self.multColView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.leftTitleLabel.mas_right).offset(kCellContentSpace);
        make.right.equalTo(self.rightImageView.mas_left).offset(-kCellContentSpace);
        make.top.equalTo(self.leftTitleLabel.mas_top);
        make.bottom.equalTo(self.mas_bottom).offset(-(kCellNormalHeight - [UIFont boldFontMaxTitle].lineHeight)/2.0f);
    }];
    
    [self.iTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.multColView);
    }];
    
    
    [self.contentView addSubview:self.selectBtn];
    [self.selectBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.equalTo(self.contentView);
    }];
}

#pragma mark -懒加载
- (UIButton *)selectBtn {
    if (!_selectBtn) {
        __weak typeof(self) weakSelf = self;
        _selectBtn = [[UIButton alloc] initWithFrame:CGRectZero];
        [_selectBtn bk_addEventHandler:^(id sender) {
            if (weakSelf.selectBlock) {
                weakSelf.selectBlock();
            }
        } forControlEvents:UIControlEventTouchUpInside];
    }
    return _selectBtn;
}

- (UIView *)topView {
    if (!_topView) {
        _topView = [[UIView alloc] init];
        _topView.layer.masksToBounds = YES;
        _topView.backgroundColor = adaptAndDarkColor([UIColor colorWhite], [UIColor colorBlackBGDark]);
    }
    return _topView;
}

- (UIView *)inputLine {
    if (!_inputLine) {
        _inputLine = [[UIView alloc] init];
        _inputLine.layer.masksToBounds = YES;
        _inputLine.backgroundColor = adaptAndDarkColor([UIColor colorGrayLine], [UIColor colorGrayLine]);;
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
        [_leftTitleLabel setFont:[UIFont boldFontMaxTitle]];
    }
    return _leftTitleLabel;
}

- (UILabel *)rightTitleLabel {
    if (!_rightTitleLabel) {
        _rightTitleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _rightTitleLabel.textColor = adaptAndDarkColor([UIColor colorTextBlack], [UIColor colorTextBlackDark]);
        _rightTitleLabel.text = @"";
        _rightTitleLabel.numberOfLines = 0;
        _rightTitleLabel.textAlignment = NSTextAlignmentRight;
        [_rightTitleLabel setFont:[UIFont fontContent]];
    }
    return _rightTitleLabel;
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
        [_inputTextField setTextColor:adaptAndDarkColor([UIColor colorTextBlack], [UIColor colorTextBlackDark])];
        _inputTextField.delegate = self;
        [_inputTextField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    }
    return _inputTextField;
}


- (UIImageView *)rightImageView {
    if (!_rightImageView) {
        _rightImageView = [[UIImageView alloc] init];
        _rightImageView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _rightImageView;
}

- (UIView *)multColView {
    if (!_multColView) {
        _multColView = [[UIView alloc] init];
        _multColView.backgroundColor = adaptAndDarkColor([UIColor colorWhite], [UIColor colorBlackBGDark]);
    }
    
    return _multColView;
}

-(UITableView *)iTableView {
    if (!_iTableView) {
        _iTableView = [[UITableView alloc]initWithFrame:self.multColView.bounds style:UITableViewStylePlain];
        _iTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _iTableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
        _iTableView.showsVerticalScrollIndicator = NO;
        _iTableView.showsHorizontalScrollIndicator = NO;
        if ([_iTableView respondsToSelector:@selector(contentInsetAdjustmentBehavior)]) {
            _iTableView.estimatedRowHeight = 0;
            _iTableView.estimatedSectionHeaderHeight = 0;
            _iTableView.estimatedSectionFooterHeight = 0;
            if (@available(iOS 11.0, *)) {
                _iTableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
            } else {
                // Fallback on earlier versions
            }
        }
        _iTableView.delegate = self;
        _iTableView.dataSource = self;
        _iTableView.scrollEnabled = NO;
        _iTableView.backgroundColor = adaptAndDarkColor([UIColor colorWhite], [UIColor colorBlackBGDark]);
    }
    return _iTableView;
}

#pragma mark - -textField delegate
- (void)textFieldDidChange:(UITextField *)textField {
    [ZPublicTool textField:textField maxLenght:self.model.max > 0 ? self.model.max:20 type:self.model.formatterType];
 
    _model.content = textField.text;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    return [ZPublicTool textField:textField shouldChangeCharactersInRange:range replacementString:string type:self.model.formatterType];
}


#pragma mark tableView -------datasource-----
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _cellConfigArr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ZCellConfig *cellConfig = [_cellConfigArr objectAtIndex:indexPath.row];
    ZBaseCell *cell;
    cell = (ZBaseCell*)[cellConfig cellOfCellConfigWithTableView:tableView dataModel:cellConfig.dataModel];
    if ([cellConfig.title isEqualToString:@"ZSpaceEmptyCell"]){
//        ZSpaceEmptyCell *enteryCell = (ZSpaceEmptyCell *)cell;
        
    }
    return cell;
}

#pragma mark tableView ------delegate-----
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    ZCellConfig *cellConfig = _cellConfigArr[indexPath.row];
    CGFloat cellHeight =  cellConfig.heightOfCell;
    return cellHeight;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0;
}


+ (CGFloat)z_getCellHeight:(id)sender {
    ZBaseTextFieldCellModel *model = sender;
    if (!model) {
        return kCellNormalHeight;
    }
    CGFloat cellHeight = (model.cellHeight - model.leftFont.lineHeight);
    if (model.data && [model.data isKindOfClass:[NSArray class]]) {
           NSArray *tempArr = model.data;
        if (tempArr.count > 0) {
            for (int i = 0; i < tempArr.count; i++) {
                   id smodel = tempArr[i];
                   if ([smodel isKindOfClass:[ZBaseMultiseriateCellModel class]]) {
                       cellHeight += [ZMultiseriateContentLeftLineCell z_getCellHeight:smodel];
                   }
               }
            return cellHeight;
        }else{
            return model.cellHeight;
        }
    }else{
        return model.cellHeight;
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
    
    _rightTitleLabel.text = model.rightTitle;
    _rightTitleLabel.textColor = adaptAndDarkColor(model.rightColor, model.rightDarkColor);
    _rightTitleLabel.font = model.rightFont;
    
    
    _inputTextField.font = model.textFont;
    _inputTextField.textColor = adaptAndDarkColor(model.textColor, model.textDarkColor);
    _inputTextField.placeholder = model.placeholder;
    _inputTextField.text = model.content;
    _inputTextField.textAlignment = model.textAlignment;
    _inputTextField.enabled = model.isTextEnabled;
    
    _bottomLineView.hidden = model.isHiddenLine;
    _inputLine.hidden = model.isHiddenInputLine;
    
    [self.topView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).offset(CGFloatIn750(0));
        make.right.equalTo(self.contentView.mas_right).offset(-CGFloatIn750(0));
        make.top.equalTo(self.contentView);
        make.height.mas_equalTo(model.cellHeight);
    }];
    
    [self.bottomLineView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.contentView);
        make.height.mas_equalTo(0.5);
        make.left.equalTo(self.contentView.mas_left).offset(model.lineLeftMargin);
        make.right.equalTo(self.contentView.mas_right).offset(-model.lineRightMargin);
    }];
    
    if (model.leftContentWidth > 0) {
        [self.leftTitleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.topView.mas_centerY);
            make.left.equalTo(self.contentView.mas_left).offset(model.leftMargin);
            make.width.mas_equalTo(model.leftContentWidth);
        }];
    }else{
        CGSize titleSize = [model.leftTitle tt_sizeWithFont:model.leftFont];
        [self.leftTitleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.topView.mas_centerY);
            make.left.equalTo(self.contentView.mas_left).offset(model.leftMargin);
            make.width.mas_equalTo(titleSize.width + 2);
        }];
    }
    
    
    if (model.rightImage && model.rightImage.length > 0) {
        self.rightImageView.image = [UIImage imageNamed:model.rightImage];
        self.rightImageView.hidden = NO;
        
        [self.rightImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.topView.mas_centerY);
            make.right.equalTo(self.contentView.mas_right).offset(-model.rightMargin);
            make.width.mas_equalTo(model.rightImageWidth);
        }];
        
        if (model.subTitle && model.subTitle.length > 0) {
            self.subTitleLabel.hidden = NO;
            
            CGSize titleSize = [model.subTitle tt_sizeWithFont:model.textFont];
            [self.subTitleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(self.topView.mas_centerY);
                make.left.equalTo(self.leftTitleLabel.mas_right).offset(model.contentSpace);
                make.width.mas_equalTo(titleSize.width + 2);
            }];
            
            
            if (model.rightTitle && model.rightTitle.length > 0) {
                self.rightTitleLabel.hidden = NO;
                
                CGSize rightTitleSize = [model.rightTitle tt_sizeWithFont:model.rightFont];
                [self.rightTitleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
                    make.centerY.equalTo(self.topView.mas_centerY);
                    make.right.equalTo(self.rightImageView.mas_left).offset(-model.contentSpace);
                    make.width.mas_equalTo(rightTitleSize.width + 2);
                }];
                
                [self.inputTextField mas_remakeConstraints:^(MASConstraintMaker *make) {
                    make.left.equalTo(self.subTitleLabel.mas_right).offset(model.contentSpace);
                    make.height.mas_equalTo(model.textFieldHeight);
                    make.right.equalTo(self.rightTitleLabel.mas_left).offset(-model.contentSpace);
                    make.centerY.equalTo(self.subTitleLabel.mas_centerY);
                }];
            }else{
                self.rightTitleLabel.hidden = YES;
                [self.inputTextField mas_remakeConstraints:^(MASConstraintMaker *make) {
                    make.left.equalTo(self.subTitleLabel.mas_right).offset(model.contentSpace);
                    make.height.mas_equalTo(model.textFieldHeight);
                    make.right.equalTo(self.rightImageView.mas_left).offset(-model.contentSpace);
                    make.centerY.equalTo(self.subTitleLabel.mas_centerY);
                }];
            }
        }else{
            self.subTitleLabel.hidden = YES;
            
            if (model.rightTitle && model.rightTitle.length > 0) {
                self.rightTitleLabel.hidden = NO;
                
                CGSize rightTitleSize = [model.rightTitle tt_sizeWithFont:model.rightFont];
                [self.rightTitleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
                    make.centerY.equalTo(self.topView.mas_centerY);
                    make.right.equalTo(self.rightImageView.mas_left).offset(-model.contentSpace);
                    make.width.mas_equalTo(rightTitleSize.width + 2);
                }];
                
                [self.inputTextField mas_remakeConstraints:^(MASConstraintMaker *make) {
                    make.left.equalTo(self.leftTitleLabel.mas_right).offset(model.contentSpace);
                    make.height.mas_equalTo(model.textFieldHeight);
                    make.right.equalTo(self.rightTitleLabel.mas_left).offset(-model.contentSpace);
                    make.centerY.equalTo(self.subTitleLabel.mas_centerY);
                }];
            }else{
                self.rightTitleLabel.hidden = YES;
                [self.inputTextField mas_remakeConstraints:^(MASConstraintMaker *make) {
                    make.left.equalTo(self.leftTitleLabel.mas_right).offset(model.contentSpace);
                    make.height.mas_equalTo(model.textFieldHeight);
                    make.right.equalTo(self.rightImageView.mas_left).offset(-model.contentSpace);
                    make.centerY.equalTo(self.subTitleLabel.mas_centerY);
                }];
            }
        }
    }else{
        self.rightImageView.hidden = YES;
        
        if (model.subTitle  && model.subTitle.length > 0) {
            self.subTitleLabel.hidden = NO;
            CGSize titleSize = [model.subTitle tt_sizeWithFont:model.textFont];
            [self.subTitleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(self.topView.mas_centerY);
                make.left.equalTo(self.leftTitleLabel.mas_right).offset(model.contentSpace);
                make.width.mas_equalTo(titleSize.width + 2);
            }];
            
            if (model.rightTitle && model.rightTitle.length > 0) {
                self.rightTitleLabel.hidden = NO;
                
                CGSize rightTitleSize = [model.rightTitle tt_sizeWithFont:model.rightFont];
                [self.rightTitleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
                    make.centerY.equalTo(self.topView.mas_centerY);
                    make.right.equalTo(self.contentView.mas_right).offset(-model.rightMargin);
                    make.width.mas_equalTo(rightTitleSize.width + 2);
                }];
                [self.inputTextField mas_remakeConstraints:^(MASConstraintMaker *make) {
                    make.left.equalTo(self.subTitleLabel.mas_right).offset(model.contentSpace);
                    make.height.mas_equalTo(model.textFieldHeight);
                    make.right.equalTo(self.rightTitleLabel.mas_left).offset(-model.contentSpace);
                    make.centerY.equalTo(self.subTitleLabel.mas_centerY);
                }];
            }else{
                self.rightTitleLabel.hidden = YES;
                [self.inputTextField mas_remakeConstraints:^(MASConstraintMaker *make) {
                    make.left.equalTo(self.subTitleLabel.mas_right).offset(model.contentSpace);
                    make.height.mas_equalTo(model.textFieldHeight);
                    make.right.equalTo(self.contentView.mas_right).offset(-model.rightMargin);
                    make.centerY.equalTo(self.subTitleLabel.mas_centerY);
                }];
            }
            
        }else{
            self.subTitleLabel.hidden = YES;
            
            if (model.rightTitle && model.rightTitle.length > 0) {
               self.rightTitleLabel.hidden = NO;
               
               CGSize rightTitleSize = [model.rightTitle tt_sizeWithFont:model.rightFont];
               [self.rightTitleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
                   make.centerY.equalTo(self.topView.mas_centerY);
                   make.right.equalTo(self.contentView.mas_right).offset(-model.rightMargin);
                   make.width.mas_equalTo(rightTitleSize.width + 2);
               }];
               [self.inputTextField mas_remakeConstraints:^(MASConstraintMaker *make) {
                   make.left.equalTo(self.leftTitleLabel.mas_right).offset(model.contentSpace);
                   make.height.mas_equalTo(model.textFieldHeight);
                   make.right.equalTo(self.rightTitleLabel.mas_left).offset(-model.contentSpace);
                   make.centerY.equalTo(self.subTitleLabel.mas_centerY);
               }];
           }else{
               self.rightTitleLabel.hidden = YES;
               [self.inputTextField mas_remakeConstraints:^(MASConstraintMaker *make) {
                   make.left.equalTo(self.leftTitleLabel.mas_right).offset(model.contentSpace);
                   make.height.mas_equalTo(model.textFieldHeight);
                   make.right.equalTo(self.contentView.mas_right).offset(-model.rightMargin);
                   make.centerY.equalTo(self.subTitleLabel.mas_centerY);
               }];
           }
        }
    }
    
    if (model.subTitle && model.subTitle.length > 0) {
        if (model.rightImage && model.rightImage.length > 0) {
            [self.multColView mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.subTitleLabel.mas_right).offset(model.contentSpace);
                make.right.equalTo(self.rightImageView.mas_left).offset(-model.contentSpace);
                make.top.equalTo(self.leftTitleLabel.mas_top);
                make.bottom.equalTo(self.mas_bottom).offset(-(model.cellHeight - model.leftFont.lineHeight)/2.0f);
            }];
        }else{
            [self.multColView mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.subTitleLabel.mas_right).offset(model.contentSpace);
                make.right.equalTo(self.mas_right).offset(-model.rightMargin);
                make.top.equalTo(self.leftTitleLabel.mas_top);
                make.bottom.equalTo(self.mas_bottom).offset(-(model.cellHeight - model.leftFont.lineHeight)/2.0f);
            }];
        }
    }else {
        if(model.leftTitle && model.leftTitle.length > 0){
            if (model.rightImage && model.rightImage.length > 0) {
                [self.multColView mas_remakeConstraints:^(MASConstraintMaker *make) {
                    make.left.equalTo(self.leftTitleLabel.mas_right).offset(model.contentSpace);
                    make.right.equalTo(self.rightImageView.mas_left).offset(-model.contentSpace);
                    make.top.equalTo(self.leftTitleLabel.mas_top);
                    make.bottom.equalTo(self.mas_bottom).offset(-(model.cellHeight - model.leftFont.lineHeight)/2.0f);
                }];
            }else{
                [self.multColView mas_remakeConstraints:^(MASConstraintMaker *make) {
                    make.left.equalTo(self.leftTitleLabel.mas_right).offset(model.contentSpace);
                    make.right.equalTo(self.mas_right).offset(-model.rightMargin);
                    make.top.equalTo(self.leftTitleLabel.mas_top);
                    make.bottom.equalTo(self.mas_bottom).offset(-(model.cellHeight - model.leftFont.lineHeight)/2.0f);
                }];
            }
        }else{
            if (model.rightImage && model.rightImage.length > 0) {
                [self.multColView mas_remakeConstraints:^(MASConstraintMaker *make) {
                    make.left.equalTo(self.contentView.mas_left).offset(model.leftMargin);
                    make.right.equalTo(self.rightImageView.mas_left).offset(-model.contentSpace);
                    make.top.equalTo(self.leftTitleLabel.mas_top);
                    make.bottom.equalTo(self.mas_bottom).offset(-(model.cellHeight - model.leftFont.lineHeight)/2.0f);
                }];
            }else{
                [self.multColView mas_remakeConstraints:^(MASConstraintMaker *make) {
                    make.left.equalTo(self.contentView.mas_left).offset(model.leftMargin);
                    make.right.equalTo(self.mas_right).offset(-model.rightMargin);
                    make.top.equalTo(self.leftTitleLabel.mas_top);
                    make.bottom.equalTo(self.mas_bottom).offset(-(model.cellHeight - model.leftFont.lineHeight)/2.0f);
                }];
            }
        }
    }
    
    if (model.data && [model.data isKindOfClass:[NSArray class]]) {
        self.multColView.hidden = NO;
        
        [self initCellConfigArr];
        [self.iTableView reloadData];
    }else{
        self.multColView.hidden = YES;
    }
//    if (_model.rightImage && [_model.rightImage isEqualToString:@"rightBlackArrowN"]) {
//        self.rightImageView.image = isDarkModel() ? [UIImage imageNamed:@"rightBlackArrowDarkN"] :  [UIImage imageNamed:@"rightBlackArrowN"];
//    }
    [self bringSubviewToFront:self.selectBtn];
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


- (void)initCellConfigArr {
    [_cellConfigArr removeAllObjects];

    if (self.model.data && [self.model.data isKindOfClass:[NSArray class]]) {
        NSArray *tempArr = self.model.data;
        for (int i = 0; i < tempArr.count; i++) {
            id model = tempArr[i];
            if ([model isKindOfClass:[ZBaseMultiseriateCellModel class]]) {
                ZBaseMultiseriateCellModel *sModel = model;
                ZCellConfig *menuCellConfig = [ZCellConfig cellConfigWithClassName:[ZMultiseriateContentLeftLineCell className] title:sModel.cellTitle showInfoMethod:@selector(setMModel:) heightOfCell:[ZMultiseriateContentLeftLineCell z_getCellHeight:sModel] cellType:ZCellTypeClass dataModel:sModel];
                
                [self.cellConfigArr addObject:menuCellConfig];
            }
        }
    }
}


- (void)traitCollectionDidChange:(UITraitCollection *)previousTraitCollection {
//    if (self.model.rightImage && [self.model.rightImage isEqualToString:@"rightBlackArrowN"]) {
//        self.rightImageView.image = isDarkModel() ? [UIImage imageNamed:@"rightBlackArrowDarkN"] :  [UIImage imageNamed:@"rightBlackArrowN"];
//    }
}
@end



