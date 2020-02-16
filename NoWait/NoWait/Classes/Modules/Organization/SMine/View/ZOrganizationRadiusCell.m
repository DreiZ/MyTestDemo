//
//  ZOrganizationRadiusCell.m
//  NoWait
//
//  Created by zhuang zhang on 2020/2/16.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZOrganizationRadiusCell.h"

@interface ZOrganizationRadiusCell ()
@property (nonatomic,strong) UIView *radiusView;

@end


@implementation ZOrganizationRadiusCell

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
    self.contentView.backgroundColor =
    adaptAndDarkColor([UIColor colorGrayBG], [UIColor colorGrayBGDark]);
    
    [self.contentView addSubview:self.radiusView];
    [_radiusView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self);
        make.left.equalTo(self.contentView.mas_left).offset(CGFloatIn750(30));
        make.right.equalTo(self.contentView.mas_right).offset(-CGFloatIn750(30));
        make.height.mas_equalTo(32);
    }];
}

- (UIView *)radiusView {
    if (!_radiusView ) {
        _radiusView = [[UIView alloc] initWithFrame:CGRectZero];
        _radiusView.backgroundColor = adaptAndDarkColor([UIColor whiteColor], [UIColor colorBlackBGDark]);
        ViewRadius(_radiusView, CGFloatIn750(16));
    }
    return _radiusView;
}

- (void)setIsTop:(NSString *)isTop {
    _isTop = isTop;
    if (isTop && isTop.length > 0) {
        [_radiusView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self);
            make.left.equalTo(self.contentView.mas_left).offset(CGFloatIn750(30));
            make.right.equalTo(self.contentView.mas_right).offset(-CGFloatIn750(30));
            make.height.mas_equalTo(32);
        }];
    }else{
        [_radiusView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self);
            make.left.equalTo(self.contentView.mas_left).offset(CGFloatIn750(30));
            make.right.equalTo(self.contentView.mas_right).offset(-CGFloatIn750(30));
            make.height.mas_equalTo(32);
        }];
    }
}

+ (CGFloat)z_getCellHeight:(id)sender {
    return CGFloatIn750(16);
}
@end
