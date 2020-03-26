//
//  ZStudentLessonDetailVC.m
//  NoWait
//
//  Created by zhuang zhang on 2020/3/21.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZStudentLessonDetailVC.h"
#import "ZOrganizationLessonDetailHeaderCell.h"

#import "ZOrganizationLessonDetailPriceCell.h"
#import "ZTextFieldMultColCell.h"
#import "ZMultiseriateContentLeftLineCell.h"
#import "ZStudentOrganizationDetailIntroLabelCell.h"
#import "ZStudentOrganizationDetailEnteryCell.h"
#import "ZStudentOrganizationPersonnelMoreCell.h"
#import "ZStudentOrganizationPersonnelListCell.h"
#import "ZBaseUnitModel.h"
#import "ZStudentMineModel.h"
#import "ZStudentEvaListCell.h"
#import "ZStudentLessonSelectMainNewView.h"
#import "ZAlertCouponCheckBoxView.h"
#import "ZOriganizationLessonViewModel.h"

#import "ZOriganizationOrderViewModel.h"
#import "ZOrganizationDetailBottomView.h"
#import "ZOrderModel.h"

@interface ZStudentLessonDetailVC ()
@property (nonatomic,strong) UIButton *navLeftBtn;
@property (nonatomic,strong) UIView *topNavView;
@property (nonatomic,strong) ZStudentLessonSelectMainNewView *selectView;
@property (nonatomic,strong) ZOriganizationLessonAddModel *addModel;
@property (nonatomic,strong) ZOrganizationDetailBottomView *bottomView;
@property (nonatomic,assign) NSInteger k;
@end

@implementation ZStudentLessonDetailVC

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.isHidenNaviBar = YES;
    
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initCellConfigArr];
    [self.iTableView reloadData];
    [self refreshData];
}

- (void)setupMainView {
    [super setupMainView];
    
    [self.view addSubview:self.topNavView];
    [self.topNavView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(self.view);
        make.height.mas_equalTo(kTopHeight);
    }];
    
    [self.view addSubview:self.navLeftBtn];
    [self.navLeftBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(CGFloatIn750(50));
        make.left.equalTo(self.view.mas_left).offset(CGFloatIn750(30));
        make.bottom.equalTo(self.topNavView.mas_bottom).offset(-CGFloatIn750(17));
    }];
    
    [self.view addSubview:self.bottomView];
    [self.bottomView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.height.mas_equalTo(CGFloatIn750(88) + safeAreaBottom());
    }];
    
    [self.iTableView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self.view);
        make.bottom.equalTo(self.bottomView.mas_top);
    }];
}

- (UIButton *)navLeftBtn {
    if (!_navLeftBtn) {
        __weak typeof(self) weakSelf = self;
        _navLeftBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, CGFloatIn750(50), CGFloatIn750(50))];
        [_navLeftBtn setBackgroundColor:[UIColor colorGrayBG] forState:UIControlStateNormal];
        [_navLeftBtn setImage:[UIImage imageNamed:@"navleftBack"] forState:UIControlStateNormal];
        ViewRadius(_navLeftBtn, CGFloatIn750(25));
        [_navLeftBtn bk_whenTapped:^{
            [weakSelf.navigationController popViewControllerAnimated:YES];
        }];
    }
    return _navLeftBtn;
}

- (UIView *)topNavView {
    if (!_topNavView) {
        _topNavView = [[UIView alloc] init];
        _topNavView.backgroundColor = adaptAndDarkColor([UIColor colorMain], [UIColor colorMainDark]);
        _topNavView.alpha = 0;
    }
    return _topNavView;
}


- (ZStudentLessonSelectMainNewView *)selectView {
    if (!_selectView) {
        __weak typeof(self) weakSelf = self;
        _selectView = [[ZStudentLessonSelectMainNewView alloc] init];
//        _selectView.completeBlock = ^(ZLessonBuyType type) {
//            if (type == ZLessonBuyTypeBuyInitial || type == ZLessonBuyTypeBuyBeginLesson) {
//                ZStudentLessonSureOrderVC *order = [[ZStudentLessonSureOrderVC alloc] init];
//                [weakSelf.navigationController pushViewController:order animated:YES];
//            }else{
//                ZStudentLessonSubscribeSureOrderVC *order = [[ZStudentLessonSubscribeSureOrderVC alloc] init];
//                [weakSelf.navigationController pushViewController:order animated:YES];
//            }
//        };
    }
    return _selectView;
}


