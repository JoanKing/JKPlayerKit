//
//  ViewController.m
//  JKPlayerKit
//
//  Created by 王冲 on 2019/2/9.
//  Copyright © 2019年 JK科技有限公司. All rights reserved.
//

#import "ViewController.h"
#import <JKPlayerKitFramework/JKPlayerKitFramework.h>
#import <AVFoundation/AVFoundation.h>
@interface ViewController ()
{
    // 播放时间
    UILabel *timeLabel1;
    // 总时间
    UILabel *timeLabel2;
    // 播放的进度
    UISlider *progressSlider;
    // 声音的大小
    UISlider *volumeSlider;
    // 加载进度
    UIProgressView *progressView;
    // 静音
    UIButton *buttton4;
    
    // 播放
    UIButton *buttton1;
    
    
    
}
@property(nonatomic,strong) JKPlayerKit *playerKit;

@property(nonatomic,weak) NSTimer *timer;

@end

@implementation ViewController

-(NSTimer *)timer{
    
    if (!_timer) {
        
        NSTimer *timer = [NSTimer timerWithTimeInterval:1.0 target:self selector:@selector(update) userInfo:nil repeats:YES];
        [[NSRunLoop currentRunLoop]addTimer:timer forMode:NSRunLoopCommonModes];
        _timer = timer;
    }
    return _timer;
}

