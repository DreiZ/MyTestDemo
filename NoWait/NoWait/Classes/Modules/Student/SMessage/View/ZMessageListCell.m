//
//  ZMessageListCell.m
//  NoWait
//
//  Created by zhuang zhang on 2020/5/9.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZMessageListCell.h"
#import "ZBaseLineCell.h"


@interface ZMessageListCell ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic,strong) UIView *contView;
@property (nonatomic,strong) UITableView *iTableView;
@property (nonatomic,strong) NSMutableArray *cellConfigArr;
@end

@implementation ZMessageListCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupView];
    }
    return self;
}

-(void)setupView {
    [super setupView];
    
    _cellConfigArr = @[].mutableCopy;
    
    self.contentView.backgroundColor = adaptAndDarkColor([UIColor colorGrayBG], [UIColor colorGrayBGDark]);
    [self.contentView addSubview:self.contView];
    [self.contView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(CGFloatIn750(30));
        make.right.equalTo(self.mas_right).offset(-CGFloatIn750(30));
        make.top.equalTo(self.mas_top).offset(CGFloatIn750(20));
        make.bottom.equalTo(self.mas_bottom).offset(-CGFloatIn750(10));
    }];
    
    [self.contView addSubview:self.iTableView];
    [self.iTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.contView);
        make.top.equalTo(self.contView.mas_top).offset(CGFloatIn750(24));
        make.bottom.equalTo(self.contView.mas_bottom).offset(-CGFloatIn750(10));
    }];
    [self initCellConfigArr];
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

- (UIView *)contView {
    if (!_contView) {
        _contView = [[UIView alloc] init];
        _contView.backgroundColor = adaptAndDarkColor([UIColor colorWhite], [UIColor colorBlackBGDark]);
        ViewRadius(_contView, CGFloatIn750(20));
    }
    return _contView;
}


