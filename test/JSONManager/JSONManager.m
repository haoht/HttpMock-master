//
//  JSONManager.m
//  ProjectA v2
//
//  Created by Joe.Xi on 11-9-20.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "JSONManager.h"
#import "CJSONDeserializer.h"
#import "CJSONSerializer.h"

@implementation JSONManager

- (id)initwithType:(sandboxItemtype)Type
{
    self = [super init];
    if (self) {
        _itemType=Type;
        NSString* documentsDirectory= [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
        _filePath= [[NSString alloc]initWithString:[documentsDirectory stringByAppendingPathComponent:@"test.txt"]];
        _timePath= [[NSString alloc]initWithString:[documentsDirectory stringByAppendingPathComponent:@"time.txt"]];
        _avatarPath= [[NSString alloc]initWithString:[documentsDirectory stringByAppendingPathComponent:@"avatar.txt"]];
    }
    return self;
}
- (void)dealloc
{
    [super dealloc];
}
- (void)cleanText
{
    NSMutableData *writer = [[NSMutableData alloc]init]; 
    [writer appendData:[@"" dataUsingEncoding:NSUTF8StringEncoding]]; 
    [writer writeToFile:_filePath atomically:NO];
    [writer release];
}
#pragma mark - JsonAnalyze
- (NSDictionary *)transformDatatodic:(NSData *)reader 
{
    NSObject *obj=[[CJSONDeserializer deserializer] deserialize:reader error:nil];
    if([obj isKindOfClass:[NSDictionary class]]) 
    {
        NSDictionary* dic = (NSDictionary *)obj;
        return  dic;
    }
    return nil;
}
- (NSData *)transformDictodata:(NSDictionary *)dic
{
    NSObject *obj=[[CJSONSerializer serializer]serializeObject:dic error:nil];
    if([obj isKindOfClass:[NSData class]]) 
    {
        NSData* data = (NSData *)obj;
        return  data;
    }
    return nil;
}
#pragma mark - FilePart
//对更新日志文件进行添加修改查找或者删除，包括对沙盒中图片的删除
- (NSString *)getObjectbykey:(NSString *)key
{
    NSData *reader = [NSData dataWithContentsOfFile:_filePath];
    return [[self transformDatatodic:reader] objectForKey:key];
}
- (void)addObjectbykey:(NSString *)key value:(NSString *)value
{
    NSData *reader = [NSData dataWithContentsOfFile:_filePath];
    NSDictionary *dic=[[NSMutableDictionary dictionary] retain];
    dic=[[NSMutableDictionary alloc]initWithDictionary:[self transformDatatodic:reader]];
    [dic setValue:value forKey:key];
    NSData *write=[self transformDictodata:(NSDictionary *)dic];
    [write writeToFile:_filePath atomically:NO];
}
- (void)updateValuebykey:(NSString *)key value:(NSString *)value
{
    NSData *reader = [NSData dataWithContentsOfFile:_filePath];
    NSDictionary *dic=[[NSMutableDictionary dictionary] retain];
    dic=[[NSMutableDictionary alloc]initWithDictionary:[self transformDatatodic:reader]];
    [dic setValue:value forKey:key];
    NSData *write=[self transformDictodata:(NSDictionary *)dic];
    [write writeToFile:_filePath atomically:NO];
}
- (void)removeImagebypath:(NSString *)path
{
    NSFileManager* fileManager = [NSFileManager defaultManager];
	if (path && [fileManager fileExistsAtPath:path]) {
		[fileManager removeItemAtPath:path error:nil];
	}
}
- (void)removeObjectbykey:(NSString *)key
{
    NSData *reader = [NSData dataWithContentsOfFile:_filePath];
    NSMutableDictionary *dic=[[NSMutableDictionary dictionary] retain];
    dic=[[NSMutableDictionary alloc]initWithDictionary:[self transformDatatodic:reader]];
    [self removeImagebypath:[dic objectForKey:key]];
    [dic removeObjectForKey:key];
    NSData *write=[self transformDictodata:(NSDictionary *)dic];
    [write writeToFile:_filePath atomically:NO];
}
#pragma mark - PicturePart
//保存本地或url图片至app沙盒
- (void)savePicturefromurl:(NSString *)url path:(NSString *)path imgName:(NSString *)imgName
{
    UIImage *img=[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:url]]];
    [self savePicturefromimage:img path:path imgName:imgName];
}

