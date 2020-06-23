//
//  ZOrganizationCardAddStudentCell.m
//  NoWait
//
//  Created by zhuang zhang on 2020/6/23.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZOrganizationCardAddStudentCell.h"

#define btnHeight CGFloatIn750(54)
#define btnAddWidth CGFloatIn750(48)
#define leftX CGFloatIn750(30)
#define labelBack @"   X"

@interface ZOrganizationCardAddStudentCell ()
@property (nonatomic,strong) UIView *labelView;
@property (nonatomic,strong) NSMutableArray *btnArr;

@end

@implementation ZOrganizationCardAddStudentCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupView];
    }
    return self;
}

-(void)setupView {
    _btnArr = @[].mutableCopy;
    
    [self.contentView addSubview:self.labelView];
    [self.labelView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView);
    }];
}

- (UIView *)labelView {
    if (!_labelView) {
        _labelView = [[UIView alloc] init];
        _labelView.layer.masksToBounds = YES;
    }
    return _labelView;
}

- (void)setList:(NSMutableArray *)list {
    _list = list;
    
    [self setLabel];
}

- (void)setLabel {
    [self.labelView removeAllSubviews];
    
    CGFloat maxWidth = KScreenWidth - 2 * leftX;
    CGFloat offSetX = leftX;
    CGFloat offSetY = CGFloatIn750(24);
    for (int i = 0; i< _list.count; i++) {
        ZOriganizationStudentListModel *model = _list[i];
        UIButton *btn = [self getHotSearchBtnItem:i];
        [btn setTitle:[NSString stringWithFormat:@"%@%@", model.name,labelBack] forState:UIControlStateNormal];
        [self.labelView addSubview:btn];
        CGFloat width = [self getTheStringWidth:[NSString stringWithFormat:@"%@%@", model.name,labelBack] font:[UIFont systemFontOfSize:14]];
        width += btnAddWidth;
        if (offSetX+width > maxWidth) {
            offSetX = leftX;
            offSetY += CGFloatIn750(20) + btnHeight;
        }
        btn.frame = CGRectMake(offSetX, offSetY, width, btnHeight);
        offSetX += (width+leftX);
    }
}


- (CGFloat) getTheStringWidth:(NSString *)str font:(UIFont *)font
{
    return  [str sizeWithAttributes:@{NSFontAttributeName: font}].width;
}

-(UIButton*) getHotSearchBtnItem:(NSInteger)index
{
    if (index >= _btnArr.count) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.tag = index;
        btn.titleLabel.font = [UIFont systemFontOfSize:14];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        btn.layer.cornerRadius = btnHeight/2.0;
        btn.layer.masksToBounds = YES;
        btn.backgroundColor = adaptAndDarkColor([UIColor colorMain], [UIColor colorMainDark]);
        [btn addTarget:self action:@selector(selectedBtnOnClick:) forControlEvents:UIControlEventTouchUpInside];
        
        [_btnArr addObject:btn];
    }
    
    return _btnArr[index];
}

- (void)selectedBtnOnClick:(UIButton *)sender {
    if (sender.tag < self.list.count && self.list.count == self.btnArr.count) {
        [self.list removeObjectAtIndex:sender.tag];
        [self.btnArr removeObjectAtIndex:sender.tag];
        [self setLabel];
    }
}

+ (CGFloat)z_getCellHeight:(id)sender {
    if (sender && [sender isKindOfClass:[NSArray class]]) {
        NSArray *list = sender;
        if (list.count == 0) {
            return 1;
        }
        CGFloat labelHeight = CGFloatIn750(24);
        CGFloat maxWidth = KScreenWidth - 2 * leftX;
        CGFloat offSetX = leftX;
        CGFloat offSetY = CGFloatIn750(24);
        for (int i = 0; i< list.count; i++) {
            ZOriganizationStudentListModel *model = list[i];
            CGFloat width = [self getTheStringWidth:[NSString stringWithFormat:@"%@%@", model.name,labelBack] font:[UIFont systemFontOfSize:14]];
            width += btnAddWidth;
            if (offSetX+width > maxWidth) {
                offSetX = leftX;
                offSetY += CGFloatIn750(20) + btnHeight;
            }
            offSetX += (width+leftX);
        }
        labelHeight = offSetY + btnHeight;
        return labelHeight;
    }
    return 0;
}


+ (CGFloat) getTheStringWidth:(NSString *)str font:(UIFont *)font
{
    return  [str sizeWithAttributes:@{NSFontAttributeName: font}].width;
}
@end
