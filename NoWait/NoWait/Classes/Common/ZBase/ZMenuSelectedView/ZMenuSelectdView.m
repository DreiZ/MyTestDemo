//
//  ZMenuSelectdView.m
//  ZBigHealth
//
//  Created by zhuang zhang on 2018/11/21.
//  Copyright © 2018 zhuang zhang. All rights reserved.
//

#import "ZMenuSelectdView.h"

#define TopViewHeight CGFloatIn750(98)

@interface ZMenuSelectdView ()
@property (nonatomic, strong) NSMutableArray *selectedBtnArr;
@property (nonatomic, strong) NSMutableArray *ratioWidthArr;

@property (nonatomic, assign) NSInteger selectedIndex;
@property (nonatomic, assign) NSInteger selectedLastIndex;

@property (nonatomic, strong) UIButton *lastSelectedBtn;
@property (nonatomic, strong) UIView *selectedLineView;
@end

@implementation ZMenuSelectdView

- (instancetype)initWithFrame:(CGRect)frame withTitleArr:(NSArray *)titleArr topIndex:(NSString *)topIndex{
    self = [super initWithFrame:frame];
    if (self) {
        self.titleArr = titleArr;
        self.topIndex = topIndex;
        [self initSubViews];
    }
    return self;
}

- (void)initSubViews {
    _selectedBtnArr = [[NSMutableArray alloc] init];
    _ratioWidthArr = [[NSMutableArray alloc] init];
    _numLabelArr = [[NSMutableArray alloc] init];
    
    UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, TopViewHeight)];
    topView.backgroundColor = [UIColor whiteColor];
    [self addSubview:topView];
    
    NSString *tempStr = @"";
    for (int i = 0; i < _titleArr.count; i++) {
        tempStr = [NSString stringWithFormat:@"%@%@",tempStr,_titleArr[i]];
    }
    
    CGSize titleWidth = [tempStr tt_sizeWithFont:[UIFont systemFontOfSize:CGFloatIn750(30)]];
    CGFloat atomWidth = (KScreenWidth - titleWidth.width)/_titleArr.count;
    CGRect rc = CGRectMake(0, 0, 0, TopViewHeight);
    for (int i = 0; i < _titleArr.count; i++) {
        NSString *atomTempStr = _titleArr[i];
        CGSize atomTitleWidth = [atomTempStr tt_sizeWithFont:[UIFont systemFontOfSize:CGFloatIn750(30)]];
        rc.size.width = atomTitleWidth.width + atomWidth;
        [_ratioWidthArr addObject:[NSNumber numberWithFloat:atomTitleWidth.width + atomWidth]];
        UIButton *tempBtn = [[UIButton alloc] initWithFrame:rc];
        [tempBtn setTitle:atomTempStr forState:UIControlStateNormal];
        [tempBtn.titleLabel setFont:[UIFont systemFontOfSize:CGFloatIn750(32)]];
        [tempBtn setTitleColor:KFont6Color forState:UIControlStateNormal];
        [tempBtn setTag:i];
        [tempBtn addTarget:self action:@selector(selectedBtnOnClick:) forControlEvents:UIControlEventTouchUpInside];
        
        [topView addSubview:tempBtn];
        rc.origin.x += atomTitleWidth.width + atomWidth;
        
        if (_topIndex) {
            if (i == [_topIndex integerValue]) {
                _lastSelectedBtn = tempBtn;
                _selectedIndex = i;
            }
        }else{
            if (i == 0) {
                _lastSelectedBtn = tempBtn;
                _selectedIndex = i;
            }
        }
        
        [_selectedBtnArr addObject:tempBtn];
        
        UILabel *numLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        numLabel.layer.masksToBounds = YES;
        numLabel.layer.cornerRadius = 7.5;
        numLabel.layer.borderColor = [UIColor whiteColor].CGColor;
        //        numLabel.layer.borderWidth = 1;
        numLabel.backgroundColor = KMainColor;
        numLabel.textAlignment = NSTextAlignmentCenter;
        [numLabel setFont:[UIFont systemFontOfSize:8]];
        numLabel.textColor = [UIColor whiteColor];
        [tempBtn addSubview:numLabel];
        numLabel.hidden = YES;
        [_numLabelArr addObject:numLabel];
        [numLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(tempBtn.titleLabel.mas_right).offset(-8);
            make.width.mas_equalTo(16);
            make.top.equalTo(tempBtn.titleLabel.mas_top).offset(-10);
            make.height.mas_equalTo(16);
        }];
    }
    _selectedLastIndex = _selectedIndex;
