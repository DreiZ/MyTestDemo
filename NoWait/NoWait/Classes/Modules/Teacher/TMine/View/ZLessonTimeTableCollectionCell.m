//
//  ZLessonTimeTableCollectionCell.m
//  NoWait
//
//  Created by zhuang zhang on 2020/4/14.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZLessonTimeTableCollectionCell.h"

@interface ZLessonTimeTableCollectionCell ()
@property (nonatomic,strong) UIView *backView;
@property (nonatomic,strong) UILabel *lessonLabel;
@end

@implementation ZLessonTimeTableCollectionCell


- (void)setupView {
    self.contentView.backgroundColor = adaptAndDarkColor([UIColor colorWhite], [UIColor colorBlackBGDark]);
    [self.contentView addSubview:self.backView];
    [self.backView addSubview:self.lessonLabel];
    
    [self.backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    
    [self.lessonLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.backView.mas_left).offset(CGFloatIn750(8));
        make.top.equalTo(self.backView.mas_top).offset(CGFloatIn750(6));
        make.right.equalTo(self.backView.mas_right).offset(-CGFloatIn750(8));
        make.bottom.lessThanOrEqualTo(self.backView.mas_bottom);
    }];
}


#pragma mark - Getter
- (UIView *)backView {
    if (!_backView) {
        _backView = [[UIView alloc] init];
        _backView.layer.masksToBounds = YES;
        _backView.layer.cornerRadius = CGFloatIn750(12);
        _backView.backgroundColor = randomColor();
    }
    return _backView;
}


- (UILabel *)lessonLabel {
    if (!_lessonLabel) {
        _lessonLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _lessonLabel.textColor = [UIColor colorWhite];
        _lessonLabel.numberOfLines = 1;
        _lessonLabel.textAlignment = NSTextAlignmentLeft;
        [_lessonLabel setFont:[UIFont boldFontSmall]];
        [_lessonLabel setAdjustsFontSizeToFitWidth:YES];
    }
    return _lessonLabel;
}

- (void)setModel:(ZOriganizationLessonListModel *)model {
    _model = model;
    if (ValidStr(model.course_name)) {
        _lessonLabel.text = model.course_name;
        _backView.backgroundColor = randomColor();
    }else{
        _backView.backgroundColor = [UIColor clearColor];
    }
    
}

+(CGSize)z_getCellSize:(id)sender {
    return CGSizeMake((KScreenWidth-CGFloatIn750(252))/4.0, (KScreenWidth-CGFloatIn750(252))/4 * (64.0/62.0));
}
@end


