//
//  ZLessonWeekSectionView.m
//  NoWait
//
//  Created by zhuang zhang on 2020/4/14.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZLessonWeekSectionView.h"
#import "ZLessonWeekHandlerItemBtnView.h"

@interface ZLessonWeekSectionView ()
@property (nonatomic,strong) NSMutableArray *btnArr;

@end

@implementation ZLessonWeekSectionView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initMainView];
    }
    return self;
}

#pragma mark 初始化view
- (void)initMainView {
    self.backgroundColor = adaptAndDarkColor([UIColor colorWhite], [UIColor colorBlackBGDark]);
    self.clipsToBounds = YES;
    self.layer.masksToBounds = YES;
    
    _btnArr = @[].mutableCopy;
    
    UIView *tempView = nil;
    for (int i = 0; i < 7; i++) {
        UIView * sView = [self getBtnIndex:i];
        [_btnArr addObject:sView];
        [self addSubview:sView];
        [sView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self);
            make.bottom.equalTo(self.mas_bottom).offset(-CGFloatIn750(2));
            if (tempView) {
                make.left.equalTo(tempView.mas_right);
            }else{
                make.left.equalTo(self.mas_left);
            }
            make.width.mas_equalTo(KScreenWidth/7.0f);
        }];
        
        tempView = sView;
    }
    
    UIView *bottomLineView = [[UIView alloc] initWithFrame:CGRectZero];
    bottomLineView.backgroundColor = adaptAndDarkColor([UIColor colorGrayLine], [UIColor colorGrayLineDark]);
    [self addSubview:bottomLineView];
    [bottomLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self);
        make.left.equalTo(self.mas_left).offset(CGFloatIn750(30));
        make.right.equalTo(self.mas_right).offset(-CGFloatIn750(30));
        make.height.mas_equalTo(0.5);
    }];
}


- (ZLessonWeekHandlerItemBtnView *)getBtnIndex:(NSInteger)index{
    ZLessonWeekHandlerItemBtnView *menuBtn = [[ZLessonWeekHandlerItemBtnView alloc] initWithFrame:CGRectZero];
    menuBtn.tag = index;
    menuBtn.handerBlock = ^(NSDate * date) {
        
    };
    
    return menuBtn;
}

- (void)setDate:(NSDate *)date {
    _date = date;
    
    NSMutableArray *timeArr = @[].mutableCopy;
    [timeArr addObject:date];
    
    NSInteger weekIndex =  date.weekday;
    NSInteger timeInt = [date timeIntervalSince1970];
    
    for (NSInteger i = weekIndex+1; i <= 8; i++) {
        
        timeInt += 3600*24;
        [timeArr addObject:[NSDate dateWithTimeIntervalSince1970:timeInt]];
    }
    
    timeInt = [date timeIntervalSince1970];
    for (NSInteger i = weekIndex-1; i > 1; i--) {
        timeInt -= 3600*24;
        [timeArr insertObject:[NSDate dateWithTimeIntervalSince1970:timeInt] atIndex:0];
    }
    
    
    [self.btnArr enumerateObjectsUsingBlock:^(ZLessonWeekHandlerItemBtnView * obj, NSUInteger idx, BOOL * _Nonnull stop) {
        obj.date = timeArr[idx];
    }];
}
@end