-(void)update{
    
    // 播放的时间
    timeLabel1.text = [JKPlayerKit shareDownloaderManger].currentTimeFormat;
    // 总时间
    timeLabel2.text = [JKPlayerKit shareDownloaderManger].totalTimeFormat;
    // 播放的进度
    progressSlider.value = [JKPlayerKit shareDownloaderManger].progress;
    // 声音的大小
    volumeSlider.value = [JKPlayerKit shareDownloaderManger].volume;
    // 加载进度
    progressView.progress = [JKPlayerKit shareDownloaderManger].loadDataProgress;
    // 静音
    buttton4.selected = [JKPlayerKit shareDownloaderManger].muted;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self timer];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    buttton1 = [[UIButton alloc]initWithFrame:CGRectMake(20, JK_SCREEN_HEIGHT-80, 60, 40)];
    [buttton1 setTitle:@"播放" forState:UIControlStateNormal];
    [buttton1 setTitle:@"暂停" forState:UIControlStateSelected];
    [buttton1 setTitleColor:[UIColor brownColor] forState:UIControlStateNormal];
    
    [buttton1 setBackgroundColor:[UIColor yellowColor]];
    [buttton1 addTarget:self action:@selector(playClick) forControlEvents:UIControlEventTouchUpInside];
    buttton1.titleLabel.font = [UIFont systemFontOfSize:18.f];
    [self.view addSubview:buttton1];
    
    UIButton *buttton2 = [[UIButton alloc]initWithFrame:CGRectMake(CGRectGetMaxX(buttton1.frame)+20, JK_SCREEN_HEIGHT-80, 60, 40)];
    [buttton2 setTitle:@"暂停" forState:UIControlStateNormal];
    [buttton2 setTitleColor:[UIColor brownColor] forState:UIControlStateNormal];
    [buttton2 setBackgroundColor:[UIColor yellowColor]];
    [buttton2 addTarget:self action:@selector(pauseClick) forControlEvents:UIControlEventTouchUpInside];
    buttton2.titleLabel.font = [UIFont systemFontOfSize:18.f];
    [self.view addSubview:buttton2];
    
    UIButton *buttton3 = [[UIButton alloc]initWithFrame:CGRectMake(CGRectGetMaxX(buttton2.frame)+20, JK_SCREEN_HEIGHT-80, 60, 40)];
    [buttton3 setTitle:@"继续" forState:UIControlStateNormal];
    [buttton3 setTitleColor:[UIColor brownColor] forState:UIControlStateNormal];
    [buttton3 setBackgroundColor:[UIColor yellowColor]];
    [buttton3 addTarget:self action:@selector(resumeClick) forControlEvents:UIControlEventTouchUpInside];
    buttton3.titleLabel.font = [UIFont systemFontOfSize:18.f];
    [self.view addSubview:buttton3];
    
    buttton4 = [[UIButton alloc]initWithFrame:CGRectMake(CGRectGetMaxX(buttton3.frame)+20, JK_SCREEN_HEIGHT-80, 60, 40)];
    [buttton4 setTitle:@"静音" forState:UIControlStateNormal];
    [buttton4 setTitleColor:[UIColor brownColor] forState:UIControlStateNormal];
    [buttton4 setBackgroundColor:[UIColor yellowColor]];
    [buttton4 addTarget:self action:@selector(muteClick:) forControlEvents:UIControlEventTouchUpInside];
    buttton4.titleLabel.font = [UIFont systemFontOfSize:18.f];
    [self.view addSubview:buttton4];
    
    UIButton *buttton5 = [[UIButton alloc]initWithFrame:CGRectMake(CGRectGetMaxX(buttton4.frame)+20, JK_SCREEN_HEIGHT-80, 60, 40)];
    [buttton5 setTitle:@"快进" forState:UIControlStateNormal];
    [buttton5 setTitleColor:[UIColor brownColor] forState:UIControlStateNormal];
    [buttton5 setBackgroundColor:[UIColor yellowColor]];
    [buttton5 addTarget:self action:@selector(seekTimeDifferClick) forControlEvents:UIControlEventTouchUpInside];
    buttton5.titleLabel.font = [UIFont systemFontOfSize:18.f];
    [self.view addSubview:buttton5];
    
    // 音量设置
    UILabel *volumeLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, CGRectGetMinY(buttton1.frame)-80, 50, 50)];
    volumeLabel.text = @"音量";
    volumeLabel.textAlignment = NSTextAlignmentCenter;
    volumeLabel.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:volumeLabel];
    
    volumeSlider = [[UISlider alloc]initWithFrame:CGRectMake(CGRectGetMaxX(volumeLabel.frame)+20, CGRectGetMinY(buttton1.frame)-80, JK_SCREEN_WIDTH-160, 50)];
    [volumeSlider addTarget:self action:@selector(volumeSliderValueChanged:) forControlEvents:UIControlEventValueChanged];
    volumeSlider.backgroundColor = [UIColor brownColor];
    // 1.minimumValue  : 当值可以改变时，滑块可以滑动到最小位置的值，默认为0.0
    volumeSlider.minimumValue = 0.0;
    // 2.maximumValue : 当值可以改变时，滑块可以滑动到最大位置的值，默认为1.0
    volumeSlider.maximumValue = 1.0;
    // 3.当前值
    volumeSlider.value = 0;
    // 4.continuous : 如果设置YES，在拖动滑块的任何时候，滑块的值都会改变。默认设置为YES
    // [slider setContinuous:YES];
    
    // 5.滑块条最小值处设置的图片，默认为nil
    // slider.minimumValueImage = [UIImage imageNamed:@"001.jpeg"];
    
    // 6.滑块条最大值处设置的图片，默认为nil
    // slider.maximumValueImage = [UIImage imageNamed:@"001.jpeg"];
    
    // 7.minimumTrackTintColor : 小于滑块当前值滑块条的颜色，默认为蓝色
    volumeSlider.minimumTrackTintColor = [UIColor redColor];
    
    // 8.maximumTrackTintColor: 大于滑块当前值滑块条的颜色，默认为白色
    volumeSlider.maximumTrackTintColor = [UIColor blueColor];
    
    // 9.thumbTintColor : 当前滑块的颜色，默认为白色
    volumeSlider.thumbTintColor = [UIColor yellowColor];
    
    // 10.currentMaximumTrackImage : 滑块条最大值处设置的图片
    // 11.currentMinimumTrackImage : 滑块条最小值处设置的图片
    // 12.currentThumbImage: 当前滑块的图片
    
    [self.view addSubview:volumeSlider];
    
    
    // 播放进度的滑块
    
    UILabel *progressLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, CGRectGetMinY(volumeSlider.frame)-80, 50, 50)];
    progressLabel.text = @"进度";
    progressLabel.textAlignment = NSTextAlignmentCenter;
    progressLabel.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:progressLabel];
    
    progressSlider = [[UISlider alloc]initWithFrame:CGRectMake(CGRectGetMaxX(progressLabel.frame)+20, CGRectGetMinY(volumeSlider.frame)-80, JK_SCREEN_WIDTH-160, 50)];
    [progressSlider addTarget:self action:@selector(progressSliderSliderValueChanged:) forControlEvents:UIControlEventValueChanged];
    progressSlider.backgroundColor = [UIColor brownColor];
    // 1.minimumValue  : 当值可以改变时，滑块可以滑动到最小位置的值，默认为0.0
    progressSlider.minimumValue = 0.0;
    // 2.maximumValue : 当值可以改变时，滑块可以滑动到最大位置的值，默认为1.0
    progressSlider.maximumValue = 1.0;
    // 3.当前值
    progressSlider.value = 0;
    
    // 7.minimumTrackTintColor : 小于滑块当前值滑块条的颜色，默认为蓝色
    progressSlider.minimumTrackTintColor = [UIColor purpleColor];
    
    // 8.maximumTrackTintColor: 大于滑块当前值滑块条的颜色，默认为白色
    progressSlider.maximumTrackTintColor = [UIColor blueColor];
    
    // 9.thumbTintColor : 当前滑块的颜色，默认为白色
    progressSlider.thumbTintColor = [UIColor yellowColor];
    
    // 10.currentMaximumTrackImage : 滑块条最大值处设置的图片
    // 11.currentMinimumTrackImage : 滑块条最小值处设置的图片
    // 12.currentThumbImage: 当前滑块的图片
    
    [self.view addSubview:progressSlider];
    
    // 加载进度
    // 使用博客 https://www.jianshu.com/p/98aa4a28553c
    progressView = [[UIProgressView alloc]initWithFrame:CGRectMake(40, 200, JK_SCREEN_WIDTH-80, 40)];
    // 高度的调整
    progressView.transform = CGAffineTransformMakeScale(1.0f, 5.0f);
    progressView.backgroundColor = [UIColor brownColor];
    // 设置进度条的颜色
    progressView.progressTintColor = [UIColor blueColor];
    
    //设置进度条的当前值，范围：0~1；
    progressView.progress = 0;
    
    /*
     typedef NS_ENUM(NSInteger, UIProgressViewStyle) {
     UIProgressViewStyleDefault,     // normal progress bar
     UIProgressViewStyleBar __TVOS_PROHIBITED,     // for use in a toolbar
     };
     */
    progressView.progressViewStyle = UIProgressViewStyleDefault;
    
    [self.view addSubview:progressView];
    
    UIButton *buttton6 = [[UIButton alloc]initWithFrame:CGRectMake(20, CGRectGetMinY(progressSlider.frame)-80, 60, 40)];
    [buttton6 setTitle:@"1.0x" forState:UIControlStateNormal];
    [buttton6 setTitleColor:[UIColor brownColor] forState:UIControlStateNormal];
    [buttton6 setBackgroundColor:[UIColor yellowColor]];
    [buttton6 addTarget:self action:@selector(rateClick1) forControlEvents:UIControlEventTouchUpInside];
    buttton6.titleLabel.font = [UIFont systemFontOfSize:18.f];
    [self.view addSubview:buttton6];
    
    UIButton *buttton62 = [[UIButton alloc]initWithFrame:CGRectMake(20, CGRectGetMinY(buttton6.frame)-80, 60, 40)];
    [buttton62 setTitle:@"1.5x" forState:UIControlStateNormal];
    [buttton62 setTitleColor:[UIColor brownColor] forState:UIControlStateNormal];
    [buttton62 setBackgroundColor:[UIColor yellowColor]];
    [buttton62 addTarget:self action:@selector(rateClick2) forControlEvents:UIControlEventTouchUpInside];
    buttton62.titleLabel.font = [UIFont systemFontOfSize:18.f];
    [self.view addSubview:buttton62];
    
    // 播放时间
    timeLabel1 = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(buttton6.frame)+20, CGRectGetMinY(buttton6.frame), 90, 50)];
    timeLabel1.text = @"00:00";
    timeLabel1.textAlignment = NSTextAlignmentCenter;
    timeLabel1.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:timeLabel1];
    
    // 总时间
    timeLabel2 = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(timeLabel1.frame)+20, CGRectGetMinY(buttton6.frame), 90, 50)];
    timeLabel2.text = @"00:00";
    timeLabel2.textAlignment = NSTextAlignmentCenter;
    timeLabel2.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:timeLabel2];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playStateChange:) name:JKPlayerPlayStateChangeNotification object:nil];
    
}

