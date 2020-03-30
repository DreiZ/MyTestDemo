//
//  ZStudentLessonTeacherSelectedCell.m
//  NoWait
//
//  Created by zhuang zhang on 2020/3/21.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZStudentLessonTeacherSelectedCell.h"

@interface ZStudentLessonTeacherSelectedCell ()
@property (nonatomic,strong) UILabel *nameLabel;
@property (nonatomic,strong) UIImageView *organizationImageView;
@property (nonatomic,strong) UILabel *lessonLabel;

@end

@implementation ZStudentLessonTeacherSelectedCell
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
    
    [self.contentView addSubview:self.organizationImageView];
    [self.contentView addSubview:self.nameLabel];
    [self.contentView addSubview:self.lessonLabel];
    
    [self.organizationImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(CGFloatIn750(30));
        make.width.mas_equalTo(CGFloatIn750(88));
        make.height.mas_equalTo(CGFloatIn750(88));
        make.centerY.equalTo(self.mas_centerY);
    }];
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.organizationImageView.mas_top).offset(CGFloatIn750(4));
        make.left.equalTo(self.organizationImageView.mas_right).offset(CGFloatIn750(20));
        make.right.equalTo(self.mas_right).offset(-CGFloatIn750(20));
    }];
    
    [self.lessonLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.organizationImageView.mas_bottom).offset(-CGFloatIn750(10));
        make.left.equalTo(self.organizationImageView.mas_right).offset(CGFloatIn750(20));
        make.right.equalTo(self.mas_right).offset(-CGFloatIn750(20));
    }];
    
}

- (UILabel *)nameLabel {
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _nameLabel.textColor = adaptAndDarkColor([UIColor colorTextBlack], [UIColor colorTextBlackDark]);
        
        _nameLabel.numberOfLines = 1;
        _nameLabel.textAlignment = NSTextAlignmentLeft;
        [_nameLabel setFont:[UIFont boldFontContent]];
    }
    return _nameLabel;
}

- (UILabel *)lessonLabel {
    if (!_lessonLabel) {
        _lessonLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _lessonLabel.textColor = adaptAndDarkColor([UIColor colorTextGray], [UIColor colorTextGrayDark]);
        
        _lessonLabel.numberOfLines = 1;
        _lessonLabel.textAlignment = NSTextAlignmentLeft;
        [_lessonLabel setFont:[UIFont fontMin]];
    }
    return _lessonLabel;
}

- (UIImageView *)organizationImageView {
    if (!_organizationImageView) {
        _organizationImageView = [[UIImageView alloc] init];
        _organizationImageView.contentMode = UIViewContentModeScaleAspectFill;
        ViewRadius(_organizationImageView, CGFloatIn750(10));
    }
    return _organizationImageView;
}

- (void)setData:(NSDictionary *)data {
    _data = data;
    if (ValidDict(data)) {
        if ([data objectForKey:@"image"]) {
            self.organizationImageView.hidden = NO;
            [_organizationImageView tt_setImageWithURL:[NSURL URLWithString:imageFullUrl(data[@"image"])] placeholderImage:[UIImage imageNamed:@"default_image32"]];
            
            
            [self.organizationImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.mas_left).offset(CGFloatIn750(30));
                make.width.mas_equalTo(CGFloatIn750(88));
                make.height.mas_equalTo(CGFloatIn750(88));
                make.centerY.equalTo(self.mas_centerY);
            }];
            
            [self.nameLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.organizationImageView.mas_top).offset(CGFloatIn750(4));
                make.left.equalTo(self.organizationImageView.mas_right).offset(CGFloatIn750(20));
                make.right.equalTo(self.mas_right).offset(-CGFloatIn750(20));
            }];
            
            [self.lessonLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.bottom.equalTo(self.organizationImageView.mas_bottom).offset(-CGFloatIn750(4));
                make.left.equalTo(self.organizationImageView.mas_right).offset(CGFloatIn750(20));
                make.right.equalTo(self.mas_right).offset(-CGFloatIn750(20));
            }];
        }else{
            self.organizationImageView.hidden = YES;
            [self.nameLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.organizationImageView.mas_top).offset(CGFloatIn750(4));
                make.left.equalTo(self.contentView.mas_left).offset(CGFloatIn750(30));
                make.right.equalTo(self.mas_right).offset(-CGFloatIn750(20));
            }];
            
            [self.lessonLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.bottom.equalTo(self.organizationImageView.mas_bottom).offset(-CGFloatIn750(4));
                make.left.equalTo(self.contentView.mas_left).offset(CGFloatIn750(30));
                make.right.equalTo(self.mas_right).offset(-CGFloatIn750(20));
            }];
        }
        if ([data objectForKey:@"lesson"]) {
            _lessonLabel.text = data[@"lesson"];
        }
        if ([data objectForKey:@"name"]) {
            _nameLabel.text = data[@"name"];
        }
    }
}


+(CGFloat)z_getCellHeight:(id)sender {
    return CGFloatIn750(90);
}

@end





