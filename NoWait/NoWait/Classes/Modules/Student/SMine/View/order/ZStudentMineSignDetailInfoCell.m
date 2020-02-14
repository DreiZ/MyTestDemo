//
//  ZStudentMineSignDetailInfoCell.m
//  NoWait
//
//  Created by zhuang zhang on 2020/1/15.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZStudentMineSignDetailInfoCell.h"
#import "ZStudentMineSignListItemCell.h"
#import "ZSpaceEmptyCell.h"

#import "ZStudentDetailModel.h"


@interface ZStudentMineSignDetailInfoCell ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic,strong) UITableView *iTableView;

@property (nonatomic,strong) UILabel *lessonLabel;

@property (nonatomic,strong) NSMutableArray *cellConfigArr;

@end

@implementation ZStudentMineSignDetailInfoCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupView];
    }
    return self;
}

-(void)setupView {
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.contentView.backgroundColor = KAdaptAndDarkColor([UIColor colorGrayBG], [UIColor colorBlackBG]);
    
    _cellConfigArr = @[].mutableCopy;
    
    UIView *contView = [[UIView alloc] init];
    contView.layer.masksToBounds = YES;
    contView.layer.cornerRadius = CGFloatIn750(12);
    contView.backgroundColor = KAdaptAndDarkColor([UIColor colorWhite], K1aBackColor);
    [self.contentView addSubview:contView];
    [contView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView);
        make.left.equalTo(self.contentView.mas_left).offset(CGFloatIn750(20));
        make.right.equalTo(self.contentView.mas_right).offset(-CGFloatIn750(20));
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-CGFloatIn750(20));
    }];
    
    
    UIView *topView = [[UIView alloc] initWithFrame:CGRectZero];
    topView.backgroundColor = KAdaptAndDarkColor([UIColor colorWhite], K1aBackColor);
    [contView addSubview:topView];
    [topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(CGFloatIn750(110));
        make.left.right.top.equalTo(contView);
    }];
    
    UIView *bottomLineView = [[UIView alloc] initWithFrame:CGRectZero];
    bottomLineView.backgroundColor = KAdaptAndDarkColor(KLineColor, [UIColor colorBlackBG]);
    [topView addSubview:bottomLineView];
    [bottomLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(topView);
        make.height.mas_equalTo(0.5);
    }];

    
    UIView *middleView = [[UIView alloc] initWithFrame:CGRectZero];
    middleView.backgroundColor = KAdaptAndDarkColor([UIColor colorWhite], K1aBackColor);
    [contView addSubview:middleView];
    [middleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(topView.mas_bottom);
        make.bottom.equalTo(contView.mas_bottom);
        make.left.right.equalTo(contView);
    }];


    [topView addSubview:self.lessonLabel];
    
    [self.lessonLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(topView.mas_left).offset(CGFloatIn750(30));
        make.centerY.equalTo(topView.mas_centerY);
    }];
    

    [middleView addSubview:self.iTableView];
    [self.iTableView mas_makeConstraints:^(MASConstraintMaker *make) {
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
        _iTableView.backgroundColor = KAdaptAndDarkColor([UIColor colorWhite], K1aBackColor);
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
        _lessonLabel.textColor = KAdaptAndDarkColor(KFont3Color, KFont9Color);
        _lessonLabel.text = @"课程";
        _lessonLabel.numberOfLines = 1;
        _lessonLabel.textAlignment = NSTextAlignmentLeft;
        [_lessonLabel setFont:[UIFont boldSystemFontOfSize:CGFloatIn750(34)]];
    }
    return _lessonLabel;
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
    return CGFloatIn750(166) + [ZStudentMineSignListItemCell z_getCellHeight:nil] * list.count + CGFloatIn750(22) * list.count;
}


- (void)setData {
    [_cellConfigArr removeAllObjects];
    
    
    NSMutableArray *list = @[].mutableCopy;
    NSArray *des = @[@"单笔消费满100元试用",@"单笔消费满100元试用",@"单笔消费满100元试用"];
    ZCellConfig *bottomCellConfig = [ZCellConfig cellConfigWithClassName:[ZSpaceEmptyCell className] title:[ZSpaceEmptyCell className] showInfoMethod:@selector(setBackColor:) heightOfCell:CGFloatIn750(22) cellType:ZCellTypeClass dataModel:KAdaptAndDarkColor([UIColor colorWhite], K1aBackColor)];
           [_cellConfigArr addObject:bottomCellConfig];
    
    for (int i = 0; i < des.count; i++) {
        ZCellConfig *lessonDesCellConfig = [ZCellConfig cellConfigWithClassName:[ZStudentMineSignListItemCell className] title:[ZStudentMineSignListItemCell className] showInfoMethod:nil heightOfCell:[ZStudentMineSignListItemCell z_getCellHeight:nil] cellType:ZCellTypeClass dataModel:list];
            [_cellConfigArr addObject:lessonDesCellConfig];
        //

        ZCellConfig *bottomCellConfig = [ZCellConfig cellConfigWithClassName:[ZSpaceEmptyCell className] title:[ZSpaceEmptyCell className] showInfoMethod:@selector(setBackColor:) heightOfCell:CGFloatIn750(22) cellType:ZCellTypeClass dataModel:KAdaptAndDarkColor([UIColor colorWhite], K1aBackColor)];
        [_cellConfigArr addObject:bottomCellConfig];
    }
    
    [self.iTableView reloadData];
}
@end



