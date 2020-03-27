//
//  ZOriganizationTeachListCell.m
//  NoWait
//
//  Created by zhuang zhang on 2020/2/20.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZOriganizationTeachListCell.h"

@interface ZOriganizationTeachListCell ()
@property (nonatomic,strong) UIView *contView;

@property (nonatomic,strong) UILabel *nameLabel;
@property (nonatomic,strong) UILabel *phoneLabel;
@property (nonatomic,strong) UILabel *typeLabel;
@property (nonatomic,strong) UILabel *workLabel;

@property (nonatomic,strong) UIImageView *leftImageView;
@property (nonatomic,strong) UIImageView *rightImageView;

@end

@implementation ZOriganizationTeachListCell

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
    [self.contView addSubview:self.phoneLabel];
    [self.contView addSubview:self.typeLabel];
    [self.contView addSubview:self.workLabel];
    [self.contView addSubview:self.leftImageView];
    [self.contView addSubview:self.rightImageView];
    
    [self.contView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.contentView);
        make.left.equalTo(self.mas_left).offset(CGFloatIn750(0));
        make.right.equalTo(self.mas_right).offset(-CGFloatIn750(0));
    }];
    
    [self.leftImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contView.mas_left).offset(CGFloatIn750(30));
        make.centerY.equalTo(self.mas_centerY);
        make.height.width.mas_equalTo(CGFloatIn750(88));
    }];
    
    
    [self.rightImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contView.mas_right).offset(-CGFloatIn750(20));
        make.centerY.equalTo(self.mas_centerY);
        make.height.width.mas_equalTo(CGFloatIn750(60));
    }];
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.leftImageView.mas_right).offset(CGFloatIn750(20));
        make.bottom.equalTo(self.contView.mas_centerY).offset(-CGFloatIn750(6));
        make.right.equalTo(self.contView.mas_centerX).offset(-CGFloatIn750(10));
    }];
    
    [self.typeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.leftImageView.mas_right).offset(CGFloatIn750(20));
        make.top.equalTo(self.contView.mas_centerY).offset(CGFloatIn750(6));
        make.right.equalTo(self.contView.mas_centerX).offset(-CGFloatIn750(10));
    }];
    
    [self.phoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contView.mas_centerX).offset(CGFloatIn750(0));
        make.centerY.equalTo(self.nameLabel.mas_centerY);
        make.right.equalTo(self.rightImageView.mas_left).offset(-CGFloatIn750(10));
    }];
    
    [self.workLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contView.mas_centerX).offset(CGFloatIn750(0));
        make.centerY.equalTo(self.typeLabel.mas_centerY);
        make.right.equalTo(self.rightImageView.mas_left).offset(-CGFloatIn750(10));
    }];
    
    __weak typeof(self) weakSelf = self;
    UIButton *coverBtn = [[UIButton alloc] initWithFrame:CGRectZero];
    [coverBtn bk_whenTapped:^{
        if (weakSelf.handleBlock) {
            weakSelf.handleBlock(0);
        }
    }];
    
    
    [self.contView addSubview:coverBtn];
    [coverBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contView);
    }];

    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(btnLong:)];
    longPress.minimumPressDuration = 0.5; //定义按的时间
    [coverBtn addGestureRecognizer:longPress];
}

- (void)btnLong:(id)sender {
    if (self.handleBlock) {
        self.handleBlock(1);
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


- (UILabel *)phoneLabel {
    if (!_phoneLabel) {
        _phoneLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _phoneLabel.textColor = adaptAndDarkColor([UIColor colorTextBlack],[UIColor colorTextBlackDark]);
        _phoneLabel.numberOfLines = 1;
        _phoneLabel.textAlignment = NSTextAlignmentLeft;
        [_phoneLabel setFont:[UIFont fontContent]];
    }
    return _phoneLabel;
}

- (UILabel *)typeLabel {
    if (!_typeLabel) {
        _typeLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _typeLabel.textColor = adaptAndDarkColor([UIColor colorOrangeMoment],[UIColor colorOrangeMoment]);
        
        _typeLabel.numberOfLines = 1;
        _typeLabel.textAlignment = NSTextAlignmentLeft;
        [_typeLabel setFont:[UIFont fontSmall]];
    }
    return _typeLabel;
}


- (UILabel *)workLabel {
    if (!_workLabel) {
        _workLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _workLabel.textColor = adaptAndDarkColor([UIColor colorTextBlack],[UIColor colorTextBlackDark]);
        
        _workLabel.numberOfLines = 1;
        _workLabel.textAlignment = NSTextAlignmentLeft;
        [_workLabel setFont:[UIFont fontSmall]];
    }
    return _workLabel;
}

- (UIImageView *)leftImageView {
    if (!_leftImageView) {
        _leftImageView = [[UIImageView alloc] init];
        ViewRadius(_leftImageView, CGFloatIn750(44));
    }
    return _leftImageView;
}

- (UIImageView *)rightImageView {
    if (!_rightImageView) {
        _rightImageView = [[UIImageView alloc] init];
        _rightImageView.image = [UIImage imageNamed:@"unSelectedCycleMin"];
        _rightImageView.contentMode = UIViewContentModeCenter;
    }
    return _rightImageView;
}

- (void)setModel:(ZOriganizationTeacherListModel *)model {
    _model = model;
    _nameLabel.text = model.teacher_name;
    _typeLabel.text = [model.c_level intValue] == 1 ? @"普通教师":@"明星教师";
    _workLabel.text = model.position;
    _phoneLabel.text = model.phone;
    [_leftImageView tt_setImageWithURL:[NSURL URLWithString:imageFullUrl(SafeStr(model.image))] placeholderImage:[UIImage imageNamed:@"default_head"]];
    
    if([model.c_level intValue] == 1) {
        _typeLabel.textColor = adaptAndDarkColor([UIColor colorTextGray1], [UIColor colorTextGray1]);
    }else{
        _typeLabel.textColor = adaptAndDarkColor([UIColor colorOrangeMoment],[UIColor colorOrangeMoment]);
    }
    
    if (model.isEdit) {
        _rightImageView.image = model.isSelected ? [UIImage imageNamed:@"selectedCycle"] : [UIImage imageNamed:@"unSelectedCycle"];
    }else{
        _rightImageView.image =  [UIImage imageNamed:@"unSelectedCycleMin"];
    }
}

+(CGFloat)z_getCellHeight:(id)sender {
    return CGFloatIn750(150);
}

@end