- (void)playStateChange: (NSNotification *)notice {
    NSDictionary *noticeDic = notice.userInfo;
    NSURL *url = noticeDic[@"playURL"];
    
    if (![[NSURL URLWithString:@"http://audio.xmcdn.com/group23/M04/63/C5/wKgJNFg2qdLCziiYAGQxcTOSBEw402.m4a"] isEqual:url]) {
        buttton1.selected = NO;
        return;
    }
    
    JKPlayerState state = [noticeDic[@"playState"] integerValue];
    if (state == JKPlayerStatePlaying || state == JKPlayerStateLoading) {
        buttton1.selected = YES;
    }else {
        buttton1.selected = NO;
    }
}


-(void)volumeSliderValueChanged:(UISlider *)slider
{
    NSLog(@"slider value：%f",slider.value);
    [[JKPlayerKit shareDownloaderManger] setVolume:slider.value];
}

-(void)progressSliderSliderValueChanged:(UISlider *)slider
{
    NSLog(@"slider value：%f",slider.value);
    [[JKPlayerKit shareDownloaderManger] seekWithTimeProgress:slider.value];
}

#pragma mark 播放
-(void)playClick{
    
    // http://play.ciotimes.com/DJT55.mp4
    // http://audio.xmcdn.com/group23/M04/63/C5/wKgJNFg2qdLCziiYAGQxcTOSBEw402.m4a
    // http://audio.xmcdn.com/group23/M06/5C/70/wKgJL1g0DVahoMhrAMJMkvfN17c025.m4a
    
    self.playerKit = [JKPlayerKit shareDownloaderManger];
    
    [self.playerKit playerWithUrl:[NSURL URLWithString:@"http://play.ciotimes.com/DJT55.mp4"] isCache:YES];
    [self.playerKit setVolume:0.5];
    
    /*
     self.playerKit.playerLayer = [AVPlayerLayer playerLayerWithPlayer:self.playerKit.player];
     self.playerKit.playerLayer.frame = CGRectMake(0, 240, self.view.bounds.size.width, 200);
     [self.view.layer addSublayer:self.playerKit.playerLayer];
     */
}

#pragma mark 暂停
-(void)pauseClick{
    
    [[JKPlayerKit shareDownloaderManger]pause];
}

#pragma mark 继续播放
-(void)resumeClick{
    
    [[JKPlayerKit shareDownloaderManger]resume];
}

#pragma mark 静音
-(void)muteClick:(UIButton *)sender{
    
    sender.selected = !sender.isSelected;
    
    [[JKPlayerKit shareDownloaderManger]setMuted:sender.selected];
}

#pragma mark 快进
-(void)seekTimeDifferClick{
    
    // 快进15秒
    [[JKPlayerKit shareDownloaderManger]seekWithTimeDiffer:15];
    
}

#pragma mark 倍速
-(void)rateClick1{
    
    [[JKPlayerKit shareDownloaderManger]setRate:1.0];
}

-(void)rateClick2{
    
    [[JKPlayerKit shareDownloaderManger]setRate:1.5];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    NSLog(@"%@",NSHomeDirectory());
}
@end
