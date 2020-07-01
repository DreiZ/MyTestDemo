//
//  ZOrganizationPhotoUploadManageVC.m
//  NoWait
//
//  Created by zhuang zhang on 2020/6/22.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZOrganizationPhotoUploadManageVC.h"
#import "FBAttachmentUploadCollectionViewCell.h"

#import "XLPaymentSuccessHUD.h"
#import "XLPaymentLoadingHUD.h"

#import "ZFileManager.h"
#import "ZFileUploadTask.h"
#import "ZFileUploadManager.h"
#import "FBCustomUploadProgress.h"
#import "ZOriganizationPhotoViewModel.h"

/**每行显示的个数*/
static CGFloat kPerLineNumber = 3;
/**cell的identifier*/
static NSString *kAttachmentUploadCellIdentifier = @"kAttachmentUploadCellIdentifier";

#define SECTION_LEFT_MARGIN 30
#define ITEM_SPACE 20

@interface ZOrganizationPhotoUploadManageVC ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,FBAttachmentUploadCollectionViewCellDelegate>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray *uploadArr;
@property (nonatomic, strong) UIView *bottomView;
@property (nonatomic, strong) FBCustomUploadProgress *progressView;

@end

@implementation ZOrganizationPhotoUploadManageVC

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.navigationItem setTitle:@"相册上传列表"];
    
    [self setMainView];
    self.collectionView.hidden = NO;
    
    [self setDataSource];
    [self configData];
}

- (void)setDataSource {

    NSMutableArray *tasklist = @[].mutableCopy;
    
    NSInteger count = 0;
    for (int i = 0; i < self.imageArr.count; i++) {
//        ZFileUploadDataModel *dataModel = [[ZFileUploadDataModel alloc] init];
//        dataModel.image = self.imageArr[i];
//        dataModel.taskState = ZUploadStateWaiting;
        ZFileUploadDataModel *dataModel = self.imageArr[i];
        if (dataModel.taskState == ZUploadStateWaiting) {
            count++;
        }
        [tasklist addObject:self.imageArr[i]];
        [ZFileUploadManager addTaskDataToUploadWith:self.imageArr[i]];
    }
    if (count > 0) {
        [self configProgress:0.01];
            [self showLoadingAnimation];
        //    //异步串行
            [[ZFileUploadManager sharedInstance] asyncSerialUpload:tasklist progress:^(CGFloat p, NSInteger index) {
                [self configProgress:p/(tasklist.count+0.3)];
            } completion:^(id obj) {
                if (obj && [obj isKindOfClass:[NSArray class]]) {
                    NSArray *arr = obj;
                    NSMutableArray *images = @[].mutableCopy;
                    for (int i = 0; i < arr.count; i++) {
                        if ([arr[i] isKindOfClass:[ZBaseNetworkBackModel class]]) {
                            ZBaseNetworkBackModel *dataModel = arr[i];
                            if (ValidDict(dataModel.data)) {
                                ZBaseNetworkImageBackModel *imageModel = [ZBaseNetworkImageBackModel mj_objectWithKeyValues:dataModel.data];
                                if ([dataModel.code integerValue] == 0 ) {
                                    [images addObject:SafeStr(imageModel.url)];
                                }
                            }
                        }else if([arr[i] isKindOfClass:[NSString class]]){
                            [images addObject:SafeStr(arr[i])];
                        }
                    }

                    [self updateData:images];
                }
            }];
    }
    
//    asyncConcurrentGroupUpload asyncConcurrentConstUpload
}

- (void)setMainView {
    [self.view addSubview:self.collectionView];
    [self.view addSubview:self.bottomView];
    [self.view addSubview:self.progressView];
    self.progressView.hidden = YES;
    
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.equalTo(self.view);
        make.height.mas_equalTo(CGFloatIn750(200));
    }];
    
    [self.progressView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).offset(CGFloatIn750(30));
        make.left.equalTo(self.view.mas_left).offset(CGFloatIn750(30));
        make.right.equalTo(self.view.mas_right).offset(-CGFloatIn750(30));
        make.height.mas_equalTo(CGFloatIn750(0));
    }];
    
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.bottom.equalTo(self.bottomView.mas_top);
        make.top.equalTo(self.view.mas_top).offset(CGFloatIn750(0));
    }];
}


