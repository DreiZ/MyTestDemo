//
//  ZOrganizationSchoolTypeCell.m
//  NoWait
//
//  Created by zhuang zhang on 2020/5/22.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZOrganizationSchoolTypeCell.h"

@interface ZOrganizationSchoolTypeCell ()
@property (nonatomic,strong) UIView *contView;
@property (nonatomic,strong) NSMutableArray *menuArr;

@end

@implementation ZOrganizationSchoolTypeCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupView];
    }
    return self;
}

-(void)setupView {
    [super setupView];
    self.contentView.backgroundColor = adaptAndDarkColor([UIColor colorWhite], [UIColor colorBlackBGDark]);
    self.clipsToBounds = YES;

    _menuArr = @[].mutableCopy;
    [self.contentView addSubview:self.contView];
    [self.contView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView);
    }];
}

-(void)setClassifysArr:(NSMutableArray<ZMainClassifyOneModel *> *)classifysArr {
    _classifysArr = classifysArr;
    [self.contView removeAllSubviews];
    [self.menuArr removeAllObjects];
    __block NSInteger row = 0;
    [classifysArr enumerateObjectsUsingBlock:^(ZMainClassifyOneModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        row = (idx)/3;
        UIButton *btn = [self getBtnWithText:obj.name index:idx];
        [self.contView addSubview:btn];
        CGSize tempSize = [obj.name tt_sizeWithFont:[UIFont fontSmall]];
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(CGFloatIn750(54));
            make.width.mas_equalTo(tempSize.width + CGFloatIn750(40));
            make.top.mas_equalTo((row)*CGFloatIn750(40) + row*CGFloatIn750(54));
            make.centerX.equalTo(self.mas_right).multipliedBy((idx%3 * 2 + 1)/6.0f);
        }];
    }];
}

- (UIView *)contView {
    if (!_contView) {
        _contView = [[UIView alloc] init];
        _contView.backgroundColor = adaptAndDarkColor([UIColor colorWhite], [UIColor colorBlackBGDark]);
    }
    return _contView;
}

- (NSMutableArray *)menuArr {
    if (!_menuArr) {
        _menuArr = @[].mutableCopy;
    }
    return _menuArr;
}

- (UIButton *)getBtnWithText:(NSString *)text index:(NSInteger)index{
    ZMainClassifyOneModel *model = _classifysArr[index];
    
    UIButton *menuBtn = [[UIButton alloc] initWithFrame:CGRectZero];
    menuBtn.tag = index;
    __weak typeof(self) weakSelf = self;
    [menuBtn bk_addEventHandler:^(id sender) {
        [weakSelf menuBtn:menuBtn.tag];
    } forControlEvents:UIControlEventTouchUpInside];
    [menuBtn setTitle:text forState:UIControlStateNormal];
    [menuBtn.titleLabel setFont:[UIFont fontSmall]];
    
    if (model.isSelected) {
        menuBtn.backgroundColor = adaptAndDarkColor([UIColor colorMainSub], [UIColor colorMainSub]);
        [menuBtn setTitleColor:adaptAndDarkColor([UIColor colorMain], [UIColor colorMain]) forState:UIControlStateNormal];
        ViewBorderRadius(menuBtn, CGFloatIn750(27), 1, [UIColor colorMain]);
    }else {
        menuBtn.backgroundColor = adaptAndDarkColor([UIColor colorWhite], [UIColor colorBlackBGDark]);
        [menuBtn setTitleColor:adaptAndDarkColor([UIColor colorTextBlack], [UIColor colorTextBlackDark]) forState:UIControlStateNormal];
        ViewBorderRadius(menuBtn, CGFloatIn750(27), 1, adaptAndDarkColor([UIColor colorWhite], [UIColor colorBlackBGDark]));
    }
    [self.menuArr addObject:menuBtn];
    return menuBtn;
}

