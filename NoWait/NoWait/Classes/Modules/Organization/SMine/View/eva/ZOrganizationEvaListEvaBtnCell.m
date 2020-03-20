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
        make.centerY.equalTo(self.contentView.mas_centerY);
        make.width.mas_equalTo(CGFloatIn750(136));
        make.height.mas_equalTo(CGFloatIn750(44));
    }];
}


- (UIButton *)evaBtn {
    if (!_evaBtn) {
        _evaBtn = [[UIButton alloc] initWithFrame:CGRectZero];
        [_evaBtn setTitle:@"回复评价" forState:UIControlStateNormal];
        [_evaBtn setTitleColor:[UIColor colorMain] forState:UIControlStateNormal];
        [_evaBtn.titleLabel setFont:[UIFont fontSmall]];
        ViewBorderRadius(_evaBtn, CGFloatIn750(22), 1, [UIColor colorMain]);
        __weak typeof(self) weakSelf = self;
        [_evaBtn bk_whenTapped:^{
            if (weakSelf.evaBlock) {
                weakSelf.evaBlock(1);
            }
        }];
    }
    return _evaBtn;
}

+ (CGFloat)z_getCellHeight:(id)sender {
    return CGFloatIn750(124);
}
@end
