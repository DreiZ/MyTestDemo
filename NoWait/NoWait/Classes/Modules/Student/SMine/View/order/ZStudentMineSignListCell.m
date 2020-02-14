//
//  ZStudentMineSignListCell.m
//  NoWait
//
//  Created by zhuang zhang on 2020/1/15.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZStudentMineSignListCell.h"
#import "ZStudentMineSignListItemCell.h"
#import "ZSpaceEmptyCell.h"

#import "ZStudentDetailModel.h"


@interface ZStudentMineSignListCell ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic,strong) UITableView *iTableView;

@property (nonatomic,strong) UILabel *lessonLabel;
@property (nonatomic,strong) UIButton *signBtn;

@property (nonatomic,strong) NSMutableArray *cellConfigArr;

@end

@implementation ZStudentMineSignListCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupView];
    }
    return self;
}

-(void)setupView {
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.contentView.backgroundColor = adaptAndDarkColor([UIColor colorWhite], [UIColor colorBlackDarkBG]);
    
    _cellConfigArr = @[].mutableCopy;
    
    UIView *contView = [[UIView alloc] init];
    contView.layer.masksToBounds = YES;
    [self.contentView addSubview:contView];
    [contView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(self.contentView);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-CGFloatIn750(20));
    }];
    
    
    UIView *topView = [[UIView alloc] initWithFrame:CGRectZero];
    topView.backgroundColor = adaptAndDarkColor([UIColor colorWhite], [UIColor colorBlackDarkBG]);
    [contView addSubview:topView];
    [topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(CGFloatIn750(110));
        make.left.right.top.equalTo(contView);
    }];

    
    UIView *middleView = [[UIView alloc] initWithFrame:CGRectZero];
    middleView.backgroundColor = adaptAndDarkColor([UIColor colorWhite], [UIColor colorBlackDarkBG]);
    [contView addSubview:middleView];
    [middleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(topView.mas_bottom);
        make.bottom.equalTo(contView.mas_bottom);
        make.left.right.equalTo(contView);
    }];


    [topView addSubview:self.lessonLabel];
    [topView addSubview:self.signBtn];
    
    
    [self.lessonLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(topView.mas_left).offset(CGFloatIn750(30));
        make.centerY.equalTo(topView.mas_centerY);
    }];
    

    [middleView addSubview:self.iTableView];
    [self.iTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(middleView);
    }];
    
    [self.signBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(topView.mas_right).offset(-CGFloatIn750(20));
        make.centerY.equalTo(topView.mas_centerY);
        make.height.mas_equalTo(CGFloatIn750(50));
        make.width.mas_equalTo(CGFloatIn750(130));
    }];
    
    __weak typeof(self) weakSelf = self;
    UIButton *detailBtn = [[UIButton alloc] initWithFrame:CGRectZero];
    [detailBtn bk_whenTapped:^{
        if (weakSelf.handleBlock) {
            weakSelf.handleBlock(1);
        }
    }];
    [self.contentView addSubview:detailBtn];
    [detailBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(middleView);
    }];
    
    [self setData];
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
        _iTableView.backgroundColor = adaptAndDarkColor([UIColor colorWhite], [UIColor colorBlackDarkBG]);
        _iTableView.delegate = self;
        _iTableView.dataSource = self;
        _iTableView.layer.masksToBounds = YES;
        _iTableView.scrollEnabled = NO;
    }
    return _iTableView;
}

- (UILabel *)lessonLabel {
    if (!_lessonLabel) {
        _lessonLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _lessonLabel.textColor = adaptAndDarkColor([UIColor colorTextBlack], [UIColor colorTextGray1]);
        _lessonLabel.text = @"仰泳班1023期";
        _lessonLabel.numberOfLines = 1;
        _lessonLabel.textAlignment = NSTextAlignmentLeft;
        [_lessonLabel setFont:[UIFont boldSystemFontOfSize:CGFloatIn750(34)]];
    }
    return _lessonLabel;
}


- (UIButton *)signBtn {
    if (!_signBtn) {
        _signBtn = [[UIButton alloc] initWithFrame:CGRectZero];
        _signBtn.layer.masksToBounds = YES;
        _signBtn.layer.cornerRadius = CGFloatIn750(25);
        _signBtn.backgroundColor = [UIColor  colorMain];
        
        [_signBtn setTitle:@"签到" forState:UIControlStateNormal];
        [_signBtn setTitleColor:[UIColor colorWhite] forState:UIControlStateNormal];
        [_signBtn.titleLabel setFont:[UIFont fontContent]];
        
        __weak typeof(self) weakSelf = self;
        [_signBtn bk_whenTapped:^{
            if (weakSelf.handleBlock) {
                weakSelf.handleBlock(1);
            }
        }];
    }
    return _signBtn;
}

#pragma mark tableView -------datasource-----
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
    if ([cellConfig.title isEqualToString:@"ZStudentLessonDetailLessonListCell"]) {
//        ZStudentMineSignListItemCell *listCell = (ZStudentMineSignListItemCell *)cell;
//        listCell.isHiddenBottomLine = YES;
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
    if ([cellConfig.title isEqualToString:@"ZRecordWeightMoreCell"]) {
       
    }
}


+ (CGFloat)z_getCellHeight:(id)sender {
    NSArray *list = @[@"单笔消费满100元试用",@"单笔消费满100元试用",@"单笔消费满100元试用"];
    return CGFloatIn750(144) + [ZStudentMineSignListItemCell z_getCellHeight:nil] * list.count + CGFloatIn750(22) * list.count;
}


- (void)setData {
    [_cellConfigArr removeAllObjects];
    
    
    NSMutableArray *list = @[].mutableCopy;
    NSArray *des = @[@"单笔消费满100元试用",@"单笔消费满100元试用",@"单笔消费满100元试用"];
    
    for (int i = 0; i < des.count; i++) {
        ZCellConfig *lessonDesCellConfig = [ZCellConfig cellConfigWithClassName:[ZStudentMineSignListItemCell className] title:[ZStudentMineSignListItemCell className] showInfoMethod:nil heightOfCell:[ZStudentMineSignListItemCell z_getCellHeight:nil] cellType:ZCellTypeClass dataModel:list];
            [_cellConfigArr addObject:lessonDesCellConfig];
        //

        ZCellConfig *bottomCellConfig = [ZCellConfig cellConfigWithClassName:[ZSpaceEmptyCell className] title:[ZSpaceEmptyCell className] showInfoMethod:@selector(setBackColor:) heightOfCell:CGFloatIn750(22) cellType:ZCellTypeClass dataModel:adaptAndDarkColor([UIColor colorWhite], [UIColor colorBlackDarkBG])];
        [_cellConfigArr addObject:bottomCellConfig];
    }
    
    [self.iTableView reloadData];
}
@end


