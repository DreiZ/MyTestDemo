//
//  ZStudentOrganizationDetailIVideoCell.m
//  NoWait
//
//  Created by zhuang zhang on 2020/1/8.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZStudentOrganizationDetailIVideoCell.h"


@interface ZStudentOrganizationDetailIVideoCell ()
@property (nonatomic,strong) UIImageView *contentImageView;
@property (nonatomic,strong) UIImageView *playImageView;

@end

@implementation ZStudentOrganizationDetailIVideoCell
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
    
    [self.contentView addSubview:self.contentImageView];
    [self.contentImageView  mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(self).offset(CGFloatIn750(10));
        make.right.bottom.equalTo(self).offset(CGFloatIn750(-10));
    }];
    
    [self.contentView addSubview:self.playImageView];
    [self.playImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.contentImageView);
    }];
}

- (UIImageView *)contentImageView {
    if (!_contentImageView) {
        _contentImageView = [[UIImageView alloc] init];
        _contentImageView.layer.cornerRadius = 6;
        _contentImageView.layer.masksToBounds = YES;
    }
    
    return _contentImageView;
}

- (UIImageView *)playImageView {
    if (!_playImageView) {
        _playImageView = [[UIImageView alloc] init];
        _playImageView.layer.masksToBounds = YES;
        _playImageView.image = [UIImage imageNamed:@"infomationVideoPlay"];
    }
    
    return _playImageView;
}

+(CGFloat)z_getCellHeight:(id)sender {
    return CGFloatIn750(271);
}

- (void)setModel:(ZStudentDetailContentListModel *)model {
    _model = model;
    _contentImageView.image = [UIImage imageNamed:model.image];
}
@end

