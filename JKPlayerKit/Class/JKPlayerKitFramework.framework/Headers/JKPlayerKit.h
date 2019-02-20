//
//  JKPlayerKit.h
//  JKPlayerKit
//
//  Created by 王冲 on 2019/2/9.
//  Copyright © 2019年 JK科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
NS_ASSUME_NONNULL_BEGIN

#define JKPlayerPlayStateChangeNotification @"PlayStateChangeNotification"

/**
 播放器的状态
 因为UI界面需要加载状态显示, 所以需要提供加载状态
 */
typedef NS_ENUM(NSInteger, JKPlayerState) {
    // 未知(比如都没有开始播放音视频资源)
    JKPlayerStateUnknown  = 0,
    // 正在加载
    JKPlayerStateLoading  = 1,
    // 正在播放
    JKPlayerStatePlaying  = 2,
    // 停止
    JKPlayerStateStopped  = 3,
    // 暂停
    JKPlayerStatePause    = 4,
    // 失败(比如没有网络缓存失败, 地址找不到)
    JKPlayerStateFailed   = 5
};

@interface JKPlayerKit : NSObject

+(instancetype)shareDownloaderManger;
    
/**
  播放器
 */
@property(nonatomic,strong,nullable) AVPlayer *player;

#pragma mark 播放视频
/**
 播放视频

 @param url 视频的 url
 @param isCache 是否缓存：YES：缓存，NO：不缓存
 */
-(void)playerWithUrl:(NSURL *)url isCache:(BOOL)isCache;

/**
 暂停播放
 */
-(void)pause;

/**
 继续播放
 */
-(void)resume;

/**
 停止播放
 */
-(void)stop;

/**
 快进

 @param timeDiffer 快进的时间
 */
-(void)seekWithTimeDiffer:(NSTimeInterval)timeDiffer;

/**
 指定播放进度

 @param progress 进度值
 */
-(void)seekWithTimeProgress:(float)progress;

/**
 播放的倍速

 @param rate 倍速值：1.0、2.0、3.0
 */
// -(void)setRate:(float)rate;

/**
 是否静音

 @param muted YES：静音 NO：不静音
 */
// -(void)setMuted:(BOOL)muted;

/**
 音量调整

 @param volume 音量的大小
 */
// -(void)setVolume:(float)volume;

#pragma mark api 数据提供 (通过属性外界获取的值是 拉模式，通过block,代理，通知是 推模式)

/**
 是否静音 YES：静音 NO：不静音
 */
@property(nonatomic,assign) BOOL muted;


/**
 音量调整
 */
@property(nonatomic,assign) float volume;

/**
 倍速值：1.0、2.0、3.0
 */
@property(nonatomic,assign) float rate;


/**
 总时长
 */
@property(nonatomic,assign,readonly) NSTimeInterval totalTime;
@property(nonatomic,strong,readonly) NSString *totalTimeFormat;

/**
 当前播放的时长
 */
@property(nonatomic,assign,readonly) NSTimeInterval currentTime;
// 格式化后的时间 00:00
@property(nonatomic,strong,readonly) NSString *currentTimeFormat;

/**
 当前播放的url地址
 */
@property(nonatomic,strong,readonly) NSURL *url;

/**
 当前播放的进度
 */
@property(nonatomic,assign,readonly) float progress;

/**
 当前已经缓冲的进度
 */
@property(nonatomic,assign,readonly) float loadDataProgress;

/**
 播放的状态
 */
@property(nonatomic,assign,readonly) JKPlayerState state;

/**
 播放界面（layer）
 */
@property (strong, nonatomic)AVPlayerLayer *playerLayer;


@end

NS_ASSUME_NONNULL_END
