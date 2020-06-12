//
//  ZOriganizationStudentListCell.m
//  NoWait
//
//  Created by zhuang zhang on 2020/2/22.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZOriganizationStudentListCell.h"

@interface ZOriganizationStudentListCell ()
@property (nonatomic,strong) UIView *contView;

@property (nonatomic,strong) UIImageView *userImageView;
@property (nonatomic,strong) UILabel *nameLabel;
@property (nonatomic,strong) UILabel *lessonLabel;
@property (nonatomic,strong) UILabel *typeLabel;
@property (nonatomic,strong) UILabel *numLabel;
@property (nonatomic,strong) UILabel *buLabel;

@property (nonatomic,strong) UIImageView *rightImageView;
@property (nonatomic,strong) UIButton *selectBtn;

@end

@implementation ZOriganizationStudentListCell

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
    [self.contView addSubview:self.userImageView];
    [self.contView addSubview:self.nameLabel];
    [self.contView addSubview:self.lessonLabel];
    [self.contView addSubview:self.typeLabel];
    [self.contView addSubview:self.numLabel];
    [self.contView addSubview:self.rightImageView];
    [self.contView addSubview:self.buLabel];
    
    [self.rightImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contView.mas_right).offset(-CGFloatIn750(20));
        make.centerY.equalTo(self.mas_centerY);
        make.height.width.mas_equalTo(CGFloatIn750(60));
    }];
    
    [self.contView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.contentView);
        make.left.equalTo(self.mas_left).offset(CGFloatIn750(0));
        make.right.equalTo(self.mas_right).offset(-CGFloatIn750(0));
    }];
    
    
    [self.numLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.lessonLabel.mas_centerY);
        make.right.equalTo(self.rightImageView.mas_left).offset(-CGFloatIn750(10));
        make.width.mas_equalTo(CGFloatIn750(140));
    }];
    
    [self.typeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.numLabel.mas_right);
        make.centerY.equalTo(self.nameLabel.mas_centerY);
        make.width.mas_equalTo(CGFloatIn750(140));
    }];
    
    [self.userImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contView.mas_left).offset(CGFloatIn750(30));
        make.centerY.equalTo(self.contView.mas_centerY);
        make.width.height.mas_equalTo(CGFloatIn750(88));
    }];
    
    
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.userImageView.mas_right).offset(CGFloatIn750(20));
        make.bottom.equalTo(self.contView.mas_centerY).offset(-CGFloatIn750(6));
        make.right.equalTo(self.typeLabel.mas_left).offset(-CGFloatIn750(0));
    }];
    
    [self.lessonLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.nameLabel.mas_left).offset(CGFloatIn750(0));
        make.top.equalTo(self.contView.mas_centerY).offset(CGFloatIn750(6));
        make.right.equalTo(self.typeLabel.mas_left);
    }];
    
    
    
    [self.buLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.numLabel.mas_right);
        make.centerY.equalTo(self.nameLabel.mas_centerY);
        make.width.mas_equalTo(CGFloatIn750(52));
        make.height.mas_equalTo(CGFloatIn750(24));
    }];
    
    [self.contView addSubview:self.selectBtn];
    [self.selectBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.contView);
        make.left.equalTo(self.contView.mas_left);
        make.width.mas_equalTo(CGFloatIn750(160));
    }];
    
    __weak typeof(self) weakSelf = self;
    UIButton *coverBtn = [[UIButton alloc] initWithFrame:CGRectZero];
    [coverBtn bk_addEventHandler:^(id sender) {
        if (weakSelf.handleBlock) {
            weakSelf.handleBlock(0);
        }
    } forControlEvents:UIControlEventTouchUpInside];
    
    
    [self.contView addSubview:coverBtn];
    [coverBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.equalTo(self.contView);
        make.right.equalTo(self.selectBtn.mas_left);
    }];
    

    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(btnLong:)];
    longPress.minimumPressDuration = 0.5; //定义按的时间
    [coverBtn addGestureRecognizer:longPress];
}

- (void)btnLong:(UILongPressGestureRecognizer *)sender {
    if (sender.state == UIGestureRecognizerStateBegan) {
        if (self.handleBlock) {
            self.handleBlock(1);
        }
    }
}

#pragma mark -Getter
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
        [_nameLabel setFont:[UIFont boldFontContent]];
    }
    return _nameLabel;
}


- (UILabel *)buLabel {
    if (!_buLabel) {
        _buLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _buLabel.textColor = adaptAndDarkColor([UIColor colorOrangeMoment],[UIColor colorOrangeMoment]);
        _buLabel.text = @"补课";
        _buLabel.numberOfLines = 1;
        _buLabel.textAlignment = NSTextAlignmentCenter;
        [_buLabel setFont:[UIFont systemFontOfSize:CGFloatIn750(16)]];
        ViewBorderRadius(_buLabel, CGFloatIn750(8), 1, [UIColor colorOrangeMoment]);
        _buLabel.backgroundColor = [UIColor colorOrangeBack];
    }
    return _buLabel;
}