+(CGFloat)z_getCellHeight:(id)sender {
//    if (sender && [sender isKindOfClass:[ZMessgeModel class]]) {
//        CGFloat cellHeight = CGFloatIn750(54)+CGFloatIn750(20) + CGFloatIn750(104);
//        ZMessgeModel *model = sender;
////        switch ([model.notice intValue]) {
////            case ZCustomNoticeTypeSettledIn :                        //  机构入驻通知
////                {
////
////                }
////                    break;
////            case ZCustomNoticeTypeCourseAudit:                    //  课程审核通知
////                {
////
////                }
////                    break;
////            case ZCustomNoticeTypePayment:                       //  支付交易通知
////                {
////
////                }
////                    break;
////            case ZCustomNoticeTypeRefund:                          //  退款通知
////                {
////
////                }
////                    break;
////            case ZCustomNoticeTypeMoneyBack:                      //  回款通知
////                {
////
////                }
////                    break;
////            case ZCustomNoticeTypeRegister:                       //  注册通知
////                {
////
////                }
////                    break;
////            case ZCustomNoticeTypeAppointment:                     //  预约通知
////                {
////
////                }
////                    break;
////            case ZCustomNoticeTypeCourseBegins:                   //  开课通知
////                {
////
////                }
////                    break;
////            case ZCustomNoticeTypeCourseEnd:                      //  结课通知
////                {
////
////                }
////                    break;
////            case ZCustomNoticeTypeCourseSign:                     //  签课通知
////                {
////
////                }
////                    break;
////            case ZCustomNoticeTypeEvaluate:                        //  评价通知
////                {
////
////                }
////                    break;
////            case ZCustomNoticeTypeCustom:
////                {
////
////                }
////                    break;
////            case ZCustomNoticeTypeNotice:                        //机构老师通知
////                {
////                    cellHeight = cellHeight + CGFloatIn750(54) + CGFloatIn750(20);
////                    cellHeight = cellHeight +CGFloatIn750(50) + CGFloatIn750(2);
////                    return cellHeight;
////                }
////                    break;
////            default:
////
////                break;
////        }
////    }
   
    CGFloat cellHeigt = CGFloatIn750(64) + CGFloatIn750(40);
    {
        ZLineCellModel *model = ZLineCellModel.zz_lineCellModel_create(@"message")
        .imageLeft(@"moneypaihang").titleLeft(@"校区消息")
        .fontLeft([UIFont boldFontTitle])
        .fontRight([UIFont fontSmall])
        .imageLeftHeight(CGFloatIn750(30))
        .lineHidden(YES)
        .height(CGFloatIn750(54));

        ZCellConfig *tempCellConfig = [ZCellConfig cellConfigWithClassName:[ZBaseLineCell className] title:model.cellTitle showInfoMethod:@selector(setModel:) heightOfCell:[ZBaseLineCell z_getCellHeight:model] cellType:ZCellTypeClass dataModel:model];
        cellHeigt = cellHeigt + tempCellConfig.heightOfCell;
    }
    {//老师
        ZLineCellModel *model = ZLineCellModel.zz_lineCellModel_create(@"message")
            .titleLeft(@"菜菜老师")
            .imageRight(@"http://wx3.sinaimg.cn/mw600/44f2ef1bgy1gem93vp6cej20u00ylh35.jpg")
            .imageLeftHeight(CGFloatIn750(44))
            .lineHidden(YES)
            .height(CGFloatIn750(64));

            ZCellConfig *tempCellConfig = [ZCellConfig cellConfigWithClassName:[ZBaseLineCell className] title:model.cellTitle showInfoMethod:@selector(setModel:) heightOfCell:[ZBaseLineCell z_getCellHeight:model] cellType:ZCellTypeClass dataModel:model];
            
        cellHeigt = cellHeigt + tempCellConfig.heightOfCell;
    }
    {
        ZLineCellModel *model = ZLineCellModel.zz_lineCellModel_create(@"message")
        .titleLeft(@"砥节奉公党内法规DNF看过来拿上来看的那个快乐是当年高考历年圣诞快乐尼古拉斯")
        .fontLeft([UIFont fontContent])
        .width(KScreenWidth - CGFloatIn750(60))
        .leftMultiLine(YES)
        .lineHidden(YES)
        .height(CGFloatIn750(36))
        .spaceLine(CGFloatIn750(12));

        ZCellConfig *tempCellConfig = [ZCellConfig cellConfigWithClassName:[ZBaseLineCell className] title:model.cellTitle showInfoMethod:@selector(setModel:) heightOfCell:[ZBaseLineCell z_getCellHeight:model] cellType:ZCellTypeClass dataModel:model];
        cellHeigt = cellHeigt + tempCellConfig.heightOfCell;
    }
    {//校区
        cellHeigt = cellHeigt + CGFloatIn750(20);
        ZLineCellModel *model = ZLineCellModel.zz_lineCellModel_create(@"message")
            .titleRight(@"菜菜老师")
            .fontRight([UIFont boldFontSmall])
            .lineHidden(YES)
            .height(CGFloatIn750(30));

            ZCellConfig *tempCellConfig = [ZCellConfig cellConfigWithClassName:[ZBaseLineCell className] title:model.cellTitle showInfoMethod:@selector(setModel:) heightOfCell:[ZBaseLineCell z_getCellHeight:model] cellType:ZCellTypeClass dataModel:model];
            
        cellHeigt = cellHeigt + tempCellConfig.heightOfCell;
    }
    {
        ZLineCellModel *model = ZLineCellModel.zz_lineCellModel_create(@"message")
        .lineHidden(NO)
        .height(CGFloatIn750(2));

        ZCellConfig *tempCellConfig = [ZCellConfig cellConfigWithClassName:[ZBaseLineCell className] title:model.cellTitle showInfoMethod:@selector(setModel:) heightOfCell:[ZBaseLineCell z_getCellHeight:model] cellType:ZCellTypeClass dataModel:model];
        cellHeigt = cellHeigt + tempCellConfig.heightOfCell;
    }
    {
        ZLineCellModel *model = ZLineCellModel.zz_lineCellModel_create(@"message")
        .titleLeft(@"查看详情")
        .fontLeft([UIFont fontSmall])
        .imageRight(@"rightBlackArrowN")
        .lineHidden(YES)
        .height(CGFloatIn750(54));

        
        ZCellConfig *tempCellConfig = [ZCellConfig cellConfigWithClassName:[ZBaseLineCell className] title:model.cellTitle showInfoMethod:@selector(setModel:) heightOfCell:[ZBaseLineCell z_getCellHeight:model] cellType:ZCellTypeClass dataModel:model];
        cellHeigt = cellHeigt + tempCellConfig.heightOfCell;
        cellHeigt = cellHeigt + CGFloatIn750(20);
    }
    return cellHeigt;
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
    if ([cellConfig.title isEqualToString:@"seeDetail"]) {
        if (self.handleBlock) {
            self.handleBlock(self.model, 0);
        }
    }else{
        if (self.handleBlock) {
            self.handleBlock(self.model, 1);
        }
    }
}

