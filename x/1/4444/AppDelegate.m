//
//  AppDelegate.m
//  4444
//
//  Created by Jz D on 2022/7/16.
//

#import "AppDelegate.h"

#import "fishhook.h"
#import <dlfcn.h>

#import "queue.h"

#include <string.h>
#include <malloc/malloc.h>



static void (* orig_free)(void*);




struct DSQueue* _unfreeQueue=NULL;
//用来保存自己偷偷保留的内存:1这个队列要线程安全或者自己加锁;2这个队列内部应该尽量少申请和释放堆内存。


int unfreeSize=0;//用来记录我们偷偷保存的内存的大小

#define MAX_STEAL_MEM_SIZE 1024*1024*100//最多存这么多内存，大于这个值就释放一部分

#define MAX_STEAL_MEM_NUM 1024*1024*10//最多保留这么多个指针，再多就释放一部分

#define BATCH_FREE_NUM 100//每次释放的时候释放指针数量


//系统内存警告的时候调用这个函数释放一些内存
void free_some_mem(size_t freeNum){
    size_t count=ds_queue_length(_unfreeQueue);
    freeNum=freeNum>count?count:freeNum;
    for (int i=0; i<freeNum; i++) {
        void* unfreePoint=ds_queue_get(_unfreeQueue);
        size_t memSiziee=malloc_size(unfreePoint);
        __sync_fetch_and_sub(&unfreeSize,memSiziee);
        orig_free(unfreePoint);
    }
}


void safe_free(void* p){
    int unFreeCount=ds_queue_length(_unfreeQueue);
        if (unFreeCount>MAX_STEAL_MEM_NUM*0.9 || unfreeSize>MAX_STEAL_MEM_SIZE) {
            free_some_mem(BATCH_FREE_NUM);
        }else{
            size_t memSiziee=malloc_size(p);
            memset(p, 0x55, memSiziee);
            __sync_fetch_and_add(&unfreeSize,memSiziee);
            ds_queue_put(_unfreeQueue, p);
        }
}


void init_safe_free(void){
    _unfreeQueue=ds_queue_create(MAX_STEAL_MEM_NUM);
    rebind_symbols((struct rebinding[1]){{"free", safe_free, (void *)&orig_free}}, 1);
}



@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    free_some_mem(1024*1024);
    
    
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
