//
//  ZStudentStarInfoImageCell.m
//  NoWait
//
//  Created by zhuang zhang on 2020/1/13.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZStudentStarInfoImageCell.h"


@interface ZStudentStarInfoImageCell ()
@property (nonatomic,strong) UIImageView *contentImageView;

@end

@implementation ZStudentStarInfoImageCell
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
    self.contentView.backgroundColor = adaptAndDarkColor([UIColor colorWhite], [UIColor colorBlackBGDark]);
    
    [self.contentView addSubview:self.contentImageView];
    [self.contentImageView  mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(self).offset(CGFloatIn750(0));
        make.right.equalTo(self).offset(CGFloatIn750(-0));
        make.bottom.equalTo(self.mas_bottom).offset(-CGFloatIn750(20));
    }];
}

- (UIImageView *)contentImageView {
    if (!_contentImageView) {
        _contentImageView = [[UIImageView alloc] init];
        _contentImageView.contentMode = UIViewContentModeScaleAspectFill;
//        _contentImageView.layer.cornerRadius = 6;
//        _contentImageView.layer.masksToBounds = YES;
    }
    
    return _contentImageView;
}

+(CGFloat)z_getCellHeight:(id)sender {
    return CGFloatIn750(360);
}

- (void)setModel:(ZStudentDetailContentListModel *)model {
    _model = model;
    _contentImageView.image = [UIImage imageNamed:model.image];
}
@end

