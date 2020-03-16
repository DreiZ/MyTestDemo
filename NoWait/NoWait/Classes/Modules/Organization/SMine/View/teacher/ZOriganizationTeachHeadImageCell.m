//
//  ZOriganizationTeachHeadImageCell.m
//  NoWait
//
//  Created by zhuang zhang on 2020/2/21.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZOriganizationTeachHeadImageCell.h"

@interface ZOriganizationTeachHeadImageCell ()
@property (nonatomic,strong) UIImageView *headImageView;

@end

@implementation ZOriganizationTeachHeadImageCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupView];
    }
    return self;
}

-(void)setupView {
    [super setupView];
    
    [self.contentView addSubview:self.headImageView];
    
    
    [self.headImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).offset(CGFloatIn750(38));
        make.centerX.equalTo(self.mas_centerX);
        make.height.width.mas_equalTo(CGFloatIn750(104));
    }];
    
}

#pragma mark -Getter
- (UIImageView *)headImageView {
    if (!_headImageView) {
        _headImageView = [[UIImageView alloc] init];
        _headImageView.image = [UIImage imageNamed:@"uploadUserHeadImage"];
        _headImageView.backgroundColor = adaptAndDarkColor([UIColor colorGrayContentBG], [UIColor colorGrayContentBGDark]);
        _headImageView.contentMode = UIViewContentModeScaleAspectFit;
        ViewRadius(_headImageView, CGFloatIn750(52));
    }
    return _headImageView;
}

- (void)setImage:(id)image {
    _image = image;
    if (ValidStr(image)) {
        [self.headImageView tt_setImageWithURL:[NSURL URLWithString:image]];
    }else if (ValidClass(image, [UIImage class])){
        self.image = image;
    }
}

+(CGFloat)z_getCellHeight:(id)sender {
    return CGFloatIn750(148);
}

@end




