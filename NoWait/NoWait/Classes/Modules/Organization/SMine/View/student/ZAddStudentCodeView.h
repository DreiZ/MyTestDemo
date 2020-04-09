//
//  ZAddStudentCodeView.h
//  NoWait
//
//  Created by zhuang zhang on 2020/4/9.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZOriganizationModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface ZAddStudentCodeView : UIView
@property (nonatomic,strong) ZOriganizationStudentCodeAddModel *model;
@property (nonatomic,strong) UIView *topView;
@property (nonatomic,strong) UIView *bottomView;

@property (nonatomic,strong) UIImageView *codeImageView;
@property (nonatomic,strong) UIImageView *userImageView;
@property (nonatomic,strong) void (^handleBlock)(NSInteger);
@end

NS_ASSUME_NONNULL_END
