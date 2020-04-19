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
@property (nonatomic,strong) UIButton *userBtn;
@property (nonatomic,strong) UIView *delView;
@property (nonatomic,strong) UIButton *delBtn;

@property (nonatomic,strong) UIButton *selectedBtn;
@property (nonatomic,strong) UIImageView *rightImageView;

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
    [self.contentView addSubview:self.userBtn];
    
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
    
    [self.userBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self);
        make.top.bottom.equalTo(self);
        make.width.mas_equalTo(KScreenWidth/3.0f);
    }];
    
    
    [self.seeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.numLabel.mas_right);
        make.height.mas_equalTo(CGFloatIn750(56));
        make.width.mas_equalTo(CGFloatIn750(142));
        make.centerY.equalTo(self.mas_centerY);
    }];
    
    [self.delView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right);
        make.top.bottom.equalTo(self);
        make.width.equalTo(self.mas_width).multipliedBy(1/4.0);
    }];
    
    [self.delView addSubview:self.delBtn];
    [self.delBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.delView.mas_centerY);
        make.centerX.equalTo(self.delView.mas_centerX).offset(CGFloatIn750(8));
        make.height.mas_equalTo(CGFloatIn750(56));
        make.width.mas_equalTo(CGFloatIn750(142));
    }];
    
    [self.contentView addSubview:self.selectedBtn];
    [self.selectedBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.right.equalTo(self.contentView);
        make.width.mas_equalTo(CGFloatIn750(142));
    }];

}


#pragma mark - Getter

- (UIImageView *)rightImageView {
    if (!_rightImageView) {
        _rightImageView = [[UIImageView alloc] init];
        _rightImageView.contentMode = UIViewContentModeCenter;
    }
    return _rightImageView;
}

- (UILabel *)nameLabel {
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _nameLabel.textColor = adaptAndDarkColor([UIColor colorTextGray],[UIColor colorTextGrayDark]);
        
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


- (UIButton *)userBtn {
    if (!_userBtn) {
        __weak typeof(self) weakSelf = self;
        _userBtn = [[UIButton alloc] initWithFrame:CGRectZero];
        [_userBtn bk_whenTapped:^{
            if (weakSelf.handleBlock) {
                weakSelf.handleBlock(2,weakSelf.model);
            };
        }];
    }
    return _userBtn;
}

- (UIButton *)seeBtn {
    if (!_seeBtn) {
        __weak typeof(self) weakSelf = self;
        _seeBtn = [[UIButton alloc] initWithFrame:CGRectZero];
        [_seeBtn setTitle:@"签课详情" forState:UIControlStateNormal];
        [_seeBtn setTitleColor:adaptAndDarkColor([UIColor colorMain], [UIColor colorMainDark]) forState:UIControlStateNormal];
        ViewBorderRadius(_seeBtn, CGFloatIn750(28), 1, adaptAndDarkColor([UIColor colorMain], [UIColor colorMainDark]));
        [_seeBtn.titleLabel setFont:[UIFont fontSmall]];
        [_seeBtn bk_whenTapped:^{
            if (weakSelf.handleBlock) {
                weakSelf.handleBlock(0,weakSelf.model);
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
                weakSelf.handleBlock(1,weakSelf.model);
            };
        }];
    }
    return _delBtn;
}


- (UIButton *)selectedBtn {
    if (!_selectedBtn) {
        __weak typeof(self) weakSelf = self;
        _selectedBtn = [[UIButton alloc] initWithFrame:CGRectZero];
        [_selectedBtn addSubview:self.rightImageView];
        [self.rightImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self.selectedBtn);
        }];
        [_selectedBtn bk_whenTapped:^{
            self.model.isSelected = !self.model.isSelected;
            self.rightImageView.image = self.model.isSelected ? [UIImage imageNamed:@"selectedCycle"] : [UIImage imageNamed:@"unSelectedCycle"];
            if (weakSelf.handleBlock) {
                weakSelf.handleBlock(10,self.model);
            };
        }];
    }
    return _selectedBtn;
}





+(CGFloat)z_getCellHeight:(id)sender {
    return CGFloatIn750(140);
}

- (void)traitCollectionDidChange:(UITraitCollection *)previousTraitCollection {
    ViewBorderRadius(_delBtn, CGFloatIn750(28), CGFloatIn750(2), adaptAndDarkColor([UIColor colorTextGray], [UIColor colorTextGrayDark]));
}

- (void)setModel:(ZOriganizationStudentListModel *)model {
    _model = model;
    _nameLabel.text = model.name;
    _numLabel.text = [NSString stringWithFormat:@"%@/%@",model.now_progress,model.total_progress];
    
    if (model.isEdit) {
        _selectedBtn.hidden = NO;
        _rightImageView.image = model.isSelected ? [UIImage imageNamed:@"selectedCycle"] : [UIImage imageNamed:@"unSelectedCycle"];
    }else{
        
        _selectedBtn.hidden = YES;
        _rightImageView.image =  [UIImage imageNamed:@"unSelectedCycleMin"];
    }
}

- (void)setIsEnd:(BOOL)isEnd {
    _isEnd = isEnd;
    if (isEnd) {
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
        
        [self.userBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self);
            make.top.bottom.equalTo(self);
            make.width.mas_equalTo(KScreenWidth/3.0f);
        }];
        
        
        [self.seeBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.numLabel.mas_right);
            make.centerY.equalTo(self.mas_centerY);
            make.height.mas_equalTo(CGFloatIn750(56));
            make.width.mas_equalTo(CGFloatIn750(142));
        }];
        if (self.model.isEdit) {
            self.seeBtn.hidden = YES;
        }else{
            self.seeBtn.hidden = NO;
        }
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
        
        [self.userBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self);
            make.top.bottom.equalTo(self);
            make.width.mas_equalTo(KScreenWidth/4.0f);
        }];
        
        [self.seeBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.numLabel.mas_right);
            make.centerY.equalTo(self.mas_centerY);
            make.height.mas_equalTo(CGFloatIn750(56));
            make.width.mas_equalTo(CGFloatIn750(142));
        }];
        
        [self.delView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.mas_right);
            make.width.equalTo(self.mas_width).multipliedBy(1/4.0);
            make.top.bottom.equalTo(self);
        }];
        if (self.model.isEdit) {
            self.delView.hidden = YES;
        }else{
            self.delView.hidden = NO;
        }
    }
}
@end
