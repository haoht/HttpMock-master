//
//  HUDHelper.h
//  pizus
//
//  Created by xxx on 12-11-28.
//  Copyright (c) 2012年 xxx. All rights reserved.
//

#import "MBProgressHUD.h"

@interface HUDHelper : NSObject<MBProgressHUDDelegate>
{
@private
//    __weak UIWindow *_window;
    NSMutableArray *_showingHUDs;
    
    MBProgressHUD *_loadingHud;
    
}

//@property (nonatomic, weak) UIWindow *window;

- (void)addHUD:(MBProgressHUD *)hud;
- (void)removeHUD:(MBProgressHUD *)hud;

+ (HUDHelper *)sharedInstance;
- (void)serviceLoading:(NSInteger)maxRequestCount;
- (void)loading;
- (void)loadingFor:(CGFloat)seconds;
- (void)loadingFor:(CGFloat)seconds inView:(UIView *)view;
- (void)stopLoading;

- (void)tipMessage:(NSString *)msg;
- (void)tipMessage:(NSString *)msg delay:(CGFloat)seconds;
//- (void)tipMessage:(NSString *)msg delay:(CGFloat)seconds inView:(UIView *)view;

//liman
- (void)loadingWithText:(NSString *)text;

@end
