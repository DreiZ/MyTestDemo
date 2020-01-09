//
//  ZStudentLessonDetailMainCell.m
//  NoWait
//
//  Created by zhuang zhang on 2020/1/8.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZStudentLessonDetailMainCell.h"

@interface ZStudentLessonDetailMainCell ()<UIScrollViewDelegate>

@end

@implementation ZStudentLessonDetailMainCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initMainView];
    }
    return self;
}


+(CGFloat)z_getCellHeight:(id)sender {
    return KScreenHeight - kNavBarHeight - kStatusBarHeight - kTabBarHeight - 50;
}

- (void)initMainView {
    self.contentView.clipsToBounds = YES;
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    _iScrollView = [[UIScrollView alloc] initWithFrame:CGRectZero];
    _iScrollView.pagingEnabled = YES;
    _iScrollView.bounces = NO;
    _iScrollView.showsHorizontalScrollIndicator = NO;
    [self.contentView addSubview:_iScrollView];
    [_iScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.top.equalTo(self.contentView);
    }];
    _iScrollView.contentSize = CGSizeMake(KScreenWidth * 3, 0);
    
    [self.iScrollView addSubview:self.iDetilView];
    [self.iDetilView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.iScrollView.mas_left);
        make.top.equalTo(self.iScrollView.mas_top);
        make.height.mas_equalTo([ZStudentLessonDetailMainCell z_getCellHeight:nil]);
        make.width.mas_equalTo(KScreenWidth);
    }];
    
    [self.iScrollView addSubview:self.iNoticeView];
    [self.iNoticeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.iDetilView.mas_right);
        make.top.equalTo(self.iScrollView.mas_top);
        make.height.mas_equalTo([ZStudentLessonDetailMainCell z_getCellHeight:nil]);
        make.width.mas_equalTo(KScreenWidth);
    }];

    [self.iScrollView addSubview:self.iEvaView];
    [self.iEvaView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.iNoticeView.mas_right);
        make.top.equalTo(self.iScrollView.mas_top);
        make.height.mas_equalTo([ZStudentLessonDetailMainCell z_getCellHeight:nil]);
        make.width.mas_equalTo(KScreenWidth);
    }];
//    self.iScrollView
}

//#pragma mark -scrollviewdelegate
//-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
//    DLog(@"cell zzzscrollview offset %f",scrollView.contentOffset.y);
//
//}

#pragma mark -getter
- (ZStudentLessonDetailView *)iDetilView {
    if (!_iDetilView) {
        _iDetilView = [[ZStudentLessonDetailView alloc] init];
    }
    
    return _iDetilView;
}

- (ZStudentLessonNoticeView *)iNoticeView {
    if (!_iNoticeView) {
        _iNoticeView = [[ZStudentLessonNoticeView alloc] init];
    }
    
    return _iNoticeView;
}

- (ZStudentLessonEvaView *)iEvaView {
    if (!_iEvaView) {
        _iEvaView = [[ZStudentLessonEvaView alloc] init];
    }
    
    return _iEvaView;
}

#pragma mark 设置数据
- (void)setMainVC:(ZStudentOrganizationLessonDetailVC *)mainVC {
    _mainVC = mainVC;
    self.iDetilView.mainVC = self.mainVC;
    self.iNoticeView.mainVC = self.mainVC;
    self.iEvaView.mainVC = self.mainVC;
}

- (void)setDesModel:(ZStudentDetailDesModel *)desModel {
    _desModel = desModel;
    self.desModel = desModel;
}

- (void)setNoticeModel:(ZStudentDetailNoticeModel *)noticeModel {
    _noticeModel = noticeModel;
    
}

- (void)setEvaModel:(ZStudentDetailEvaModel *)evaModel {
    _evaModel = evaModel;
}
@end
