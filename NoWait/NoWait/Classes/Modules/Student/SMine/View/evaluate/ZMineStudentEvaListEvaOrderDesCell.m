//
//  ZMineStudentEvaListEvaOrderDesCell.m
//  NoWait
//
//  Created by zhuang zhang on 2020/1/14.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZMineStudentEvaListEvaOrderDesCell.h"

@interface ZMineStudentEvaListEvaOrderDesCell ()

@property (nonatomic,strong) UILabel *evaTitleLabel;
@end

@implementation ZMineStudentEvaListEvaOrderDesCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupView];
    }
    return self;
}

-(void)setupView {
    [super setupView];
    
    [self.contentView addSubview:self.evaTitleLabel];
    
    [self.evaTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).offset(CGFloatIn750(30));
        make.right.equalTo(self.contentView.mas_right).offset(CGFloatIn750(-30));
        make.top.equalTo(self.contentView.mas_top).offset(CGFloatIn750(0));
    }];
}


#pragma mark -Getter

- (UILabel *)evaTitleLabel {
    if (!_evaTitleLabel) {
        _evaTitleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _evaTitleLabel.textColor = adaptAndDarkColor([UIColor colorTextBlack], [UIColor colorTextBlackDark]);
        _evaTitleLabel.text = @"教师评价";
        _evaTitleLabel.numberOfLines = 0;
        _evaTitleLabel.textAlignment = NSTextAlignmentLeft;
        [_evaTitleLabel setFont:[UIFont fontSmall]];
    }
    return _evaTitleLabel;
}


+(CGFloat)z_getCellHeight:(id)sender {
    NSString *eva = sender;
    if (!eva || eva.length < 0) {
        return 0;
    }
    
    CGSize tsize = [eva tt_sizeWithFont:[UIFont fontSmall] constrainedToSize:CGSizeMake(KScreenWidth - CGFloatIn750(120), MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping lineSpace:CGFloatIn750(10)];

    return CGFloatIn750(24) + tsize.height;
}

- (void)setEvaDes:(NSString *)evaDes {
    _evaDes = evaDes;
    _evaTitleLabel.text = evaDes;
    
    [ZPublicTool setLineSpacing:CGFloatIn750(10) label:self.evaTitleLabel];
}
@end


