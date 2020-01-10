//
//  ZStudentLessonSelectTimeSubCell.m
//  NoWait
//
//  Created by zhuang zhang on 2020/1/10.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZStudentLessonSelectTimeSubCell.h"

@interface ZStudentLessonSelectTimeSubCell ()
@property (nonatomic,strong) UIView *timeView;

@end

@implementation ZStudentLessonSelectTimeSubCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupView];
    }
    return self;
}

-(void)setupView {
    self.contentView.backgroundColor = KWhiteColor;
    self.clipsToBounds = YES;
    self.selectionStyle = UITableViewCellSelectionStyleNone;

    [self.contentView addSubview:self.timeView];
    [self.timeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.top.equalTo(self.mas_top).offset(CGFloatIn750(10));
        make.bottom.equalTo(self.mas_bottom).offset(-CGFloatIn750(40));
    }];
}

- (UIView *)timeView {
    if (!_timeView) {
        _timeView = [[UIView alloc] init];
        _timeView.layer.masksToBounds = YES;
        _timeView.backgroundColor = KWhiteColor;
    }
    return _timeView;
}

- (UIView *)getViewWithText:(NSString *)text leftX:(CGFloat)leftX topY:(CGFloat)topY  tag:(NSInteger)index{
    ZStudentDetailLessonTimeSubModel *model = self.list[index];
    __weak typeof(self) weakSelf = self;
    UIButton *timeBtn = [[UIButton alloc] initWithFrame:CGRectMake(leftX, topY, CGFloatIn750(120), CGFloatIn750(50))];
    [timeBtn setTitle:text forState:UIControlStateNormal];
    [timeBtn setTitleColor:KFont2Color forState:UIControlStateNormal];
    [timeBtn setTitleColor:KMainColor forState:UIControlStateSelected];
    [timeBtn.titleLabel setFont:[UIFont systemFontOfSize:CGFloatIn750(22)]];
    timeBtn.tag = index;
    timeBtn.selected = model.isSubTimeSelected;
    [timeBtn bk_addEventHandler:^(UIButton *sender) {
        if (weakSelf.timeBlock) {
            weakSelf.timeBlock(sender.tag);
        }
    } forControlEvents:UIControlEventTouchUpInside];
    
    
    return timeBtn;
}

- (void)setList:(NSArray<ZStudentDetailLessonTimeSubModel *> *)list {
    _list = list;
    [_timeView removeAllSubviews];
    
    CGFloat width = KScreenWidth - CGFloatIn750(300);
    CGFloat space = (width - CGFloatIn750(120) * 3)/4;
    CGFloat leftX = space;
    CGFloat topY = 0;
   for (int i = 0; i < list.count; i++) {
       if (i % 3 == 0) {
           leftX = space;
       }
       if (i != 0 && i % 3 == 0) {
           topY += CGFloatIn750(50) + CGFloatIn750(42);
       }
       
       ZStudentDetailLessonTimeSubModel *model = list[i];
       UIView *label = [self getViewWithText:model.subTime leftX:leftX topY:topY tag:i];
       [self.timeView addSubview:label];
       
       leftX += CGFloatIn750(120) + space;
   }
}

+(CGFloat)z_getCellHeight:(id)sender {
    NSArray *list = sender;
    
    if ((list.count + 1) % 3 == 0) {
        return CGFloatIn750(150) * list.count / 3  + CGFloatIn750(160);
    }else{
        return CGFloatIn750(150) * (list.count / 3 + 1) + CGFloatIn750(160);
    }
}

@end
