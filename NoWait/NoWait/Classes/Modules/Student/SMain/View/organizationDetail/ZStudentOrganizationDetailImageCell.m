//
//  ZStudentOrganizationDetailImageCell.m
//  NoWait
//
//  Created by zhuang zhang on 2020/1/8.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZStudentOrganizationDetailImageCell.h"


@interface ZStudentOrganizationDetailImageCell ()
@property (nonatomic,strong) UIImageView *contentImageView;

@end

@implementation ZStudentOrganizationDetailImageCell
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
}

- (UIImageView *)contentImageView {
    if (!_contentImageView) {
        _contentImageView = [[UIImageView alloc] init];
        _contentImageView.layer.cornerRadius = 6;
        _contentImageView.layer.masksToBounds = YES;
    }
    
    return _contentImageView;
}

+(CGFloat)z_getCellHeight:(id)sender {
    return CGFloatIn750(271);
}

- (void)setModel:(ZStudentDetailContentListModel *)model {
    _model = model;
    _contentImageView.image = [UIImage imageNamed:model.image];
}
@end