-(ZOrganizationDetailBottomView *)bottomView {
    if (!_bottomView) {
        NSArray *name = @[@"恨桃", @"依秋", @"依波", @"香巧", @"紫萱", @"涵易", @"忆之", @"幻巧", @"美倩", @"安寒", @"白亦", @"惜玉", @"碧春", @"怜雪", @"听南", @"念蕾", @"紫夏", @"凌旋", @"芷梦", @"凌寒", @"梦竹", @"千凡", @"丹蓉", @"慧贞", @"思菱", @"平卉", @"笑柳", @"雪卉", @"南蓉", @"谷梦", @"巧兰", @"绿蝶", @"飞荷", @"佳蕊", @"芷荷", @"怀瑶", @"慕易", @"若芹", @"紫安", @"曼冬", @"寻巧", @"雅昕", @"尔槐", @"以旋", @"初夏", @"依丝", @"怜南", @"傲菡", @"谷蕊", @"笑槐", @"飞兰", @"笑卉", @"迎荷", @"佳音", @"梦君", @"妙绿", @"觅雪", @"寒安", @"沛凝", @"白容", @"乐蓉", @"映安", @"依云", @"映冬", @"凡雁", @"梦秋", @"梦凡", @"秋巧", @"若云", @"元容", @"怀蕾", @"灵寒", @"天薇", @"翠安", @"乐琴", @"宛南", @"怀蕊", @"白风", @"访波", @"亦凝", @"易绿", @"夜南", @"曼凡", @"亦巧", @"青易", @"冰真", @"白萱", @"友安", @"海之", @"小蕊", @"又琴", @"天风", @"若松", @"盼菡", @"秋荷", @"香彤", @"语梦", @"惜蕊", @"迎彤", @"沛白", @"雁彬", @"易蓉", @"雪晴", @"诗珊", @"春冬", @"晴钰", @"冰绿", @"半梅", @"笑容", @"沛凝", @"映秋", @"盼烟", @"晓凡", @"涵雁", @"问凝", @"冬萱", @"晓山", @"雁蓉", @"梦蕊", @"山菡", @"南莲", @"飞双", @"凝丝", @"思萱", @"怀梦", @"雨梅", @"冷霜", @"向松", @"迎丝", @"迎梅", @"雅彤", @"香薇", @"以山", @"碧萱", @"寒云", @"向南", @"书雁", @"怀薇", @"思菱", @"忆文", @"翠巧", @"书文", @"若山", @"向秋", @"凡白", @"绮烟", @"从蕾", @"天曼", @"又亦", @"从语", @"绮彤", @"之玉", @"凡梅", @"依琴", @"沛槐", @"又槐", @"元绿", @"安珊", @"夏之"];
        __weak typeof(self) weakSelf = self;
        _bottomView = [[ZOrganizationDetailBottomView alloc] init];
        _bottomView.handleBlock = ^(NSInteger index) {
            if (index == 0) {
                NSMutableDictionary *params = @{}.mutableCopy;
                [params setObject:weakSelf.addModel.stores_id forKey:@"stores_id"];
                [params setObject:@"7" forKey:@"teacher_id"];
//                [params setObject:@"23" forKey:@"coupons_id"];
                [params setObject:weakSelf.addModel.lessonID forKey:@"course_id"];
//                [params setObject:@"1" forKey:@"pay_type"];
//                [params setObject:@"1" forKey:@"pay_amount"];
                [params setObject:name[weakSelf.k] forKey:@"real_name"];
                [params setObject:@"18762288553" forKey:@"phone"];
                [ZOriganizationOrderViewModel addOrder:params completeBlock:^(BOOL isSuccess, id data) {
                    if (isSuccess) {
                        ZOrderAddNetModel *model = data;
                        [TLUIUtility showSuccessHint:model.message];
                    }else{
                        [TLUIUtility showErrorHint:data];
                    }
                    weakSelf.k++;
                }];
                
//                [weakSelf.selectView showSelectViewWithType:ZLessonBuyTypeBuyBeginLesson];
            }else{
//                [weakSelf.selectView showSelectViewWithType:ZLessonBuyTypeSubscribeBeginLesson];
            }
            
        };
    }
    return _bottomView;
}