- (void)savePicturefromimage:(UIImage *)image path:(NSString *)path imgName:(NSString *)imgName
{
    if(path==nil)
    {
        path = [[[NSBundle mainBundle] bundlePath] stringByAppendingPathComponent:imgName];
    }
    [UIImagePNGRepresentation(image) writeToFile:path atomically:YES];
    [self addObjectbykey:imgName value:path];
}
- (UIImage *)getImagefrompath:(NSString *)path
{
    return [[UIImage alloc]initWithContentsOfFile:path];
}
#pragma mark - Avatar
//保存用户使用过的头像至沙盒，并记录,在_filePath更新日志文件中通过CurrentAvatar关键字可访问用户当前头像，_avatarPath保存用户历史头像
- (void)setAvatar:(NSString *)key
{
    NSData *reader = [NSData dataWithContentsOfFile:_filePath];
    NSDictionary *dic=[[NSMutableDictionary dictionary] retain];
    dic=[[NSMutableDictionary alloc]initWithDictionary:[self transformDatatodic:reader]];
    [dic setValue:[self getObjectbykey:key] forKey:@"CurrentAvatar"];
    NSData *write=[self transformDictodata:(NSDictionary *)dic];
    [write writeToFile:_filePath atomically:YES];
    [dic release];
    
    reader=[NSData dataWithContentsOfFile:_avatarPath];
    dic=[[NSMutableDictionary dictionary] retain];
    dic=[[NSMutableDictionary alloc]initWithDictionary:[self transformDatatodic:reader]];
    [dic setValue:[self getObjectbykey:key] forKey:[NSString stringWithFormat:@"%ld",time(NULL)]];
    write=[self transformDictodata:(NSDictionary *)dic];
    [write writeToFile:_avatarPath atomically:NO];
}
- (UIImage *)getCurrentavatar
{
    return [self getImagefrompath:[self getObjectbykey:@"CurrentAvatar"]];
}
- (void)cleanAvatarary
{
    NSData *reader = [NSData dataWithContentsOfFile:_avatarPath];
    NSMutableDictionary *dic=[[NSMutableDictionary dictionary] retain];
    dic=[[NSMutableDictionary alloc]initWithDictionary:[self transformDatatodic:reader]];
    [dic removeAllObjects];
    NSData *write=[self transformDictodata:(NSDictionary *)dic];
    [write writeToFile:_avatarPath atomically:NO];
}
- (NSArray *)getAvatarary
{
    NSData *reader = [NSData dataWithContentsOfFile:_avatarPath];
    NSMutableDictionary *dic=[[NSMutableDictionary dictionary] retain];
    dic=[[NSMutableDictionary alloc]initWithDictionary:[self transformDatatodic:reader]];
    NSArray *keyAry=[dic allKeys];
    for (int i=0; i<[keyAry count]; i++) {
        if(![self isValid:[keyAry objectAtIndex:i]]&&[self notCurrent:[keyAry objectAtIndex:i] keyAry:keyAry])
        {
            [self removeImagebypath:[dic objectForKey:[keyAry objectAtIndex:i]]];
            [dic removeObjectForKey:[keyAry objectAtIndex:i]];
        }
    }
    NSData *write=[self transformDictodata:(NSDictionary *)dic];
    [write writeToFile:_avatarPath atomically:NO];
    NSArray *pathAry=[dic allValues];
    [dic release];
    return pathAry;
}
- (void)avatarChoosed:(NSString *)path
{
    NSData *reader = [NSData dataWithContentsOfFile:_avatarPath];
    NSMutableDictionary *dic=[[NSMutableDictionary dictionary] retain];
    dic=[[NSMutableDictionary alloc]initWithDictionary:[self transformDatatodic:reader]];
    NSArray *valueAry=[dic allKeys];
    for (int i=0;i<[dic count]; i++) {
        if ([[dic objectForKey:[valueAry objectAtIndex:i]] isEqualToString:path]) {
            [dic setValue:path forKey:[NSString stringWithFormat:@"%ld",time(NULL)]];
            [dic removeObjectForKey:[valueAry objectAtIndex:i]];
            break;
        }
    }
    NSData *write=[self transformDictodata:(NSDictionary *)dic];
    [write writeToFile:_avatarPath atomically:YES];
    [dic release];
    
    reader = [NSData dataWithContentsOfFile:_filePath];
    dic=[[NSMutableDictionary dictionary] retain];
    dic=[[NSMutableDictionary alloc]initWithDictionary:[self transformDatatodic:reader]];
    [dic setValue:path forKey:@"CurrentAvatar"];
    write=[self transformDictodata:(NSDictionary *)dic];
    [write writeToFile:_filePath atomically:NO];
    [dic release];
}
- (BOOL)notCurrent:(NSString *)key keyAry:(NSArray *)keyAry
{
    for(int i=0;i<[keyAry count];i++)
    {
        if([key intValue]<[[keyAry objectAtIndex:i]intValue])
        {
            return YES;
        }
    }
    return NO;
}
- (BOOL)isValid:(NSString *)timestamp
{
    if((time(NULL)-[timestamp intValue])>60*60*24*30)
    {
        return NO;
    }
    return YES;
}
#pragma mark - TimeStamp
//时间戳，用于记录更新时间等信息
- (void)recordTimebykey:(NSString *)key
{
    NSData *reader = [NSData dataWithContentsOfFile:_timePath];
    NSDictionary *dic=[[NSMutableDictionary dictionary] retain];
    dic=[[NSMutableDictionary alloc]initWithDictionary:[self transformDatatodic:reader]];
    [dic setValue:[NSString stringWithFormat:@"%ld", time(NULL)] forKey:key];
    NSData *write=[self transformDictodata:(NSDictionary *)dic];
    [write writeToFile:_timePath atomically:NO];
}
- (NSString *)getTimebykey:(NSString *)key
{
    NSData *reader = [NSData dataWithContentsOfFile:_timePath];
    return [[self transformDatatodic:reader] objectForKey:key];
}
@end
