//
//  ZStudentLessonTeacherCell.m
//  NoWait
//
//  Created by zhuang zhang on 2020/3/21.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZStudentLessonTeacherCell.h"

#define kLabelHeight CGFloatIn750(62)
#define kLabelSpace CGFloatIn750(20)
#define kLabelAddWidth CGFloatIn750(60)
#define kLabelSpaceY CGFloatIn750(40)


@interface ZStudentLessonTeacherCell ()
@property (nonatomic,strong) UIView *activityView;
@end

@implementation ZStudentLessonTeacherCell
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
    [super setupView];
    
    [self.contentView addSubview:self.activityView];
    [self.activityView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    
    
    [self setActivityData:KScreenWidth-CGFloatIn750(60) textArr:@[@"重中之重",@"下火海",@"上刀山",@"重之重",@"下火海",@"上刀山"]];
}


- (UIView *)activityView {
    if (!_activityView) {
        _activityView = [[UIView alloc] init];
        _activityView.layer.masksToBounds = YES;
    }
    return _activityView;
}


- (CGFloat)setActivityData:(CGFloat)maxWidth textArr:(NSArray *)adeptArr{
    [self.activityView removeAllSubviews];
    
    CGFloat labelWidth = maxWidth;
    CGFloat leftX = CGFloatIn750(30);
    CGFloat topY = 0;

    for (int i = 0; i < adeptArr.count; i++) {
       CGSize tempSize = [adeptArr[i] tt_sizeWithFont:[UIFont fontContent] constrainedToSize:CGSizeMake(labelWidth, MAXFLOAT)];
       if (leftX + tempSize.width + kLabelAddWidth + kLabelSpace > labelWidth) {
           topY += kLabelHeight + kLabelSpaceY;
           leftX = CGFloatIn750(30);
       }
           
        UILabel *actLabel = [[UILabel alloc] initWithFrame:CGRectMake(leftX, topY, tempSize.width+kLabelAddWidth, kLabelHeight)];
        actLabel.textColor = adaptAndDarkColor([UIColor colorTextBlack], [UIColor colorTextBlackDark]);
        actLabel.backgroundColor = adaptAndDarkColor([UIColor colorGrayBG], [UIColor colorGrayBGDark]);
        actLabel.text = adeptArr[i];
        actLabel.numberOfLines = 1;
        actLabel.layer.masksToBounds = YES;
        actLabel.layer.cornerRadius = kLabelHeight/2.0f;
        actLabel.textAlignment = NSTextAlignmentCenter;
        [actLabel setFont:[UIFont fontContent]];
        [self.activityView addSubview:actLabel];
        leftX = actLabel.right + kLabelSpace;
    }
    
    return topY + kLabelHeight;
}

+(CGFloat)z_getCellHeight:(id)sender {
    NSArray *tempArr = @[@"重中之重",@"下火海",@"上刀山",@"重之重",@"下火海",@"上刀山"];
    CGFloat cellHeight = 0;
    cellHeight += [self setActivityData:KScreenWidth-CGFloatIn750(60) textArr:tempArr];
    return cellHeight;
}



+ (CGFloat)setActivityData:(CGFloat)maxWidth textArr:(NSArray *)adeptArr{
    CGFloat labelWidth = maxWidth;
    CGFloat leftX = CGFloatIn750(30);
    CGFloat topY = 0;

    for (int i = 0; i < adeptArr.count; i++) {
       CGSize tempSize = [adeptArr[i] tt_sizeWithFont:[UIFont fontContent] constrainedToSize:CGSizeMake(labelWidth, MAXFLOAT)];
       if (leftX + tempSize.width + kLabelAddWidth + kLabelSpace > labelWidth) {
           topY += kLabelHeight + kLabelSpaceY;
           leftX = CGFloatIn750(30);
       }
        
        leftX = leftX + tempSize.width+kLabelAddWidth + kLabelSpace;
    }
    
    return topY + kLabelHeight;
}
@end




