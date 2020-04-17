//
//  ZMineStudentEvaListHadEvaCell.m
//  NoWait
//
//  Created by zhuang zhang on 2020/1/14.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZMineStudentEvaListHadEvaCell.h"
#import "ZOrganizationEvaListLessonCell.h"
#import "ZMineStudentEvaListEvaCoachCell.h"
#import "ZMineStudentEvaListEvaOrderDesCell.h"
#import "ZMineStudentEvaListEvaImageCell.h"
#import "ZMineStudentEvaListEvaImageCollectionCell.h"
#import "ZOrganizationEvaListReEvaCell.h"

#import "ZSpaceEmptyCell.h"

@interface ZMineStudentEvaListHadEvaCell ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic,strong) UITableView *iTableView;
@property (nonatomic,strong) NSMutableArray *cellConfigArr;
@property (nonatomic,strong) UILabel *clubLabel;
@property (nonatomic,strong) UIImageView *clubImageView;
@property (nonatomic,strong) UIView *topView;
@property (nonatomic,strong) UIView *contView;


@end

@implementation ZMineStudentEvaListHadEvaCell

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
    
    self.cellConfigArr = @[].mutableCopy;
    
    [self.contentView addSubview:self.contView];
    [self.contView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(CGFloatIn750(30));
        make.right.equalTo(self.mas_right).offset(-CGFloatIn750(30));
        make.top.equalTo(self.mas_top).offset(CGFloatIn750(20));
        make.bottom.equalTo(self.mas_bottom).offset(-CGFloatIn750(10));
    }];
    
    [self.contView addSubview:self.topView];
    [self.topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(self.contView);
        make.height.mas_equalTo(CGFloatIn750(88));
    }];
    
    [self.topView addSubview:self.clubLabel];
    
    [self.clubLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.topView.mas_left).offset(CGFloatIn750(30));
        make.centerY.equalTo(self.topView.mas_centerY);
    }];
    
    [self.topView addSubview:self.clubImageView];
    [self.clubImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.clubLabel.mas_right).offset(CGFloatIn750(20));
        make.centerY.equalTo(self.topView.mas_centerY);
    }];
    
    [self.contView addSubview:self.iTableView];
    [self.iTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.contView);
        make.top.equalTo(self.topView.mas_bottom);
        make.bottom.equalTo(self.contView.mas_bottom).offset(-CGFloatIn750(20));
    }];
    
    __weak typeof(self) weakSelf = self;
    UIButton *clubtn = [[UIButton alloc] initWithFrame:CGRectZero];
    [clubtn bk_whenTapped:^{
        if (weakSelf.evaBlock) {
            weakSelf.evaBlock(1);
        }
    }];
    [self.topView addSubview:clubtn];
    [clubtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.topView);
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

-(UIImageView *)clubImageView {
    if (!_clubImageView) {
        _clubImageView = [[UIImageView alloc] init];
        _clubImageView.image = [[UIImage imageNamed:@"rightBlackArrowN"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        _clubImageView.tintColor = adaptAndDarkColor([UIColor colorBlack], [UIColor colorWhite]);
    }
    return _clubImageView;
}


- (UILabel *)clubLabel {
    if (!_clubLabel) {
        _clubLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _clubLabel.textColor = adaptAndDarkColor([UIColor colorTextBlack],[UIColor colorTextBlackDark]);
        _clubLabel.text = @"";
        _clubLabel.numberOfLines = 1;
        _clubLabel.textAlignment = NSTextAlignmentLeft;
        [_clubLabel setFont:[UIFont fontContent]];
    }
    return _clubLabel;
}

- (UIView *)topView {
    if (!_topView) {
        _topView = [[UIView alloc] init];
        _topView.backgroundColor = adaptAndDarkColor([UIColor colorWhite], [UIColor colorBlackBGDark]);
        _topView.clipsToBounds = YES;
        _topView.layer.cornerRadius = CGFloatIn750(12);
    }
    return _topView;
}

- (UIView *)contView {
    if (!_contView) {
        
        _contView = [[UIView alloc] init];
        _contView.backgroundColor = adaptAndDarkColor([UIColor colorWhite], [UIColor colorBlackBGDark]);
        ViewShadowRadius(_contView, CGFloatIn750(30), CGSizeMake(0, 0), 0.5, isDarkModel() ? [UIColor colorGrayContentBGDark] : [UIColor colorGrayContentBG]);
         _contView.layer.cornerRadius = CGFloatIn750(12);
    }
    return _contView;
}

#pragma mark - tableView -------datasource-----
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _cellConfigArr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ZCellConfig *cellConfig = [_cellConfigArr objectAtIndex:indexPath.row];
    ZBaseCell *cell;
    cell = (ZBaseCell*)[cellConfig cellOfCellConfigWithTableView:tableView dataModel:cellConfig.dataModel];
    if ([cellConfig.title isEqualToString:@"ZSpaceEmptyCell"]){
//        ZSpaceEmptyCell *enteryCell = (ZSpaceEmptyCell *)cell;
        
    }
    return cell;
}

#pragma mark tableView ------delegate-----
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    ZCellConfig *cellConfig = _cellConfigArr[indexPath.row];
    CGFloat cellHeight =  cellConfig.heightOfCell;
    return cellHeight;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.01f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01f;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    ZCellConfig *cellConfig = [_cellConfigArr objectAtIndex:indexPath.row];
    if ([cellConfig.title isEqualToString:@"ZSpaceCell"]) {
        
    }
    if (self.evaBlock) {
        self.evaBlock(0);
    }
}

