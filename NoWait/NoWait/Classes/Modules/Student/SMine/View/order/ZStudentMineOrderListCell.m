//
//  ZStudentMineOrderListCell.m
//  NoWait
//
//  Created by zhuang zhang on 2020/1/15.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZStudentMineOrderListCell.h"
#import "ZAlertView.h"

@interface ZStudentMineOrderListCell ()
@end

@implementation ZStudentMineOrderListCell


#pragma mark - set model
-(void)setModel:(ZOrderListModel *)model {
    [super setModel:model];
    if (model.isStudent) {
        self.clubImageView.hidden = NO;
        self.clubLabel.text = model.stores_name;
        self.userImgeView.hidden = YES;
        [self.clubLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contView.mas_left).offset(CGFloatIn750(30));
            make.centerY.equalTo(self.topView.mas_centerY);
        }];
    }else{
        self.clubImageView.hidden = YES;
        self.userImgeView.hidden = NO;
        [self.userImgeView tt_setImageWithURL:[NSURL URLWithString:imageFullUrl(model.account_image)] placeholderImage:[UIImage imageNamed:@"default_head"]];
        self.clubLabel.text = model.students_name;
        [self.clubLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.userImgeView.mas_right).offset(CGFloatIn750(20));
            make.centerY.equalTo(self.topView.mas_centerY);
        }];
    }
    [self.leftImageView tt_setImageWithURL:[NSURL URLWithString:imageFullUrl(model.courses_image_url)] placeholderImage:[UIImage imageNamed:@"default_image32"]];
    
    self.orderNameLabel.text = model.courses_name;
    self.priceLabel.text = [NSString stringWithFormat:@"¥%@",model.pay_amount];
    
    if ([model.type intValue] == 1) {
        self.detailLabel.text = [NSString stringWithFormat:@"教师：%@",model.teacher_name];
    }else{
        self.detailLabel.text = [NSString stringWithFormat:@"体验时长：%@",model.experience_duration];
    }
    
    self.failLabel.text = SafeStr(model.refund_amount);
    self.statelabel.text = model.statusStr;
    
    self.bottomView.hidden = YES;
    self.failView.hidden = YES;
    
    self.payBtn.hidden = YES;
    self.cancleBtn.hidden = YES;
    self.evaBtn.hidden = YES;
    self.delBtn.hidden = YES;
    self.receivedBtn.hidden = YES;
    self.refundSureBtn.hidden = YES;

    self.refundRefectBtn.hidden = YES;
    self.refundCancle.hidden = YES;
    self.refundOSureBtn.hidden = YES;
    self.refundORefectBtn.hidden = YES;
    self.refundPayBtn.hidden = YES;
    
    switch (model.order_type) {
        case ZStudentOrderTypeOrderForPay:
        case ZStudentOrderTypeForPay: //待付款（去支付，取消）
        {
            self.statelabel.textColor = adaptAndDarkColor([UIColor colorTextBlack],[UIColor colorTextBlackDark]);
            
            [self.bottomView mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.left.bottom.right.equalTo(self.contView);
                make.height.mas_equalTo(CGFloatIn750(136));
            }];
            
            [self.midView mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.left.right.equalTo(self.contView);
                make.top.equalTo(self.topView.mas_bottom);
                make.bottom.equalTo(self.bottomView.mas_top);
            }];
            
            self.bottomView.hidden = NO;
            self.payBtn.hidden = NO;
            self.cancleBtn.hidden = NO;
            
            [self.payBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(self.bottomView.mas_centerY);
                make.right.equalTo(self.bottomView.mas_right).offset(CGFloatIn750(-30));
                make.height.mas_equalTo(CGFloatIn750(56));
                make.width.mas_equalTo(CGFloatIn750(142));
            }];
            
            [self.cancleBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(self.bottomView.mas_centerY);
                make.right.equalTo(self.payBtn.mas_left).offset(CGFloatIn750(-20));
                make.height.mas_equalTo(CGFloatIn750(56));
                make.width.mas_equalTo(CGFloatIn750(172));
            }];
        }
            break;
        case ZStudentOrderTypeHadPay:
        {
            self.statelabel.textColor = adaptAndDarkColor([UIColor colorTextBlack],[UIColor colorTextBlackDark]);
            
            [self.bottomView mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.left.bottom.right.equalTo(self.contView);
                make.height.mas_equalTo(CGFloatIn750(136));
            }];
            
            [self.midView mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.left.right.equalTo(self.contView);
                make.top.equalTo(self.topView.mas_bottom);
                make.bottom.equalTo(self.bottomView.mas_top);
            }];
            
            self.bottomView.hidden = NO;
            self.evaBtn.hidden = NO;
            
            [self.evaBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(self.bottomView.mas_centerY);
                make.right.equalTo(self.bottomView.mas_right).offset(CGFloatIn750(-30));
                make.height.mas_equalTo(CGFloatIn750(56));
                make.width.mas_equalTo(CGFloatIn750(116));
            }];
        }
            break;
        case ZStudentOrderTypeOrderOutTime:
        case ZStudentOrderTypeOutTime:
        case ZOrganizationOrderTypeCancel:
        case ZStudentOrderTypeCancel:
        case ZOrganizationOrderTypeOrderOutTime:
        case ZOrganizationOrderTypeOutTime:
        {
            self.statelabel.textColor = adaptAndDarkColor([UIColor colorTextGray1],[UIColor colorTextGray1Dark]);

            [self.bottomView mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.left.bottom.right.equalTo(self.contView);
                make.height.mas_equalTo(CGFloatIn750(136));
            }];

            [self.midView mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.left.right.equalTo(self.contView);
                make.top.equalTo(self.topView.mas_bottom);
                make.bottom.equalTo(self.bottomView.mas_top);
            }];

            self.bottomView.hidden = NO;
            self.delBtn.hidden = NO;

            [self.delBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(self.bottomView.mas_centerY);
                make.right.equalTo(self.bottomView.mas_right).offset(CGFloatIn750(-30));
                make.height.mas_equalTo(CGFloatIn750(56));
                make.width.mas_equalTo(CGFloatIn750(172));
            }];

        }
            break;
        case ZOrganizationOrderTypeOrderForReceived:
        {
            self.statelabel.textColor = adaptAndDarkColor([UIColor colorTextBlack],[UIColor colorTextBlackDark]);
            
            [self.bottomView mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.left.bottom.right.equalTo(self.contView);
                make.height.mas_equalTo(CGFloatIn750(136));
            }];
            
            [self.midView mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.left.right.equalTo(self.contView);
                make.top.equalTo(self.topView.mas_bottom);
                make.bottom.equalTo(self.bottomView.mas_top);
            }];
            
            self.bottomView.hidden = NO;
            self.receivedBtn.hidden = NO;
            
            
            [self.receivedBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(self.bottomView.mas_centerY);
                make.right.equalTo(self.bottomView.mas_right).offset(CGFloatIn750(-30));
                make.height.mas_equalTo(CGFloatIn750(56));
                make.width.mas_equalTo(CGFloatIn750(172));
            }];
        }
            break;
        case ZStudentOrderTypeForRefund:
        case ZStudentOrderTypeRefundReceive:
        case ZStudentOrderTypeRefunding:
        case ZStudentOrderTypeForRefundComplete:
        case ZOrganizationOrderTypeForRefund:
        case ZOrganizationOrderTypeRefundReceive:
        case ZOrganizationOrderTypeRefunding:
        case ZOrganizationOrderTypeForRefundComplete:
        case ZStudentOrderTypeRefundCancle:
        case ZOrganizationOrderTypeRefundCancle:
        {
            if (model.isRefund) {
                self.statelabel.textColor = adaptAndDarkColor([UIColor colorRedDefault],[UIColor colorRedDefault]);
                [self.bottomView mas_remakeConstraints:^(MASConstraintMaker *make) {
                    make.left.right.equalTo(self.contView);
                    make.bottom.equalTo(self.contView.mas_bottom);
                    make.height.mas_equalTo(CGFloatIn750(136));
                }];
                
                NSString *fail = self.model.refund_amount? self.model.refund_amount : @"";
                CGSize failSize = [fail tt_sizeWithFont:[UIFont fontSmall] constrainedToSize:CGSizeMake((KScreenWidth - CGFloatIn750(30) * 2 - CGFloatIn750(30) - CGFloatIn750(16) - CGFloatIn750(240) - CGFloatIn750(30)), MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping lineSpace:CGFloatIn750(10)];
    
                [self.failView mas_remakeConstraints:^(MASConstraintMaker *make) {
                    make.left.right.equalTo(self.contView);
                    make.bottom.equalTo(self.bottomView.mas_top);
                    make.height.mas_equalTo(CGFloatIn750(36) + failSize.height + 4);
                }];
    
                [self.failHintLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
                    make.right.equalTo(self.leftImageView);
                    make.top.equalTo(self.failView.mas_top).offset(CGFloatIn750(34));
                }];
    
    
                [self.failLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
                    make.left.equalTo(self.failHintLabel.mas_right).offset(CGFloatIn750(16));
                    make.top.equalTo(self.failHintLabel.mas_top);
                    make.right.equalTo(self.failView.mas_right).offset(-CGFloatIn750(30));
                }];
    
                [self.midView mas_remakeConstraints:^(MASConstraintMaker *make) {
                    make.left.right.equalTo(self.contView);
                    make.top.equalTo(self.topView.mas_bottom);
                    make.bottom.equalTo(self.failView.mas_top);
                }];
    
                [ZPublicTool setLineSpacing:CGFloatIn750(10) label:self.failLabel];
                
                self.failView.hidden = NO;
                
                if (model.order_type == ZStudentOrderTypeForRefund) {
// 1：学员申请 2：商家拒绝 3：学员拒绝 4：学员同意 5：商家同意 6:学员取消 7：商家支付成功
                    if ([model.refund_status intValue] == 1 || [model.refund_status intValue] == 3 || [model.refund_status intValue] == 4) {
                        self.bottomView.hidden = NO;
                        self.refundCancle.hidden = NO;
                        [self.refundCancle mas_remakeConstraints:^(MASConstraintMaker *make) {
                            make.centerY.equalTo(self.bottomView.mas_centerY);
                            make.right.equalTo(self.bottomView.mas_right).offset(CGFloatIn750(-30));
                            make.height.mas_equalTo(CGFloatIn750(56));
                            make.width.mas_equalTo(CGFloatIn750(182));
                        }];
                    }else if ([model.refund_status intValue] == 2){
                        self.bottomView.hidden = NO;
                        self.refundSureBtn.hidden = NO;
                        self.refundRefectBtn.hidden = NO;
                        self.refundCancle.hidden = NO;
                        
                        [self.refundSureBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
                            make.centerY.equalTo(self.bottomView.mas_centerY);
                            make.right.equalTo(self.bottomView.mas_right).offset(CGFloatIn750(-30));
                            make.height.mas_equalTo(CGFloatIn750(56));
                            make.width.mas_equalTo(CGFloatIn750(172));
                        }];
                        
                        [self.refundRefectBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
                            make.centerY.equalTo(self.bottomView.mas_centerY);
                            make.right.equalTo(self.refundSureBtn.mas_left).offset(CGFloatIn750(-20));
                            make.height.mas_equalTo(CGFloatIn750(56));
                            make.width.mas_equalTo(CGFloatIn750(172));
                        }];
                        
                        [self.refundCancle mas_remakeConstraints:^(MASConstraintMaker *make) {
                            make.centerY.equalTo(self.bottomView.mas_centerY);
                            make.right.equalTo(self.refundRefectBtn.mas_left).offset(CGFloatIn750(-20));
                            make.height.mas_equalTo(CGFloatIn750(56));
                            make.width.mas_equalTo(CGFloatIn750(172));
                        }];
                    }else if ([model.refund_status intValue] == 5
                              || [model.refund_status intValue] == 6
                              || [model.refund_status intValue] == 7){
                        [self.failView mas_remakeConstraints:^(MASConstraintMaker *make) {
                            make.left.right.equalTo(self.contView);
                            make.height.mas_equalTo(CGFloatIn750(36) + failSize.height + 4); make.bottom.equalTo(self.contView.mas_bottom).offset(-CGFloatIn750(40));
                        }];
                    }else{
                        [self.failView mas_remakeConstraints:^(MASConstraintMaker *make) {
                            make.left.right.equalTo(self.contView);
                            make.height.mas_equalTo(CGFloatIn750(36) + failSize.height + 4); make.bottom.equalTo(self.contView.mas_bottom).offset(-CGFloatIn750(40));
                        }];
                    }
                }else if (model.order_type == ZStudentOrderTypeRefundReceive
                          || model.order_type == ZStudentOrderTypeRefunding
                          || model.order_type == ZStudentOrderTypeForRefundComplete
                          || model.order_type == ZStudentOrderTypeRefundCancle){
                    [self.failView mas_remakeConstraints:^(MASConstraintMaker *make) {
                        make.left.right.equalTo(self.contView);
                        make.height.mas_equalTo(CGFloatIn750(36) + failSize.height + 4); make.bottom.equalTo(self.contView.mas_bottom).offset(-CGFloatIn750(40));
                    }];
                }else if (model.order_type == ZOrganizationOrderTypeForRefund){
// 1：学员申请 2：商家拒绝 3：学员拒绝 4：学员同意 5：商家同意 6:学员取消 7：商家支付成功
                    if ([model.refund_status intValue] == 1 || [model.refund_status intValue] == 3 ) {
                        self.bottomView.hidden = NO;
                        self.refundSureBtn.hidden = NO;
                        self.refundRefectBtn.hidden = NO;
                        
                        [self.refundSureBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
                            make.centerY.equalTo(self.bottomView.mas_centerY);
                            make.right.equalTo(self.bottomView.mas_right).offset(CGFloatIn750(-30));
                            make.height.mas_equalTo(CGFloatIn750(56));
                            make.width.mas_equalTo(CGFloatIn750(172));
                        }];
                        
                        [self.refundRefectBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
                            make.centerY.equalTo(self.bottomView.mas_centerY);
                            make.right.equalTo(self.refundSureBtn.mas_left).offset(CGFloatIn750(-20));
                            make.height.mas_equalTo(CGFloatIn750(56));
                            make.width.mas_equalTo(CGFloatIn750(172));
                        }];
                    }else if ([model.refund_status intValue] == 4 || [model.refund_status intValue] == 5){
                        self.bottomView.hidden = NO;
                        self.refundPayBtn.hidden = NO;
                        
                        [self.refundPayBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
                            make.centerY.equalTo(self.bottomView.mas_centerY);
                            make.right.equalTo(self.bottomView.mas_right).offset(CGFloatIn750(-30));
                            make.height.mas_equalTo(CGFloatIn750(56));
                            make.width.mas_equalTo(CGFloatIn750(172));
                        }];
                    }else if ([model.refund_status intValue] == 2){
                        [self.failView mas_remakeConstraints:^(MASConstraintMaker *make) {
                            make.left.right.equalTo(self.contView);
                            make.height.mas_equalTo(CGFloatIn750(36) + failSize.height + 4); make.bottom.equalTo(self.contView.mas_bottom).offset(-CGFloatIn750(40));
                        }];
                    }else if ([model.refund_status intValue] == 6 ||[model.refund_status intValue] == 7){
                        [self.failView mas_remakeConstraints:^(MASConstraintMaker *make) {
                            make.left.right.equalTo(self.contView);
                            make.height.mas_equalTo(CGFloatIn750(36) + failSize.height + 4); make.bottom.equalTo(self.contView.mas_bottom).offset(-CGFloatIn750(40));
                        }];
                    }else{
                        [self.failView mas_remakeConstraints:^(MASConstraintMaker *make) {
                            make.left.right.equalTo(self.contView);
                            make.height.mas_equalTo(CGFloatIn750(36) + failSize.height + 4); make.bottom.equalTo(self.contView.mas_bottom).offset(-CGFloatIn750(40));
                        }];
                    }
                }else if (model.order_type == ZOrganizationOrderTypeRefundReceive){
                    [self.failView mas_remakeConstraints:^(MASConstraintMaker *make) {
                        make.left.right.equalTo(self.contView);
                        make.height.mas_equalTo(CGFloatIn750(36) + failSize.height + 4); make.bottom.equalTo(self.contView.mas_bottom).offset(-CGFloatIn750(40));
                    }];
                }else if (model.order_type == ZOrganizationOrderTypeRefunding
                          ||model.order_type == ZOrganizationOrderTypeForRefundComplete
                          ||model.order_type == ZOrganizationOrderTypeRefundCancle){
                    [self.failView mas_remakeConstraints:^(MASConstraintMaker *make) {
                        make.left.right.equalTo(self.contView);
                        make.height.mas_equalTo(CGFloatIn750(36) + failSize.height + 4); make.bottom.equalTo(self.contView.mas_bottom).offset(-CGFloatIn750(40));
                    }];
                }
             
            }else{
                self.statelabel.textColor = adaptAndDarkColor([UIColor colorTextBlack],[UIColor colorTextBlackDark]);
                
                [self.midView mas_remakeConstraints:^(MASConstraintMaker *make) {
                 make.left.right.equalTo(self.contView);
                 make.top.equalTo(self.topView.mas_bottom);
                 make.bottom.equalTo(self.contView.mas_bottom).offset(-CGFloatIn750(40));
                }];
            }
        }
            break;
        default:
            {
                self.statelabel.textColor = adaptAndDarkColor([UIColor colorTextBlack],[UIColor colorTextBlackDark]);
                
                [self.midView mas_remakeConstraints:^(MASConstraintMaker *make) {
                 make.left.right.equalTo(self.contView);
                 make.top.equalTo(self.topView.mas_bottom);
                 make.bottom.equalTo(self.contView.mas_bottom).offset(-CGFloatIn750(40));
                }];
            }
        break;
    }
}

