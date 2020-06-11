//
//  HNUpdateAlertView.h
//  hntx
//
//  Created by RoyLei on 2018/9/7.
//  Copyright © 2018年 LaKa. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HNUpdateAlertView : UIView

@property (strong, nonatomic) UILabel *versionLabel;
@property (strong, nonatomic) UITextView *contentTextView;
@property (strong, nonatomic) UIButton *updateButton;
@property (strong, nonatomic) UIButton *cancleButton;

@property (copy, nonatomic) NSString *contentText;

- (void)setContentText:(NSString *)contentText force_upgrade:(BOOL)isForce ;
@end
