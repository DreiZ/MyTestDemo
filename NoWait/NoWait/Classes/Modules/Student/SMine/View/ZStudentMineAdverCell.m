//
//  ZStudentMineAdverCell.m
//  NoWait
//
//  Created by zhuang zhang on 2020/1/4.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZStudentMineAdverCell.h"

@interface ZStudentMineAdverCell ()
@property (nonatomic,strong) UIImageView *adverImageView;

@end

@implementation ZStudentMineAdverCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupView];
    }
    return self;
}

- (void)setupView {
    self.contentView.backgroundColor = adaptAndDarkColor([UIColor colorGrayBG], [UIColor colorBlackBG]);
    self.clipsToBounds = YES;
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    [self.contentView addSubview:self.adverImageView];
    [self.adverImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(CGFloatIn750(20));
        make.right.equalTo(self.mas_right).offset(CGFloatIn750(-20));
        make.top.equalTo(self.mas_top).offset(CGFloatIn750(0));
        make.bottom.equalTo(self.mas_bottom).offset(CGFloatIn750(-20));
    }];
    
}

- (UIImageView *)adverImageView {
    if (!_adverImageView) {
        _adverImageView = [[UIImageView alloc] init];
        _adverImageView.image = [UIImage imageNamed:@"adverImage"];
        _adverImageView.layer.masksToBounds = YES;
        _adverImageView.clipsToBounds = YES;
        _adverImageView.layer.cornerRadius = 4;
        _adverImageView.contentMode = UIViewContentModeScaleAspectFill;
        _adverImageView.backgroundColor = [UIColor  colorMain];
    }
    return _adverImageView;
}

+ (CGFloat)z_getCellHeight:(id)sender {
    return CGFloatIn750(244);
}
@end