+ (CGFloat)z_getCellHeight:(id)sender {
    if (sender && [sender isKindOfClass:[ZOrderListModel class]]) {
        ZOrderListModel *listModel = (ZOrderListModel *)sender;
        if (listModel.isRefund) {
            NSString *fail = listModel.refund_amount ? listModel.refund_amount : @"";
            CGSize failSize = [fail tt_sizeWithFont:[UIFont fontSmall] constrainedToSize:CGSizeMake((KScreenWidth - CGFloatIn750(30) * 2 - CGFloatIn750(30) - CGFloatIn750(16) - CGFloatIn750(240) - CGFloatIn750(30)), MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping lineSpace:CGFloatIn750(10)];
            
            if (listModel.order_type == ZStudentOrderTypeForRefund
            ) {
                if ([listModel.refund_status intValue] == 2 || [listModel.refund_status intValue] == 1 || [listModel.refund_status intValue] == 3 || [listModel.refund_status intValue] == 4) {
                    return CGFloatIn750(414) + failSize.height + CGFloatIn750(40);
                }else{
                    return CGFloatIn750(318) + failSize.height + CGFloatIn750(40);
                }
            }else if(listModel.order_type == ZStudentOrderTypeRefundReceive
                     ||  listModel.order_type == ZStudentOrderTypeRefunding
                     ||  listModel.order_type == ZStudentOrderTypeForRefundComplete
                     ||  listModel.order_type == ZStudentOrderTypeRefundCancle){
                
                return CGFloatIn750(318) + failSize.height + CGFloatIn750(40);
                
            }else if (listModel.order_type == ZOrganizationOrderTypeForRefund
                      ||  listModel.order_type == ZOrganizationOrderTypeRefundReceive
            ) {
                if ([listModel.refund_status intValue] == 1 || [listModel.refund_status intValue] == 3 || [listModel.refund_status intValue] == 4|| [listModel.refund_status intValue] == 5) {
                    return CGFloatIn750(414) + failSize.height + CGFloatIn750(40);
                }else{
                    return CGFloatIn750(318) + failSize.height + CGFloatIn750(40);
                }
            }else if(listModel.order_type == ZOrganizationOrderTypeRefunding
                     ||  listModel.order_type == ZOrganizationOrderTypeForRefundComplete
                     || listModel.order_type == ZOrganizationOrderTypeCancel){
                return CGFloatIn750(318) + failSize.height + CGFloatIn750(40);
            } else{
                return CGFloatIn750(318) + failSize.height + CGFloatIn750(40);
            }
        }else if (listModel.order_type == ZStudentOrderTypeForPay
            || listModel.order_type == ZStudentOrderTypeHadPay
            || listModel.order_type == ZStudentOrderTypeOutTime
            || listModel.order_type == ZStudentOrderTypeCancel
            || listModel.order_type == ZStudentOrderTypeOrderForPay
            || listModel.order_type == ZStudentOrderTypeOrderOutTime
            
            || listModel.order_type == ZOrganizationOrderTypeOutTime
            || listModel.order_type == ZOrganizationOrderTypeCancel
            || listModel.order_type == ZOrganizationOrderTypeOrderOutTime
            || listModel.order_type == ZOrganizationOrderTypeOrderForReceived){
            return CGFloatIn750(414);
        } else{
            return CGFloatIn750(318);
        }
    }
    return CGFloatIn750(0);
}

@end
