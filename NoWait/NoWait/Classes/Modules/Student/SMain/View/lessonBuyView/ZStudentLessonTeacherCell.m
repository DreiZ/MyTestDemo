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
@property (nonatomic,strong) NSMutableArray *teacherArr;
@property (nonatomic,assign) NSInteger selectedIndex;
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
    _selectedIndex = -1;
    _teacherArr = @[].mutableCopy;
    [self.contentView addSubview:self.activityView];
    [self.activityView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
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
    [self.teacherArr removeAllObjects];
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
        [_teacherArr addObject:actLabel];
        if (i < self.teacher_list.count) {
            ZOriganizationLessonTeacherModel *model = self.teacher_list[i];
            if (model.isSelected) {
                actLabel.textColor = adaptAndDarkColor([UIColor colorMain], [UIColor colorMain]);
                actLabel.backgroundColor = adaptAndDarkColor([UIColor colorMainSub], [UIColor colorMainSub]);
                ViewBorderRadius(actLabel, kLabelHeight/2.0f, 1, [UIColor colorMain]);
            }else{
                actLabel.textColor = adaptAndDarkColor([UIColor colorTextBlack], [UIColor colorTextBlackDark]);
                actLabel.backgroundColor = adaptAndDarkColor([UIColor colorGrayBG], [UIColor colorGrayBGDark]);
                ViewBorderRadius(actLabel, kLabelHeight/2.0f, 1, [UIColor colorGrayBG]);
            }
        }
        
        
        leftX = actLabel.right + kLabelSpace;
        
        __weak typeof(self) weakSelf = self;
        UIButton *tBtn = [[UIButton alloc] initWithFrame:CGRectMake(leftX, topY, tempSize.width+kLabelAddWidth, kLabelHeight)];
        tBtn.tag = i;
        [tBtn bk_whenTapped:^{
            [weakSelf btnClick:i];
        }];
        [self.activityView addSubview:tBtn];
        [tBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(actLabel);
        }];
    }
    
    return topY + kLabelHeight;
}

- (void)btnClick:(NSInteger)index {
    for (NSInteger i = 0; i < self.teacher_list.count; i++) {
        ZOriganizationLessonTeacherModel *model = self.teacher_list[i];
        if (i == index) {
            if (model.isSelected) {
                model.isSelected = NO;
                if (self.handleBlock) {
                    self.handleBlock(nil);
                }
            }else{
                model.isSelected = YES;
                if (self.handleBlock) {
                    self.handleBlock(model);
                }
            }
        }else{
            model.isSelected = NO;
            if (self.handleBlock) {
                self.handleBlock(nil);
            }
        }
    }
//
//    for (NSInteger i = 0; i < self.teacherArr.count; i++) {
//        ZOriganizationLessonTeacherModel *model = self.teacher_list[i];
//        if (i >= self.teacher_list.count) {
//            return;
//        }
//        UILabel *actLabel = self.teacherArr[i];
//        if (model.isSelected) {
//            actLabel.textColor = adaptAndDarkColor([UIColor colorMain], [UIColor colorMain]);
//            actLabel.backgroundColor = adaptAndDarkColor([UIColor colorMainSub], [UIColor colorMainSub]);
//            ViewBorderRadius(actLabel, kLabelHeight/2.0f, 1, [UIColor colorMain]);
//        }else{
//            actLabel.textColor = adaptAndDarkColor([UIColor colorTextBlack], [UIColor colorTextBlackDark]);
//            actLabel.backgroundColor = adaptAndDarkColor([UIColor colorGrayBG], [UIColor colorGrayBGDark]);
//            ViewBorderRadius(actLabel, kLabelHeight/2.0f, 1, [UIColor colorGrayBG]);
//        }
//    }
    
}

- (void)setTeacher_list:(NSArray<ZOriganizationLessonTeacherModel *> *)teacher_list {
    _teacher_list = teacher_list;
    NSMutableArray *tArr = @[].mutableCopy;
    for (ZOriganizationLessonTeacherModel *teacher in _teacher_list) {
        [tArr addObject:teacher.teacher_name];
    }
    [self setActivityData:KScreenWidth-CGFloatIn750(60) textArr:tArr];
}

+(CGFloat)z_getCellHeight:(id)sender {
    NSArray *teacher_list = sender;
    NSMutableArray *tempArr = @[].mutableCopy;
    for (ZOriganizationLessonTeacherModel *teacher in teacher_list) {
        [tempArr addObject:teacher.teacher_name];
    }
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




