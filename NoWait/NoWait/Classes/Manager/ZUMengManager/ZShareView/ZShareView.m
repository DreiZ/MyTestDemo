//
//  ZShareView.m
//  ZBigHealth
//
//  Created by 承希-开发 on 2018/12/3.
//  Copyright © 2018 承希-开发. All rights reserved.
//

#import "ZShareView.h"
#import "AppDelegate.h"
#import "ZUMengShareManager.h"

@interface ZShareView ()
@property (nonatomic,strong) UIView *contView;
@property (nonatomic,strong) UILabel *contentLabel;
@property (nonatomic,strong) void (^handleBlock)(NSInteger);
@end

@implementation ZShareView

static ZShareView *sharedManager;

+ (ZShareView *)sharedManager {
    @synchronized (self) {
        if (!sharedManager) {
            sharedManager = [[ZShareView alloc] init];
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
    
    UIButton *backBtn = [[UIButton alloc] initWithFrame:CGRectZero];
    [backBtn bk_addEventHandler:^(id sender) {
        [self removeFromSuperview];
    } forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:backBtn];
    [backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    
    UIView *bottomSpaceView = [[UIView alloc] initWithFrame:CGRectZero];
    bottomSpaceView.backgroundColor = [UIColor whiteColor];
    [self addSubview:bottomSpaceView];
    [bottomSpaceView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self);
        make.height.mas_equalTo(kStatusBarHeight-20);
    }];
    
    [self addSubview:self.contView];
    [self.contView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(CGFloatIn750(448));
        make.left.right.equalTo(self);
        make.bottom.equalTo(bottomSpaceView.mas_top);
    }];
    
    
    [self.contView addSubview:self.contentLabel];
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contView.mas_top).offset(CGFloatIn750(50));
        make.centerX.equalTo(self.contView.mas_centerX);
    }];
    
    UIImageView *chatFriendImageView = [[UIImageView alloc] init];
    chatFriendImageView.image = [UIImage imageNamed:@"shareFriend"];
    chatFriendImageView.layer.masksToBounds = YES;
    [self.contView addSubview:chatFriendImageView];
    [chatFriendImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(CGFloatIn750(92));
        make.right.equalTo(self.contView.mas_centerX).offset(CGFloatIn750(-62));
        make.top.equalTo(self.contentLabel.mas_bottom).offset(CGFloatIn750(64));
    }];
    
    
    
    UILabel *chatFriendLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    chatFriendLabel.textColor = [UIColor colorTextGray];
    chatFriendLabel.text = @"微信好友";
    chatFriendLabel.numberOfLines = 0;
    chatFriendLabel.textAlignment = NSTextAlignmentCenter;
    [chatFriendLabel setFont:[UIFont systemFontOfSize:CGFloatIn750(24)]];
    [self.contView addSubview:chatFriendLabel];
    [chatFriendLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(chatFriendImageView.mas_centerX);
        make.top.equalTo(chatFriendImageView.mas_bottom).offset(CGFloatIn750(16));
    }];
    
    UIImageView *chatMomentImageView = [[UIImageView alloc] init];
    chatMomentImageView.image = [UIImage imageNamed:@"shareMoments"];
    chatMomentImageView.layer.masksToBounds = YES;
    [self.contView addSubview:chatMomentImageView];
    [chatMomentImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(CGFloatIn750(92));
        make.left.equalTo(self.contView.mas_centerX).offset(CGFloatIn750(62));
        make.top.equalTo(self.contentLabel.mas_bottom).offset(CGFloatIn750(64));
    }];
    
    UILabel *chatMomentLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    chatMomentLabel.textColor = [UIColor colorTextGray];
    chatMomentLabel.text = @"朋友圈";
    chatMomentLabel.numberOfLines = 0;
    chatMomentLabel.textAlignment = NSTextAlignmentCenter;
    [chatMomentLabel setFont:[UIFont systemFontOfSize:CGFloatIn750(24)]];
    [self.contView addSubview:chatMomentLabel];
    [chatMomentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(chatMomentImageView.mas_centerX);
        make.top.equalTo(chatMomentImageView.mas_bottom).offset(CGFloatIn750(16));
    }];
    
    
    __weak typeof(self) weakSelf = self;
    UIButton *friendBtn = [[UIButton alloc] initWithFrame:CGRectZero];
    [friendBtn bk_addEventHandler:^(id sender) {
        if (weakSelf.handleBlock ) {
            weakSelf.handleBlock(0);
        }
        [weakSelf removeFromSuperview];
    } forControlEvents:UIControlEventTouchUpInside];
    [self.contView addSubview:friendBtn];
    [friendBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(chatFriendImageView);
        make.bottom.equalTo(chatFriendLabel.mas_bottom);
    }];
    
    UIButton *momentBtn = [[UIButton alloc] initWithFrame:CGRectZero];
    [momentBtn bk_addEventHandler:^(id sender) {
        if (weakSelf.handleBlock ) {
            weakSelf.handleBlock(1);
        }
        [weakSelf removeFromSuperview];
    } forControlEvents:UIControlEventTouchUpInside];
    [self.contView addSubview:momentBtn];
    [momentBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(chatMomentImageView);
        make.bottom.equalTo(chatMomentLabel.mas_bottom);
    }];
    
    
    UIButton *cancleBtn = [[UIButton alloc] initWithFrame:CGRectZero];
    [cancleBtn bk_addEventHandler:^(id sender) {
        [self removeFromSuperview];
    } forControlEvents:UIControlEventTouchUpInside];
    [cancleBtn setTitle:@"取消" forState:UIControlStateNormal];
    [cancleBtn setTitleColor:[UIColor colorTextBlack] forState:UIControlStateNormal];
    [cancleBtn.titleLabel setFont:[UIFont systemFontOfSize:CGFloatIn750(32)]];
    [self.contView addSubview:cancleBtn];
    [cancleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(CGFloatIn750(110));
        make.left.right.equalTo(self.contView);
        make.bottom.equalTo(self.contView.mas_bottom);
    }];
    
    UIView *bottomLineView = [[UIView alloc] initWithFrame:CGRectZero];
    bottomLineView.backgroundColor = [UIColor colorGrayLine];
    [cancleBtn addSubview:bottomLineView];
    [bottomLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(cancleBtn);
        make.height.mas_equalTo(1.0);
    }];
}