//    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, TopViewHeight - 0.5, KScreenWidth, 0.5f)];
//    lineView.backgroundColor = KLineColor;
//    [topView addSubview:lineView];
    
    [_lastSelectedBtn setTitleColor:KMainColor forState:UIControlStateNormal];
    
    _selectedLineView  = [[UIView alloc] initWithFrame:CGRectMake(_lastSelectedBtn.frame.origin.x, TopViewHeight - 2, [_ratioWidthArr[_selectedIndex] floatValue], 2)];
    _selectedLineView.backgroundColor = KMainColor;
    [topView addSubview:_selectedLineView];
    _topIndex = [NSString stringWithFormat:@"%ld",_selectedIndex];
    [self selectedBtnOnClick:_lastSelectedBtn];
    
    
//    UIView *bottomLineView = [[UIView alloc] initWithFrame:CGRectZero];
//    bottomLineView.backgroundColor = KLineColor;
//    [self addSubview:bottomLineView];
//    [bottomLineView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.right.bottom.equalTo(self);
//        make.height.mas_equalTo(0.5);
//    }];
}


- (void)selectedBtnOnClick:(UIButton*)sender {
    if (sender  != _lastSelectedBtn) {
        [_lastSelectedBtn setTitleColor:KFont6Color forState:UIControlStateNormal];
        _lastSelectedBtn = sender;
        [_lastSelectedBtn setTitleColor:KMainColor forState:UIControlStateNormal];
        
        _selectedIndex = sender.tag;
        _selectedLastIndex = _selectedIndex;
        _selectedLineView.frame = CGRectMake(_lastSelectedBtn.frame.origin.x, TopViewHeight - 2, _lastSelectedBtn.bounds.size.width, 2.0f);
        
        _topIndex = [NSString stringWithFormat:@"%ld",_selectedIndex];
        if (_selectBlock) {
            _selectBlock(_selectedIndex);
        }
    }
}

- (void)setOffset:(CGFloat )contentOffset {
    
    //计算selectedLine位置
    CGFloat tempX = 0;
    CGFloat offsetx = 0;
    NSInteger index = 0;
    for (int i = 0; i < _ratioWidthArr.count; i++) {
        if (contentOffset - KScreenWidth * i  >= 0 ) {
            offsetx = contentOffset - KScreenWidth * i;
            index = i;
        }
    }
    
    //计算selectedLine width
    CGFloat leftWidth = 0;
    CGFloat rightWidth = 0;
    for (int i = 0; i <= index; i++) {
        CGFloat ratio = [_ratioWidthArr[i] floatValue];
        if (i == index) {
            ratio = offsetx/KScreenWidth * ratio;
        }else{
            ratio = ratio;
        }
        tempX += ratio;
    }
    if (index < _ratioWidthArr.count-1) {
        CGFloat ratioL = [_ratioWidthArr[index] floatValue];
        CGFloat ratioR = [_ratioWidthArr[index+1] floatValue];
        leftWidth = (KScreenWidth - offsetx)/KScreenWidth * ratioL;
        rightWidth = offsetx / KScreenWidth * ratioR;
    }else{
        CGFloat ratioL = [_ratioWidthArr[index] floatValue];
        leftWidth = ratioL;
        rightWidth = 0;
    }
    _selectedLineView.frame = CGRectMake(tempX, TopViewHeight-2, leftWidth + rightWidth, 2);
    
    //选择index 及 btn设置
    _selectedIndex = (contentOffset + KScreenWidth/2.0)/KScreenWidth;
    if (_selectedIndex < 0) {
        _selectedIndex = 0;
    }else if (_selectedIndex > _selectedBtnArr.count-1){
        _selectedIndex = _selectedBtnArr.count-1;
    }
    UIButton *tempBtn = _selectedBtnArr[_selectedIndex];
    [_lastSelectedBtn setTitleColor:KFont6Color forState:UIControlStateNormal];
    [tempBtn setTitleColor:KMainColor forState:UIControlStateNormal];
    if (_lastSelectedBtn==tempBtn) {
    }else{
        _lastSelectedBtn = tempBtn;
    }
    _topIndex = [NSString stringWithFormat:@"%ld",_selectedIndex];
}

- (void)setNumArr:(NSMutableArray *)numArr {
    _numArr = numArr;
    for (int i = 0; i < _numLabelArr.count; i++) {
        UILabel *numLabel = _numLabelArr[i];
        if ([numArr[i] integerValue] > 0) {
            numLabel.hidden = NO;
            CGSize titleWidth = [numArr[i] tt_sizeWithFont:[UIFont systemFontOfSize:8]];
            numLabel.text = numArr[i];
            CGFloat width = titleWidth.width;
            if (width <= 16) {
                width = 16;
            }else{
                width += 4;
            }
            UIButton *tempBtn = (UIButton *)numLabel.superview;
            [numLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(tempBtn.titleLabel.mas_right).offset(-8);
                make.width.mas_equalTo(width);
                make.top.equalTo(tempBtn.titleLabel.mas_top).offset(-10);
                make.height.mas_equalTo(16);
            }];
        }else{
            numLabel.hidden = YES;
        }
    }
}
@end
