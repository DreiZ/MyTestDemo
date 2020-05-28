//
//  ZDatePickerManager.m
//  NoWait
//
//  Created by zhuang zhang on 2020/2/27.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZDatePickerManager.h"


static ZDatePickerManager *sharedDateManager;

@interface ZDatePickerManager ()<PGDatePickerDelegate>
@property (nonatomic,strong) UIViewController *viewController;
@property (nonatomic,assign) PGDatePickerMode datePickerMode;
@property (nonatomic,strong) PGDatePickManager *datePickManager;
@property (nonatomic,strong) PGDatePicker *datePicker;
@property (nonatomic,strong) void (^handleBlock)(NSDateComponents *);
@end

@implementation ZDatePickerManager
//
//+ (ZDatePickerManager *)sharedManager {
//    @synchronized (self) {
//        if (!sharedDateManager) {
//            sharedDateManager = [[ZDatePickerManager alloc] init];
//        }
//    }
//    return sharedDateManager;
//}


- (instancetype)initWithMode:(PGDatePickerMode)datePickerMode {
    self = [super init];
    if (self) {
        sharedDateManager = self;
        self.datePickerMode = datePickerMode;
        [self setup];
    }
    return self;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)setup {
    self.datePickManager.datePicker.delegate = self;
}

- (PGDatePickManager *)datePickManager {
    if (!_datePickManager) {
        _datePickManager = [[PGDatePickManager alloc]init];
        PGDatePicker *datePicker = _datePickManager.datePicker;
        datePicker.delegate = self;
        datePicker.datePickerMode = self.datePickerMode;
        _datePicker = datePicker;
        
        _datePickManager.style = PGDatePickManagerStyleAlertTopButton;
        _datePickManager.titleLabel.text = @"选择日期";
        _datePickManager.titleLabel.font = [UIFont boldFontTitle];
        _datePickManager.titleLabel.textColor = adaptAndDarkColor([UIColor colorTextBlack], [UIColor colorTextBlackDark]);
        _datePickManager.headerHeight = CGFloatIn750(116);
        _datePickManager.headerViewBackgroundColor = adaptAndDarkColor([UIColor whiteColor], [UIColor colorBlackBGDark]);
        //设置半透明的背景颜色
        _datePickManager.isShadeBackground = true;
        //设置头部的背景颜色
        _datePickManager.headerViewBackgroundColor = adaptAndDarkColor([UIColor colorWhite], [UIColor colorBlackBGDark]);
        
        _datePickManager.datePicker.lineBackgroundColor =  adaptAndDarkColor([UIColor colorWhite], [UIColor colorBlackBGDark]);
        
        _datePickManager.datePicker.backgroundColor =  adaptAndDarkColor([UIColor colorWhite], [UIColor colorBlackBGDark]);
        
        //设置线条的颜色
        datePicker.lineBackgroundColor = adaptAndDarkColor([UIColor colorGrayLine], [UIColor colorGrayLineDark]);
        //设置选中行的字体颜色
        datePicker.textColorOfSelectedRow = adaptAndDarkColor([UIColor colorMain], [UIColor colorMainDark]);
        //设置未选中行的字体颜色
        datePicker.textColorOfOtherRow = adaptAndDarkColor([UIColor colorTextGray], [UIColor colorTextGrayDark]);
        //设置取消按钮的字体颜色
        _datePickManager.cancelButtonTextColor = adaptAndDarkColor([UIColor colorTextGray1], [UIColor colorTextGray1Dark]);
        //设置取消按钮的字
        _datePickManager.cancelButtonText = @"取消";
        //设置取消按钮的字体大小
        _datePickManager.cancelButtonFont = [UIFont fontContent];
        
        //设置确定按钮的字体颜色
        _datePickManager.confirmButtonTextColor = adaptAndDarkColor([UIColor colorMain], [UIColor colorMainDark]);
        //设置确定按钮的字
        _datePickManager.confirmButtonText = @"确定";
        //设置确定按钮的字体大小
        _datePickManager.confirmButtonFont = [UIFont fontContent];
        
        
        // 自定义收起动画逻辑
//        _datePickManager.customDismissAnimation = ^NSTimeInterval(UIView *dismissView, UIView *contentView) {
//            NSTimeInterval duration = 0.5;
//            [UIView animateWithDuration:duration animations:^{
//                contentView.frame = (CGRect){{contentView.frame.origin.x, CGRectGetMaxY([AppDelegate shareAppDelegate].window.bounds)}, contentView.bounds.size};
//            } completion:^(BOOL finished) {
//            }];
//            return duration;
//        };
    }
    return _datePickManager;
}

- (void)showDatePicker {
    if (!_viewController) {
        [[AppDelegate shareAppDelegate].getCurrentVC presentViewController:self.datePickManager animated:YES completion:nil];
    }else{
        [_viewController presentViewController:self.datePickManager animated:YES completion:nil];
    }
}

#pragma mark - 展示
- (void)showDatePickerWithTitle:(NSString *)title type:(PGDatePickerMode)type handle:(void(^)(NSDateComponents *))handleBlock {
    self.datePickManager.titleLabel.text = title;
    _handleBlock = handleBlock;
    self.datePickManager.datePicker.datePickerMode = type;
    self.datePickManager.datePicker.delegate = self;
    [self showDatePicker];
    
}

- (void)showDatePickerWithTitle:(NSString *)title type:(PGDatePickerMode)type viewController:(UIViewController *)viewController handle:(void(^)(NSDateComponents *))handleBlock {
    _viewController = viewController;
    _handleBlock = handleBlock;
    self.datePickManager.datePicker.delegate = self;
    [self showDatePickerWithTitle:title type:type handle:handleBlock];
}

+ (void)showDatePickerWithTitle:(NSString *)title type:(PGDatePickerMode)type handle:(void(^)(NSDateComponents *))handleBlock {
    ZDatePickerManager *datepicker = [[ZDatePickerManager alloc] initWithMode:type];
    [datepicker showDatePickerWithTitle:title type:type handle:handleBlock];
}


+ (void)showDatePickerWithTitle:(NSString *)title type:(PGDatePickerMode)type showDate:(NSDate *)showDate handle:(void(^)(NSDateComponents *))handleBlock {
    ZDatePickerManager *datepicker = [[ZDatePickerManager alloc] initWithMode:type];
    
    if (showDate) {
        [datepicker.datePicker setDate:showDate];
    }
    
    [datepicker showDatePickerWithTitle:title type:type handle:handleBlock];
}

+ (void)showDatePickerWithTitle:(NSString *)title type:(PGDatePickerMode)type viewController:(UIViewController *)viewController handle:(void(^)(NSDateComponents *))handleBlock {
    ZDatePickerManager *datepicker = [[ZDatePickerManager alloc] initWithMode:type];
    datepicker.viewController = viewController;
    [datepicker showDatePickerWithTitle:title type:type handle:handleBlock];
}


#pragma PGDatePickerDelegate
- (void)datePicker:(PGDatePicker *)datePicker didSelectDate:(NSDateComponents *)dateComponents {
    DLog(@"dateComponents = %@", dateComponents);
    if (_handleBlock) {
        _handleBlock(dateComponents);
    }
}

@end
