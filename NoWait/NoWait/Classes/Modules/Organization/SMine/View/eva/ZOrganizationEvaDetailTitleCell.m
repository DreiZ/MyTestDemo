//
//  ZOrganizationEvaDetailTitleCell.m
//  NoWait
//
//  Created by zhuang zhang on 2020/3/20.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZOrganizationEvaDetailTitleCell.h"
#import "CWStarRateView.h"

@interface ZOrganizationEvaDetailTitleCell ()
@property (nonatomic,strong) UILabel *nameLabel;
@property (nonatomic,strong) CWStarRateView *crView;
@end

@implementation ZOrganizationEvaDetailTitleCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupView];
    }
    return self;
}

-(void)setupView {
    [super setupView];
    
    [self.contentView addSubview:self.nameLabel];
    [self.contentView addSubview:self.crView];
    
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).offset(CGFloatIn750(30));
        make.centerY.equalTo(self.contentView.mas_centerY);
    }];
   

    [self.crView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(CGFloatIn750(16));
        make.right.equalTo(self.contentView.mas_right).offset(-CGFloatIn750(30));
        make.width.offset(CGFloatIn750(110.));
        make.centerY.equalTo(self.mas_centerY);
    }];
}


#pragma mark -Getter

-(CWStarRateView *)crView
{
    if (!_crView) {
        _crView = [[CWStarRateView alloc] init];
    }
    return _crView;
}

- (UILabel *)nameLabel {
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _nameLabel.textColor = adaptAndDarkColor([UIColor colorTextBlack], [UIColor colorTextBlackDark]);
        _nameLabel.text = @"课程评价";
        _nameLabel.numberOfLines = 1;
        _nameLabel.textAlignment = NSTextAlignmentLeft;
        [_nameLabel setFont:[UIFont boldFontTitle]];
    }
    return _nameLabel;
}

- (void)setData:(NSDictionary *)data {
    if (ValidDict(data)) {
        _nameLabel.text = data[@"title"];
        _crView.scorePercent = [data[@"star"] doubleValue]/10.0f * 2;
    }
}

+(CGFloat)z_getCellHeight:(id)sender {
    return CGFloatIn750(70);
}
@end



