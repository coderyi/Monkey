//
//  AppDelegate.m
//  GitHubYi
//
//  Created by coderyi on 15/3/22.
//  Copyright (c) 2015年 www.coderyi.com. All rights reserved.
//
//
//                            _ooOoo_
//                           o8888888o
//                           88" . "88
//                           (| -_- |)
//                            O\ = /O
//                        ____/`---'\____
//                      .   ' \\| |// `.
//                       / \\||| : |||// \
//                     / _||||| -:- |||||- \
//                       | | \\\ - /// | |
//                     | \_| ''\---/'' | |
//                      \ .-\__ `-` ___/-. /
//                   ___`. .' /--.--\ `. . __
//                ."" '< `.___\_<|>_/___.' >'"".
//               | | : `- \`.;`\ _ /`;.`/ - ` : | |
//                 \ \ `-. \_ __\ /__ _/ .-` / /
//         ======`-.____`-.___\_____/___.-`____.-'======
//                            `=---='
//
//         .............................................
//                  佛祖镇楼                  BUG辟易
//          佛曰:
//                  写字楼里写字间，写字间里程序员；
//                  程序人员写程序，又拿程序换酒钱。
//                  酒醒只在网上坐，酒醉还来网下眠；
//                  酒醉酒醒日复日，网上网下年复年。
//                  但愿老死电脑间，不愿鞠躬老板前；
//                  奔驰宝马贵者趣，公交自行程序员。
//                  别人笑我忒疯癫，我笑自己命太贱；
//                  不见满街漂亮妹，哪个归得程序员？
#import "AppDelegate.h"
#import "UserRankViewController.h"
#import "RepositoriesViewController.h"
#import "MoreViewController.h"
#import "DiscoveryViewController.h"
#import "MobClick.h"
#import "UMFeedback.h"
#import "UMOpus.h"
#import "UMessage.h"
#import "NEHTTPEye.h"

#import "BaseNavigationController.h"
@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    //延长启动页面的显示时间
    [NSThread sleepForTimeInterval:2];
    // Override point for customization after application launch.
#if defined(DEBUG)||defined(_DEBUG)
    [NEHTTPEye setEnabled:NO];// open a network debug library
#endif
    [self setupTabBar];//setup tabbar
    self.apiEngine = [[YiNetworkEngine alloc] initWithDefaultSet];//set a app network engine
    [self setupUM:launchOptions];//setup UM
    return YES;
}

- (void)setupTabBar
{
    UserRankViewController *languageRank=[[UserRankViewController alloc] init];
    BaseNavigationController *navLanguageRank=[self initlizerNavigationControllerWithRootViewController:languageRank];
    navLanguageRank.navigationBar.barTintColor=YiBlue;
    navLanguageRank.navigationBar.tintColor=[UIColor whiteColor];
    navLanguageRank.navigationBar.titleTextAttributes=[NSDictionary dictionaryWithObject:[UIColor whiteColor] forKey:NSForegroundColorAttributeName];
    
    RepositoriesViewController *repositories=[[RepositoriesViewController alloc] init];
    BaseNavigationController *navRepositories = [self initlizerNavigationControllerWithRootViewController:repositories];
    navRepositories.navigationBar.barTintColor=YiBlue;
    navRepositories.navigationBar.tintColor=[UIColor whiteColor];
    navRepositories.navigationBar.titleTextAttributes=[NSDictionary dictionaryWithObject:[UIColor whiteColor] forKey:NSForegroundColorAttributeName];
    
    DiscoveryViewController *discovery=[[DiscoveryViewController alloc] init];
    BaseNavigationController *navDiscovery = [self initlizerNavigationControllerWithRootViewController:discovery];
    navDiscovery.navigationBar.barTintColor=YiBlue;
    navDiscovery.navigationBar.tintColor=[UIColor whiteColor];
    navDiscovery.navigationBar.titleTextAttributes=[NSDictionary dictionaryWithObject:[UIColor whiteColor] forKey:NSForegroundColorAttributeName];
    
    MoreViewController *more=[[MoreViewController alloc] init];
    BaseNavigationController *navMore = [self initlizerNavigationControllerWithRootViewController:more];
    navMore.navigationBar.barTintColor=YiBlue;
    navMore.navigationBar.tintColor=[UIColor whiteColor];
    navMore.navigationBar.titleTextAttributes=[NSDictionary dictionaryWithObject:[UIColor whiteColor] forKey:NSForegroundColorAttributeName];
    
    UITabBarController *tab=[[UITabBarController alloc] init];
    tab.viewControllers=@[navLanguageRank,navRepositories,navDiscovery,navMore];
    UITabBar *tabBar = tab.tabBar;
    tab.tabBar.backgroundColor=[UIColor whiteColor];
    tab.tabBar.tintColor=YiBlue;
    
    UITabBarItem *tabBarItem1 = [tabBar.items objectAtIndex:0];
    UITabBarItem *tabBarItem2 = [tabBar.items objectAtIndex:1];
    UITabBarItem *tabBarItem3 = [tabBar.items objectAtIndex:2];
    UITabBarItem *tabBarItem4 = [tabBar.items objectAtIndex:3];
    tabBarItem1.title=@"Users";
    tabBarItem1.image=[UIImage imageNamed:@"github60"];
    
    tabBarItem2.title=@"Repositories";
    tabBarItem2.image=[UIImage imageNamed:@"github160"];
    
    tabBarItem3.title=@"Discovery";
    tabBarItem3.image=[UIImage imageNamed:@"github60"];
    
    tabBarItem4.title=@"More";
    tabBarItem4.image=[UIImage imageNamed:@"more"];
    
    self.window.rootViewController=tab;
}


