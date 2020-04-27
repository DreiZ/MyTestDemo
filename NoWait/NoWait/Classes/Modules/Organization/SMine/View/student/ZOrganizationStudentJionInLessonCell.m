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
@property (nonatomic,strong) UILabel *classLabel;

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
    [self.contView addSubview:self.classLabel];
    
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
        make.top.equalTo(self.userImageView.mas_top).offset(CGFloatIn750(0));
        make.right.equalTo(self.contView.mas_right).offset(-CGFloatIn750(20));
    }];
    
    [self.lessonLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.nameLabel.mas_left).offset(CGFloatIn750(0));
        make.centerY.equalTo(self.contView.mas_centerY).offset(CGFloatIn750(8));
        make.right.equalTo(self.contView.mas_right).offset(-CGFloatIn750(30));
    }];
    
    
    [self.teacherLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contView.mas_right).offset(-CGFloatIn750(20));
        make.bottom.equalTo(self.contView.mas_bottom).offset(-CGFloatIn750(28));
        make.width.mas_equalTo(CGFloatIn750(340));
    }];
    
    
    [self.teacherImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.teacherLabel.mas_left).offset(-CGFloatIn750(12));
        make.centerY.equalTo(self.teacherLabel.mas_centerY);
        make.height.width.mas_equalTo(CGFloatIn750(40));
    }];
    
    [self.classLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.lessonLabel.mas_left);
        make.right.equalTo(self.teacherImageView.mas_left).offset(-CGFloatIn750(30));
        make.centerY.equalTo(self.teacherLabel.mas_centerY);
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
        [_nameLabel setFont:[UIFont boldFontContent]];
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

- (UILabel *)classLabel {
    if (!_classLabel) {
        _classLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _classLabel.textColor = adaptAndDarkColor([UIColor colorTextBlack],[UIColor colorTextBlackDark]);
        
        _classLabel.numberOfLines = 1;
        _classLabel.textAlignment = NSTextAlignmentLeft;
        [_classLabel setFont:[UIFont fontSmall]];
    }
    return _classLabel;
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

- (void)setModel:(ZOriganizationClassDetailModel *)model {
    _model = model;
    _teacherLabel.text = model.teacher_name;
    _lessonLabel.text = model.stores_name;
    _classLabel.text = model.name;
    _nameLabel.text = model.stores_courses_name;
    [_userImageView tt_setImageWithURL:[NSURL URLWithString:model.stores_course_image] placeholderImage:[UIImage imageNamed:@"default_image32"]];
    [_teacherImageView tt_setImageWithURL:[NSURL URLWithString:model.teacher_image]];
    
    CGSize tempSize = [model.teacher_name sizeForFont:[UIFont fontSmall] size:CGSizeMake(KScreenWidth, MAXFLOAT) mode:NSLineBreakByCharWrapping];
    [self.teacherLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contView.mas_right).offset(-CGFloatIn750(20));
        make.bottom.equalTo(self.contView.mas_bottom).offset(-CGFloatIn750(28));
        make.width.mas_equalTo(tempSize.width+ 2);
    }];
    
    [self.teacherImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.teacherLabel.mas_left).offset(-CGFloatIn750(12));
        make.centerY.equalTo(self.teacherLabel.mas_centerY);
        make.height.width.mas_equalTo(CGFloatIn750(40));
    }];
}

+(CGFloat)z_getCellHeight:(id)sender {
    return CGFloatIn750(238);
}
@end

