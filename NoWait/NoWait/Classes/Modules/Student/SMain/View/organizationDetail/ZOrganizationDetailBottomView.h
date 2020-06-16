//
//  ZOrganizationDetailBottomView.h
//  NoWait
//
//  Created by zhuang zhang on 2020/3/9.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZOrganizationDetailBottomView : UIView
@property (nonatomic,assign) BOOL isCollection;
@property (nonatomic,strong) NSString *title;

@property (nonatomic,strong) UIButton *handleBtn;
@property (nonatomic,strong) UIButton *telBtn;
@property (nonatomic,strong) UIButton *collectionBtn;
@property (nonatomic,strong) UIImageView *messageImageView;
@property (nonatomic,strong) UIView *backView;

@property (nonatomic,strong) void (^handleBlock)(NSInteger);

- (void)initMainView;
@end

NS_ASSUME_NONNULL_END
