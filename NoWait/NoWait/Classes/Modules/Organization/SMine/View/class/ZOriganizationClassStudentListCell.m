//
//  ZOriganizationClassStudentListCell.m
//  NoWait
//
//  Created by zhuang zhang on 2020/2/26.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZOriganizationClassStudentListCell.h"

@interface ZOriganizationClassStudentListCell ()

@property (nonatomic,strong) UILabel *nameLabel;
@property (nonatomic,strong) UILabel *numLabel;


@property (nonatomic,strong) UIButton *seeBtn;
@property (nonatomic,strong) UIView *delView;
@property (nonatomic,strong) UIButton *delBtn;
@end

@implementation ZOriganizationClassStudentListCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupView];
    }
    return self;
}

-(void)setupView {
    [super setupView];
    
    UIView *bottomLineView = [[UIView alloc] initWithFrame:CGRectZero];
    bottomLineView.backgroundColor = adaptAndDarkColor([UIColor colorGrayLine], [UIColor colorGrayLine]);
    [self.contentView addSubview:bottomLineView];
    [bottomLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self);
        make.height.mas_equalTo(0.5);
    }];
    

    [self.contentView addSubview:self.nameLabel];
    [self.contentView addSubview:self.numLabel];
    
    [self.contentView addSubview:self.seeBtn];
    [self.contentView addSubview:self.delView];

    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left);
        make.width.equalTo(self.mas_width).multipliedBy(1/4.0);
        make.centerY.equalTo(self.mas_centerY);
    }];
    
    [self.numLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.nameLabel.mas_right);
        make.width.equalTo(self.mas_width).multipliedBy(1/4.0);
        make.centerY.equalTo(self.mas_centerY);
    }];
    
    
    [self.seeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.numLabel.mas_right);
        make.width.equalTo(self.mas_width).multipliedBy(1/4.0);
        make.centerY.equalTo(self.mas_centerY);
    }];
    
    [self.delView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.seeBtn.mas_right);
        make.top.bottom.equalTo(self);
        make.width.equalTo(self.mas_width).multipliedBy(1/4.0);
    }];
    
    [self.delView addSubview:self.delBtn];
    [self.delBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.delView.mas_centerY);
        make.centerX.equalTo(self.delView.mas_centerX).offset(-CGFloatIn750(8));
        make.height.mas_equalTo(CGFloatIn750(56));
        make.width.mas_equalTo(CGFloatIn750(162));
    }];
}


#pragma mark - Getter
- (UILabel *)nameLabel {
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _nameLabel.textColor = adaptAndDarkColor([UIColor colorTextGray],[UIColor colorTextGrayDark]);
        _nameLabel.text = @"网三局";
        _nameLabel.numberOfLines = 1;
        _nameLabel.textAlignment = NSTextAlignmentCenter;
        [_nameLabel setFont:[UIFont fontContent]];
    }
    return _nameLabel;
}


- (UILabel *)numLabel {
    if (!_numLabel) {
        _numLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _numLabel.textColor = adaptAndDarkColor([UIColor colorTextGray],[UIColor colorTextGrayDark]);
        _numLabel.text = @"2/10";
        _numLabel.numberOfLines = 1;
        _numLabel.textAlignment = NSTextAlignmentCenter;
        [_numLabel setFont:[UIFont fontContent]];
    }
    return _numLabel;
}

- (UIView *)delView {
    if (!_delView) {
        _delView = [[UIView alloc] init];
    }
    return _delView;
}

- (UIButton *)seeBtn {
    if (!_seeBtn) {
        __weak typeof(self) weakSelf = self;
        _seeBtn = [[UIButton alloc] initWithFrame:CGRectZero];
        [_seeBtn setTitle:@"查看" forState:UIControlStateNormal];
        [_seeBtn setTitleColor:adaptAndDarkColor([UIColor colorMain], [UIColor colorMain]) forState:UIControlStateNormal];
        [_seeBtn.titleLabel setFont:[UIFont fontContent]];
        [_seeBtn bk_whenTapped:^{
            if (weakSelf.handleBlock) {
                weakSelf.handleBlock(0);
            };
        }];
    }
    return _seeBtn;
}

- (UIButton *)delBtn {
    if (!_delBtn) {
        __weak typeof(self) weakSelf = self;
        _delBtn = [[UIButton alloc] initWithFrame:CGRectZero];
        [_delBtn setTitle:@"移除班级" forState:UIControlStateNormal];
        [_delBtn setTitleColor:adaptAndDarkColor([UIColor colorTextGray], [UIColor colorTextGrayDark]) forState:UIControlStateNormal];
        [_delBtn.titleLabel setFont:[UIFont fontSmall]];
        ViewBorderRadius(_delBtn, CGFloatIn750(28), CGFloatIn750(2), adaptAndDarkColor([UIColor colorTextGray], [UIColor colorTextGrayDark]));
        [_delBtn bk_whenTapped:^{
            if (weakSelf.handleBlock) {
                weakSelf.handleBlock(1);
            };
        }];
    }
    return _delBtn;
}



+(CGFloat)z_getCellHeight:(id)sender {
    return CGFloatIn750(140);
}

- (void)traitCollectionDidChange:(UITraitCollection *)previousTraitCollection {
    ViewBorderRadius(_delBtn, CGFloatIn750(28), CGFloatIn750(2), adaptAndDarkColor([UIColor colorTextGray], [UIColor colorTextGrayDark]));
}

- (void)setModel:(ZBaseCellModel *)model {
    if (model.data) {
        self.isOpen = YES;
    }else{
        self.isOpen = NO;
    }
}

- (void)setIsOpen:(BOOL)isOpen {
    _isOpen = isOpen;
    if (isOpen) {
        [self.nameLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView.mas_left);
            make.width.equalTo(self.mas_width).multipliedBy(1/3.0);
            make.centerY.equalTo(self.mas_centerY);
        }];
        
        [self.numLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.nameLabel.mas_right);
            make.width.equalTo(self.mas_width).multipliedBy(1/3.0);
            make.centerY.equalTo(self.mas_centerY);
        }];
        
        
        [self.seeBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.numLabel.mas_right);
            make.width.equalTo(self.mas_width).multipliedBy(1/3.0);
            make.top.bottom.equalTo(self);
        }];
    }else{
        [self.nameLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView.mas_left);
            make.width.equalTo(self.mas_width).multipliedBy(1/4.0);
            make.centerY.equalTo(self.mas_centerY);
        }];
        
        [self.numLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.nameLabel.mas_right);
            make.width.equalTo(self.mas_width).multipliedBy(1/4.0);
            make.centerY.equalTo(self.mas_centerY);
        }];
        
        
        [self.seeBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.numLabel.mas_right);
            make.width.equalTo(self.mas_width).multipliedBy(1/4.0);
            make.top.bottom.equalTo(self);
        }];
        
        [self.delView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.seeBtn.mas_right);
            make.width.equalTo(self.mas_width).multipliedBy(1/4.0);
            make.top.bottom.equalTo(self);
        }];
    }
}
@end
