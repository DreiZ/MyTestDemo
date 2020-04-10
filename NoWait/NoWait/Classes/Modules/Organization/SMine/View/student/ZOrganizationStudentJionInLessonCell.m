//
//  ZOrganizationStudentJionInLessonCell.m
//  NoWait
//
//  Created by zhuang zhang on 2020/4/9.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZOrganizationStudentJionInLessonCell.h"

@interface ZOrganizationStudentJionInLessonCell ()
@property (nonatomic,strong) UIView *contView;

@property (nonatomic,strong) UIImageView *userImageView;
@property (nonatomic,strong) UILabel *nameLabel;
@property (nonatomic,strong) UILabel *lessonLabel;
@property (nonatomic,strong) UILabel *teacherLabel;

@property (nonatomic,strong) UIImageView *teacherImageView;

@end

@implementation ZOrganizationStudentJionInLessonCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupView];
    }
    return self;
}

-(void)setupView {
    [super setupView];
    self.contentView.backgroundColor = adaptAndDarkColor([UIColor colorWhite],[UIColor colorBlackBGDark]);
    
    [self.contentView addSubview:self.contView];
    [self.contView addSubview:self.userImageView];
    [self.contView addSubview:self.nameLabel];
    [self.contView addSubview:self.lessonLabel];
    [self.contView addSubview:self.teacherLabel];
    [self.contView addSubview:self.teacherImageView];
    
    
    [self.contView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).offset(CGFloatIn750(10));
        make.bottom.equalTo(self.contentView.mas_bottom).offset(CGFloatIn750(-20));
        make.left.equalTo(self.mas_left).offset(CGFloatIn750(30));
        make.right.equalTo(self.mas_right).offset(-CGFloatIn750(30));
    }];

    
    [self.userImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contView.mas_left).offset(CGFloatIn750(20));
        make.centerY.equalTo(self.contView.mas_centerY);
        make.width.mas_equalTo(CGFloatIn750(240));
        make.height.mas_equalTo(CGFloatIn750(160));
    }];
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.userImageView.mas_right).offset(CGFloatIn750(20));
        make.top.equalTo(self.contView.mas_top).offset(CGFloatIn750(34));
        make.right.equalTo(self.contView.mas_right).offset(-CGFloatIn750(30));
    }];
    
    [self.lessonLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.nameLabel.mas_left).offset(CGFloatIn750(0));
        make.top.equalTo(self.contView.mas_centerY).offset(CGFloatIn750(6));
        make.right.equalTo(self.contView.mas_right).offset(-CGFloatIn750(30));
    }];
    
    
    
    [self.teacherLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contView.mas_right).offset(-CGFloatIn750(30));
        make.bottom.equalTo(self.contView.mas_bottom).offset(-CGFloatIn750(30));
        make.width.mas_lessThanOrEqualTo(CGFloatIn750(340));
    }];
    
    
    [self.teacherImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.teacherLabel.mas_left).offset(-CGFloatIn750(12));
        make.centerY.equalTo(self.teacherLabel.mas_centerY);
        make.height.width.mas_equalTo(CGFloatIn750(40));
    }];
}


#pragma mark -Getter
- (UIView *)contView {
    if (!_contView) {
        _contView = [[UIView alloc] init];
        _contView.layer.masksToBounds = YES;
        _contView.backgroundColor = adaptAndDarkColor([UIColor colorWhite], [UIColor colorBlackBGDark]);
        ViewShadowRadius(_contView, CGFloatIn750(30), CGSizeMake(0, 0), 0.5, isDarkModel() ? [UIColor colorGrayContentBGDark] : [UIColor colorGrayContentBG]);
        _contView.layer.cornerRadius = CGFloatIn750(12);
    }
    return _contView;
}


- (UILabel *)nameLabel {
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _nameLabel.textColor = adaptAndDarkColor([UIColor colorTextBlack],[UIColor colorTextBlackDark]);
        _nameLabel.numberOfLines = 0;
        
        _nameLabel.textAlignment = NSTextAlignmentLeft;
        [_nameLabel setFont:[UIFont boldFontTitle]];
    }
    return _nameLabel;
}


- (UILabel *)lessonLabel {
    if (!_lessonLabel) {
        _lessonLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _lessonLabel.textColor = adaptAndDarkColor([UIColor colorTextBlack],[UIColor colorTextBlackDark]);
        _lessonLabel.numberOfLines = 1;
        
        _lessonLabel.textAlignment = NSTextAlignmentLeft;
        [_lessonLabel setFont:[UIFont fontSmall]];
    }
    return _lessonLabel;
}

- (UILabel *)teacherLabel {
    if (!_teacherLabel) {
        _teacherLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _teacherLabel.textColor = adaptAndDarkColor([UIColor colorTextBlack],[UIColor colorTextBlackDark]);
        
        _teacherLabel.numberOfLines = 1;
        _teacherLabel.textAlignment = NSTextAlignmentRight;
        [_teacherLabel setFont:[UIFont fontSmall]];
    }
    return _teacherLabel;
}



- (UIImageView *)teacherImageView {
    if (!_teacherImageView) {
        _teacherImageView = [[UIImageView alloc] init];
        _teacherImageView.contentMode = UIViewContentModeScaleAspectFill;
        ViewRadius(_teacherImageView, CGFloatIn750(20));
        
    }
    return _teacherImageView;
}


- (UIImageView *)userImageView {
    if (!_userImageView) {
        _userImageView = [[UIImageView alloc] init];
        _userImageView.contentMode = UIViewContentModeScaleAspectFill;
        ViewRadius(_userImageView, CGFloatIn750(12));
        
    }
    return _userImageView;
}

- (void)setModel:(ZOriganizationStudentAddModel *)model {
    _teacherLabel.text = model.teacher_name;
    _lessonLabel.text = model.courses_name;
    _nameLabel.text = model.stores_name;
    [_userImageView tt_setImageWithURL:[NSURL URLWithString:model.courses_image] placeholderImage:[UIImage imageNamed:@"default_image32"]];
    [_teacherImageView tt_setImageWithURL:[NSURL URLWithString:model.coach_img]];
}

+(CGFloat)z_getCellHeight:(id)sender {
    return CGFloatIn750(238);
}
@end

