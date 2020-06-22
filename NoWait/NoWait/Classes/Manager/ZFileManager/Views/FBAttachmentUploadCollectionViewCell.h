//
//  FBAttachmentUploadCollectionViewCell.h
//  FengbangB
//
//  Created by fengbang on 2018/6/28.
//  Copyright © 2018年 com.fengbangstore. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FBUploadTool.h"
#import "ZFileUploadTask.h"

@class FBAttachmentUploadCollectionViewCell;

@protocol FBAttachmentUploadCollectionViewCellDelegate <NSObject>
- (void)configCellDelete:(FBAttachmentUploadCollectionViewCell *)cell withOject:(id)object;
@end

@interface FBAttachmentUploadCollectionViewCell : UICollectionViewCell

@property (nonatomic, weak) id<FBAttachmentUploadCollectionViewCellDelegate> delegate;

@property (nonatomic,strong) ZFileUploadTask *task;

@property (nonatomic,strong) ZFileUploadDataModel *taskModel;
/**
 配置第一个“+”号按钮
 */
- (void)configCellAdd;

/**
 根据进度显示进度条

 @param progress 进度 范围为：0~1
 */
- (void)configCellProgress:(CGFloat)progress;

/**
 是否显示进度条

 @param show bool值
 */
- (void)showProgress:(BOOL)show;

/**
 是否显示删除按钮

 @param show bool值
 */
- (void)showCleanIcon:(BOOL)show;

@end
