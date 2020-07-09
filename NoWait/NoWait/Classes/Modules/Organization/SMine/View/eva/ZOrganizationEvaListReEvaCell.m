//
//  ZOrganizationEvaListReEvaCell.m
//  NoWait
//
//  Created by zhuang zhang on 2020/3/20.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZOrganizationEvaListReEvaCell.h"

@interface ZOrganizationEvaListReEvaCell ()

@property (nonatomic,strong) UILabel *evaTitleLabel;
@property (nonatomic,strong) UIView *bottomLineView;

@end

@implementation ZOrganizationEvaListReEvaCell

-(void)setupView {
    [super setupView];
    
    [self.contentView addSubview:self.evaTitleLabel];
    
    [self.evaTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).offset(CGFloatIn750(62));
        make.right.equalTo(self.contentView.mas_right).offset(CGFloatIn750(-30));
        make.top.equalTo(self.contentView.mas_top).offset(CGFloatIn750(20));
    }];
    
    
    [self.contentView addSubview:self.bottomLineView];
    [self.bottomLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(CGFloatIn750(50));
        make.top.equalTo(self.mas_top).offset(CGFloatIn750(20));
        make.width.mas_equalTo(3);
        make.bottom.equalTo(self.mas_bottom).offset(-CGFloatIn750(10));
    }];
}


#pragma mark -Getter
- (UIView *)bottomLineView {
    if (!_bottomLineView) {
        _bottomLineView = [[UIView alloc] initWithFrame:CGRectZero];
        _bottomLineView.backgroundColor = adaptAndDarkColor([UIColor colorTextBlackDark], [UIColor colorTextBlack]);
    }
    return _bottomLineView;
}

- (UILabel *)evaTitleLabel {
    if (!_evaTitleLabel) {
        _evaTitleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _evaTitleLabel.textColor = adaptAndDarkColor([UIColor colorTextGray], [UIColor colorTextGrayDark]);
        _evaTitleLabel.numberOfLines = 0;
        _evaTitleLabel.textAlignment = NSTextAlignmentLeft;
        [_evaTitleLabel setFont:[UIFont fontSmall]];
    }
    return _evaTitleLabel;
}


+(CGFloat)z_getCellHeight:(id)sender {
    NSString *eva = sender;
    if (!eva || eva.length < 0) {
        return 0;
    }
    
    CGSize tsize = [eva tt_sizeWithFont:[UIFont fontSmall] constrainedToSize:CGSizeMake(KScreenWidth - CGFloatIn750(92+60), MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping lineSpace:CGFloatIn750(10)];

    return CGFloatIn750(34) + tsize.height;
}

- (void)setEvaDes:(NSString *)evaDes {
    _evaDes = evaDes;
    _evaTitleLabel.text = evaDes;
    
    [ZPublicTool setLineSpacing:CGFloatIn750(10) label:self.evaTitleLabel];
}
@end