#pragma mark - setcellconfig
- (void)setModel:(ZMessgeModel *)model {
    _model = model;
    [self initCellConfigArr];
    [self.iTableView reloadData];
}

- (void)initCellConfigArr {
    [self.cellConfigArr removeAllObjects];
    
    [self.cellConfigArr addObject:[ZMessageListCell setTopTitle:self.model]];
    [self.cellConfigArr addObject:[ZMessageListCell setEmptyCell:CGFloatIn750(20) cellTitle:nil]];
    switch ([self.model.notice intValue]) {
        case ZCustomNoticeTypeSettledIn :                        //  机构入驻通知
            {
                [self.cellConfigArr addObject:[ZMessageListCell setMessageContent:self.model]];
                [self.cellConfigArr addObject:[ZMessageListCell setEmptyCell:CGFloatIn750(20) cellTitle:nil]];
                
                [self.cellConfigArr addObject:[ZMessageListCell setLineCell:CGFloatIn750(2)]];
                [self.cellConfigArr addObject:[ZMessageListCell setEmptyCell:CGFloatIn750(20) cellTitle:@"seeDetail"]];
                [self.cellConfigArr addObject:[ZMessageListCell setSeeDetail:@"去完善"]];
                [self.cellConfigArr addObject:[ZMessageListCell setEmptyCell:CGFloatIn750(20) cellTitle:@"seeDetail"]];
            }
                break;
        case ZCustomNoticeTypeCourseAudit:                    //  课程审核通知
            {
                
            }
                break;
        case ZCustomNoticeTypePayment:                       //  支付交易通知
            {
                
            }
                break;
        case ZCustomNoticeTypeRefund:                          //  退款通知
            {
                
            }
                break;
        case ZCustomNoticeTypeMoneyBack:                      //  回款通知
            {
                
            }
                break;
        case ZCustomNoticeTypeRegister:                       //  注册通知
            {
                [self.cellConfigArr addObject:[ZMessageListCell setMessageContent:self.model]];
                [self.cellConfigArr addObject:[ZMessageListCell setEmptyCell:CGFloatIn750(20) cellTitle:nil]];
                
                [self.cellConfigArr addObject:[ZMessageListCell setLineCell:CGFloatIn750(2)]];
                [self.cellConfigArr addObject:[ZMessageListCell setEmptyCell:CGFloatIn750(20) cellTitle:@"seeDetail"]];
                [self.cellConfigArr addObject:[ZMessageListCell setSeeDetail:@"去完善"]];
                [self.cellConfigArr addObject:[ZMessageListCell setEmptyCell:CGFloatIn750(20) cellTitle:@"seeDetail"]];
            }
                break;
        case ZCustomNoticeTypeAppointment:                     //  预约通知
            {
                
            }
                break;
        case ZCustomNoticeTypeCourseBegins:                   //  开课通知
            {
                
            }
                break;
        case ZCustomNoticeTypeCourseEnd:                      //  结课通知
            {
                
            }
                break;
        case ZCustomNoticeTypeCourseSign:                     //  签课通知
            {
                
            }
                break;
        case ZCustomNoticeTypeEvaluate:                        //  评价通知
            {
                
            }
                break;
        case ZCustomNoticeTypeCustom:
            {
                
            }
                break;
        case ZCustomNoticeTypeNotice:                        //机构老师通知
            {
                if ([[ZUserHelper sharedHelper].user.type intValue] != 2 && [self.model.terminal intValue] == ZCustomChannleTypeTeacher) {
                    [self.cellConfigArr addObject:[ZMessageListCell setTeacher:self.model]];
                    [self.cellConfigArr addObject:[ZMessageListCell setEmptyCell:CGFloatIn750(20) cellTitle:nil]];
                }
                
                [self.cellConfigArr addObject:[ZMessageListCell setMessageContent:self.model]];
                [self.cellConfigArr addObject:[ZMessageListCell setEmptyCell:CGFloatIn750(20) cellTitle:nil]];
                [self.cellConfigArr addObject:[ZMessageListCell setMessageSend:self.model]];
                [self.cellConfigArr addObject:[ZMessageListCell setEmptyCell:CGFloatIn750(20) cellTitle:nil]];
                
                if ([[ZUserHelper sharedHelper].user.type intValue] != 1) {
                    [self.cellConfigArr addObject:[ZMessageListCell setLineCell:CGFloatIn750(2)]];
                    [self.cellConfigArr addObject:[ZMessageListCell setEmptyCell:CGFloatIn750(20) cellTitle:@"seeDetail"]];
                    [self.cellConfigArr addObject:[ZMessageListCell setSeeDetail:[NSString stringWithFormat:@"查看收件人(%@)",self.model.extra.account_total]]];
                    [self.cellConfigArr addObject:[ZMessageListCell setEmptyCell:CGFloatIn750(20) cellTitle:@"seeDetail"]];
                }else{
                    [self.cellConfigArr addObject:[ZMessageListCell setEmptyCell:CGFloatIn750(20) cellTitle:@"seeDetail"]];
                }
            }
                break;
        default:
            
            break;
    }
    [self.iTableView reloadData];
}