- (UIView *)contView {
    if (!_contView) {
        _contView = [[UIView alloc] init];
        _contView.backgroundColor = [UIColor whiteColor];
    }
    
    return _contView;
}

- (UILabel *)contentLabel {
    if (!_contentLabel) {
        _contentLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _contentLabel.textColor = [UIColor colorTextBlack];
        _contentLabel.text = @"";
        _contentLabel.numberOfLines = 1;
        _contentLabel.textAlignment = NSTextAlignmentCenter;
        [_contentLabel setFont:[UIFont systemFontOfSize:CGFloatIn750(30)]];
    }
    return _contentLabel;
}



- (void)setPre_title:(NSString *)pre_title reduce_weight:(NSString *)reduce_weight after_title:(NSString *)after_title  handlerBlock:(void(^)(NSInteger))handleBlock {
    self.handleBlock = handleBlock;
    
    NSString *titleStr = [NSString stringWithFormat:@" %@%@%@",pre_title, reduce_weight,after_title];
    
    NSMutableAttributedString * noteStr = [[NSMutableAttributedString alloc]initWithString:titleStr];
    if (reduce_weight.length >= noteStr.length) {
        return;
    }
    NSRange redRangeAll = NSMakeRange([[noteStr string] rangeOfString:titleStr].location, [[noteStr string] rangeOfString:titleStr].length);
    NSRange redRangeUnit = NSMakeRange([[noteStr string] rangeOfString:reduce_weight].location, [[noteStr string] rangeOfString:reduce_weight].length);
    
    [noteStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:CGFloatIn750(28)] range:redRangeAll];
    [noteStr addAttribute:NSForegroundColorAttributeName value:[UIColor colorTextBlack] range:redRangeAll];
    
    [noteStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:CGFloatIn750(32)] range:redRangeUnit];
    [noteStr addAttribute:NSForegroundColorAttributeName value:[UIColor colorMain] range:redRangeUnit];
    
    [self.contentLabel setAttributedText:noteStr];
    
    [self.contentLabel sizeToFit];
    
    self.alpha = 0;
    self.frame = CGRectMake(0, 0, KScreenWidth, KScreenHeight);
    [[AppDelegate shareAppDelegate].window addSubview:self];
    [UIView animateWithDuration:0.3 animations:^{
        self.alpha = 1;
        self.frame = CGRectMake(0, 0, KScreenWidth, KScreenHeight);
    }];
}

- (void)shareWithTitle:(NSString *)title handlerBlock:(void(^)(NSInteger))handleBlock {
    self.handleBlock = handleBlock;
    
    NSString *titleStr = [NSString stringWithFormat:@"%@", title];
    
    NSMutableAttributedString * noteStr = [[NSMutableAttributedString alloc]initWithString:titleStr];
    
    NSRange redRangeTwo = NSMakeRange([[noteStr string] rangeOfString:title].location, [[noteStr string] rangeOfString:title].length);
    
    [noteStr addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:CGFloatIn750(30)] range:redRangeTwo];
    [noteStr addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:redRangeTwo];
    
    
    [self.contentLabel setAttributedText:noteStr];
    
    [self.contentLabel sizeToFit];
    
    self.alpha = 0;
    self.frame = CGRectMake(0, 0, KScreenWidth, KScreenHeight);
    [[AppDelegate shareAppDelegate].window addSubview:self];
    [UIView animateWithDuration:0.3 animations:^{
        self.alpha = 1;
        self.frame = CGRectMake(0, 0, KScreenWidth, KScreenHeight);
    }];
}

+ (void)setPre_title:(NSString *)pre_title reduce_weight:(NSString *)reduce_weight after_title:(NSString *)after_title  handlerBlock:(void(^)(NSInteger))handleBlock {
    if (pre_title && reduce_weight && after_title) {
        [[ZShareView sharedManager] setPre_title:pre_title reduce_weight:reduce_weight after_title:after_title handlerBlock:handleBlock];
    }
}

+ (void)shareWithtitle:(NSString *)title  handlerBlock:(void(^)(NSInteger))handleBlock {
    [[ZShareView sharedManager] shareWithTitle:title handlerBlock:handleBlock];
}
@end

