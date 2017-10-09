//
//  KNMovieViewController.m
//  KNStartMovie
//
//  Created by 刘凡 on 2017/10/9.
//  Copyright © 2017年 KrystalName. All rights reserved.
//

#import "KNMovieViewController.h"
#import "ViewController.h"
#import <AVFoundation/AVFoundation.h>
#import <AVKit/AVKit.h>

@interface KNMovieViewController ()

//播放器View
@property(nonatomic, strong)AVPlayerViewController *AVplayer;

@end

@implementation KNMovieViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    //初始化AVPlayer
    [self setMoviePlayer];
}

-(void)setMoviePlayer{
    
    //初始化播放器
    _AVplayer = [[AVPlayerViewController alloc]init];
    //关闭AVPlayerViewController内部的约束
    _AVplayer.view.translatesAutoresizingMaskIntoConstraints = YES;
    //设置代理.监听播放状态
    _AVplayer.allowsPictureInPicturePlayback = NO;
    _AVplayer.showsPlaybackControls = false;
    
    //初始化一个播放单位。给AVplayer 使用
    AVPlayerItem *item = [[AVPlayerItem alloc]initWithURL:_movieURL];
    
    AVPlayer *player = [AVPlayer playerWithPlayerItem:item];
    
    //设置AVPlayerViewController内部的AVPlayer为刚创建的AVPlayer
    _AVplayer.player = player;
    //layer
    AVPlayerLayer *layer = [AVPlayerLayer playerLayerWithPlayer:player];
    
    [layer setFrame:[UIScreen mainScreen].bounds];
    
    //设置填充模式
    layer.videoGravity = AVLayerVideoGravityResizeAspect;
    

    [self.view.layer addSublayer:layer];

    //开始播放
    [_AVplayer.player play];
    
    //通知r
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(playDidEnd:)
                                                 name:AVPlayerItemDidPlayToEndTimeNotification
                                               object:item];
    
    //添加进入应用页面
    [self setupLoginView];
}

//播放完成的代理
- (void)playDidEnd:(NSNotification *)Notification{
    //播放完成后。设置播放进度为0 。 重新播放
    [_AVplayer.player seekToTime:CMTimeMake(0, 1)];
    //开始播放
    [_AVplayer.player play];
    
}

- (void)setupLoginView
{
    //进入按钮
    UIButton *enterMainButton = [[UIButton alloc] init];
    enterMainButton.frame = CGRectMake(24, [UIScreen mainScreen].bounds.size.height - 32 - 48, [UIScreen mainScreen].bounds.size.width - 48, 48);
    enterMainButton.layer.borderWidth = 1;
    enterMainButton.layer.cornerRadius = 24;
    enterMainButton.alpha = 0;
    enterMainButton.layer.borderColor = [UIColor whiteColor].CGColor;
    [enterMainButton setTitle:@"进入应用" forState:UIControlStateNormal];
    [self.view addSubview:enterMainButton];
    [enterMainButton addTarget:self action:@selector(enterMainAction:) forControlEvents:UIControlEventTouchUpInside];

    [UIView animateWithDuration:3 animations:^{
        enterMainButton.alpha = 1;
    }];
}


- (void)enterMainAction:(UIButton *)btn {
    ViewController *rootTabCtrl = [[ViewController alloc]init];
    self.view.window.rootViewController = rootTabCtrl;
}
@end