#pragma mark - scrollview delegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    // 获取到tableView偏移量
    CGFloat Offset_y = scrollView.contentOffset.y;
    // 下拉 纵向偏移量变小 变成负的
   
    if (Offset_y > CGFloatIn750(420)) {
        self.topNavView.alpha = (Offset_y - CGFloatIn750(420))/CGFloatIn750(50);
    }else {
        self.topNavView.alpha = 0;
    }
}

- (void)zz_tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath cellConfig:(ZCellConfig *)cellConfig {
    [ZAlertCouponCheckBoxView setAlertName:@"选择优惠券" schoolID:@"7" handlerBlock:^(NSInteger index, id data) {
        
    }];
//    [self.selectView showSelectViewWithType:ZLessonBuyTypeSubscribeInitial];
}

#pragma mark - setDetailData
- (void)setLessonName {
    ZBaseSingleCellModel *model = [[ZBaseSingleCellModel alloc] init];
    model.leftTitle = @"是的噶是的发送到";
    model.rightTitle = @"3小时/节   共12节";
    model.isHiddenLine = YES;
    model.leftFont = [UIFont boldFontMax1Title];
    model.rightFont = [UIFont fontSmall];
    model.rightColor = [UIColor colorTextGray];
    model.rightDarkColor = [UIColor colorTextGrayDark];
    model.cellHeight = CGFloatIn750(116);
    
    ZCellConfig *menuCellConfig = [ZCellConfig cellConfigWithClassName:[ZSingleLineCell className] title:model.cellTitle showInfoMethod:@selector(setModel:) heightOfCell:[ZSingleLineCell z_getCellHeight:model] cellType:ZCellTypeClass dataModel:model];
    
    [self.cellConfigArr addObject:menuCellConfig];
    
    {
        ZBaseSingleCellModel *model = [[ZBaseSingleCellModel alloc] init];
        model.leftTitle = @"是的噶是的发送到";
        model.isHiddenLine = YES;
        model.leftFont = [UIFont fontContent];
        model.rightFont = [UIFont fontSmall];
        model.cellHeight = CGFloatIn750(50);
        
        ZCellConfig *menuCellConfig = [ZCellConfig cellConfigWithClassName:[ZSingleLineCell className] title:model.cellTitle showInfoMethod:@selector(setModel:) heightOfCell:[ZSingleLineCell z_getCellHeight:model] cellType:ZCellTypeClass dataModel:model];
        
        [self.cellConfigArr addObject:menuCellConfig];
    }
    
    {
        ZCellConfig *topCellConfig = [ZCellConfig cellConfigWithClassName:[ZSpaceEmptyCell className] title:[ZSpaceEmptyCell className] showInfoMethod:@selector(setBackColor:) heightOfCell:CGFloatIn750(24) cellType:ZCellTypeClass dataModel:adaptAndDarkColor([UIColor colorWhite], [UIColor colorBlackBGDark])];
        [self.cellConfigArr addObject:topCellConfig];
        
        ZCellConfig *menuCellConfig = [ZCellConfig cellConfigWithClassName:[ZStudentOrganizationDetailEnteryCell className] title:[ZStudentOrganizationDetailEnteryCell className] showInfoMethod:nil heightOfCell:[ZStudentOrganizationDetailEnteryCell z_getCellHeight:model] cellType:ZCellTypeClass dataModel:nil];
        
        [self.cellConfigArr addObject:menuCellConfig];
        [self.cellConfigArr addObject:topCellConfig];
    }
    {
        {
            ZCellConfig *topCellConfig = [ZCellConfig cellConfigWithClassName:[ZSpaceEmptyCell className] title:[ZSpaceEmptyCell className] showInfoMethod:@selector(setBackColor:) heightOfCell:CGFloatIn750(24) cellType:ZCellTypeClass dataModel:adaptAndDarkColor([UIColor colorWhite], [UIColor colorBlackBGDark])];
            [self.cellConfigArr addObject:topCellConfig];
            
            
            ZBaseSingleCellModel *model = [[ZBaseSingleCellModel alloc] init];
            model.leftTitle = @"课程教练";
            model.isHiddenLine = YES;
            model.leftFont = [UIFont boldFontContent];
            model.cellHeight = CGFloatIn750(50);
            
            ZCellConfig *menuCellConfig = [ZCellConfig cellConfigWithClassName:[ZSingleLineCell className] title:model.cellTitle showInfoMethod:@selector(setModel:) heightOfCell:[ZSingleLineCell z_getCellHeight:model] cellType:ZCellTypeClass dataModel:model];
            
            [self.cellConfigArr addObject:menuCellConfig];
        }
        
        NSArray *entryArr = @[@[@"赵忠",@"http://wx1.sinaimg.cn/mw600/006Gs6QQly1gcknb2ejnyj30j60t6qbn.jpg"],@[@"张丽",@"http://wx4.sinaimg.cn/mw600/0076BSS5ly1gcl80isz84j30u00u0jwi.jpg"],@[@"马克",@"http://wx1.sinaimg.cn/mw600/0076BSS5ly1gcl7zwzov9j30u018y1kx.jpg"],@[@"张丽",@"http://wx3.sinaimg.cn/mw600/0076BSS5ly1gcl7u7pskfj30u011hn2c.jpg"],@[@"张思思",@"http://wx3.sinaimg.cn/mw600/0076BSS5ly1gcl7pza70dj30u01a4tuy.jpg"],@[@"许倩倩",@"http://wx3.sinaimg.cn/mw600/0076BSS5ly1gcl7fhvi5tj30ds0kumz8.jpg"],@[@"吴楠",@"http://wx3.sinaimg.cn/mw600/0076BSS5ly1gcl77552l7j30qo0hsgpo.jpg"],@[@"闫晶晶",@"http://wx3.sinaimg.cn/mw600/0076BSS5ly1gcl74tqdyfj30gk0cbqfk.jpg"]];
        
        NSMutableArray *peoples = @[].mutableCopy;
        for (int i = 0; i < entryArr.count; i++) {
            ZStudentDetailPersonnelModel *model = [[ZStudentDetailPersonnelModel alloc] init];
            model.image = entryArr[i][1];
            model.name = entryArr[i][0];
            model.skill = entryArr[i][0];
            [peoples addObject:model];
        }
        
        ZCellConfig *coachCellConfig = [ZCellConfig cellConfigWithClassName:[ZStudentOrganizationPersonnelListCell className] title:@"starCoach" showInfoMethod:@selector(setPeopleslList:) heightOfCell:[ZStudentOrganizationPersonnelListCell z_getCellHeight:peoples] cellType:ZCellTypeClass dataModel:peoples];
        [self.cellConfigArr addObject:coachCellConfig];
    }
    
    {
        {
            ZCellConfig *topCellConfig = [ZCellConfig cellConfigWithClassName:[ZSpaceEmptyCell className] title:[ZSpaceEmptyCell className] showInfoMethod:@selector(setBackColor:) heightOfCell:CGFloatIn750(24) cellType:ZCellTypeClass dataModel:adaptAndDarkColor([UIColor colorWhite], [UIColor colorBlackBGDark])];
            [self.cellConfigArr addObject:topCellConfig];
            
            
            ZBaseSingleCellModel *model = [[ZBaseSingleCellModel alloc] init];
            model.leftTitle = @"课程教练";
            model.isHiddenLine = YES;
            model.leftFont = [UIFont boldFontContent];
            model.cellHeight = CGFloatIn750(50);
            
            ZCellConfig *menuCellConfig = [ZCellConfig cellConfigWithClassName:[ZSingleLineCell className] title:model.cellTitle showInfoMethod:@selector(setModel:) heightOfCell:[ZSingleLineCell z_getCellHeight:model] cellType:ZCellTypeClass dataModel:model];
            
            [self.cellConfigArr addObject:menuCellConfig];
        }
        
        ZBaseMultiseriateCellModel *model = [[ZBaseMultiseriateCellModel alloc] init];
        model.rightTitle = @"          跟你说开了个男的说开了个女生里看到那个克里斯\n         蒂娜离开给你离开萨拉的奶粉噶克里斯蒂娜赶快来昂阿森纳的管理卡拿到了开始给你来卡都是那个路口那里卡少女管\n       理可能来说可能打过来看你离开你离开那里看到你离开你离开你了上当了看上的管理科拿上来看你的过来看上了快过年了开始你的\n     管理科少打了那个老卡死你过来看上了困难";
        model.isHiddenLine = YES;
        model.cellWidth = KScreenWidth;
        model.singleCellHeight = CGFloatIn750(60);
        model.leftMargin = CGFloatIn750(30);
        model.rightMargin = CGFloatIn750(30);
        model.cellHeight = CGFloatIn750(62);
        model.rightColor = [UIColor colorTextBlack];
        model.rightDarkColor = [UIColor colorTextBlackDark];
        model.rightFont = [UIFont fontContent];
        
        ZCellConfig *menuCellConfig = [ZCellConfig cellConfigWithClassName:[ZMultiseriateContentLeftLineCell className] title:model.cellTitle showInfoMethod:@selector(setMModel:) heightOfCell:[ZMultiseriateContentLeftLineCell z_getCellHeight:model] cellType:ZCellTypeClass dataModel:model];
        
        [self.cellConfigArr addObject:menuCellConfig];
    }
    
    
    {
        {
            ZCellConfig *topCellConfig = [ZCellConfig cellConfigWithClassName:[ZSpaceEmptyCell className] title:[ZSpaceEmptyCell className] showInfoMethod:@selector(setBackColor:) heightOfCell:CGFloatIn750(24) cellType:ZCellTypeClass dataModel:adaptAndDarkColor([UIColor colorWhite], [UIColor colorBlackBGDark])];
            [self.cellConfigArr addObject:topCellConfig];
            
            
            ZBaseSingleCellModel *model = [[ZBaseSingleCellModel alloc] init];
            model.leftTitle = @"购买须知：";
            model.isHiddenLine = YES;
            model.leftFont = [UIFont boldFontContent];
            model.cellHeight = CGFloatIn750(50);
            
            ZCellConfig *menuCellConfig = [ZCellConfig cellConfigWithClassName:[ZSingleLineCell className] title:model.cellTitle showInfoMethod:@selector(setModel:) heightOfCell:[ZSingleLineCell z_getCellHeight:model] cellType:ZCellTypeClass dataModel:model];
            
            [self.cellConfigArr addObject:menuCellConfig];
        }
        
        ZBaseMultiseriateCellModel *model = [[ZBaseMultiseriateCellModel alloc] init];
        model.rightTitle = @"跟你说开了个男的说开了个女生里看到那个克里斯";
        model.isHiddenLine = YES;
        model.cellWidth = KScreenWidth;
        model.singleCellHeight = CGFloatIn750(60);
        model.leftMargin = CGFloatIn750(30);
        model.rightMargin = CGFloatIn750(30);
        model.cellHeight = CGFloatIn750(62);
        model.rightColor = [UIColor colorTextBlack];
        model.rightDarkColor = [UIColor colorTextBlackDark];
        model.rightFont = [UIFont fontContent];
        
        ZCellConfig *menuCellConfig = [ZCellConfig cellConfigWithClassName:[ZMultiseriateContentLeftLineCell className] title:model.cellTitle showInfoMethod:@selector(setMModel:) heightOfCell:[ZMultiseriateContentLeftLineCell z_getCellHeight:model] cellType:ZCellTypeClass dataModel:model];
        
        [self.cellConfigArr addObject:menuCellConfig];
    }
}


