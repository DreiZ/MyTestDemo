//
//  ZOrganizationEvaListEvaBtnCell.m
//  NoWait
//
//  Created by zhuang zhang on 2020/3/20.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZOrganizationEvaListEvaBtnCell.h"

@interface ZOrganizationEvaListEvaBtnCell ()
@property (nonatomic,strong) UIButton *evaBtn;
@end

@implementation ZOrganizationEvaListEvaBtnCell


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupView];
    }
    return self;
}

-(void)setupView {
    [super setupView];
    
    [self.contentView addSubview:self.evaBtn];
    [self.evaBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView.mas_right).offset(-CGFloatIn750(30));
        make.centerY.equalTo(self.contentView.mas_centerY).offset(-CGFloatIn750(10));
        make.width.mas_equalTo(CGFloatIn750(136));
        make.height.mas_equalTo(CGFloatIn750(44));
    }];
}


- (UIButton *)evaBtn {
    if (!_evaBtn) {
        _evaBtn = [[ZButton alloc] initWithFrame:CGRectZero];
        [_evaBtn setTitle:@"回复评价" forState:UIControlStateNormal];
        [_evaBtn setTitleColor:adaptAndDarkColor([UIColor colorMain], [UIColor colorMainDark]) forState:UIControlStateNormal];
        [_evaBtn.titleLabel setFont:[UIFont fontSmall]];
        ViewBorderRadius(_evaBtn, CGFloatIn750(22), 1, adaptAndDarkColor([UIColor colorMain], [UIColor colorMainDark]));
        __weak typeof(self) weakSelf = self;
        [_evaBtn bk_addEventHandler:^(id sender) {
            if (weakSelf.evaBlock) {
                weakSelf.evaBlock(1);
            }
        } forControlEvents:UIControlEventTouchUpInside];
    }
    return _evaBtn;
}

+ (CGFloat)z_getCellHeight:(id)sender {
    return CGFloatIn750(104);
}

- (void)traitCollectionDidChange:(UITraitCollection *)previousTraitCollection {
    ViewBorderRadius(_evaBtn, CGFloatIn750(22), 1, adaptAndDarkColor([UIColor colorMain], [UIColor colorMainDark]));
}
@end