- (UILabel *)lessonLabel {
    if (!_lessonLabel) {
        _lessonLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _lessonLabel.textColor = adaptAndDarkColor([UIColor colorTextGray],[UIColor colorTextGrayDark]);
        _lessonLabel.numberOfLines = 1;
        _lessonLabel.textAlignment = NSTextAlignmentLeft;
        [_lessonLabel setFont:[UIFont fontContent]];
    }
    return _lessonLabel;
}

- (UILabel *)typeLabel {
    if (!_typeLabel) {
        _typeLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _typeLabel.textColor = adaptAndDarkColor([UIColor colorTextGray],[UIColor colorTextGrayDark]);
        _typeLabel.numberOfLines = 1;
        _typeLabel.textAlignment = NSTextAlignmentRight;
        [_typeLabel setFont:[UIFont fontContent]];
    }
    return _typeLabel;
}


- (UILabel *)numLabel {
    if (!_numLabel) {
        _numLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _numLabel.textColor = adaptAndDarkColor([UIColor colorTextGray],[UIColor colorTextGrayDark]);
        _numLabel.numberOfLines = 1;
        _numLabel.textAlignment = NSTextAlignmentRight;
        [_numLabel setFont:[UIFont fontContent]];
    }
    return _numLabel;
}


- (UIImageView *)rightImageView {
    if (!_rightImageView) {
        _rightImageView = [[UIImageView alloc] init];
        _rightImageView.contentMode = UIViewContentModeCenter;
    }
    return _rightImageView;
}


- (UIImageView *)userImageView {
    if (!_userImageView) {
        _userImageView = [[UIImageView alloc] init];
        _userImageView.contentMode = UIViewContentModeScaleAspectFill;
        _userImageView.layer.cornerRadius = CGFloatIn750(44);
        ViewRadius(_userImageView, CGFloatIn750(44));
    }
    return _userImageView;
}

- (UIButton *)selectBtn {
    if (!_selectBtn) {
        __weak typeof(self) weakSelf = self;
        _selectBtn = [[UIButton alloc] initWithFrame:CGRectZero];
        [_selectBtn bk_addEventHandler:^(id sender) {
            if (weakSelf.handleBlock) {
                weakSelf.handleBlock(10);
            }
        } forControlEvents:UIControlEventTouchUpInside];
    }
    return _selectBtn;
}

+(CGFloat)z_getCellHeight:(id)sender {
    return CGFloatIn750(150);
}

- (void)setModel:(ZOriganizationStudentListModel *)model {
    _model = model;
    
    [_userImageView tt_setImageWithURL:[NSURL URLWithString:imageFullUrl(model.student_image)] placeholderImage:[UIImage imageNamed:@"default_head"]];
    _buLabel.hidden = YES;
    _nameLabel.text = model.name;
    _lessonLabel.text = [NSString stringWithFormat:@"%@-%@",SafeStr(model.courses_name),SafeStr(model.teacher_name)];
//1：待排课 2：待开课 3：已开课 4：已结课 5：待补课 6：已过期
    switch ([model.status intValue]) {
        case 1:
            _typeLabel.text = @"待排课";
            break;
        case 2:
            _typeLabel.text = @"待开课";
            break;
        case 3:
            _typeLabel.text = @"已开课";
            break;
        case 4:
            _typeLabel.text = @"已结课";
            if ([model.end_class_type intValue] == 1) {
                _typeLabel.text = @"已结课(已退款)";
            }
            
            break;
        case 5:
            _typeLabel.text = @"待补课";
            break;
        case 6:
            _typeLabel.text = @"已过期";
            break;
            
        default:
            break;
    }
    _numLabel.text = [NSString stringWithFormat:@"%@/%@节",ValidStr(model.now_progress)? SafeStr(model.now_progress):@"0",ValidStr(model.total_progress) ? SafeStr(model.total_progress):@"0"];
    
    if (model.isEdit) {
        _rightImageView.image = model.isSelected ? [UIImage imageNamed:@"selectedCycle"] : [UIImage imageNamed:@"unSelectedCycle"];
        [self.selectBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.right.top.bottom.equalTo(self.contView);
            make.width.mas_equalTo(CGFloatIn750(160));
        }];
    }else{
        [self.selectBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(self.contView);
            make.left.equalTo(self.contView.mas_right);
            make.width.mas_equalTo(CGFloatIn750(160));
        }];
        _rightImageView.image =  [UIImage imageNamed:@"unSelectedCycleMin"];
    }
    
    CGSize stateSize = [SafeStr(_typeLabel.text) tt_sizeWithFont:[UIFont fontContent]];
    
    [self.typeLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.numLabel.mas_right);
        make.centerY.equalTo(self.nameLabel.mas_centerY);
        make.width.mas_equalTo(stateSize.width + 2);
    }];
    
}
@end