- (void)initCellConfigArr {
    [super initCellConfigArr];
    
    [self setImagesAndPrice];
    
    {
        ZBaseMultiseriateCellModel *mModel = [[ZBaseMultiseriateCellModel alloc] init];
        mModel.rightFont = [UIFont fontContent];
        mModel.rightColor = adaptAndDarkColor([UIColor colorTextBlack], [UIColor colorTextBlackDark]);
        mModel.singleCellHeight = CGFloatIn750(40);
        mModel.isHiddenLine = YES;
        mModel.data = @[@"代付俱乐部",@"代付俱乐部",@"代付俱乐部"];
        mModel.rightColor = [UIColor colorRedForLabel];
        mModel.rightDarkColor = [UIColor colorRedForLabelSub];
        mModel.leftFont = [UIFont boldFontMax1Title];
        mModel.rightImage = @"rightBlackArrowN";
        
        ZCellConfig *textCellConfig = [ZCellConfig cellConfigWithClassName:[ZStudentOrganizationDetailIntroLabelCell className] title:mModel.cellTitle showInfoMethod:@selector(setModel:) heightOfCell:[ZStudentOrganizationDetailIntroLabelCell z_getCellHeight:mModel] cellType:ZCellTypeClass dataModel:mModel];
        [self.cellConfigArr addObject:textCellConfig];
    }
    
    [self setLessonName];
 
    
    {
        ZCellConfig *topCellConfig = [ZCellConfig cellConfigWithClassName:[ZSpaceEmptyCell className] title:[ZSpaceEmptyCell className] showInfoMethod:@selector(setBackColor:) heightOfCell:CGFloatIn750(30) cellType:ZCellTypeClass dataModel:adaptAndDarkColor([UIColor colorWhite], [UIColor colorBlackBGDark])];
        [self.cellConfigArr addObject:topCellConfig];
        
        ZBaseSingleCellModel *model = [[ZBaseSingleCellModel alloc] init];
        model.leftTitle = @"课程有效期";
        model.leftFont = [UIFont boldFontContent];
        model.cellHeight = CGFloatIn750(50);
        model.isHiddenLine = YES;
        
        ZCellConfig *menuCellConfig = [ZCellConfig cellConfigWithClassName:[ZSingleLineCell className] title:model.cellTitle showInfoMethod:@selector(setModel:) heightOfCell:[ZSingleLineCell z_getCellHeight:model] cellType:ZCellTypeClass dataModel:model];
        [self.cellConfigArr addObject:menuCellConfig];
        
        ZBaseSingleCellModel *model1 = [[ZBaseSingleCellModel alloc] init];
        model1.leftTitle = [NSString stringWithFormat:@"%d月",12];
        model1.leftFont = [UIFont fontSmall];
        model1.cellHeight = CGFloatIn750(42);
        model1.isHiddenLine = YES;
        
        ZCellConfig *menu1CellConfig = [ZCellConfig cellConfigWithClassName:[ZSingleLineCell className] title:model1.cellTitle showInfoMethod:@selector(setModel:) heightOfCell:[ZSingleLineCell z_getCellHeight:model1] cellType:ZCellTypeClass dataModel:model1];
        [self.cellConfigArr addObject:menu1CellConfig];
        
        {
            ZBaseSingleCellModel *model = [[ZBaseSingleCellModel alloc] init];
            model.lineLeftMargin = CGFloatIn750(30);
            model.lineRightMargin = CGFloatIn750(30);
            model.isHiddenLine = NO;
            model.cellHeight = CGFloatIn750(30);
            ZCellConfig *menuCellConfig = [ZCellConfig cellConfigWithClassName:[ZSingleLineCell className] title:model.cellTitle showInfoMethod:@selector(setModel:) heightOfCell:[ZSingleLineCell z_getCellHeight:model] cellType:ZCellTypeClass dataModel:model];
            
            [self.cellConfigArr addObject:menuCellConfig];
        }
    }
    [self addTimeOrder];
    [self setEva];
    
    [self.iTableView reloadData];
}

