//
//  HNUpdateAlertView.m
//  hntx
//
//  Created by RoyLei on 2018/9/7.
//  Copyright © 2018年 LaKa. All rights reserved.
//

#import "HNUpdateAlertView.h"
#import "LKUIUtils.h"

@implementation HNUpdateAlertView
{
    UIImageView  *_bgImageView;
    UIImageView  *_downImageView;
    UILabel      *_titleLabel;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.layer.masksToBounds = YES;
        self.layer.cornerRadius = CGFloatIn750(16);
        self.clipsToBounds = YES;
        
        _bgImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"pop_update_up_background"]];
        _bgImageView.contentMode = UIViewContentModeTop;
        _downImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"pop_update_dw_background"]];
        _downImageView.contentMode = UIViewContentModeScaleAspectFill;
        
        _titleLabel = ({
            UILabel *aLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
            aLabel.font = [UIFont boldSystemFontOfSize:20];
            aLabel.textColor = UIColorHex(0xffffff);
            aLabel.numberOfLines = 1;
            aLabel.text = @"发现新版本";
            aLabel;
        });
        
        _versionLabel = ({
            UILabel *aLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
            aLabel.font = [UIFont boldSystemFontOfSize:18];
            aLabel.textColor = UIColorHex(0xffffff);
            aLabel.numberOfLines = 1;
            aLabel;
        });
        
        _contentTextView = ({
            UITextView *aTextView = [[UITextView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
            aTextView.font = [UIFont boldSystemFontOfSize:14];
            aTextView.textColor = UIColorHex(0x222222);
            aTextView.textAlignment = NSTextAlignmentJustified;
            aTextView.text = @"";
            aTextView.editable = NO;
            aTextView;
        });
        
        UIImage *bgImage = [LKUIUtils getRoundImageWithCutOuter:YES corners:UIRectCornerAllCorners size:CGSizeMake(50, 46) radius:23 backgroundColor:[UIColor colorMain]];
        bgImage = [bgImage stretchableImageWithLeftCapWidth:25 topCapHeight:23];
        
        _updateButton = ({
            UIButton *aButton = [UIButton buttonWithType:UIButtonTypeCustom];
            aButton.frame = (CGRect){0,0,50,40};
            aButton.titleLabel.font = [UIFont boldSystemFontOfSize:16];
            [aButton setTitleColor:UIColorHex(0xffffff) forState:UIControlStateNormal];
            [aButton setBackgroundImage:bgImage forState:UIControlStateNormal];
            [aButton setTitle:@"立即更新" forState:UIControlStateNormal];
            aButton;
        });
        
        {
            UIImage *bgImage = [LKUIUtils getRoundImageWithCutOuter:YES corners:UIRectCornerAllCorners size:CGSizeMake(50, 46) radius:23 backgroundColor:[UIColor colorTextGray1]];
            bgImage = [bgImage stretchableImageWithLeftCapWidth:25 topCapHeight:23];
            
            _cancleButton = ({
                UIButton *aButton = [UIButton buttonWithType:UIButtonTypeCustom];
                aButton.frame = (CGRect){0,0,50,40};
                aButton.titleLabel.font = [UIFont boldSystemFontOfSize:16];
                [aButton setTitleColor:UIColorHex(0xffffff) forState:UIControlStateNormal];
                [aButton setBackgroundImage:bgImage forState:UIControlStateNormal];
                [aButton setTitle:@"下次再说" forState:UIControlStateNormal];
                aButton;
            });
        }
        
        [self addSubview:_downImageView];
        [self addSubview:_bgImageView];
        [self addSubview:_titleLabel];
        [self addSubview:_versionLabel];
        [self addSubview:_contentTextView];
        [self addSubview:_updateButton];
        [self addSubview:_cancleButton];
        
        _titleLabel.hidden = YES;
        _versionLabel.hidden = YES;
        
        self.clipsToBounds = YES;
        
        [self setupContraints];
    }
    return self;
}

- (void)setupContraints
{
    [_bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self);
        make.left.right.equalTo(self);
        make.height.equalTo(_bgImageView.mas_width).multipliedBy(605.0/970.0);
    }];
    
    [_downImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(605.0/970.0 * 260);
        make.right.left.mas_equalTo(_bgImageView);
        make.bottom.equalTo(self.mas_bottom);
    }];
    
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(25);
        make.top.mas_equalTo(32);
    }];
    
    [_versionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_titleLabel);
        make.top.mas_equalTo(_titleLabel.mas_bottom).offset(5);
    }];
    
    [_contentTextView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_titleLabel);
        make.top.mas_equalTo(605.0/970.0 * 260);
        make.right.mas_equalTo(-25);
        make.height.mas_lessThanOrEqualTo(150);
    }];
    
    [_updateButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_titleLabel);
        make.right.mas_equalTo(-25);
        make.height.mas_equalTo(46);
        make.top.equalTo(_contentTextView.mas_bottom).offset(CGFloatIn750(20));
    }];
    
    [_cancleButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_titleLabel);
        make.right.mas_equalTo(-25);
        make.height.mas_equalTo(46);
        make.top.equalTo(_updateButton.mas_bottom).offset(CGFloatIn750(20));
    }];
}

- (void)setContentText:(NSString *)contentText force_upgrade:(BOOL)isForce {
    if (_contentText != contentText) {
        _contentText = contentText;
    }
    
    if (!ValidStr(_contentText)) {
        _contentText = @"似锦APP已更新，请从App Store下载全新版本";
    }
    
    NSMutableAttributedString *attriText = [[NSMutableAttributedString alloc] initWithString:_contentText];
    NSMutableParagraphStyle *paragraphStyle = [NSMutableParagraphStyle new];
    [paragraphStyle setLineSpacing:6];
    [paragraphStyle setLineBreakMode:NSLineBreakByWordWrapping];
    [attriText addAttributes:@{NSFontAttributeName:[UIFont fontContent],
                               NSForegroundColorAttributeName:UIColorHex(0x222222),
                               NSParagraphStyleAttributeName:paragraphStyle}
                       range:NSMakeRange(0, _contentText.length)];
    
    CGSize contentSize = [attriText boundingRectWithSize:CGSizeMake(260 - 25*2, YYScreenSize().height - 120*2) options:NSStringDrawingUsesLineFragmentOrigin context:nil].size;
    contentSize.height = MAX(contentSize.height, 60);
    
    _contentTextView.attributedText = attriText;
    [_contentTextView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_titleLabel);
        make.top.mas_equalTo(210);
        make.right.mas_equalTo(-25);
        make.height.mas_equalTo(contentSize.height);
    }];
    
    if (isForce) {
        _cancleButton.hidden = YES;
        self.size = CGSizeMake(260, 202 + 12 + 46 + 20 + contentSize.height);
    }else{
        _cancleButton.hidden = NO;
        self.size = CGSizeMake(260, 262 + 12 + 46 + 20 + contentSize.height);
    }
}

- (void)setContentText:(NSString *)contentText
{
    
}

@end
