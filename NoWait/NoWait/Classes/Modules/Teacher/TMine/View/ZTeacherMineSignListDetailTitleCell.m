//
//  ZTeacherMineSignListDetailTitleCell.m
//  NoWait
//
//  Created by zhuang zhang on 2020/4/13.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZTeacherMineSignListDetailTitleCell.h"

@interface ZTeacherMineSignListDetailTitleCell ()
@property (nonatomic,strong) UIImageView *stateImageView;

@property (nonatomic,strong) UILabel *zhuanPriceLabel;
@property (nonatomic,strong) UILabel *leftTitleLabel;
@property (nonatomic,strong) UIButton *editBtn;

@end

@implementation ZTeacherMineSignListDetailTitleCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupView];
    }
    return self;
}

-(void)setupView {
    [super setupView];
    
    self.contentView.backgroundColor = adaptAndDarkColor([UIColor colorWhite], [UIColor colorBlackBGDark]);
    
    
    [self.contentView addSubview:self.leftTitleLabel];
    [self.contentView addSubview:self.zhuanPriceLabel];
    [self.contentView addSubview:self.stateImageView];
    
    
    [self.leftTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).offset(CGFloatIn750(30));
        make.centerY.equalTo(self.contentView.mas_centerY);
    }];
    
    [self.stateImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.leftTitleLabel.mas_right).offset(CGFloatIn750(20));
        make.centerY.equalTo(self.contentView.mas_centerY);
        make.width.height.mas_equalTo(CGFloatIn750(22));
    }];
    
    [self.zhuanPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.stateImageView.mas_right).offset(CGFloatIn750(6));
        make.centerY.equalTo(self.leftTitleLabel.mas_centerY);
    }];
    
    [self.contentView addSubview:self.editBtn];
    [self.editBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right).offset(-CGFloatIn750(30));
        make.width.mas_equalTo(CGFloatIn750(140));
        make.height.mas_equalTo(CGFloatIn750(50));
        make.centerY.equalTo(self.mas_centerY);
    }];
}


#pragma mark - Getter

- (UILabel *)zhuanPriceLabel {
    if (!_zhuanPriceLabel) {
        _zhuanPriceLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _zhuanPriceLabel.textColor = adaptAndDarkColor([UIColor colorTextBlack],[UIColor colorTextBlackDark]);
        _zhuanPriceLabel.text = @"";
        _zhuanPriceLabel.numberOfLines = 1;
        _zhuanPriceLabel.textAlignment = NSTextAlignmentRight;
        [_zhuanPriceLabel setFont:[UIFont boldFontContent]];
    }
    return _zhuanPriceLabel;
}


- (UILabel *)leftTitleLabel {
    if (!_leftTitleLabel) {
        _leftTitleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _leftTitleLabel.textColor = adaptAndDarkColor([UIColor colorTextBlack],[UIColor colorTextBlackDark]);
        _leftTitleLabel.text = @"";
        _leftTitleLabel.numberOfLines = 1;
        _leftTitleLabel.textAlignment = NSTextAlignmentLeft;
        [_leftTitleLabel setFont:[UIFont boldFontContent]];
    }
    return _leftTitleLabel;
}

- (UIImageView *)stateImageView {
    if (!_stateImageView) {
        _stateImageView = [[UIImageView alloc] init];
        _stateImageView.layer.masksToBounds = YES;
        _stateImageView.tintColor = adaptAndDarkColor([UIColor colorBlack], [UIColor colorWhite]);
    }
    return _stateImageView;
}


- (UIButton *)editBtn {
    if (!_editBtn) {
        __weak typeof(self) weakSelf = self;
        _editBtn = [[UIButton alloc] initWithFrame:CGRectZero];
        [_editBtn setTitle:@"编辑" forState:UIControlStateNormal];
        [_editBtn setTitleColor:adaptAndDarkColor([UIColor colorMain], [UIColor colorMainDark]) forState:UIControlStateNormal];
        [_editBtn.titleLabel setFont:[UIFont fontContent]];
        ViewBorderRadius(_editBtn, CGFloatIn750(24), 1, [UIColor colorMain]);
        [_editBtn bk_whenTapped:^{
            if (weakSelf.handleBlock) {
                weakSelf.handleBlock(self.model.data);
            };
        }];
    }
    return _editBtn;
}


- (void)setModel:(ZBaseSingleCellModel *)model {
    _model = model;
    _leftTitleLabel.text = model.leftTitle;
    _zhuanPriceLabel.text = model.rightTitle;
    _stateImageView.image = [[UIImage imageNamed:model.leftImage]  imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];;
    
    ZOriganizationSignListModel *lModel = model.data;
    if (lModel.isOpen) {
        if ([lModel.type intValue] == 4 || [lModel.type intValue] == 5 || [lModel.type intValue] == 6 ) {
            self.editBtn.hidden = NO;
        }else{
            self.editBtn.hidden = YES;
        }
    }else{
        self.editBtn.hidden = YES;
    }
    
    
    if (lModel.isEdit) {
        [_editBtn setTitle:@"取消" forState:UIControlStateNormal];
    }else{
        [_editBtn setTitle:@"编辑" forState:UIControlStateNormal];
    }
}

+(CGFloat)z_getCellHeight:(id)sender {
    return CGFloatIn750(64);
}

@end

