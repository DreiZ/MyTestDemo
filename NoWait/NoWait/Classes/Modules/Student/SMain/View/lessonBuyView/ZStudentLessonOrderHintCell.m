//
//  ZStudentLessonOrderHintCell.m
//  NoWait
//
//  Created by zhuang zhang on 2020/1/11.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZStudentLessonOrderHintCell.h"

@interface ZStudentLessonOrderHintCell ()
@property (nonatomic,strong) YYLabel *skillLabel;
@end

@implementation ZStudentLessonOrderHintCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupView];
    }
    return self;
}

-(void)setupView
{
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.backgroundColor = KBackColor;
    self.clipsToBounds = YES;
    
    [self.contentView addSubview:self.skillLabel];
    
    [self.skillLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).offset(CGFloatIn750(24));
        make.left.equalTo(self.contentView.mas_left).offset(CGFloatIn750(40));
        make.right.equalTo(self.contentView.mas_right).offset(CGFloatIn750(-40));
    }];
    
    
}

- (YYLabel *)skillLabel {
    if (!_skillLabel) {
        _skillLabel = [[YYLabel alloc] initWithFrame:CGRectZero];
        _skillLabel.layer.masksToBounds = YES;
        _skillLabel.textColor = KFont6Color;
        _skillLabel.numberOfLines = 0;
        _skillLabel.textAlignment = NSTextAlignmentLeft;
        [_skillLabel setFont:[UIFont systemFontOfSize:CGFloatIn750(22)]];
        _skillLabel.preferredMaxLayoutWidth = kScreenWidth - CGFloatIn750(44);
    }
    return _skillLabel;
}

+(CGFloat)z_getCellHeight:(id)sender {
    return CGFloatIn750(124);
}

- (void)setModel:(ZStudentLessonOrderInfoCellModel *)model {
    _model = model;

    
   NSMutableAttributedString *text  = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@%@",model.title, model.subTitle]];
       text.lineSpacing = 6;
       text.font = [UIFont systemFontOfSize:CGFloatIn750(22)];
       text.color = KFont9Color;
       //    __weak typeof(self) weakself = self;
       
       
       [text setTextHighlightRange:NSMakeRange(model.title.length, model.subTitle.length) color:KRedColor backgroundColor:KBackColor tapAction:^(UIView * _Nonnull containerView, NSAttributedString * _Nonnull text, NSRange range, CGRect rect) {
   //        ZAgreementVC *avc = [[ZAgreementVC alloc] init];
   //        avc.navTitle = @"隐私协议";
   //        avc.type = @"privacy_policy";
   //        [self.navigationController pushViewController:avc animated:YES];
       }];
       
       _skillLabel.attributedText = text;  //设置富文本
}
@end
