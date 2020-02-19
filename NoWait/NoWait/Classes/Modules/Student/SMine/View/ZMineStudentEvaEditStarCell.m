//
//  ZMineStudentEvaEditStarCell.m
//  NoWait
//
//  Created by zhuang zhang on 2020/1/14.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZMineStudentEvaEditStarCell.h"
#import "CWStarRateView.h"

@interface ZMineStudentEvaEditStarCell ()<CWStarRateViewDelegate>

@property (nonatomic,strong) UILabel *evaTitleLabel;
@property (nonatomic,strong) UILabel *evaDesLabel;
@property (nonatomic,strong) CWStarRateView *crView;
@end

@implementation ZMineStudentEvaEditStarCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupView];
    }
    return self;
}

-(void)setupView {
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.contentView.backgroundColor = adaptAndDarkColor([UIColor colorWhite], [UIColor colorBlackBGDark]);
    
    [self.contentView addSubview:self.evaTitleLabel];
    [self.contentView addSubview:self.evaDesLabel];
    [self.contentView addSubview:self.crView];
    
    [self.evaTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).offset(CGFloatIn750(36));
        make.centerY.equalTo(self.contentView.mas_centerY);
    }];
    
    [self.crView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(CGFloatIn750(30));
        make.left.equalTo(self.evaTitleLabel.mas_right).offset(CGFloatIn750(34));
        make.width.offset(CGFloatIn750(230.));
        make.centerY.equalTo(self.mas_centerY);
    }];
    
   [self.evaDesLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       make.left.equalTo(self.crView.mas_right).offset(CGFloatIn750(34));
       make.centerY.equalTo(self.contentView.mas_centerY);
   }];

    
}


#pragma mark -Getter

-(CWStarRateView *)crView
{
    if (!_crView) {
        _crView = [[CWStarRateView alloc] init];
        _crView.hasAnimation = YES;
        _crView.allowIncompleteStar = YES;
        _crView.allowUserInteraction = YES;
    }
    return _crView;
}


- (UILabel *)evaTitleLabel {
    if (!_evaTitleLabel) {
        _evaTitleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _evaTitleLabel.textColor = [UIColor colorTextGray];
        _evaTitleLabel.text = @"教练评价";
        _evaTitleLabel.numberOfLines = 1;
        _evaTitleLabel.textAlignment = NSTextAlignmentLeft;
        [_evaTitleLabel setFont:[UIFont fontSmall]];
    }
    return _evaTitleLabel;
}


- (UILabel *)evaDesLabel {
    if (!_evaDesLabel) {
        _evaDesLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _evaDesLabel.textColor = adaptAndDarkColor([UIColor colorTextGray1], [UIColor colorTextGray1Dark]);
        _evaDesLabel.text = @"很好";
        _evaDesLabel.numberOfLines = 1;
        _evaDesLabel.textAlignment = NSTextAlignmentLeft;
        [_evaDesLabel setFont:[UIFont fontSmall]];
    }
    return _evaDesLabel;
}


+(CGFloat)z_getCellHeight:(id)sender {
    return CGFloatIn750(40);
}

#pragma mark -star delegate
-(void)starRateView:(CWStarRateView *)starRateView scroePercentDidChange:(CGFloat)newScorePercent {
    NSLog(@"------------  %f",newScorePercent);
}
@end

