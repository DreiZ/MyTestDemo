//
//  ZAlertUpdateAppView.m
//  ZBigHealth
//
//  Created by zhuang zhang on 2018/12/29.
//  Copyright © 2018 zhuang zhang. All rights reserved.
//

#import "ZAlertUpdateAppView.h"
#import "AppDelegate.h"
#import "ZPublicTool.h"
#import <NSString+Size.h>
#import <YYLabel.h>

@interface ZAlertUpdateAppView ()
@property (nonatomic,strong) UIView *contView;
@property (nonatomic,strong) UIImageView *contentBackImageView;
@property (nonatomic,strong) UILabel *titleLabel;
@property (nonatomic,strong) UILabel *subTitleLabel;
@property (nonatomic,strong) YYLabel *detailLabel;

@property (nonatomic,strong) UIScrollView *iScrollview;
@property (nonatomic,strong) UIView *containerView;


@property (nonatomic,strong) UIView *closeView;
@property (nonatomic,strong) UIButton *updateBtn;

@property (nonatomic,strong) void (^handleBlock)(NSInteger);
@end

@implementation ZAlertUpdateAppView

static ZAlertUpdateAppView *sharedManager;

+ (ZAlertUpdateAppView *)sharedManager {
    @synchronized (self) {
        if (!sharedManager) {
            sharedManager = [[ZAlertUpdateAppView alloc] init];
        }
    }
    return sharedManager;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initMainView];
    }
    return self;
}

#pragma mark 初始化view
- (void)initMainView {
    self.backgroundColor = RGBAColor(1, 1, 1, 0.5);
    self.clipsToBounds = YES;
    self.layer.masksToBounds = YES;
    
//    UIButton *backBtn = [[UIButton alloc] initWithFrame:CGRectZero];
//    [backBtn bk_addEventHandler:^(id sender) {
//        [self removeFromSuperview];
//    } forControlEvents:UIControlEventTouchUpInside];
//    [self addSubview:backBtn];
//    [backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.edges.equalTo(self);
//    }];
    
    [self addSubview:self.contView];
    [self.contView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(CGFloatIn750(535));
        make.height.mas_equalTo(CGFloatIn750(708 + 108));
        make.centerX.equalTo(self.mas_centerX);
        make.centerY.equalTo(self.mas_centerY).offset(-CGFloatIn750(80));
    }];
    
    [self.contView addSubview:self.contentBackImageView];
    [self.contView addSubview:self.iScrollview];
    [self.contView addSubview:self.updateBtn];
    
    [self.contView addSubview:self.closeView];
    
    UIView *containerView = [[UIView alloc] init];
    self.containerView = containerView;
    [self.iScrollview addSubview:containerView];
    [containerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.top.mas_equalTo(0);
        make.width.mas_equalTo(CGFloatIn750(458));
        make.height.mas_equalTo(KScreenHeight);
    }];
   
    
    [self.containerView addSubview:self.titleLabel];
    [self.containerView addSubview:self.detailLabel];
    [self.containerView addSubview:self.subTitleLabel];
    
    [self.contentBackImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contView).offset(CGFloatIn750(108));
        make.left.right.bottom.equalTo(self.contView);
    }];
    
    UIImageView *rocketImageView = [[UIImageView alloc] init];
    rocketImageView.image = [UIImage imageNamed:@"updaterocketImage"];
    rocketImageView.layer.masksToBounds = YES;
    [self.contView addSubview:rocketImageView];
    [rocketImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.contView.mas_centerX);
        make.top.equalTo(self.contentBackImageView.mas_top).offset(-CGFloatIn750(70));
    }];
    
    [self.iScrollview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contView.mas_left).offset(CGFloatIn750(40));
        make.right.equalTo(self.contView.mas_right).offset(-CGFloatIn750(40));
        make.bottom.equalTo(self.updateBtn.mas_top).offset(-CGFloatIn750(40));
        make.top.equalTo(self.contentBackImageView.mas_top).offset(CGFloatIn750(270));
    }];
    
    
    [self.updateBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(CGFloatIn750(80));
        make.width.mas_equalTo(CGFloatIn750(450));
        make.bottom.equalTo(self.contView.mas_bottom).offset(-CGFloatIn750(40));
        make.centerX.equalTo(self.contView.mas_centerX);
    }];
    

    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(self.containerView);
        make.width.mas_equalTo(CGFloatIn750(458));
    }];

    [self.subTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.containerView);
        make.width.mas_equalTo(CGFloatIn750(458));
        make.top.equalTo(self.titleLabel.mas_bottom).offset(CGFloatIn750(18));
    }];
    
    [self.detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.containerView.mas_left);
        make.width.mas_equalTo(CGFloatIn750(458));
        make.top.equalTo(self.subTitleLabel.mas_bottom).offset(CGFloatIn750(50));
    }];
    
    [self.closeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.equalTo(self.contView);
        make.height.mas_equalTo(CGFloatIn750(108));
        make.width.mas_equalTo(CGFloatIn750(76));
    }];
}

