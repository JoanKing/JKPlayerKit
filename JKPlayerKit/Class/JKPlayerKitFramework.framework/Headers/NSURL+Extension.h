//
//  NSURL+Extension.h
//  JKPlayerKit
//
//  Created by 王冲 on 2019/2/11.
//  Copyright © 2019年 JK科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSURL (Extension)


/**
 更换协议

 @return 返回一个  sreaming 协议的视频链接
 */
-(NSURL *)stremingURL;

/**
 http 协议
 
 @return 返回一个  http 协议的视频链接
 */
-(NSURL *)httpURL;


@end

NS_ASSUME_NONNULL_END
