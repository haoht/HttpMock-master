//
//  HUDHelper.m
//  pizus
//
//  Created by xxx on 12-11-28.
//  Copyright (c) 2012年 xxx. All rights reserved.
//

#import "HUDHelper.h"

@implementation HUDHelper

+ (HUDHelper *)sharedInstance
{
    static HUDHelper *sharedInstace = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstace = [[self alloc] init];
    });
    
    return sharedInstace;
}

- (id)init
{
    self = [super init];
    if (self) {
        _showingHUDs = [[NSMutableArray alloc] init];
    }
    
    return self;
}


- (void)hudWasHidden:(MBProgressHUD *)hud
{
    @synchronized(_loadingHud)
    {
        if (_loadingHud == hud) {
            [_loadingHud removeFromSuperview];
            [self removeHUD:_loadingHud];
            _loadingHud = nil;
        }
    }
    
}

- (void)addHUD:(MBProgressHUD *)hud
{
    @synchronized(_showingHUDs)
    {
        [_showingHUDs addObject:hud];
    }
}
- (void)removeHUD:(MBProgressHUD *)hud
{
    @synchronized(_showingHUDs)
    {
        [_showingHUDs removeObject:hud];
    }
}

- (void)serviceLoading:(NSInteger)maxRequestCount
{
    @synchronized(_loadingHud)
    {
        if (_loadingHud == nil) {
            _loadingHud = [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow animated:YES];
            _loadingHud.delegate = self;
            _loadingHud.tag = 0;
            [self addHUD:_loadingHud];
            [_loadingHud show:YES];
        }
        if (_loadingHud)
        {
            
            _loadingHud.tag++;
        }
    }
}

- (void)loading
{
    if ([NSThread isMainThread])
    {
        @synchronized(_loadingHud)
        {
            if (_loadingHud == nil) {
                _loadingHud = [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow animated:YES];
                _loadingHud.delegate = self;
                _loadingHud.tag = 0;
                [self addHUD:_loadingHud];
                [_loadingHud show:YES];
            }
            if (_loadingHud)
            {
                
                _loadingHud.tag++;
            }
        }
    }
    else
    {
        [self performSelectorOnMainThread:@selector(loading) withObject:nil waitUntilDone:NO];
    }
    
}

- (void)stopLoading
{
    if ([NSThread isMainThread]) {
        @synchronized(_loadingHud)
        {
            if (_loadingHud)
            {
                if (--_loadingHud.tag <= 0)
                {
                    [_loadingHud hide:YES];
                }
            }
        }
    }
    else
    {
        [self performSelectorOnMainThread:@selector(stopLoading) withObject:nil waitUntilDone:NO];
    }
    
}

- (void)tipMessage:(NSString *)msg delay:(CGFloat)seconds
{
    if (!msg) {
        return;
    }
    MBProgressHUD *HUD = [[MBProgressHUD alloc] initWithWindow:[UIApplication sharedApplication].keyWindow];
    [[UIApplication sharedApplication].keyWindow addSubview:HUD];
    HUD.mode = MBProgressHUDModeText;
    HUD.delegate = self;
//    HUD.labelText = msg;
    [HUD show:YES];
    [HUD hide:YES afterDelay:seconds];

    //liman
    HUD.detailsLabelText = msg;
    HUD.detailsLabelFont = HUD.labelFont;
}

- (void)delayTipMessage:(NSString *)msg
{
    [self tipMessage:msg delay:2.0];
}

- (void)tipMessage:(NSString *)msg
{
    //liman
    [self stopLoading];
    
    if (!msg) {
        return;
    }
    
    if ([NSThread isMainThread])
    {
        [self performSelector:@selector(delayTipMessage:) withObject:msg afterDelay:0.2];
    }
    else
    {
        [self performSelectorOnMainThread:@selector(tipMessage:) withObject:msg waitUntilDone:NO];
    }
    
}


- (void)loadingFor:(CGFloat)seconds
{
    MBProgressHUD *HUD = [[MBProgressHUD alloc] initWithView:[UIApplication sharedApplication].keyWindow];
    [[UIApplication sharedApplication].keyWindow addSubview:HUD];
    [HUD show:YES];
    [HUD hide:YES afterDelay:seconds];
}


- (void)loadingFor:(CGFloat)seconds inView:(UIView *)view
{
    if (!view)
    {
        return;
    }
    MBProgressHUD *HUD = [[MBProgressHUD alloc] initWithView:view];
    [view addSubview:HUD];
    [HUD show:YES];
    [HUD hide:YES afterDelay:seconds];
}

//liman
- (void)loadingWithText:(NSString *)text
{
    if ([NSThread isMainThread])
    {
        @synchronized(_loadingHud)
        {
            if (_loadingHud == nil) {
                _loadingHud = [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow animated:YES];
                _loadingHud.delegate = self;
                _loadingHud.tag = 0;
//                _loadingHud.labelText = text;
                [self addHUD:_loadingHud];
                [_loadingHud show:YES];
                
                _loadingHud.detailsLabelText = text;
                _loadingHud.detailsLabelFont = _loadingHud.labelFont;
            }
            if (_loadingHud)
            {
                
                _loadingHud.tag++;
            }
        }
    }
    else
    {
        [self performSelectorOnMainThread:@selector(loadingWithText:) withObject:text waitUntilDone:NO];
    }
    
}

@end
