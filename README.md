# KNStartMovie

###  先上效果图

![]{https://github.com/krystalName/StartMovie/blob/master/movie.gif}

 ## 跟着时代的变化。 很多app的启动页面会选择用一段视频去代替传统的滑动启动。 所以我就写了一个demo 实现了拿本地视频作为启示页面
 
 1.也可以做拿网络视频作为启动视频。（需要自己做）
 
 2.首先你本地肯定是要有一个视频的。 不可以直接去获取网络视频。 否则会造成网络慢而没有视频的后果

### 核心代码如下
``` objc 
//播放器ViewController
@property(nonatomic, strong)AVPlayerViewController *AVPlayer;

 -(void)setMoviePlayer{  
    //初始化AVPlayer
    self.AVPlayer = [[AVPlayerViewController alloc]init];
    //多分屏功能取消
    self.AVPlayer.allowsPictureInPicturePlayback = NO;
    //设置是否显示媒体播放组件
    self.AVPlayer.showsPlaybackControls = false;
    
    //初始化一个播放单位。给AVplayer 使用
    AVPlayerItem *item = [[AVPlayerItem alloc]initWithURL:_movieURL];
    
    AVPlayer *player = [AVPlayer playerWithPlayerItem:item];

    //layer
    AVPlayerLayer *layer = [AVPlayerLayer playerLayerWithPlayer:player];
    [layer setFrame:[UIScreen mainScreen].bounds];
    //设置填充模式
    layer.videoGravity = AVLayerVideoGravityResizeAspect;
    
    
    //设置AVPlayerViewController内部的AVPlayer为刚创建的AVPlayer
    self.AVPlayer.player = player;
    //添加到self.view上面去
    [self.view.layer addSublayer:layer];
    //开始播放
    [self.AVPlayer.player play];
    
    
    
    //这里设置的是重复播放。
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(playDidEnd:)
                                                 name:AVPlayerItemDidPlayToEndTimeNotification
                                               object:item];
    
    
 }  
```

## 因为考虑到视频播放完也不能卡住。 所以做了一个重复播放的动作

``` objc
//播放完成的代理
- (void)playDidEnd:(NSNotification *)Notification{
    //播放完成后。设置播放进度为0 。 重新播放
    [self.AVPlayer.player seekToTime:CMTimeMake(0, 1)];
    //开始播放
    [self.AVPlayer.player play];
}

```

## 然后做了一个定时器。3秒钟之后出现进入应用的按钮
``` objc 
  //定时器。延迟3秒再出现进入应用按钮
    [NSTimer scheduledTimerWithTimeInterval:3.0 target:self selector:@selector(setupLoginView) userInfo:nil repeats:YES];
```
