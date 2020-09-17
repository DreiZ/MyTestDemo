//
//  ZTeacherClassReportFormCell.m
//  NoWait
//
//  Created by zhuang zhang on 2020/9/14.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZTeacherClassReportFormCell.h"

@interface ZTeacherClassReportFormCell ()
@property (nonatomic,strong) UIView *funBackView;
@property (nonatomic,strong) NSMutableArray <UILabel *>*labelArr;
@property (nonatomic,strong) NSMutableArray <UILabel *>*labelTitleArr;
@end

@implementation ZTeacherClassReportFormCell
- (void)setupView {
    [super setupView];
  
    self.contentView.backgroundColor = adaptAndDarkColor([UIColor colorGrayBG],[UIColor colorGrayBGDark]);
  
  
    [self.contentView addSubview:self.funBackView];
    [self.funBackView mas_makeConstraints:^(MASConstraintMaker *make) {
      make.top.bottom.equalTo(self.contentView);
      make.left.equalTo(self.contentView.mas_left).offset(CGFloatIn750(30));
      make.right.equalTo(self.contentView.mas_right).offset(CGFloatIn750(-30));
    }];
    
    NSArray *titleArr = @[@"日期",@"已签课",@"补签",@"请假",@"旷课"];
    NSArray *titleColorArr = @[[UIColor colorTextGray],[UIColor colorTextGray],[UIColor colorWithHexString:@"f7c173"],[UIColor colorWithHexString:@"5e73ce"],[UIColor colorWithHexString:@"ff0808"]];
    NSArray *titleDarkColorArr = @[[UIColor colorTextGrayDark],[UIColor colorTextGrayDark],[UIColor colorWithHexString:@"f7c173"],[UIColor colorWithHexString:@"5e73ce"],[UIColor colorWithHexString:@"ff0808"]];
    NSArray *contentArr = @[@"2020年1月1日",@"0人",@"0人",@"0人",@"0人"];
    NSArray *contentColorArr = @[[UIColor colorTextBlack],[UIColor colorTextBlack],[UIColor colorWithHexString:@"f7c173"],[UIColor colorWithHexString:@"5e73ce"],[UIColor colorWithHexString:@"ff0808"]];
    NSArray *contentDarkColorArr = @[[UIColor colorTextBlackDark],[UIColor colorTextBlackDark],[UIColor colorWithHexString:@"f7c173"],[UIColor colorWithHexString:@"5e73ce"],[UIColor colorWithHexString:@"ff0808"]];
    
    self.labelArr = @[].mutableCopy;
    self.labelTitleArr = @[].mutableCopy;
    
    for (int i = 0; i < titleArr.count; i++) {
        UILabel *titleLabel = [self getLabel:titleArr[i] color:titleColorArr[i] darkColor:titleDarkColorArr[i] alignment:i == 0? NSTextAlignmentLeft:NSTextAlignmentCenter];
        [self.labelTitleArr addObject:titleLabel];
        
        UILabel *contentLabel = [self getLabel:contentArr[i] color:contentColorArr[i] darkColor:contentDarkColorArr[i] alignment:i == 0? NSTextAlignmentLeft:NSTextAlignmentCenter];
        [self.labelArr addObject:contentLabel];
        
        [self.funBackView addSubview:_labelTitleArr[i]];
        [self.funBackView addSubview:_labelArr[i]];
    }
    
    [_labelArr[0] mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.funBackView.mas_left).offset(CGFloatIn750(40));
        make.top.equalTo(self.funBackView.mas_top).offset(CGFloatIn750(38));
    }];
    [_labelTitleArr[0] mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.funBackView.mas_left).offset(CGFloatIn750(40));
        make.top.equalTo(self.labelArr[0].mas_bottom).offset(CGFloatIn750(16));
    }];
    
    
    UILabel *titleLabel = nil;
    UILabel *contentLabel = nil;
    for (int i = 1; i < _labelTitleArr.count; i++) {
        [_labelTitleArr[i] mas_makeConstraints:^(MASConstraintMaker *make) {
            if (titleLabel) {
                make.left.equalTo(titleLabel.mas_right);
                
            }else{
                make.left.equalTo(self.funBackView.mas_left).offset(CGFloatIn750(0));
            }
            
            if (i == _labelTitleArr.count - 1) {
                make.right.equalTo(self.funBackView.mas_right);
            }
            make.width.mas_equalTo((KScreenWidth-CGFloatIn750(60))/4.0f);
            make.bottom.equalTo(self.funBackView.mas_bottom).offset(-CGFloatIn750(40));
        }];
        
        [_labelArr[i] mas_makeConstraints:^(MASConstraintMaker *make) {
            if (titleLabel) {
                make.left.equalTo(titleLabel.mas_right);
            }else{
                make.left.equalTo(self.funBackView.mas_left).offset(CGFloatIn750(0));
            }
            if (i == titleArr.count - 1) {
                make.right.equalTo(self.funBackView.mas_right);
            }
            make.width.mas_equalTo((KScreenWidth-CGFloatIn750(60))/4.0f);
            make.bottom.equalTo(self.funBackView.mas_bottom).offset(-CGFloatIn750(86));
        }];
        titleLabel = _labelTitleArr[i];
        contentLabel = _labelArr[i];
    }
}

- (UIView *)funBackView {
    if (!_funBackView) {
        _funBackView = [[UIView alloc] init];
        _funBackView.layer.masksToBounds = YES;
        ViewRadius(_funBackView, CGFloatIn750(20));
        _funBackView.backgroundColor = adaptAndDarkColor([UIColor colorWhite], [UIColor colorBlackBGDark]);
    }
    return _funBackView;
}


- (UILabel *)getLabel:(NSString *)title color:(UIColor *)color darkColor:(UIColor *)darkColor alignment:(NSTextAlignment)alignment{
    UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    nameLabel.textColor = adaptAndDarkColor(color,darkColor);
    nameLabel.text = title;
    nameLabel.numberOfLines = 1;
    nameLabel.textAlignment = alignment;
    [nameLabel setFont:[UIFont fontSmall]];
    
    return nameLabel;
}

- (void)setModel:(ZOriganizationReportListModel *)model {
    _model = model;
    _labelArr[0].text = model.date;
    _labelArr[1].text = [NSString stringWithFormat:@"%@人",model.sign];
    _labelArr[2].text = [NSString stringWithFormat:@"%@人",model.replenish_nums];
    _labelArr[3].text = [NSString stringWithFormat:@"%@人",model.vacate_nums];
    _labelArr[4].text = [NSString stringWithFormat:@"%@人",model.truancy_nums];
    if (ValidStr(model.class_type) && [model.class_type intValue] == 2) {
        _labelArr[3].hidden = YES;
        _labelArr[4].hidden = YES;
        _labelTitleArr[3].hidden = YES;
        _labelTitleArr[4].hidden = YES;
    }else{
        _labelArr[3].hidden = NO;
        _labelArr[4].hidden = NO;
        _labelTitleArr[3].hidden = NO;
        _labelTitleArr[4].hidden = NO;
    }
}

+(CGFloat)z_getCellHeight:(id)sender {
    return CGFloatIn750(296);
}

@end
