//
//  ZStudentLessonOrderIntroCell.m
//  NoWait
//
//  Created by zhuang zhang on 2020/1/11.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZStudentLessonOrderIntroCell.h"
#import "ZSpaceEmptyCell.h"
#import "ZStudentLessonOrderIntroItemCell.h"

@interface ZStudentLessonOrderIntroCell ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic,strong) UITableView *iTableView;
@property (nonatomic,strong) NSMutableArray *cellConfigArr;

@end

@implementation ZStudentLessonOrderIntroCell

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
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.backgroundColor = KBackColor;
    self.clipsToBounds = YES;
    self.cellConfigArr = @[].mutableCopy;
    
    UIView *topLineView = [[UIView alloc] initWithFrame:CGRectZero];
    topLineView.backgroundColor = KMainColor;
    [self.contentView addSubview:topLineView];
    [topLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(CGFloatIn750(82));
        make.left.top.right.equalTo(self);
    }];
    
    UIView *contView = [[UIView alloc] initWithFrame:CGRectZero];
    contView.backgroundColor = KWhiteColor;
    contView.layer.masksToBounds = YES;
    contView.layer.cornerRadius = CGFloatIn750(18);
    [self.contentView addSubview:contView];
    [contView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView.mas_right).offset(-CGFloatIn750(20));
        make.left.equalTo(self.contentView.mas_left).offset(CGFloatIn750(20));
        make.top.equalTo(self.mas_top);
        make.bottom.equalTo(self.contentView.mas_bottom);
    }];
    
    [contView addSubview:self.iTableView];
    [self.iTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(contView.mas_top).offset(CGFloatIn750(24));
        make.left.equalTo(contView.mas_left);
        make.right.equalTo(contView.mas_right);
        make.bottom.equalTo(contView.mas_bottom).offset(CGFloatIn750(-24));
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
}

+ (CGFloat)z_getCellHeight:(id)sender {

    return CGFloatIn750(56) + CGFloatIn750(56) * 5;
}



#pragma mark -设置数据
- (void)setModel:(ZStudentLessonOrderInfoModel *)model {
    _model = model;
    NSArray *list = @[
                    @[@"预约信息：",[NSString stringWithFormat:@"%@ %@",model.orderUserName? model.orderUserName:@"",model.orderUserTel? model.orderUserTel:@""],KFont3Color],
                    @[@"到店时间：",model.orderTime? model.orderTime:@"",KFont3Color],
                    @[@"订单编号：",model.orderNum? model.orderNum:@"",KFont3Color],
                    @[@"预约课程：",model.orderLesson? model.orderLesson:@"",KFont3Color],
                    @[@"预约状态：",model.orderStatus? model.orderStatus:@"",KRedColor]];
    
    NSMutableArray *mList = @[].mutableCopy;
    for (int i = 0; i < list.count; i++) {
        ZStudentLessonOrderInfoCellModel *cModel = [[ZStudentLessonOrderInfoCellModel alloc] init];
        cModel.title = list[i][0];
        cModel.subTitle = list[i][1];
        cModel.subColor = list[i][2];
        
        [mList addObject:cModel];
    }
    
    [self setCellConfigArrWithList:mList];
}

- (void)setCellConfigArrWithList:(NSArray *)list {
    [self.cellConfigArr removeAllObjects];
    
    for (int i = 0; i < list.count; i++) {
        ZCellConfig *spacCellConfig = [ZCellConfig cellConfigWithClassName:[ZStudentLessonOrderIntroItemCell className] title:[ZStudentLessonOrderIntroItemCell className] showInfoMethod:@selector(setModel:) heightOfCell:[ZStudentLessonOrderIntroItemCell z_getCellHeight:nil] cellType:ZCellTypeClass dataModel:list[i]];
        [self.cellConfigArr addObject:spacCellConfig];
    }
    
    
    [self.iTableView reloadData];
}
@end
