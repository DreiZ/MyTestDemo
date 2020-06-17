//
//  ZStudentShareImageCell.m
//  NoWait
//
//  Created by zhuang zhang on 2020/6/17.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZStudentShareImageCell.h"

@interface ZStudentShareImageCell ()
@property (nonatomic,strong) UIImageView *shareImageView;

@end

@implementation ZStudentShareImageCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupView];
    }
    return self;
}

- (void)setupView {
    [super setupView];
    
    [self.contentView addSubview:self.shareImageView];
    [self.shareImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView.mas_centerY);
        make.right.equalTo(self.contentView.mas_right).offset(-CGFloatIn750(30));
        make.top.bottom.equalTo(self.contentView);
        make.width.equalTo(self.shareImageView.mas_height).multipliedBy(1.5);
    }];
}

- (UIImageView *)shareImageView {
    if (!_shareImageView) {
        _shareImageView = [[UIImageView alloc] init];
        _shareImageView.layer.masksToBounds = YES;
        ViewRadius(_shareImageView, CGFloatIn750(16));
    }
    return _shareImageView;
}

- (void)setImage:(NSString *)image {
    _image = image;
    
    [_shareImageView tt_setImageWithURL:[NSURL URLWithString:image]];
}

+(CGFloat)z_getCellHeight:(id)sender {
    return CGFloatIn750(360);
}
@end
