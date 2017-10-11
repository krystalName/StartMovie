//
//  AppDelegate.m
//  KNStartMovie
//
//  Created by 刘凡 on 2017/10/9.
//  Copyright © 2017年 KrystalName. All rights reserved.
//

#import "AppDelegate.h"
#import "KNMovieViewController.h"
#import "ViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    
    //刚开始肯定是NO. 因为没有保存过YES 放到userDefaults 里面.
    BOOL isFirstUp =  [[NSUserDefaults standardUserDefaults] objectForKey:@"FirstUp"];
    
    //首先说明一下。 我这里是随便写的一个判断首次进入。下面说明正确写法
    //1.首先要从服务器获取到版本号
    //2.然后获取到Xcode设置版本号，把本地版本号上传到服务器。以方便下次比较
    //3.开始比较。版本号不同就设置启动页面。 这个看具体需求。因为有些app升级之后是不会出现启动页面的。
    //那是因为别人不需要每次升级都出现引导页。 
    
    if (!isFirstUp) //如果本地缓存的数值是YES 就代表保存过
    {
        //存到本地UserDefaults 里面
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"FirstUp"];
        
        //然后再跳转到播放视频的画面
        KNMovieViewController *KNVC = [[KNMovieViewController alloc]init];
        // 1、获取媒体资源地址
        NSString *path =  [[NSBundle mainBundle] pathForResource:@"movie.mp4" ofType:nil];
        KNVC.movieURL = [NSURL fileURLWithPath:path];
        self.window.rootViewController = KNVC;
    }else{
        //不是首次启动
        ViewController *rootTabCtrl = [[ViewController alloc]init];
        self.window.rootViewController = rootTabCtrl;
    }
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
