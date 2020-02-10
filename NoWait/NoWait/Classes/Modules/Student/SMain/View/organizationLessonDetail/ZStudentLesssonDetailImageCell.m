//
//  ZStudentLesssonDetailImageCell.m
//  NoWait
//
//  Created by zhuang zhang on 2020/1/9.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZStudentLesssonDetailImageCell.h"


@interface ZStudentLesssonDetailImageCell ()
@property (nonatomic,strong) UIImageView *contentImageView;

@end

@implementation ZStudentLesssonDetailImageCell
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
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.contentView.backgroundColor = KAdaptAndDarkColor(KWhiteColor, K1aBackColor);
    
    [self.contentView addSubview:self.contentImageView];
    [self.contentImageView  mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(CGFloatIn750(10));
        make.top.equalTo(self.mas_top).offset(CGFloatIn750(10));
        make.right.equalTo(self).offset(CGFloatIn750(-10));
        make.bottom.equalTo(self.mas_bottom).offset(-CGFloatIn750(20));
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
    return CGFloatIn750(340);
}

- (void)setModel:(ZStudentDetailContentListModel *)model {
    _model = model;
    _contentImageView.image = [UIImage imageNamed:model.image];
}
@end

