//
//  ZStudentTestCell.m
//  NoWait
//
//  Created by zhuang zhang on 2020/6/4.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZStudentTestCell.h"
#import "ZNumberCalculateView.h"

@interface ZStudentTestCell ()
@property (nonatomic,strong) ZNumberCalculateView *number;

@end

@implementation ZStudentTestCell
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
    self.contentView.backgroundColor = adaptAndDarkColor([UIColor colorWhite], [UIColor colorBlackBGDark]);
    
    [self.contentView addSubview:self.number];
    [self.number mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView.mas_centerY);
        make.width.mas_equalTo(CGFloatIn750(240));
        make.top.bottom.equalTo(self.contentView);
        make.right.equalTo(self.contentView.mas_right).offset(-CGFloatIn750(40));
    }];
    self.number.unit = @"节  ";
    
    _number.resultNumber = ^(NSInteger number) {
        DLog(@"%ld>>>resultBlock>>",number);
    };
}

- (ZNumberCalculateView *)number {
    if (!_number) {
        _number = [[ZNumberCalculateView alloc] initWithNumberWidth:CGFloatIn750(210) height:CGFloatIn750(60)];
        _number.numCornerRadius = 6;
        _number.showNum = 9;
        _number.multipleNum = 22;//数值增减基数（倍数增减） 默认1的倍数增减
        _number.minNum = 2;
        _number.maxNum = 999;//最大值
    }
    return _number;
}

+(CGFloat)z_getCellHeight:(id)sender {
    return 60;
}
@end