+ (ZCellConfig *)setTopTitle:(ZMessgeModel *)messageModel {
//标题;
    NSString *image = @"";
    NSString *type = @"";
    switch ([messageModel.type intValue]) {
        case ZCustomChannleTypeInteract:
        {
            type = @"互动消息";
            image = @"messageTypeHudong";
        }
            break;
        case ZCustomChannleTypeSystem:
        {
            type = @"系统消息";
            image = @"messageTypeSystem";
        }
            break;
        case ZCustomChannleTypeStore:
        {
            type = @"校区消息";
            image = @"messageTypeSchool";
        }
            break;
        case ZCustomChannleTypeTeacher:
        {
            type = @"教师消息";
            image = @"messageTypeStore";
        }
            break;
        case ZCustomChannleTypeStudent:
        {
            type = @"学员消息";
            image = @"messageTypeSystem";
        }
            break;
        case ZCustomChannleTypeCustom:
        {
            type = @"通知消息";
            image = @"ZCustomChannleTypeCustom";
        }
            break;
            
        default:
            
            break;
    }
    ZLineCellModel *model = ZLineCellModel.zz_lineCellModel_create(@"message")
        .imageLeft(image).titleLeft(type)
        .fontLeft([UIFont boldFontTitle])
        .fontRight([UIFont fontSmall])
        .titleRight(SafeStr(messageModel.time)).colorRight([UIColor colorTextGray1])
        .colorDarkRight([UIColor colorTextGray1Dark])
        .imageLeftHeight(CGFloatIn750(30))
        .lineHidden(YES)
        .height(CGFloatIn750(54));

    ZCellConfig *tempCellConfig = [ZCellConfig cellConfigWithClassName:[ZBaseLineCell className] title:model.cellTitle showInfoMethod:@selector(setModel:) heightOfCell:[ZBaseLineCell z_getCellHeight:model] cellType:ZCellTypeClass dataModel:model];
        
    return tempCellConfig;
}

+ (ZCellConfig *)setMessageContent:(ZMessgeModel *)messageModel {
    ZLineCellModel *model = ZLineCellModel.zz_lineCellModel_create(@"message")
    .titleLeft(SafeStr(messageModel.body))
    .fontLeft([UIFont fontContent])
    .colorLeft([UIColor colorTextGray])
    .colorDarkLeft([UIColor colorTextGrayDark])
    .width(KScreenWidth - CGFloatIn750(60))
    .leftMultiLine(YES)
    .lineHidden(YES)
    .height(CGFloatIn750(36))
    .spaceLine(CGFloatIn750(12));

    ZCellConfig *tempCellConfig = [ZCellConfig cellConfigWithClassName:[ZBaseLineCell className] title:model.cellTitle showInfoMethod:@selector(setModel:) heightOfCell:[ZBaseLineCell z_getCellHeight:model] cellType:ZCellTypeClass dataModel:model];
    return tempCellConfig;
}