- (void)menuBtn:(NSInteger)index {
    ZMainClassifyOneModel *model = _classifysArr[index];
    
    if (model.isSelected) {
        
    }else{
        UIButton *menuBtn = _menuArr[index];
        if ([menuBtn.titleLabel.text hasPrefix:@"全部"]) {
            [self setAllSelectedNO];
        }else{
            [self setAllBtnSetNO];
            
            if ([self getSelectedNum] >= 5) {
                [TLUIUtility showInfoHint:@"校区类型最多选五个"];
                return;
            }
        }
    }
    UIButton *menuBtn = _menuArr[index];
    model.isSelected = !model.isSelected;
    if (model.isSelected) {
        [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            menuBtn.backgroundColor = adaptAndDarkColor([UIColor colorMainSub], [UIColor colorMainSub]);
            [menuBtn setTitleColor:adaptAndDarkColor([UIColor colorMain], [UIColor colorMain]) forState:UIControlStateNormal];
            ViewBorderRadius(menuBtn, CGFloatIn750(27), 1, [UIColor colorMain]);
        } completion:^(BOOL finished) {
            
        }];
    }else {
        [UIView animateWithDuration:0.2 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            menuBtn.backgroundColor = adaptAndDarkColor([UIColor colorWhite], [UIColor colorBlackBGDark]);
            [menuBtn setTitleColor:adaptAndDarkColor([UIColor colorTextBlack], [UIColor colorTextBlackDark]) forState:UIControlStateNormal];
            ViewBorderRadius(menuBtn, CGFloatIn750(27), 1, adaptAndDarkColor([UIColor colorWhite], [UIColor colorBlackBGDark]));
        } completion:^(BOOL finished) {
            
        }];
    }
}

- (NSInteger)getSelectedNum {
    __block NSInteger num = 0;
    [self.classifysArr enumerateObjectsUsingBlock:^(ZMainClassifyOneModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (obj.isSelected) {
            num ++;
        }
    }];
    return num;
}


- (void)setAllSelectedNO {
    [self.classifysArr enumerateObjectsUsingBlock:^(ZMainClassifyOneModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (obj.isSelected) {
            obj.isSelected = NO;
        }
    }];
    
    [self.menuArr enumerateObjectsUsingBlock:^(UIButton *menuBtn, NSUInteger idx, BOOL * _Nonnull stop) {
        [UIView animateWithDuration:0.2 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            menuBtn.backgroundColor = adaptAndDarkColor([UIColor colorWhite], [UIColor colorBlackBGDark]);
            [menuBtn setTitleColor:adaptAndDarkColor([UIColor colorTextBlack], [UIColor colorTextBlackDark]) forState:UIControlStateNormal];
            ViewBorderRadius(menuBtn, CGFloatIn750(27), 1, adaptAndDarkColor([UIColor colorWhite], [UIColor colorBlackBGDark]));
        } completion:^(BOOL finished) {
            
        }];
    }];
}


- (void)setAllBtnSetNO {
    [self.classifysArr enumerateObjectsUsingBlock:^(ZMainClassifyOneModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj.name hasPrefix:@"全部"] && obj.isSelected) {
            obj.isSelected = NO;
        }
    }];
    
    [self.menuArr enumerateObjectsUsingBlock:^(UIButton *menuBtn, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([menuBtn.titleLabel.text hasPrefix:@"全部"]) {
            [UIView animateWithDuration:0.2 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                menuBtn.backgroundColor = adaptAndDarkColor([UIColor colorWhite], [UIColor colorBlackBGDark]);
                [menuBtn setTitleColor:adaptAndDarkColor([UIColor colorTextBlack], [UIColor colorTextBlackDark]) forState:UIControlStateNormal];
                ViewBorderRadius(menuBtn, CGFloatIn750(27), 1, adaptAndDarkColor([UIColor colorWhite], [UIColor colorBlackBGDark]));
            } completion:^(BOOL finished) {
                
            }];
        }
    }];
}

+ (CGFloat)z_getCellHeight:(id)sender {
    NSArray *classifysArr = sender;
    if (ValidArray(classifysArr)) {
        NSArray *list = sender;
        if (list.count%3 > 0) {
            return (list.count/3 + 1) * CGFloatIn750(54) + ((list.count/3) * CGFloatIn750(40))+ CGFloatIn750(20);
        }
        return list.count/3  * CGFloatIn750(54) + (list.count/3 - 1)  * CGFloatIn750(40) + CGFloatIn750(20);
    }
    return 0;
}
@end