- (void)setEva {
    {
        ZBaseSingleCellModel *model = [[ZBaseSingleCellModel alloc] init];
        model.lineLeftMargin = CGFloatIn750(30);
        model.lineRightMargin = CGFloatIn750(30);
        model.isHiddenLine = NO;
        model.cellHeight = CGFloatIn750(10);
        ZCellConfig *menuCellConfig = [ZCellConfig cellConfigWithClassName:[ZSingleLineCell className] title:model.cellTitle showInfoMethod:@selector(setModel:) heightOfCell:[ZSingleLineCell z_getCellHeight:model] cellType:ZCellTypeClass dataModel:model];
        
        [self.cellConfigArr addObject:menuCellConfig];
    }
    
    ZCellConfig *topCellConfig = [ZCellConfig cellConfigWithClassName:[ZSpaceEmptyCell className] title:[ZSpaceEmptyCell className] showInfoMethod:@selector(setBackColor:) heightOfCell:CGFloatIn750(30) cellType:ZCellTypeClass dataModel:adaptAndDarkColor([UIColor colorWhite], [UIColor colorBlackBGDark])];
    [self.cellConfigArr addObject:topCellConfig];
    
    {
        ZBaseSingleCellModel *model = [[ZBaseSingleCellModel alloc] init];
        model.leftTitle = @"课程有效期";
        model.leftFont = [UIFont boldFontContent];
        model.cellHeight = CGFloatIn750(50);
        model.isHiddenLine = YES;
        
        ZCellConfig *menuCellConfig = [ZCellConfig cellConfigWithClassName:[ZSingleLineCell className] title:model.cellTitle showInfoMethod:@selector(setModel:) heightOfCell:[ZSingleLineCell z_getCellHeight:model] cellType:ZCellTypeClass dataModel:model];
        [self.cellConfigArr addObject:menuCellConfig];
    }
    
    
    ZStudentOrderEvaModel *evaModel = [[ZStudentOrderEvaModel alloc] init];
    evaModel.orderImage = @"lessonOrder";
    evaModel.orderNum = @"23042039523452";
    evaModel.lessonTitle = @"仰泳";
    evaModel.lessonTime = @"2019-10-26";
    evaModel.lessonCoach = @"高圆圆";
    evaModel.lessonOrg = @"上飞天俱乐部";
    evaModel.coachStar = @"3.4";
    evaModel.coachEva = @"吊柜好尬施工阿红化工诶按文化宫我胡搜ID哈工我哈山东IG后is阿活动IG华东师范";

    evaModel.orgStar = @"4.5";
    evaModel.orgEva = @"反反复复付受到法律和";
    
    ZCellConfig *evaCellConfig = [ZCellConfig cellConfigWithClassName:[ZStudentEvaListCell className] title:[ZStudentEvaListCell className] showInfoMethod:@selector(setModel:) heightOfCell:[ZStudentEvaListCell z_getCellHeight:evaModel] cellType:ZCellTypeClass dataModel:evaModel];
    [self.cellConfigArr addObject:evaCellConfig];
    [self.cellConfigArr addObject:evaCellConfig];
    [self.cellConfigArr addObject:evaCellConfig];
    [self.cellConfigArr addObject:evaCellConfig];
    [self.cellConfigArr addObject:evaCellConfig];
    [self.cellConfigArr addObject:evaCellConfig];
    [self.cellConfigArr addObject:evaCellConfig];
    [self.cellConfigArr addObject:evaCellConfig];
    
    
}

