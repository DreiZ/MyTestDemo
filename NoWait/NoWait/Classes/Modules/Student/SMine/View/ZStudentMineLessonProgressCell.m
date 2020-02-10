//
//  ZStudentMineLessonProgressCell.m
//  NoWait
//
//  Created by zhuang zhang on 2020/1/4.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZStudentMineLessonProgressCell.h"
#import "ZMineStudentLessonProgressListCell.h"

@interface ZStudentMineLessonProgressCell ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic,strong) UITableView *iTableView;
@property (nonatomic,strong) UILabel *lessonTitleLabel;
@property (nonatomic,strong) UILabel *moreLabel;

@end

@implementation ZStudentMineLessonProgressCell

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
    self.contentView.backgroundColor = KAdaptAndDarkColor(KBackColor, K2eBackColor);
    self.clipsToBounds = YES;
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    UIView *contView = [[UIView alloc] initWithFrame:CGRectZero];
    contView.backgroundColor = KAdaptAndDarkColor(KWhiteColor, K1aBackColor);
    contView.layer.masksToBounds = YES;
    contView.layer.cornerRadius = 4;
    [self.contentView addSubview:contView];
    [contView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView.mas_right).offset(-CGFloatIn750(20));
        make.left.equalTo(self.contentView.mas_left).offset(CGFloatIn750(20));
        make.top.equalTo(self.mas_top);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-CGFloatIn750(20));
    }];
    
    UIView *topTitleBackView = [[UIView alloc] initWithFrame:CGRectZero];
    topTitleBackView.backgroundColor = KAdaptAndDarkColor(KWhiteColor, K1aBackColor);
    [contView addSubview:topTitleBackView];
    [topTitleBackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(CGFloatIn750(80));
        make.left.right.top.equalTo(contView);
    }];
    
    UIButton *moreBtn = [[UIButton alloc] initWithFrame:CGRectZero];
    [moreBtn bk_whenTapped:^{
        
    }];
    [contView addSubview:moreBtn];
    [moreBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.bottom.equalTo(contView);
    }];
    
    [topTitleBackView addSubview:self.lessonTitleLabel];
    [self.lessonTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(topTitleBackView.mas_centerY);
        make.left.equalTo(topTitleBackView.mas_left).offset(CGFloatIn750(18));
    }];
    
    [topTitleBackView addSubview:self.moreLabel];
    [self.moreLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(topTitleBackView.mas_centerY);
        make.right.equalTo(topTitleBackView.mas_right).offset(CGFloatIn750(-18));
    }];
    
    UIView *spaceLineView = [[UIView alloc] initWithFrame:CGRectZero];
    spaceLineView.backgroundColor = CLineColor;
    [contView addSubview:spaceLineView];
    [spaceLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(topTitleBackView.mas_bottom);
        make.left.right.equalTo(contView);
        make.height.mas_equalTo(0.5);
    }];
    
    [contView addSubview:self.iTableView];
    [self.iTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(spaceLineView.mas_bottom).offset(CGFloatIn750(8));
        make.left.equalTo(contView.mas_left);
        make.right.equalTo(contView.mas_right);
        make.bottom.equalTo(contView.mas_bottom).offset(CGFloatIn750(-16));
    }];
    
}

#pragma mark lazy loading...
-(UITableView *)iTableView {
    if (!_iTableView) {
        _iTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _iTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _iTableView.backgroundColor = [UIColor whiteColor];
        _iTableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
        if ([_iTableView respondsToSelector:@selector(contentInsetAdjustmentBehavior)]) {
            _iTableView.estimatedRowHeight = 0;
            _iTableView.estimatedSectionHeaderHeight = 0;
            _iTableView.estimatedSectionFooterHeight = 0;
            if (@available(iOS 11.0, *)) {
                _iTableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
            } else {
                // Fallback on earlier versions
            }
        } else {
            
        }
        _iTableView.delegate = self;
        _iTableView.dataSource = self;
        _iTableView.layer.masksToBounds = YES;
        _iTableView.scrollEnabled = NO;
    }
    return _iTableView;
}

- (UILabel *)moreLabel {
    if (!_moreLabel) {
        _moreLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _moreLabel.textColor = KAdaptAndDarkColor(KFont9Color, KFont3Color);
        _moreLabel.text = @"查看更多>>";
        _moreLabel.numberOfLines = 0;
        _moreLabel.textAlignment = NSTextAlignmentRight;
        [_moreLabel setFont:[UIFont systemFontOfSize:CGFloatIn750(24)]];
    }
    return _moreLabel;
}

- (UILabel *)lessonTitleLabel {
    if (!_lessonTitleLabel) {
        _lessonTitleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _lessonTitleLabel.textColor = KAdaptAndDarkColor(KFont3Color, KFont9Color);
        _lessonTitleLabel.text = @"课程进度";
        _lessonTitleLabel.numberOfLines = 0;
        _lessonTitleLabel.textAlignment = NSTextAlignmentLeft;
        [_lessonTitleLabel setFont:[UIFont systemFontOfSize:CGFloatIn750(30)]];
    }
    return _lessonTitleLabel;
}

#pragma mark tableView -------datasource-----
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.list) {
        return self.list.count;
    }
    return 0;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ZMineStudentLessonProgressListCell *cell = [ZMineStudentLessonProgressListCell z_cellWithTableView:tableView];
    return cell;
}

#pragma mark tableView ------delegate-----
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [ZMineStudentLessonProgressListCell z_getCellHeight:nil];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.01f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01f;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView *footer = [[UIView alloc] init];
    footer.backgroundColor = [UIColor whiteColor];
    return footer;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *header = [[UIView alloc] init];
    header.backgroundColor = [UIColor whiteColor];
    return header;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

+ (CGFloat)z_getCellHeight:(id)sender {
    NSArray *list = sender;
    
    if (!list || list.count == 0) {
        return 0.01f;
    }
    return CGFloatIn750(120) + CGFloatIn750(54) * list.count;
}


- (void)setList:(NSArray<ZStudentLessonModel *> *)list {
    _list = list;
    [_iTableView reloadData];
}
@end
