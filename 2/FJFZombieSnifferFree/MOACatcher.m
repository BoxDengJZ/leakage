
//
//  MOACatcher.m
//  MOAZombieSniffer
//
//  Created by fjf on 2018/7/30.
//  Copyright © 2018年 fjf. All rights reserved.
//


#include <objc/runtime.h>
#import "MOACatcher.h"

@implementation MOACatcher
- (BOOL)respondsToSelector: (SEL)aSelector
{
    NSLog(@"0_1");
    return [self.originClass instancesRespondToSelector:aSelector];
}

- (NSMethodSignature *)methodSignatureForSelector: (SEL)sel
{
    NSLog(@"0_2");
    return [self.originClass instanceMethodSignatureForSelector:sel];
}

- (void)forwardInvocation: (NSInvocation *)invocation
{
    NSLog(@"0_3");
    [self _throwMessageSentExceptionWithSelector: invocation.selector];
}


#define MOAZombieThrowMesssageSentException() [self _throwMessageSentExceptionWithSelector: _cmd]
- (Class)class
{
    NSLog(@"0_4");
    MOAZombieThrowMesssageSentException();
    return nil;
}

- (BOOL)isEqual:(id)object
{
    NSLog(@"0_5");
    MOAZombieThrowMesssageSentException();
    return NO;
}

- (NSUInteger)hash
{
    NSLog(@"0_6");
    MOAZombieThrowMesssageSentException();
    return 0;
}

- (id)self
{
    NSLog(@"0_7");
    MOAZombieThrowMesssageSentException();
    return nil;
}

- (BOOL)isKindOfClass:(Class)aClass
{
    NSLog(@"0_8");
    MOAZombieThrowMesssageSentException();
    return NO;
}

- (BOOL)isMemberOfClass:(Class)aClass
{
    NSLog(@"0_9");
    MOAZombieThrowMesssageSentException();
    return NO;
}

- (BOOL)conformsToProtocol:(Protocol *)aProtocol
{
    NSLog(@"0_10");
    MOAZombieThrowMesssageSentException();
    return NO;
}

- (BOOL)isProxy
{
    NSLog(@"0_11");
    MOAZombieThrowMesssageSentException();
    
    return NO;
}

- (id)retain
{
    NSLog(@"0_12");
    MOAZombieThrowMesssageSentException();
    return nil;
}

- (oneway void)release
{
    NSLog(@"0_13");
    MOAZombieThrowMesssageSentException();
}

- (id)autorelease
{
    NSLog(@"0_14");
    MOAZombieThrowMesssageSentException();
    return nil;
}

- (void)dealloc
{
    NSLog(@"0_15");
    MOAZombieThrowMesssageSentException();
    [super dealloc];
}

- (NSUInteger)retainCount
{
    NSLog(@"0_16");
    MOAZombieThrowMesssageSentException();
    return 0;
}

- (NSZone *)zone
{
    NSLog(@"0_17");
    MOAZombieThrowMesssageSentException();
    return nil;
}

- (NSString *)description
{
    NSLog(@"0_18");
    MOAZombieThrowMesssageSentException();
    return nil;
}


#pragma mark - Private
- (void)_throwMessageSentExceptionWithSelector: (SEL)selector
{
    @throw [NSException exceptionWithName:NSInternalInconsistencyException reason:[NSString stringWithFormat:@"(-[%@ %@]) was sent to a zombie object at address: %p", NSStringFromClass(self.originClass), NSStringFromSelector(selector), self] userInfo:nil];
}

@end