#pragma mark - lazy loading
- (UIScrollView *)iScrollview {
    if (!_iScrollview) {
        _iScrollview = [[UIScrollView alloc] init];
        _iScrollview.scrollEnabled = YES;
        _iScrollview.layer.masksToBounds = YES;
        _iScrollview.clipsToBounds = YES;
        _iScrollview.showsVerticalScrollIndicator = NO;
        _iScrollview.showsHorizontalScrollIndicator = NO;
    }
    return _iScrollview;
}

- (UIView *)contView {
    if (!_contView) {
        _contView = [[UIView alloc] init];
        _contView.backgroundColor = [UIColor clearColor];
    }
    
    return _contView;
}

- (UIImageView *)contentBackImageView {
    if (!_contentBackImageView) {
        _contentBackImageView = [[UIImageView alloc] init];
        _contentBackImageView.layer.masksToBounds = YES;
        _contentBackImageView.contentMode = UIViewContentModeScaleAspectFill;
        [_contentBackImageView setImage:[UIImage imageNamed:@"updatebackImage"]];
        _contentBackImageView.backgroundColor = [UIColor clearColor];
    }
    return _contentBackImageView;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _titleLabel.textColor = KBlackColor;
        _titleLabel.text = @"0";
        _titleLabel.numberOfLines = 1;
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        [_titleLabel setFont:[UIFont systemFontOfSize:CGFloatIn750(28)]];
    }
    return _titleLabel;
}


- (YYLabel *)detailLabel {
    if (!_detailLabel) {
        _detailLabel = [[YYLabel alloc] initWithFrame:CGRectZero];
        _detailLabel.textColor = KFont6Color;
        _detailLabel.text = @"0";
        _detailLabel.numberOfLines = 0;
        _detailLabel.textAlignment = NSTextAlignmentLeft;
        _detailLabel.lineBreakMode = NSLineBreakByCharWrapping;
        [_detailLabel setFont:[UIFont systemFontOfSize:CGFloatIn750(26)]];
    }
    return _detailLabel;
}

- (UILabel *)subTitleLabel {
    if (!_subTitleLabel) {
        _subTitleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _subTitleLabel.textColor = KBlackColor;
        _subTitleLabel.text = @"";
        _subTitleLabel.numberOfLines = 0;
        _subTitleLabel.textAlignment = NSTextAlignmentLeft;
        [_subTitleLabel setFont:[UIFont systemFontOfSize:CGFloatIn750(28)]];
    }
    return _subTitleLabel;
}


- (UIView *)closeView {
    if (!_closeView) {
        _closeView = [[UIView alloc] init];
        _closeView.backgroundColor = [UIColor clearColor];
        
        UIImageView *closeImageView = [[UIImageView alloc] init];
        closeImageView.image = [UIImage imageNamed:@"updateClose"];
        closeImageView.layer.masksToBounds = YES;
        [_closeView addSubview:closeImageView];
        [closeImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.closeView.mas_centerX);
            make.bottom.equalTo(self.closeView.mas_bottom);
        }];
        
        UIButton *closeBtn = [[UIButton alloc] initWithFrame:CGRectZero];
        [closeBtn bk_addEventHandler:^(id sender) {
            if (self.handleBlock) {
                self.handleBlock(0);
            }
            [self removeFromSuperview];
        } forControlEvents:UIControlEventTouchUpInside];
        [_closeView addSubview:closeBtn];
        [closeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.equalTo(self.closeView);
            make.height.equalTo(closeBtn.mas_width);
        }];
    }
    return _closeView;
}