#pragma mark - lazy
- (UICollectionView *)collectionView
{
    if (_collectionView) {
        return _collectionView;
    }
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.minimumLineSpacing = ITEM_SPACE;
    layout.minimumInteritemSpacing = ITEM_SPACE/2;
    layout.sectionInset = UIEdgeInsetsMake(20, SECTION_LEFT_MARGIN, 20, SECTION_LEFT_MARGIN);
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:self.view.frame collectionViewLayout:layout];
    collectionView.backgroundColor = adaptAndDarkColor([UIColor colorWhite], [UIColor colorBlackBGDark]);
    collectionView.alwaysBounceVertical = YES;
    collectionView.dataSource = self;
    collectionView.delegate = self;
    collectionView.scrollEnabled = YES;
    _collectionView = collectionView;
    
    [collectionView registerClass:[FBAttachmentUploadCollectionViewCell class] forCellWithReuseIdentifier:kAttachmentUploadCellIdentifier];
    
    return _collectionView;
}

- (UIView *)bottomView {
    if (!_bottomView) {
        _bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, CGFloatIn750(200))];
    }
    return _bottomView;
}

- (FBCustomUploadProgress *)progressView {
    if (!_progressView) {
        _progressView = [[FBCustomUploadProgress alloc] init];
        [_progressView configProgressBgColor:[UIColor colorWithWhite:0. alpha:.5] progressColor:[UIColor colorMain]];
        _progressView.presentlab.font = [UIFont systemFontOfSize:14];
    }
    return _progressView;
}

#pragma mark - configUI
/**
 重写此方法，拦截导航栏返回按钮的点击相应方法

 @return bool值
 */
- (BOOL)navigationShouldPopOnBackButton {
    return YES;
}

#pragma mark - configData
/**
 配置数据
 */
- (void)configData {
    _uploadArr = [ZFileUploadManager sharedInstance].taskModelList;

    [self.collectionView reloadData];
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.uploadArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    FBAttachmentUploadCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kAttachmentUploadCellIdentifier forIndexPath:indexPath];

    [cell layoutIfNeeded];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(FBAttachmentUploadCollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {

    ZFileUploadDataModel *taskData = self.uploadArr[indexPath.row];
    cell.taskModel = taskData;
}

#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
//    FBAttachmentUploadCollectionViewCell *cell = (FBAttachmentUploadCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
//
//    if (self.isUploading) {
//        NSLog(@"上传中，不要选图片...");
//        return;
//    }
}

#pragma mark - UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat w = (KScreenWidth - SECTION_LEFT_MARGIN*2 - (kPerLineNumber-1)*ITEM_SPACE)/kPerLineNumber;
    return CGSizeMake(w, w);
}

#pragma mark - FBAttachmentUploadCollectionViewCellDelegate
- (void)configCellDelete:(FBAttachmentUploadCollectionViewCell *)cell withOject:(id)object
{

//        if (indexPath.row>0) {
//            [mutArray removeObjectAtIndex:indexPath.row - 1];
//        }
//        self.dataArray = [mutArray copy];
//        [self.collectionView deleteItemsAtIndexPaths:@[indexPath]];
}


#pragma mark - set loading view
-(void)showLoadingAnimation{
    
    //隐藏支付完成动画
    [XLPaymentSuccessHUD hideIn:self.bottomView];
    //显示支付中动画
    [XLPaymentLoadingHUD showIn:self.bottomView];
}

-(void)showSuccessAnimation{
    
    //隐藏支付中成动画
    [XLPaymentLoadingHUD hideIn:self.bottomView];
    //显示支付完成动画
    [XLPaymentSuccessHUD showIn:self.bottomView];
}

- (void)dealloc {
    DLog(@"%@销毁了",[self class]);
}


- (void)configProgress:(CGFloat)progress {
    [self.progressView setPresent:progress];
}


#pragma mark - 上传图片url
- (void)updateData:(NSArray *)imageUrlArr {
    NSMutableDictionary *params = @{}.mutableCopy;
    [params setObject:SafeStr([ZUserHelper sharedHelper].school.schoolID) forKey:@"stores_id"];
    [params setObject:SafeStr(self.type) forKey:@"type"];
    [params setObject:imageUrlArr forKey:@"images"];
    
    __weak typeof(self) weakSelf = self;
    [TLUIUtility showLoading:@"上传图片中..."];
    [ZOriganizationPhotoViewModel addImage:params completeBlock:^(BOOL isSuccess, NSString *message) {
        [TLUIUtility hiddenLoading];
        if (isSuccess) {
            [weakSelf configProgress:1];
            [weakSelf showSuccessAnimation];
            if (weakSelf.uploadCompleteBlock) {
                weakSelf.uploadCompleteBlock();
            }
            [TLUIUtility showSuccessHint:message];
            return ;
        }else {
            [TLUIUtility showErrorHint:message];
        }
    }];
}
@end