- (void)setImagesAndPrice {
    NSArray *stemparr = @[@"http://wx3.sinaimg.cn/mw600/0076BSS5ly1gd18jm09cuj30u017x7wh.jpg",
      @"http://wx1.sinaimg.cn/mw600/0076BSS5ly1gd18eptwlij318z0u0198.jpg",
      @"http://wx2.sinaimg.cn/mw600/0076BSS5ly1gd17vgbvgfj30u011eq9i.jpg",
    @"http://wx2.sinaimg.cn/mw600/0076BSS5ly1gd17qv01jnj30u01927az.jpg",
    @"http://wx3.sinaimg.cn/mw600/0076BSS5ly1gd17mjs214j30rs15o4qp.jpg",
    @"http://wx3.sinaimg.cn/mw600/0076BSS5ly1gd17hdmtn9j30u0142ang.jpg",
    @"http://wx1.sinaimg.cn/mw600/0076BSS5ly1gd17c994y0j30u011ignb.jpg",
    @"http://wx2.sinaimg.cn/mw600/007erPXFgy1gcei2kksvkj30rs15o1kx.jpg",
    @"http://wx3.sinaimg.cn/mw600/44f2ef1bgy1gd1746o74cj20ku0q1gqz.jpg"
    ];
    NSMutableArray *images = @[].mutableCopy;
    for (int i = 0; i < stemparr.count; i++) {
        ZStudentBannerModel *model = [[ZStudentBannerModel alloc] init];
        id image = stemparr[i];
        if ([image isKindOfClass:[UIImage class]]) {
            model.data = image;
            [images addObject:model];
        }else{
            NSString *imageStr = image;
            if (imageStr.length > 0) {
                model.data = imageStr;// imageFullUrl(imageStr);
                [images addObject:model];
            }
        }
    }
    ZCellConfig *statisticsCellConfig = [ZCellConfig cellConfigWithClassName:[ZOrganizationLessonDetailHeaderCell className] title:[ZOrganizationLessonDetailHeaderCell className] showInfoMethod:@selector(setList:) heightOfCell:[ZOrganizationLessonDetailHeaderCell z_getCellHeight:nil] cellType:ZCellTypeClass dataModel:images];
    [self.cellConfigArr addObject:statisticsCellConfig];
    
    ZBaseSingleCellModel *model = [[ZBaseSingleCellModel alloc] init];
    model.leftTitle = @"123";
    model.rightTitle = @"说点";
    
    ZCellConfig *priceCellConfig = [ZCellConfig cellConfigWithClassName:[ZOrganizationLessonDetailPriceCell className] title:[ZOrganizationLessonDetailPriceCell className] showInfoMethod:@selector(setModel:) heightOfCell:[ZOrganizationLessonDetailPriceCell z_getCellHeight:nil] cellType:ZCellTypeClass dataModel:model];
    [self.cellConfigArr addObject:priceCellConfig];
}


