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

@property (nonatomic,strong) UILabel *nameLabel;
@property (nonatomic,strong) UILabel *lessonLabel;
@property (nonatomic,strong) UILabel *typeLabel;
@property (nonatomic,strong) UILabel *numLabel;

@property (nonatomic,strong) UIImageView *rightImageView;

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
    [self.contView addSubview:self.nameLabel];
    [self.contView addSubview:self.lessonLabel];
    [self.contView addSubview:self.typeLabel];
    [self.contView addSubview:self.numLabel];
    [self.contView addSubview:self.rightImageView];
    
    [self.contView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.contentView);
        make.left.equalTo(self.mas_left).offset(CGFloatIn750(0));
        make.right.equalTo(self.mas_right).offset(-CGFloatIn750(0));
    }];
    
    
    [self.rightImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contView.mas_right).offset(-CGFloatIn750(20));
        make.centerY.equalTo(self.mas_centerY);
        make.height.width.mas_equalTo(CGFloatIn750(60));
    }];
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contView.mas_left).offset(CGFloatIn750(20));
        make.bottom.equalTo(self.contView.mas_centerY).offset(-CGFloatIn750(6));
        make.right.equalTo(self.contView.mas_centerX).offset(-CGFloatIn750(10));
    }];
    
    [self.lessonLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.nameLabel.mas_left).offset(CGFloatIn750(0));
        make.top.equalTo(self.contView.mas_centerY).offset(CGFloatIn750(6));
        make.right.equalTo(self.nameLabel.mas_right);
    }];
    
    [self.typeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contView.mas_centerX);
        make.centerY.equalTo(self.lessonLabel.mas_centerY);;
    }];
    
    
    [self.numLabel mas_makeConstraints:^(MASConstraintMaker *make) {
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
        _nameLabel.text = @"李四";
        _nameLabel.numberOfLines = 1;
        _nameLabel.textAlignment = NSTextAlignmentLeft;
        [_nameLabel setFont:[UIFont boldFontContent]];
    }
    return _nameLabel;
}


- (UILabel *)lessonLabel {
    if (!_lessonLabel) {
        _lessonLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _lessonLabel.textColor = adaptAndDarkColor([UIColor colorTextGray],[UIColor colorTextGrayDark]);
        _lessonLabel.text = @"多咪屋-教师姓名";
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
        _typeLabel.text = @"待排课";
        _typeLabel.numberOfLines = 1;
        _typeLabel.textAlignment = NSTextAlignmentLeft;
        [_typeLabel setFont:[UIFont fontContent]];
    }
    return _typeLabel;
}


- (UILabel *)numLabel {
    if (!_numLabel) {
        _numLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _numLabel.textColor = adaptAndDarkColor([UIColor colorTextGray],[UIColor colorTextGrayDark]);
        _numLabel.text = @"0/9节";
        _numLabel.numberOfLines = 1;
        _numLabel.textAlignment = NSTextAlignmentRight;
        [_numLabel setFont:[UIFont fontContent]];
    }
    return _numLabel;
}


- (UIImageView *)rightImageView {
    if (!_rightImageView) {
        _rightImageView = [[UIImageView alloc] init];
        _rightImageView.image = [UIImage imageNamed:@"unSelectedCycleMin"];
        _rightImageView.contentMode = UIViewContentModeCenter;
    }
    return _rightImageView;
}

+(CGFloat)z_getCellHeight:(id)sender {
    return CGFloatIn750(150);
}

@end