+ (CGFloat)z_getCellHeight:(id)sender {
    ZOrderEvaListModel *model = sender;
    
    CGFloat cellHeight = CGFloatIn750(88 + 30 + 26 + 20);
    cellHeight += [ZOrganizationEvaListLessonCell z_getCellHeight:nil];
    cellHeight += [ZMineStudentEvaListEvaCoachCell z_getCellHeight:nil];
    cellHeight += [ZMineStudentEvaListEvaOrderDesCell z_getCellHeight:model.des];
    if ([model.is_reply intValue] == 1) {
        cellHeight += [ZOrganizationEvaListReEvaCell z_getCellHeight:model.reply_desc];
        cellHeight += CGFloatIn750(20);
    }
    
    return  cellHeight;
}

- (void)setModel:(ZOrderEvaListModel *)model {
    _model = model;
    self.clubLabel.text = model.stores_name;
    [self initCellConfigArr];
    [self.iTableView reloadData];	
}

- (void)initCellConfigArr {
    [self.cellConfigArr removeAllObjects];
    
    ZCellConfig *orderCellConfig = [ZCellConfig cellConfigWithClassName:[ZOrganizationEvaListLessonCell className] title:[ZOrganizationEvaListLessonCell className] showInfoMethod:@selector(setModel:) heightOfCell:[ZOrganizationEvaListLessonCell z_getCellHeight:nil] cellType:ZCellTypeClass dataModel:self.model];
    [self.cellConfigArr addObject:orderCellConfig];

    [self.cellConfigArr addObject:getEmptyCellWithHeight(CGFloatIn750(18))];
    
    ZCellConfig *coachCellConfig = [ZCellConfig cellConfigWithClassName:[ZMineStudentEvaListEvaCoachCell className] title:[ZMineStudentEvaListEvaCoachCell className] showInfoMethod:nil heightOfCell:[ZMineStudentEvaListEvaCoachCell z_getCellHeight:nil] cellType:ZCellTypeClass dataModel:nil];
    [self.cellConfigArr addObject:coachCellConfig];
    [self.cellConfigArr addObject:getEmptyCellWithHeight(CGFloatIn750(8))];
    
    ZCellConfig *desCellConfig = [ZCellConfig cellConfigWithClassName:[ZMineStudentEvaListEvaOrderDesCell className] title:[ZMineStudentEvaListEvaOrderDesCell className] showInfoMethod:@selector(setEvaDes:) heightOfCell:[ZMineStudentEvaListEvaOrderDesCell z_getCellHeight:self.model.des] cellType:ZCellTypeClass dataModel:self.model.des];
    [self.cellConfigArr addObject:desCellConfig];
    
    if ([_model.is_reply intValue] == 1) {
        ZCellConfig *orderCellConfig = [ZCellConfig cellConfigWithClassName:[ZOrganizationEvaListReEvaCell className] title:[ZOrganizationEvaListReEvaCell className] showInfoMethod:@selector(setEvaDes:) heightOfCell:[ZOrganizationEvaListReEvaCell z_getCellHeight:_model.reply_desc] cellType:ZCellTypeClass dataModel:_model.reply_desc];
        [self.cellConfigArr addObject:orderCellConfig];
        [self.cellConfigArr addObject:getEmptyCellWithHeight(CGFloatIn750(20))];
    }
    
}
@end