- (UIButton *)updateBtn {
    if (!_updateBtn) {
        _updateBtn = [[UIButton alloc] initWithFrame:CGRectZero];
        [_updateBtn setTitle:@"立即更新" forState:UIControlStateNormal];
        [_updateBtn setTitleColor:KWhiteColor forState:UIControlStateNormal];
        [_updateBtn.titleLabel setFont:[UIFont systemFontOfSize:CGFloatIn750(30)]];
        [_updateBtn setBackgroundColor:KMainColor forState:UIControlStateNormal];
        _updateBtn.layer.masksToBounds = YES;
        _updateBtn.layer.cornerRadius = CGFloatIn750(40);
        [_updateBtn bk_addEventHandler:^(id sender) {
            if (self.handleBlock) {
                self.handleBlock(1);
            }
            [self removeFromSuperview];
        } forControlEvents:UIControlEventTouchUpInside];
    }
    return _updateBtn;
}

//
//- (void)setUpdateModel:(ZAppUpdateModel *)updateModel handlerBlock:(void(^)(NSInteger))handleBlock {
//    self.handleBlock = handleBlock;
//
//    self.titleLabel.text = [NSString stringWithFormat:@"最新版本：%@",updateModel.newversion];
////    self.detailLabel.text = updateModel.content;
//    self.subTitleLabel.text = [NSString stringWithFormat:@"新版本大小：%@",updateModel.packagesize];
//
//    NSMutableAttributedString *text  = [[NSMutableAttributedString alloc] initWithString:updateModel.content];
//    text.lineSpacing = CGFloatIn750(20);
//    text.font = [UIFont systemFontOfSize:CGFloatIn750(26)];
//    text.lineBreakMode = NSLineBreakByWordWrapping;
//
//    [text addAttribute:NSForegroundColorAttributeName value:KFont6Color range:NSMakeRange(0, updateModel.content.length)];
//    self.detailLabel.attributedText = text;  //设置富文本
//
//
//    CGFloat detailHeight = [self getMessageHeight:text introSize:CGSizeMake(CGFloatIn750(458), MAXFLOAT) andLabel:self.detailLabel];
//
//
//    [self.containerView mas_remakeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_equalTo(0);
//        make.top.mas_equalTo(0);
//        make.width.mas_equalTo(self.iScrollview.width);
//        make.height.mas_equalTo(detailHeight + CGFloatIn750(128)+60);
//    }];
//
//
//    [self.detailLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self.containerView.mas_left);
//        make.width.mas_equalTo(CGFloatIn750(458));
//        make.top.equalTo(self.subTitleLabel.mas_bottom).offset(CGFloatIn750(50));
//        make.height.mas_equalTo(detailHeight);
//    }];
//
//
//    self.iScrollview.contentSize = CGSizeMake(0, detailHeight + CGFloatIn750(128));
//
//    if ([updateModel.enforce integerValue] == 1) {
//        self.closeView.hidden = YES;
//    }else{
//        self.closeView.hidden = NO;
//    }
//
//    self.alpha = 0;
//    self.frame = CGRectMake(0, 0, KScreenWidth, KScreenHeight);
//    [[AppDelegate shareAppDelegate].window addSubview:self];
//    [UIView animateWithDuration:0.3 animations:^{
//        self.alpha = 1;
//        self.frame = CGRectMake(0, 0, KScreenWidth, KScreenHeight);
//    }];
//}

/**
 *  获取lb的高度（默认字体13，行间距8，lb宽ScreenWidth-100）
 *  @return lb的高度
 */
-(CGFloat)getMessageHeight:(NSMutableAttributedString *)introText introSize:(CGSize)introSize andLabel:(YYLabel *)lb
{
    
    YYTextLayout *layout = [YYTextLayout layoutWithContainerSize:introSize text:introText];
    lb.textLayout = layout;
    CGFloat introHeight = layout.textBoundingSize.height;
    return introHeight;
}


//+ (void)setAlertUpdateModel:(ZAppUpdateModel *)updateModel  handlerBlock:(void(^)(NSInteger))handleBlock  {
//    [[ZAlertUpdateAppView sharedManager] setUpdateModel:updateModel handlerBlock:handleBlock];
//}
@end


