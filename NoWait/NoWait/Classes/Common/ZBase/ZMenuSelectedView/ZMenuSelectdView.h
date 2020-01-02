//
//  ZMenuSelectdView.h
//  ZBigHealth
//
//  Created by zhuang zhang on 2018/11/21.
//  Copyright © 2018 zhuang zhang. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ZMenuSelectdView : UIView
@property (nonatomic, strong) NSArray *titleArr;
@property (nonatomic, strong) NSString *topIndex;
@property (nonatomic, strong) NSMutableArray *numLabelArr;
@property (nonatomic, strong) NSMutableArray *numArr;

@property (nonatomic, strong) void (^selectBlock)(NSInteger index);

- (instancetype)initWithFrame:(CGRect)frame withTitleArr:(NSArray *)titleArr topIndex:(NSString *)topIndex;
- (void)setOffset:(CGFloat)offset;
@end

