//
//  ZStudentEvaDetailReEvaCell.m
//  NoWait
//
//  Created by zhuang zhang on 2020/4/17.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZStudentEvaDetailReEvaCell.h"

@interface ZStudentEvaDetailReEvaCell ()
@property (nonatomic,strong) UIView *contView;

@property (nonatomic,strong) UILabel *titleLabel;
@property (nonatomic,strong) UILabel *evaTitleLabel;
@end

@implementation ZStudentEvaDetailReEvaCell

-(void)setupView {
    [super setupView];
    
    [self.contentView addSubview:self.contView];

    [self.contView addSubview:self.titleLabel];
    [self.contView addSubview:self.evaTitleLabel];
    [self.contView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.contentView);
        make.left.equalTo(self.contentView.mas_left).offset(CGFloatIn750(30));
        make.right.equalTo(self.contentView.mas_right).offset(-CGFloatIn750(86));
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contView.mas_left).offset(CGFloatIn750(20));
        make.right.equalTo(self.contView.mas_right).offset(CGFloatIn750(-20));
        make.top.equalTo(self.contView.mas_top).offset(CGFloatIn750(20));
    }];
    
    [self.evaTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contView.mas_left).offset(CGFloatIn750(20));
        make.right.equalTo(self.contView.mas_right).offset(CGFloatIn750(-30));
        make.top.equalTo(self.titleLabel.mas_bottom).offset(CGFloatIn750(18));
    }];
    
}


#pragma mark -Getter
- (UIView *)contView {
    if (!_contView) {
        _contView = [[UIView alloc] init];
        _contView.layer.masksToBounds = YES;
        _contView.backgroundColor = adaptAndDarkColor([UIColor colorGrayBG], [UIColor colorGrayBGDark]);
        ViewRadius(_contView, CGFloatIn750(8));
    }
    return _contView;
}

- (UILabel *)evaTitleLabel {
    if (!_evaTitleLabel) {
        _evaTitleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _evaTitleLabel.textColor = adaptAndDarkColor([UIColor colorTextGray], [UIColor colorTextGrayDark]);
        _evaTitleLabel.numberOfLines = 0;
        _evaTitleLabel.textAlignment = NSTextAlignmentLeft;
        [_evaTitleLabel setFont:[UIFont fontContent]];
    }
    return _evaTitleLabel;
}


- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _titleLabel.textColor = adaptAndDarkColor([UIColor colorTextBlack], [UIColor colorTextBlackDark]);
        _titleLabel.numberOfLines = 0;
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        [_titleLabel setFont:[UIFont boldFontSmall]];
    }
    return _titleLabel;
}


+(CGFloat)z_getCellHeight:(id)sender {
    NSString *eva = sender;
    if (!eva || eva.length < 0) {
        return 0;
    }
    
    CGSize tsize = [eva tt_sizeWithFont:[UIFont fontContent] constrainedToSize:CGSizeMake(KScreenWidth - CGFloatIn750(116), MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping lineSpace:CGFloatIn750(10)];

    return CGFloatIn750(92) + tsize.height;
}

- (void)setData:(NSDictionary *)data{
    _data = data;
    if (ValidDict(data)) {
        if ([data objectForKey:@"title"]) {
            _titleLabel.text = ValidStr(data[@"title"])? [NSString stringWithFormat:@"%@:",SafeStr(data[@"title"])]:@"回复:";
        }
        if ([data objectForKey:@"content"]) {
            _evaTitleLabel.text = SafeStr(data[@"content"]);
        }
    }
    
    [ZPublicTool setLineSpacing:CGFloatIn750(10) label:self.evaTitleLabel];
}
@end





