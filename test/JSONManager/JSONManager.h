//
//  JSONManager.h
//  ProjectA v2
//
//  Created by Joe.Xi on 11-9-20.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef enum {
    item = 0 ,
    image = 1 ,
    avatar = 2
} sandboxItemtype;


@interface JSONManager : NSObject {
    sandboxItemtype _itemType;//存储信息类型，暂时没用上
    NSString *_filePath;//记录更新日志存储路径
    NSString *_timePath;
    NSString *_avatarPath;//记录用户曾经使用过的头像队列
}
- (id)initwithType:(sandboxItemtype)Type;//初始化
- (UIImage *)getCurrentavatar;//获取用户当前头像
- (NSArray *)getAvatarary;//获取用户历史头像队列

- (NSString *)getTimebykey:(NSString *)key;
- (NSString *)getObjectbykey:(NSString *)key;//根据关键字获取值,对象是图像其保存的值就是图片在沙盒中的路径，再通过路径获取图片
- (UIImage *)getImagefrompath:(NSString *)path;//根据路径获取图像
- (NSData *)transformDictodata:(NSDictionary *)dic;//json解析将字典转化成数据
- (NSDictionary *)transformDatatodic:(NSData *)reader;//json解析将数据转化成字典

- (void)cleanText;//清空更新日志
- (void)cleanAvatarary;//清空用户历史头像队列
- (void)setAvatar:(NSString *)key;//添加头像
- (void)avatarChoosed:(NSString *)path;//被选中头像
- (BOOL)isValid:(NSString *)timestamp;//判断头像是否过期，沙盒只保留1个月内用户使用过的头像
- (void)recordTimebykey:(NSString *)key;//如果其他属性也需要记录时间时使用
- (void)removeObjectbykey:(NSString *)key;//根据关键字删除记录
- (void)removeImagebypath:(NSString *)path;//根据路径删除图片
- (BOOL)notCurrent:(NSString *)key keyAry:(NSArray *)keyAry;//判断头像是否为用户当前头像
- (void)addObjectbykey:(NSString *)key value:(NSString *)value;//添加记录
- (void)updateValuebykey:(NSString *)key value:(NSString *)value;//更新记录
- (void)savePicturefromurl:(NSString *)url path:(NSString *)path imgName:(NSString *)imgName;//根据url将图片下载并保至沙盒，同时记录在更新日志中
- (void)savePicturefromimage:(UIImage *)image path:(NSString *)path imgName:(NSString *)imgName;//
@end