+ (ZCellConfig *)setMessageSend:(ZMessgeModel *)messageModel {
    //校区
    ZLineCellModel *model = ZLineCellModel.zz_lineCellModel_create(@"message")
    .titleRight(SafeStr(messageModel.extra.store_name))
        .colorRight([UIColor colorTextBlack])
        .colorDarkRight([UIColor colorTextBlackDark])
        .fontRight([UIFont boldFontSmall])
        .lineHidden(YES)
        .height(CGFloatIn750(30));

    ZCellConfig *tempCellConfig = [ZCellConfig cellConfigWithClassName:[ZBaseLineCell className] title:model.cellTitle showInfoMethod:@selector(setModel:) heightOfCell:[ZBaseLineCell z_getCellHeight:model] cellType:ZCellTypeClass dataModel:model];

    return tempCellConfig;
}

+ (ZCellConfig *)setSeeDetail:(NSString *)seeDetail {
    ZLineCellModel *model = ZLineCellModel.zz_lineCellModel_create(@"seeDetail")
    .titleLeft(SafeStr(seeDetail))
    .fontLeft([UIFont fontSmall])
    .imageRight(@"rightBlackArrowN")
    .imageRightHeight(CGFloatIn750(8))
    .lineHidden(YES)
    .height(CGFloatIn750(54));

    ZCellConfig *tempCellConfig = [ZCellConfig cellConfigWithClassName:[ZBaseLineCell className] title:model.cellTitle showInfoMethod:@selector(setModel:) heightOfCell:[ZBaseLineCell z_getCellHeight:model] cellType:ZCellTypeClass dataModel:model];
    return tempCellConfig;
}

+ (ZCellConfig *)setTeacher:(ZMessgeModel *)messageModel {
    //老师

    ZLineCellModel *model = ZLineCellModel.zz_lineCellModel_create(@"message")
        .titleLeft(SafeStr(messageModel.extra.teacher))
        .imageLeft(SafeStr(messageModel.extra.teacher_image))
        .imageLeftHeight(CGFloatIn750(44))
        .lineHidden(YES)
    .height(CGFloatIn750(74)).imageLeftRadius(YES);

    ZCellConfig *tempCellConfig = [ZCellConfig cellConfigWithClassName:[ZBaseLineCell className] title:model.cellTitle showInfoMethod:@selector(setModel:) heightOfCell:[ZBaseLineCell z_getCellHeight:model] cellType:ZCellTypeClass dataModel:model];
    
    return tempCellConfig;
}

+ (ZCellConfig *)setEmptyCell:(CGFloat)height cellTitle:(NSString *)cellTitle{
    ZCellConfig *cellConfig = [ZCellConfig cellConfigWithClassName:[ZSpaceEmptyCell className] title:cellTitle ? cellTitle:[ZSpaceEmptyCell className] showInfoMethod:@selector(setBackColor:) heightOfCell:height cellType:ZCellTypeClass dataModel:adaptAndDarkColor([UIColor colorWhite], [UIColor colorBlackBGDark])];
    return cellConfig;
}

+ (ZCellConfig *)setLineCell:(CGFloat)height {
     ZLineCellModel *model = ZLineCellModel.zz_lineCellModel_create(@"message")
       .lineHidden(NO)
       .height(height)
       .contentSpaceLeft(CGFloatIn750(46))
       .contentSpaceRight(CGFloatIn750(46));

    ZCellConfig *tempCellConfig = [ZCellConfig cellConfigWithClassName:[ZBaseLineCell className] title:model.cellTitle showInfoMethod:@selector(setModel:) heightOfCell:[ZBaseLineCell z_getCellHeight:model] cellType:ZCellTypeClass dataModel:model];
    return tempCellConfig;
}
@end