- (BaseNavigationController *)initlizerNavigationControllerWithRootViewController:(UIViewController *)rootViewController
{
    return [[BaseNavigationController alloc] initWithRootViewController:rootViewController];
}

- (void)setupUM:(NSDictionary *)launchOptions
{
    [MobClick startWithAppkey:@"551ff351fd98c56f12000013"];
    
    [MobClick checkUpdate];
    [UMFeedback setAppkey:@"551ff351fd98c56f12000013"];
    
    [UMOpus setAudioEnable:YES];
    
    //    下面的代码是友盟推送 需要证书
    
    [UMessage startWithAppkey:@"551ff351fd98c56f12000013" launchOptions:launchOptions];
    
    if (IOS_8_OR_LATER) {
        //register remoteNotification types
        UIMutableUserNotificationAction *action1 = [[UIMutableUserNotificationAction alloc] init];
        action1.identifier = @"action1_identifier";
        action1.title=@"Accept";
        action1.activationMode = UIUserNotificationActivationModeForeground;//当点击的时候启动程序
        
        UIMutableUserNotificationAction *action2 = [[UIMutableUserNotificationAction alloc] init];  //第二按钮
        action2.identifier = @"action2_identifier";
        action2.title=@"Reject";
        action2.activationMode = UIUserNotificationActivationModeBackground;//当点击的时候不启动程序，在后台处理
        action2.authenticationRequired = YES;//需要解锁才能处理，如果action.activationMode = UIUserNotificationActivationModeForeground;则这个属性被忽略；
        action2.destructive = YES;
        
        UIMutableUserNotificationCategory *categorys = [[UIMutableUserNotificationCategory alloc] init];
        categorys.identifier = @"category1";//这组动作的唯一标示
        [categorys setActions:@[action1,action2] forContext:(UIUserNotificationActionContextDefault)];
        
        UIUserNotificationSettings *userSettings = [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeBadge|UIUserNotificationTypeSound|UIUserNotificationTypeAlert
                                                                                     categories:[NSSet setWithObject:categorys]];
        [UMessage registerRemoteNotificationAndUserNotificationSettings:userSettings];
    } else {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
        
        [UMessage registerForRemoteNotificationTypes:UIRemoteNotificationTypeBadge |
         UIRemoteNotificationTypeSound |
         UIRemoteNotificationTypeAlert];
#pragma clang diagnostic pop
        
    }
    [UMessage setLogEnabled:NO];
    
    //关闭状态时点击反馈消息进入反馈页
    NSDictionary *notificationDict = [launchOptions valueForKey:UIApplicationLaunchOptionsRemoteNotificationKey];
    [UMFeedback didReceiveRemoteNotification:notificationDict];
    
    [[UMFeedback sharedInstance] setFeedbackViewController:nil shouldPush:NO];
    //    上面的代码是友盟推送 需要证书
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    [UMessage registerDeviceToken:deviceToken];
    NSLog(@"umeng message alias is: %@", [UMFeedback uuid]);
    [UMessage addAlias:[UMFeedback uuid] type:[UMFeedback messageType] response:^(id responseObject, NSError *error) {
        if (error != nil) {
            NSLog(@"%@", error);
            NSLog(@"%@", responseObject);
        }
    }];
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
{
    [UMFeedback didReceiveRemoteNotification:userInfo];
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)URL sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    // For handling a callback URL like my-app://oauth
    NSLog(@"%@",URL.host);
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
