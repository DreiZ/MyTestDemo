//
//  ZStudentOrganizationDetailIntroCell.m
//  NoWait
//
//  Created by zhuang zhang on 2020/3/7.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZStudentOrganizationDetailIntroCell.h"
#import "ZStudentOrganizationDetailIntroLabelCell.h"
#import "ZMultiseriateContentLeftLineCell.h"

@interface ZStudentOrganizationDetailIntroCell ()<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic,strong) NSMutableArray *cellConfigArr;
@property (nonatomic,strong) UITableView *iTableView;

@end

@implementation ZStudentOrganizationDetailIntroCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupView];
    }
    return self;
}

#pragma mark 初始化view
- (void)setupView {
    [super setupView];
    
    [self addSubview:self.iTableView];
      [self.iTableView mas_makeConstraints:^(MASConstraintMaker *make) {
          make.left.bottom.right.equalTo(self);
          make.top.equalTo(self.mas_top).offset(CGFloatIn750(0));
      }];
    
    [self setData];
}

- (void)setData {
    _cellConfigArr = @[].mutableCopy;
    [self resetData];
}

#pragma mark lazy loading...
-(UITableView *)iTableView {
    if (!_iTableView) {
        _iTableView = [[UITableView alloc]initWithFrame:self.bounds style:UITableViewStylePlain];
        _iTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _iTableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
        _iTableView.estimatedRowHeight = 0;
        _iTableView.estimatedSectionHeaderHeight = 0;
        _iTableView.estimatedSectionFooterHeight = 0;
        if (@available(iOS 11.0, *)) {
            _iTableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        } else {
            // Fallback on earlier versions
        }
        _iTableView.showsVerticalScrollIndicator = NO;
        _iTableView.showsHorizontalScrollIndicator = NO;
        _iTableView.scrollEnabled = NO;
        _iTableView.alwaysBounceVertical = YES;
        _iTableView.delegate = self;
        _iTableView.dataSource = self;
        _iTableView.backgroundColor = adaptAndDarkColor([UIColor colorWhite], [UIColor colorBlackBGDark]);
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


#pragma mark -- setdata--
- (void)resetData {
    [_cellConfigArr removeAllObjects];
    {
        ZBaseMultiseriateCellModel *mModel = [[ZBaseMultiseriateCellModel alloc] init];
        mModel.rightFont = [UIFont fontContent];
        mModel.rightColor = adaptAndDarkColor([UIColor colorTextBlack], [UIColor colorTextBlackDark]);
        mModel.singleCellHeight = CGFloatIn750(80);
        mModel.rightImage = @"rightBlackArrowN";
        mModel.isHiddenLine = YES;
        mModel.leftTitle = @"代付俱按公司";
        mModel.data = @[@"代付俱乐部",@"代付俱乐部",@"代付俱乐部"];
        mModel.leftFont = [UIFont boldFontMax1Title];
        ZCellConfig *textCellConfig = [ZCellConfig cellConfigWithClassName:[ZStudentOrganizationDetailIntroLabelCell className] title:mModel.cellTitle showInfoMethod:@selector(setModel:) heightOfCell:[ZStudentOrganizationDetailIntroLabelCell z_getCellHeight:mModel] cellType:ZCellTypeClass dataModel:mModel];
        [self.cellConfigArr addObject:textCellConfig];
    }

    {
        ZBaseMultiseriateCellModel *mModel = [[ZBaseMultiseriateCellModel alloc] init];
        mModel.rightFont = [UIFont fontContent];
        mModel.rightColor = adaptAndDarkColor([UIColor colorTextBlack], [UIColor colorTextBlackDark]);
        mModel.singleCellHeight = CGFloatIn750(60);
        mModel.rightImage = @"rightBlackArrowN";
        mModel.isHiddenLine = YES;
        mModel.rightTitle = @"公司的风格就是金融家坡附近";
        ZCellConfig *textCellConfig = [ZCellConfig cellConfigWithClassName:[ZMultiseriateContentLeftLineCell className] title:mModel.cellTitle showInfoMethod:@selector(setMModel:) heightOfCell:[ZMultiseriateContentLeftLineCell z_getCellHeight:mModel] cellType:ZCellTypeClass dataModel:mModel];
        [self.cellConfigArr addObject:textCellConfig];
    }
    {
        ZBaseMultiseriateCellModel *mModel = [[ZBaseMultiseriateCellModel alloc] init];
        mModel.rightFont = [UIFont fontContent];
        mModel.rightColor = adaptAndDarkColor([UIColor colorTextBlack], [UIColor colorTextBlackDark]);
        mModel.singleCellHeight = CGFloatIn750(60);
        mModel.isHiddenLine = YES;
        mModel.leftTitle = @"营业时间：8:00~12:00";
        ZCellConfig *textCellConfig = [ZCellConfig cellConfigWithClassName:[ZMultiseriateLineCell className] title:mModel.cellTitle showInfoMethod:@selector(setMModel:) heightOfCell:[ZMultiseriateLineCell z_getCellHeight:mModel] cellType:ZCellTypeClass dataModel:mModel];
        [self.cellConfigArr addObject:textCellConfig];
    }
    {
        ZBaseMultiseriateCellModel *mModel = [[ZBaseMultiseriateCellModel alloc] init];
        mModel.rightFont = [UIFont fontContent];
        mModel.rightColor = adaptAndDarkColor([UIColor colorTextBlack], [UIColor colorTextBlackDark]);
        mModel.singleCellHeight = CGFloatIn750(60);
        mModel.cellHeight = CGFloatIn750(62);
        mModel.isHiddenLine = YES;
        mModel.data = @[@"代付俱乐部",@"代付俱乐部",@"代付俱乐部"];
        mModel.leftFont = [UIFont fontMax1Title];
        ZCellConfig *textCellConfig = [ZCellConfig cellConfigWithClassName:[ZStudentOrganizationDetailIntroLabelCell className] title:mModel.cellTitle showInfoMethod:@selector(setModel:) heightOfCell:[ZStudentOrganizationDetailIntroLabelCell z_getCellHeight:mModel] cellType:ZCellTypeClass dataModel:mModel];
        [self.cellConfigArr addObject:textCellConfig];
        
        ZCellConfig *coachSpaceCellConfig = [ZCellConfig cellConfigWithClassName:[ZSpaceEmptyCell className] title:[ZSpaceEmptyCell className] showInfoMethod:@selector(setBackColor:) heightOfCell:CGFloatIn750(20) cellType:ZCellTypeClass dataModel:adaptAndDarkColor([UIColor colorWhite], [UIColor colorBlackBGDark])];
        [self.cellConfigArr addObject:coachSpaceCellConfig];
    }
    [self.iTableView reloadData];
}

+(CGFloat)z_getCellHeight:(id)sender {
    CGFloat height = 0;
    {
        ZBaseMultiseriateCellModel *mModel = [[ZBaseMultiseriateCellModel alloc] init];
        mModel.rightFont = [UIFont fontContent];
        mModel.rightColor = adaptAndDarkColor([UIColor colorTextBlack], [UIColor colorTextBlackDark]);
        mModel.singleCellHeight = CGFloatIn750(80);
        mModel.cellHeight = CGFloatIn750(82);
        mModel.rightImage = @"rightBlackArrowN";
        mModel.isHiddenLine = YES;
        mModel.leftTitle = @"代付俱乐部";
        mModel.data = @[@"代付俱乐部",@"代付俱乐部",@"代付俱乐部"];
        mModel.leftFont = [UIFont boldFontMax1Title];
        height += [ZStudentOrganizationDetailIntroLabelCell z_getCellHeight:mModel];
    }
    {
        ZBaseMultiseriateCellModel *mModel = [[ZBaseMultiseriateCellModel alloc] init];
        mModel.rightFont = [UIFont fontContent];
        mModel.rightColor = adaptAndDarkColor([UIColor colorTextBlack], [UIColor colorTextBlackDark]);
        mModel.singleCellHeight = CGFloatIn750(60);
        mModel.rightImage = @"rightBlackArrowN";
        mModel.isHiddenLine = YES;
        mModel.rightTitle = @"公司的风格就是金融家坡附近";
        height += [ZMultiseriateContentLeftLineCell z_getCellHeight:mModel];
    }
    {
        ZBaseMultiseriateCellModel *mModel = [[ZBaseMultiseriateCellModel alloc] init];
        mModel.rightFont = [UIFont fontContent];
        mModel.rightColor = adaptAndDarkColor([UIColor colorTextBlack], [UIColor colorTextBlackDark]);
        mModel.singleCellHeight = CGFloatIn750(60);
        mModel.isHiddenLine = YES;
        mModel.leftTitle = @"营业时间：8:00~12:00";
        height += [ZMultiseriateLineCell z_getCellHeight:mModel];
    }
    {
        ZBaseMultiseriateCellModel *mModel = [[ZBaseMultiseriateCellModel alloc] init];
        mModel.rightFont = [UIFont fontContent];
        mModel.rightColor = adaptAndDarkColor([UIColor colorTextBlack], [UIColor colorTextBlackDark]);
        mModel.singleCellHeight = CGFloatIn750(60);
        mModel.cellHeight = CGFloatIn750(62);
        mModel.isHiddenLine = YES;
        mModel.data = @[@"代付俱乐部",@"代付俱乐部",@"代付俱乐部"];
        mModel.leftFont = [UIFont fontMax1Title];
        height += [ZStudentOrganizationDetailIntroLabelCell z_getCellHeight:mModel];
        
        height += CGFloatIn750(20);
    }
    
    return height;
}

@end
