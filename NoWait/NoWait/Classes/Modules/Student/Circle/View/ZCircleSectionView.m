//
//  ZCircleSectionView.m
//  NoWait
//
//  Created by zhuang zhang on 2020/7/6.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZCircleSectionView.h"

@interface ZCircleSectionView()
@property (nonatomic,strong) UILabel *tipLabel;
@end

@implementation ZCircleSectionView
#pragma mark - Init Menthod
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.tipLabel];
        self.backgroundColor = adaptAndDarkColor([UIColor colorWhite], [UIColor colorBlackBGDark]);
        
        [self.tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.mas_centerY);
            make.left.equalTo(self.mas_left).offset(CGFloatIn750(30));
        }];
    }
    return self;
}

- (void)setTip:(NSString *)tip{
    self.tipLabel.text = tip;
}

- (UILabel *)tipLabel{
    if (!_tipLabel) {
        _tipLabel = [UILabel new];
        _tipLabel.font = [UIFont boldFontContent];
        _tipLabel.textColor = adaptAndDarkColor([UIColor colorTextBlack], [UIColor colorTextBlackDark]);
        _tipLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _tipLabel;
}
@end
