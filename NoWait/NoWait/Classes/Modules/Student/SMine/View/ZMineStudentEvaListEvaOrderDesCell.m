//
//  ZMineStudentEvaListEvaOrderDesCell.m
//  NoWait
//
//  Created by zhuang zhang on 2020/1/14.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZMineStudentEvaListEvaOrderDesCell.h"

@interface ZMineStudentEvaListEvaOrderDesCell ()

@property (nonatomic,strong) UILabel *evaTitleLabel;@end

@implementation ZMineStudentEvaListEvaOrderDesCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupView];
    }
    return self;
}

-(void)setupView {
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.contentView.backgroundColor = KAdaptAndDarkColor([UIColor colorWhite], K1aBackColor);
    
    [self.contentView addSubview:self.evaTitleLabel];
    
    [self.evaTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).offset(CGFloatIn750(24));
        make.right.equalTo(self.contentView.mas_right).offset(CGFloatIn750(-24));
        make.top.equalTo(self.contentView.mas_top).offset(CGFloatIn750(18));
    }];
   
}


#pragma mark -Getter

- (UILabel *)evaTitleLabel {
    if (!_evaTitleLabel) {
        _evaTitleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _evaTitleLabel.textColor = KAdaptAndDarkColor(KFont3Color, KFont9Color);
        _evaTitleLabel.text = @"教练评价";
        _evaTitleLabel.numberOfLines = 0;
        _evaTitleLabel.textAlignment = NSTextAlignmentLeft;
        [_evaTitleLabel setFont:[UIFont systemFontOfSize:CGFloatIn750(26)]];
    }
    return _evaTitleLabel;
}


+(CGFloat)z_getCellHeight:(id)sender {
    NSString *eva = sender;
    if (!eva || eva.length < 0) {
        return 0;
    }
    
    CGSize tsize = [eva tt_sizeWithFont:[UIFont systemFontOfSize:CGFloatIn750(24)] constrainedToSize:CGSizeMake(KScreenWidth - CGFloatIn750(48), MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping lineSpace:CGFloatIn750(14)];

    return CGFloatIn750(24) + tsize.height;
}

- (void)setEvaDes:(NSString *)evaDes {
    _evaDes = evaDes;
    _evaTitleLabel.text = evaDes;
    
    [ZPublicTool setLineSpacing:CGFloatIn750(14) label:self.evaTitleLabel];
}
@end


