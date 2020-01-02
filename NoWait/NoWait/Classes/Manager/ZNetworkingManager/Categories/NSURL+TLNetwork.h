//
//  NSURL+TLNetwork.h
//  TLChat
//
//  Created by ZZZ on 2017/7/13.
//  Copyright © 2017年 ZZZ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSURL (TLNetwork)

@property (nonatomic, assign, readonly) BOOL isHttpURL;

@property (nonatomic, assign, readonly) BOOL isHttpsURL;



@end
