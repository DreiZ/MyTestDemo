//
//  ZServerCompleteAlertView.m
//  ZBigHealth
//
//  Created by zhuang zhang on 2019/1/28.
//  Copyright © 2019 zhuang zhang. All rights reserved.
//

#import "ZServerCompleteAlertView.h"
#import "AppDelegate.h"

@interface ZServerCompleteAlertView ()
@property (nonatomic,strong) UIImageView *contView;

@end

@implementation ZServerCompleteAlertView

static ZServerCompleteAlertView *sharedManager;

+ (ZServerCompleteAlertView *)sharedManager {
    @synchronized (self) {
        if (!sharedManager) {
            sharedManager = [[ZServerCompleteAlertView alloc] init];
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
    
    [self addSubview:self.contView];
    [self.contView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(CGFloatIn750(684));
        make.width.mas_equalTo(CGFloatIn750(684));
        make.centerX.equalTo(self.mas_centerX);
        make.centerY.equalTo(self.mas_centerY).offset(-CGFloatIn750(80));
    }];
    
//    UIImageView *completeImageView = [[UIImageView alloc] init];
//    completeImageView.image = [UIImage imageNamed:@"serverCompleteHint"];
//    completeImageView.layer.masksToBounds = YES;
//    [self.contView addSubview:completeImageView];
//    [completeImageView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.edges.equalTo(self.contView);
//    }];
}

- (UIImageView *)contView {
    if (!_contView) {
        _contView = [[UIImageView alloc] init];
        _contView.layer.masksToBounds = YES;
        _contView.image = [UIImage imageNamed:@"serverCompleteHint"];
//        _contView.layer.cornerRadius = 6;
//        _contView.backgroundColor = [UIColor whiteColor];
    }
    
    return _contView;
}



- (void)setHandlerBlock:(void(^)(NSInteger))handleBlock {
    
    [self.contView removeAllSubviews];
    
    
    
    self.alpha = 0;
    self.frame = CGRectMake(0, 0, KScreenWidth, KScreenHeight);
    [[AppDelegate shareAppDelegate].window addSubview:self];
    [UIView animateWithDuration:0.3 animations:^{
        self.alpha = 1;
        self.frame = CGRectMake(0, 0, KScreenWidth, KScreenHeight);
    } completion:^(BOOL finished) {
        [self performSelector:@selector(dismiss) withObject:nil afterDelay:2];
    }];
}

- (void)dismiss {
    dispatch_async(dispatch_get_main_queue(), ^{
        [self removeFromSuperview];
    });
}

+ (void)setAlertWithHandlerBlock:(void(^)(NSInteger))handleBlock {
    [[ZServerCompleteAlertView sharedManager] setHandlerBlock:handleBlock];
}
@end

