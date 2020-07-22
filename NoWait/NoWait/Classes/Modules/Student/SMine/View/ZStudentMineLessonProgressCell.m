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
@property (nonatomic,strong) UIView *bottomView;
@property (nonatomic,strong) UIView *contView;

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
    [super setupView];
    self.contentView.backgroundColor = adaptAndDarkColor([UIColor colorGrayBG], [UIColor colorGrayBGDark]);
    
    [self.contentView addSubview:self.contView];
    [self.contView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView.mas_right).offset(-CGFloatIn750(30));
        make.left.equalTo(self.contentView.mas_left).offset(CGFloatIn750(30));
        make.top.equalTo(self.mas_top).offset(CGFloatIn750(20));
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-CGFloatIn750(20));
    }];
    
    UIView *topTitleBackView = [[UIView alloc] initWithFrame:CGRectZero];
    topTitleBackView.backgroundColor = adaptAndDarkColor([UIColor colorWhite], [UIColor colorBlackBGDark]);
    [self.contView addSubview:topTitleBackView];
    [topTitleBackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(CGFloatIn750(66));
        make.right.equalTo(self.contView);
        make.left.equalTo(self.contView.mas_left).offset(CGFloatIn750(30));
        make.top.equalTo(self.contView.mas_top).offset(CGFloatIn750(14));
    }];
    
    [topTitleBackView addSubview:self.lessonTitleLabel];
    [self.lessonTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(topTitleBackView.mas_centerY);
        make.left.equalTo(topTitleBackView.mas_left).offset(CGFloatIn750(18));
    }];
    
    
    [self.contView addSubview:self.bottomView];
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.equalTo(self.contView);
        make.height.mas_equalTo(CGFloatIn750(108));
    }];
    
    [self.contView addSubview:self.iTableView];
    [self.iTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(topTitleBackView.mas_bottom).offset(CGFloatIn750(0));
        make.left.equalTo(self.contView.mas_left);
        make.right.equalTo(self.contView.mas_right);
        make.bottom.equalTo(self.bottomView.mas_top);
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
        _iTableView.backgroundColor = adaptAndDarkColor([UIColor colorWhite], [UIColor colorBlackBGDark]);
        _iTableView.delegate = self;
        _iTableView.dataSource = self;
        _iTableView.layer.masksToBounds = YES;
        _iTableView.scrollEnabled = NO;
    }
    return _iTableView;
}

- (UILabel *)lessonTitleLabel {
    if (!_lessonTitleLabel) {
        _lessonTitleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _lessonTitleLabel.textColor = adaptAndDarkColor([UIColor colorTextBlack], [UIColor colorTextBlackDark]);
        _lessonTitleLabel.text = @"课程进度";
        _lessonTitleLabel.numberOfLines = 0;
        _lessonTitleLabel.textAlignment = NSTextAlignmentLeft;
        [_lessonTitleLabel setFont:[UIFont boldFontContent]];
    }
    return _lessonTitleLabel;
}

- (UIView *)bottomView {
    if (!_bottomView) {
        _bottomView = [[UIView alloc] init];
        UIButton *moreBtn = [[UIButton alloc] initWithFrame:CGRectZero];
        [moreBtn setTitle:@"查看全部课程  >" forState:UIControlStateNormal];
        [moreBtn setTitleColor:adaptAndDarkColor([UIColor colorTextGray], [UIColor colorTextGrayDark]) forState:UIControlStateNormal];
        [moreBtn.titleLabel setFont:[UIFont fontSmall]];
        [moreBtn bk_addEventHandler:^(id sender) {
            if (self.moreBlock) {
                self.moreBlock(0);
            }
        } forControlEvents:UIControlEventTouchUpInside];
        [_bottomView addSubview:moreBtn];
        [moreBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.bottomView);
        }];
        
        UIView *spaceLineView = [[UIView alloc] initWithFrame:CGRectZero];
        spaceLineView.backgroundColor = adaptAndDarkColor([UIColor colorGrayLine], [UIColor colorGrayLineDark]) ;
        [_bottomView addSubview:spaceLineView];
        [spaceLineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.bottomView.mas_top);
            make.left.equalTo(self.bottomView.mas_left).offset(CGFloatIn750(30));
            make.right.equalTo(self.bottomView.mas_right).offset(-CGFloatIn750(30));
            make.height.mas_equalTo(0.5);
        }];
    }
    return _bottomView;
}

- (UIView *)contView {
    if (!_contView) {
        _contView = [[UIView alloc] initWithFrame:CGRectZero];
        _contView.backgroundColor = adaptAndDarkColor([UIColor colorWhite], [UIColor colorBlackBGDark]);
        _contView.layer.cornerRadius = CGFloatIn750(16);
        _contView.clipsToBounds = YES;
    }
    return _contView;
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
    cell.model = self.list[indexPath.row];
    return cell;
}

#pragma mark tableView ------delegate-----
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [ZMineStudentLessonProgressListCell z_getCellHeight:nil];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0;
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
    if (self.handleBlock) {
        self.handleBlock(self.list[indexPath.row]);
    }
}

+ (CGFloat)z_getCellHeight:(id)sender {
    NSArray *list = sender;
    
    if (!list || list.count == 0) {
        return 0;
    }
    return CGFloatIn750(40) + CGFloatIn750(36) + CGFloatIn750(80) + CGFloatIn750(108) + CGFloatIn750(106) * list.count;
}


- (void)setList:(NSArray<ZOriganizationClassListModel *> *)list {
    _list = list;
    [_iTableView reloadData];
}

- (void)traitCollectionDidChange:(UITraitCollection *)previousTraitCollection {
    ViewShadowRadius(self.contView, CGFloatIn750(20), CGSizeMake(CGFloatIn750(0), CGFloatIn750(0)), 1, adaptAndDarkColor([UIColor colorGrayBG], [UIColor colorGrayBGDark]));
}
@end
