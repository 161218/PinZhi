//
//  LocalStorageManager.m
//  自定义demo
//
//  Created by 刘子阳 on 15/6/25.
//  Copyright (c) 2015年 刘子阳. All rights reserved.
//

#import "LocalStorageManager.h"

#include <sys/xattr.h>
#import <UIKit/UIDevice.h>
#import "macro.h"
@implementation LocalStorageManager

@synthesize homeCacheDict= _homeCacheDict;
@synthesize hasLaunchBefore = _hasLaunchBefore;

#define UserDefault [NSUserDefaults standardUserDefaults]
static LocalStorageManager *sharedSingleton_ = nil;

+ (LocalStorageManager *) sharedManager
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedSingleton_ = [[LocalStorageManager alloc] init];
    });
    return sharedSingleton_;
}


- (instancetype)init{
    self = [super init];
    if(self){
        [self createNoCloudDirectory];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationDidEnterBackground:) name:NSExtensionHostDidEnterBackgroundNotification object:nil];
    }
    return self;
}

/**
 *  设置不同步icloud属性
 */
- (void)createNoCloudDirectory
{
    NSString *storePath = [self storeRootPath];
    if (![[NSFileManager defaultManager] fileExistsAtPath:storePath])
    {
        [[NSFileManager defaultManager] createDirectoryAtPath:storePath withIntermediateDirectories:YES attributes:nil error:NULL];
        NSURL *tbDocumentURL = [NSURL fileURLWithPath:storePath isDirectory:YES];
        NSString *versionString = [[UIDevice currentDevice] systemVersion];
        if ([@"5.0.1" compare:versionString options:NSNumericSearch] == NSOrderedAscending) {
            //5.1以及以上版本
            [tbDocumentURL setResourceValue:[NSNumber numberWithBool: YES] forKey: NSURLIsExcludedFromBackupKey error:nil];
        } else if ([@"5.0.1" compare:versionString options:NSNumericSearch] == NSOrderedSame) {
            //5.0.1版本
            const char* downloadCharPath = [[tbDocumentURL path] fileSystemRepresentation];
            const char* attrName = "com.apple.MobileBackup";
            u_int8_t attrValue = 1;
            setxattr(downloadCharPath, attrName, &attrValue, sizeof(attrValue), 0, 0);
        }
    }
}


#pragma mark store
/**
 *  写入磁盘
 *
 */
- (void)applicationDidEnterBackground:(NSNotification *)notification{
    [UserDefault synchronize];
}

//所有目录存到这里
- (NSString *)storeRootPath{
    NSString *documentPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    return [documentPath stringByAppendingPathComponent:LOCAL_STORAGE_PATH];
}

/**
 *  先从本地存储目录取,若为空则去取app资源
 *
 *  @param plistName 完整名称
 *
 */
- (NSDictionary *)getDictFromLocalOrBundleWithFileName:(NSString *)fileName{
    NSString *storePath = [[self storeRootPath] stringByAppendingPathComponent:fileName];
    NSDictionary *dict = [[NSDictionary alloc] initWithContentsOfFile:storePath];
    if(!dict){
        storePath = [[NSBundle mainBundle] pathForResource:fileName ofType:nil];
        dict = [[NSDictionary alloc] initWithContentsOfFile:storePath];
    }
    return dict;
}

- (void)storeDictData:(NSDictionary *)dict toFile:(NSString *)fileName{
    NSString *storePath = [[self storeRootPath] stringByAppendingPathComponent:fileName];
    [dict writeToFile:storePath atomically:YES];
}

#pragma mark launch

- (BOOL)hasLaunchBefore{
    BOOL res = [[UserDefault objectForKey:@"hasLaunchBefore"] boolValue];
    return res;
}

- (void)setHasLaunchBefore:(BOOL)hasLaunchBefore{
    [UserDefault setObject:[NSNumber numberWithBool:hasLaunchBefore] forKey:@"hasLaunchBefore"];
}

- (NSDictionary *)lastSelectedCity{
    NSDictionary *cityDict = [UserDefault objectForKey:@"lastSelectedCity"];
    return cityDict;
}

- (void)setLastSelectedCity:(NSDictionary *)lastSelectedCity{
    if(lastSelectedCity){
        [UserDefault setObject:lastSelectedCity forKey:@"lastSelectedCity"];
    }
}



@end
