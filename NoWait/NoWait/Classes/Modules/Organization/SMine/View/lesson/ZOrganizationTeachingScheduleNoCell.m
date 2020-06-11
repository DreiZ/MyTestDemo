//
//  ZOrganizationTeachingScheduleNoCell.m
//  NoWait
//
//  Created by zhuang zhang on 2020/2/25.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZOrganizationTeachingScheduleNoCell.h"

@interface ZOrganizationTeachingScheduleNoCell ()

@property (nonatomic,strong) UILabel *nameLabel;
@property (nonatomic,strong) UILabel *detailLabel;
@property (nonatomic,strong) UIImageView *userImageView;
@property (nonatomic,strong) UIImageView *studentImageView;
//@property (nonatomic,strong) UILabel *timeLabel;
@property (nonatomic,strong) UILabel *numLabel;
@property (nonatomic,strong) UILabel *userLabel;

@property (nonatomic,strong) UIView *contView;
@property (nonatomic,strong) UIButton *editBtn;

@end

@implementation ZOrganizationTeachingScheduleNoCell

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
    [self.contView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(CGFloatIn750(30));
        make.right.equalTo(self.mas_right).offset(-CGFloatIn750(30));
        make.top.equalTo(self.mas_top).offset(CGFloatIn750(20));
        make.bottom.equalTo(self.mas_bottom).offset(CGFloatIn750(0));
    }];
    
    [self.contView addSubview:self.editBtn];
    [self.editBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.bottom.equalTo(self.contView);
        make.width.mas_equalTo(CGFloatIn750(86));
    }];
    
    UIView *topView = [[UIView alloc] initWithFrame:CGRectZero];
    [self.contView addSubview:topView];
    [topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.equalTo(self.contView);
        make.right.equalTo(self.editBtn.mas_left);
    }];
    
    
    [topView addSubview:self.studentImageView];
    [topView addSubview:self.userImageView];
    [topView addSubview:self.detailLabel];
    [topView addSubview:self.userLabel];
    [topView addSubview:self.nameLabel];
    [topView addSubview:self.numLabel];
    
    [self.studentImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(topView.mas_left).offset(CGFloatIn750(30));
        make.top.equalTo(topView.mas_top).offset(CGFloatIn750(40));
        make.width.height.mas_equalTo(CGFloatIn750(88));
    }];
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.studentImageView.mas_right).offset(CGFloatIn750(18));
        make.top.equalTo(topView.mas_top).offset(CGFloatIn750(40));
        make.right.equalTo(topView.mas_centerX).offset(CGFloatIn750(100));
    }];


    [self.detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.nameLabel.mas_left);
        make.bottom.equalTo(topView.mas_bottom).offset(-CGFloatIn750(50));
        make.right.equalTo(self.nameLabel.mas_right);
    }];
    
    
//    [topView addSubview:self.timeLabel];
//    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self.detailLabel.mas_left);
//        make.bottom.equalTo(topView.mas_bottom).offset(-CGFloatIn750(50));
//    }];
    
    [self.numLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(topView.mas_right).offset(-CGFloatIn750(30));
        make.centerY.equalTo(self.nameLabel.mas_centerY);
    }];
    
    [self.userLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.numLabel.mas_right);
        make.centerY.equalTo(self.detailLabel.mas_centerY);
    }];

    [self.userImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.userLabel.mas_left).offset(-CGFloatIn750(10));
        make.centerY.equalTo(self.userLabel.mas_centerY);
        make.width.height.mas_equalTo(CGFloatIn750(44));
    }];
}


#pragma mark - Getter
- (UIView *)contView {
    if (!_contView) {
        _contView = [[UIView alloc] init];
        _contView.backgroundColor = adaptAndDarkColor([UIColor colorWhite], [UIColor colorBlackBGDark]);
        ViewRadius(_contView, CGFloatIn750(12));
    }
    return _contView;
}

- (UILabel *)nameLabel {
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _nameLabel.textColor = adaptAndDarkColor([UIColor colorTextBlack],[UIColor colorTextBlackDark]);
        _nameLabel.text = @"";
        _nameLabel.numberOfLines = 1;
        _nameLabel.textAlignment = NSTextAlignmentLeft;
        [_nameLabel setFont:[UIFont boldFontTitle]];
    }
    return _nameLabel;
}


- (UILabel *)detailLabel {
    if (!_detailLabel) {
        _detailLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _detailLabel.textColor = adaptAndDarkColor([UIColor colorTextGray],[UIColor colorTextGrayDark]);
        _detailLabel.text = @"";
        _detailLabel.numberOfLines = 1;
        _detailLabel.textAlignment = NSTextAlignmentLeft;
        [_detailLabel setFont:[UIFont fontSmall]];
    }
    return _detailLabel;
}

- (UIImageView *)userImageView {
    if (!_userImageView) {
        _userImageView = [[UIImageView alloc] init];
        ViewRadius(_userImageView, CGFloatIn750(22));
    }
    return _userImageView;
}

- (UIImageView *)studentImageView {
    if (!_studentImageView) {
        _studentImageView = [[UIImageView alloc] init];
        ViewRadius(_studentImageView, CGFloatIn750(44));
    }
    return _studentImageView;
}

- (UILabel *)userLabel {
    if (!_userLabel) {
        _userLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _userLabel.textColor = adaptAndDarkColor([UIColor colorTextBlack],[UIColor colorTextBlackDark]);
        _userLabel.text = @"";
        _userLabel.numberOfLines = 1;
        _userLabel.textAlignment = NSTextAlignmentRight;
        [_userLabel setFont:[UIFont fontSmall]];
    }
    return _userLabel;
}