- (void)addTimeOrder {
    NSMutableArray *temo = @[].mutableCopy;
    for (int i = 0; i < 6; i++) {
        ZBaseMenuModel *model = [[ZBaseMenuModel alloc] init];
        model.name = @"周一  |";
        NSMutableArray *unit = @[].mutableCopy;
        for (int i = 0; i < 7; i++) {
            ZBaseUnitModel *unitmodel = [[ZBaseUnitModel alloc] init];
            unitmodel.name = @"12:12";
            unitmodel.subName = @"14:12";
            [unit addObject:unitmodel];
        }
        model.units = unit;
        [temo addObject:model];
    }
    ZBaseSingleCellModel *model = [[ZBaseSingleCellModel alloc] init];
    model.leftTitle = @"固定开课时间";
    model.leftFont = [UIFont boldFontContent];
    model.cellHeight = CGFloatIn750(30);
    model.isHiddenLine = YES;
    
    ZCellConfig *menuCellConfig = [ZCellConfig cellConfigWithClassName:[ZSingleLineCell className] title:model.cellTitle showInfoMethod:@selector(setModel:) heightOfCell:[ZSingleLineCell z_getCellHeight:model] cellType:ZCellTypeClass dataModel:model];
    [self.cellConfigArr addObject:menuCellConfig];
    
    for (ZBaseMenuModel *menu in temo) {
        NSString *subTitle = @"";
        for (int k = 0; k < menu.units.count; k++) {
            ZBaseUnitModel *unitModel = menu.units[k];
            if (subTitle.length == 0) {
                subTitle = [NSString stringWithFormat:@"%@~%@",unitModel.name,unitModel.subName];
            }else{
                subTitle = [NSString stringWithFormat:@"%@   %@~%@",subTitle,unitModel.name,unitModel.subName];
            }
        }
        
        ZBaseMultiseriateCellModel *model = [[ZBaseMultiseriateCellModel alloc] init];
        model.leftTitle = menu.name;
        model.rightTitle = subTitle;
        model.isHiddenLine = YES;
        model.cellWidth = KScreenWidth;
        model.singleCellHeight = CGFloatIn750(60);
        model.leftMargin = CGFloatIn750(30);
        model.rightMargin = CGFloatIn750(30);
        model.cellHeight = CGFloatIn750(62);
        model.leftFont = [UIFont fontSmall];
        model.rightFont = [UIFont fontSmall];
        model.leftColor = [UIColor colorTextGray];
        model.rightColor = [UIColor colorTextGray];
        model.leftDarkColor = [UIColor colorTextGrayDark];
        model.rightDarkColor = [UIColor colorTextGrayDark];
        
        ZCellConfig *menuCellConfig = [ZCellConfig cellConfigWithClassName:[ZMultiseriateContentLeftLineCell className] title:model.cellTitle showInfoMethod:@selector(setMModel:) heightOfCell:[ZMultiseriateContentLeftLineCell z_getCellHeight:model] cellType:ZCellTypeClass dataModel:model];
        
        [self.cellConfigArr addObject:menuCellConfig];
    }
}


- (void)refreshData {
    __weak typeof(self) weakSelf = self;
    [ZOriganizationLessonViewModel getLessonDetail:@{@"id":SafeStr(self.model.lessonID)} completeBlock:^(BOOL isSuccess, ZOriganizationLessonAddModel *addModel) {
        if (isSuccess) {
            weakSelf.addModel = addModel;
            [weakSelf initCellConfigArr];
            [weakSelf.iTableView reloadData];
        }
    }];
}
@end

