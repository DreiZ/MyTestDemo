//
//  ZMineStudentEvaListEvaImageCell.m
//  NoWait
//
//  Created by zhuang zhang on 2020/1/14.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZMineStudentEvaListEvaImageCell.h"

@interface ZMineStudentEvaListEvaImageCell ()
@property (nonatomic,strong) UIImageView *evaImageView;

@end

@implementation ZMineStudentEvaListEvaImageCell

-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initMainView];
    }
    return self;
}

- (void)initMainView {
    self.contentView.backgroundColor = adaptAndDarkColor([UIColor colorGrayBG], [UIColor colorGrayBGDark]);
    self.clipsToBounds = YES;
    
    [self.contentView addSubview:self.evaImageView];
    [self.evaImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    
}


#pragma mark -懒加载
- (UIImageView *)evaImageView {
    if (!_evaImageView) {
        _evaImageView = [[UIImageView alloc] init];
        _evaImageView.layer.masksToBounds = YES;
        _evaImageView.layer.cornerRadius = CGFloatIn750(10);
        _evaImageView.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _evaImageView;
}

- (void)setImage:(NSString *)image {
    _image = image;
    [_evaImageView tt_setImageWithURL:[NSURL URLWithString:image]];
//    _evaImageView.image = [UIImage imageNamed:image];
}
@end

