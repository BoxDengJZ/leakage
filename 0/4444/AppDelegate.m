//
//  AppDelegate.m
//  4444
//
//  Created by Jz D on 2022/7/16.
//

#import "AppDelegate.h"

#import "fishhook.h"
#import <dlfcn.h>



#include <string.h>
#include <malloc/malloc.h>



static void (* orig_free)(void*);



void safe_free(void* p){
    size_t memCapacity = malloc_size(p);
    memset(p, 0x55, memCapacity);
    orig_free(p);
}



@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    rebind_symbols((struct rebinding[1]){{"free", safe_free, (void *)&orig_free}}, 1);
    
    
    
    
    return YES;
}


#pragma mark - UISceneSession lifecycle





- (UISceneConfiguration *)application:(UIApplication *)application configurationForConnectingSceneSession:(UISceneSession *)connectingSceneSession options:(UISceneConnectionOptions *)options {
    // Called when a new scene session is being created.
    // Use this method to select a configuration to create the new scene with.
    
    
    
    
    
    
    
    return [[UISceneConfiguration alloc] initWithName:@"Default Configuration" sessionRole:connectingSceneSession.role];
}


- (void)application:(UIApplication *)application didDiscardSceneSessions:(NSSet<UISceneSession *> *)sceneSessions {
    // Called when the user discards a scene session.
    // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
    // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
}


@end
