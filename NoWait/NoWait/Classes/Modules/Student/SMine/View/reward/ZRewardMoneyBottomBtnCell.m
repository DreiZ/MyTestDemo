//
//  ZRewardMoneyBottomBtnCell.m
//  NoWait
//
//  Created by zhuang zhang on 2020/5/6.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZRewardMoneyBottomBtnCell.h"

@implementation ZRewardMoneyBottomBtnCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupView];
    }
    return self;
}

-(void)setupView
{
    UIButton *doneBtn = [[UIButton alloc] initWithFrame:CGRectZero];
    doneBtn.layer.masksToBounds = YES;
    doneBtn.layer.cornerRadius = CGFloatIn750(50);
    [doneBtn setTitle:@"提现" forState:UIControlStateNormal];
    [doneBtn setBackgroundColor:adaptAndDarkColor([UIColor colorMain], [UIColor colorMainDark]) forState:UIControlStateNormal];
    [doneBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [doneBtn setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    [doneBtn.titleLabel setFont:[UIFont fontTitle]];
    [self.contentView addSubview:doneBtn ];
    [doneBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(CGFloatIn750(100));
        make.left.equalTo(self.contentView.mas_left).offset(CGFloatIn750(60));
        make.right.equalTo(self.contentView.mas_right).offset(-CGFloatIn750(60));
        make.centerY.equalTo(self.contentView.mas_centerY);
    }];
    
    __weak typeof(self) weakSelf = self;
    [doneBtn bk_addEventHandler:^(id sender) {
        if (weakSelf.handleBlock) {
            weakSelf.handleBlock(0);
        }
    } forControlEvents:UIControlEventTouchUpInside];
}

+(CGFloat)z_getCellHeight:(id)sender {
    return CGFloatIn750(200);
}
@end