- (UILabel *)numLabel {
    if (!_numLabel) {
        _numLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _numLabel.textColor = adaptAndDarkColor([UIColor colorTextBlack],[UIColor colorTextBlackDark]);
        _numLabel.text = @"";
        _numLabel.numberOfLines = 1;
        _numLabel.textAlignment = NSTextAlignmentRight;
        [_numLabel setFont:[UIFont fontSmall]];
    }
    return _numLabel;
}

//
//- (UILabel *)timeLabel {
//    if (!_timeLabel) {
//        _timeLabel = [[UILabel alloc] initWithFrame:CGRectZero];
//        _timeLabel.textColor = adaptAndDarkColor([UIColor colorTextGray],[UIColor colorTextGrayDark]);
//        _timeLabel.text = @"有效期至2020 02.30";
//        _timeLabel.numberOfLines = 1;
//        _timeLabel.textAlignment = NSTextAlignmentLeft;
//        [_timeLabel setFont:[UIFont fontSmall]];
//    }
//    return _timeLabel;
//}


- (UIButton *)editBtn {
    if (!_editBtn) {
        __weak typeof(self) weakSelf = self;
        _editBtn = [[ZButton alloc] initWithFrame:CGRectZero];
        [_editBtn setImage:[UIImage imageNamed:@"unSelectedCycle"] forState:UIControlStateNormal];
        ViewRadius(_editBtn, CGFloatIn750(22));
        [_editBtn bk_addEventHandler:^(id sender) {
            if (weakSelf.handleBlock) {
                if (weakSelf.model.isSelected) {
                    weakSelf.model.isSelected = !weakSelf.model.isSelected;
                    if (weakSelf.model.isSelected) {
                        [weakSelf.editBtn setImage:[UIImage imageNamed:@"selectedCycle"] forState:UIControlStateNormal];
                    }else{
                        [weakSelf.editBtn setImage:[UIImage imageNamed:@"unSelectedCycle"] forState:UIControlStateNormal];
                    }
                    
                    weakSelf.handleBlock(0);
                }else{
                    weakSelf.model.isSelected = !weakSelf.model.isSelected;
                    if (weakSelf.model.isSelected) {
                        [weakSelf.editBtn setImage:[UIImage imageNamed:@"selectedCycle"] forState:UIControlStateNormal];
                    }else{
                        [weakSelf.editBtn setImage:[UIImage imageNamed:@"unSelectedCycle"] forState:UIControlStateNormal];
                    }
                    weakSelf.handleBlock(0);
                }
            }
        } forControlEvents:UIControlEventTouchUpInside];
        
//
//        [_editBtn bk_addEventHandler:^(id sender) {
//            if (weakSelf.handleBlock) {
//                if (weakSelf.model.isSelected) {
//                    weakSelf.model.isSelected = !weakSelf.model.isSelected;
//                    if (weakSelf.model.isSelected) {
//                        [weakSelf.editBtn setImage:[UIImage imageNamed:@"selectedCycle"] forState:UIControlStateNormal];
//                    }else{
//                        [weakSelf.editBtn setImage:[UIImage imageNamed:@"unSelectedCycle"] forState:UIControlStateNormal];
//                    }
//
//                    weakSelf.handleBlock(0);
//                }else{
//                    if (weakSelf.handleBlock(0)) {
//                        weakSelf.model.isSelected = !weakSelf.model.isSelected;
//                        if (weakSelf.model.isSelected) {
//                            [weakSelf.editBtn setImage:[UIImage imageNamed:@"selectedCycle"] forState:UIControlStateNormal];
//                        }else{
//                            [weakSelf.editBtn setImage:[UIImage imageNamed:@"unSelectedCycle"] forState:UIControlStateNormal];
//                        }
//                    }
//                }
//            }
//        } forControlEvents:UIControlEventTouchUpInside];
    }
    return _editBtn;
}

- (void)setModel:(ZOriganizationStudentListModel *)model {
    _model = model;
    
    _nameLabel.text = model.name;
    _detailLabel.text = model.courses_name;
    [_studentImageView tt_setImageWithURL:[NSURL URLWithString:imageFullUrl(model.student_image)] placeholderImage:[UIImage imageNamed:@"default_head"]];
    [_userImageView tt_setImageWithURL:[NSURL URLWithString:imageFullUrl(model.teacher_image)]];
    //@property (nonatomic,strong) UILabel *timeLabel;
    _numLabel.text = [NSString stringWithFormat:@"%@/%@节",ValidStr(model.now_progress)?SafeStr(model.now_progress):@"0",model.total_progress];
    _userLabel.text = model.teacher_name;
    if (model.isEdit) {
        [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            [self.editBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.top.right.bottom.equalTo(self.contView);
                make.width.mas_equalTo(CGFloatIn750(86));
            }];
            [self layoutIfNeeded];
        } completion:^(BOOL finished) {
            
        }];
        
        if (model.isSelected) {
            [self.editBtn setImage:[UIImage imageNamed:@"selectedCycle"] forState:UIControlStateNormal];
        }else{
            [self.editBtn setImage:[UIImage imageNamed:@"unSelectedCycle"] forState:UIControlStateNormal];
        }
    }else{
        [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            [self.editBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.top.bottom.equalTo(self.contView);
                make.left.equalTo(self.contView.mas_right);
                make.width.mas_equalTo(CGFloatIn750(86));
            }];
            [self layoutIfNeeded];
        } completion:^(BOOL finished) {
            
        }];
    }
}

+(CGFloat)z_getCellHeight:(id)sender {
    return CGFloatIn750(204);
}

- (void)traitCollectionDidChange:(UITraitCollection *)previousTraitCollection {
    
}
@end




