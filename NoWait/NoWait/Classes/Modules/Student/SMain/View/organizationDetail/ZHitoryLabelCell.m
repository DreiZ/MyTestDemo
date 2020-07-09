//
//  ZHitoryLabelCell.m
//  NoWait
//
//  Created by zhuang zhang on 2020/6/8.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZHitoryLabelCell.h"

#define kLabelHeight CGFloatIn750(54)
#define kLabelSpace CGFloatIn750(28)
#define kLabelAddWidth CGFloatIn750(34)
#define kLabelSpaceY CGFloatIn750(30)

@interface ZHitoryLabelCell ()
@property (nonatomic,strong) UIView *activityView;
@property (nonatomic,strong) NSMutableArray *btnArr;

@end

@implementation ZHitoryLabelCell

-(void)setupView {
    [super setupView];
    _btnArr = @[].mutableCopy;
    [self.contentView addSubview:self.activityView];
    [self.activityView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView);
    }];
}

#pragma mark -Getter
- (UIView *)activityView {
    if (!_activityView) {
        _activityView = [[UIView alloc] init];
        _activityView.layer.masksToBounds = YES;
    }
    return _activityView;
}


- (CGFloat)setActivityData:(CGFloat)maxWidth textArr:(NSArray *)adeptArr{
    [self.activityView removeAllSubviews];
    
    CGFloat labelWidth = maxWidth;
    CGFloat leftX = CGFloatIn750(30);
    CGFloat topY = CGFloatIn750(10);

    for (int i = 0; i < adeptArr.count; i++) {
        NSString *title = adeptArr[i];
       CGSize tempSize = [title tt_sizeWithFont:[UIFont fontContent] constrainedToSize:CGSizeMake(labelWidth, MAXFLOAT)];
       if (leftX + tempSize.width + kLabelAddWidth + kLabelSpace > labelWidth) {
           topY += kLabelHeight + kLabelSpaceY;
           leftX = CGFloatIn750(30);
       }
           
       UIButton *tBtn = [[UIButton alloc] initWithFrame:CGRectMake(leftX, topY, tempSize.width+kLabelAddWidth, kLabelHeight)];
       tBtn.tag = i;
        [tBtn setTitle:title forState:UIControlStateNormal];
        [tBtn setTitleColor:adaptAndDarkColor([UIColor colorWhite], [UIColor colorWhite]) forState:UIControlStateNormal];
        [tBtn.titleLabel setFont:[UIFont fontContent]];
        tBtn.backgroundColor = adaptAndDarkColor([UIColor colorMain], [UIColor colorMain]);
        tBtn.layer.masksToBounds = YES;
        tBtn.layer.cornerRadius = kLabelHeight/2.0f;
        [tBtn addTarget:self action:@selector(btnOnclick:) forControlEvents:UIControlEventTouchUpInside];

        [_btnArr addObject:tBtn];
        [self.activityView addSubview:tBtn];
        leftX += tempSize.width+kLabelAddWidth + kLabelSpace;
    }
    
    return topY + kLabelHeight;
}

- (void)btnOnclick:(UIButton *)sender {
    if (self.handleBlock) {
        self.handleBlock(sender.titleLabel.text);
    }
}

-(void)setTitleArr:(NSArray *)titleArr {
    _titleArr = titleArr;
    
    [self setActivityData:KScreenWidth textArr:self.titleArr];
}

+(CGFloat)z_getCellHeight:(id)sender {
    NSArray *temparr = sender;
    
    if (ValidArray(temparr)) {
        return [ZHitoryLabelCell setActivityData:KScreenWidth textArr:temparr] + CGFloatIn750(20);
    }
    
    return 0;
}


+ (CGFloat)setActivityData:(CGFloat)maxWidth textArr:(NSArray *)adeptArr{
    CGFloat labelWidth = maxWidth;
    CGFloat leftX = CGFloatIn750(30);
    CGFloat topY = CGFloatIn750(10);

    for (int i = 0; i < adeptArr.count; i++) {
        NSString *title = adeptArr[i];
       CGSize tempSize = [title tt_sizeWithFont:[UIFont fontContent] constrainedToSize:CGSizeMake(labelWidth, MAXFLOAT)];
       if (leftX + tempSize.width + kLabelAddWidth + kLabelSpace > labelWidth) {
           topY += kLabelHeight + kLabelSpaceY;
           leftX = CGFloatIn750(30);
       }
        leftX += tempSize.width+kLabelAddWidth + kLabelSpace;
    }
    
    return topY + kLabelHeight + kLabelHeight;
}
@end

