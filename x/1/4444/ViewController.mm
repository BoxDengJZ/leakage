//
//  ViewController.m
//  4444
//
//  Created by Jz D on 2022/7/16.
//

#import "ViewController.h"



#include <stdio.h>


#include <iostream>
using namespace std;


void dooo(void){
    
    int* p1 = (int*)malloc(40);//分配了10个int类型的内存
    
    for(int i = 0;i < 10;i++)
    {
        *(p1 + i) = i;
    }
    free(p1);
    for(int i = 0;i < 10;i++)
    {
         //看野指针的效果
        cout << *(p1 + i) << endl;
    }
    cout << "end ... " << endl;
}


@interface A : NSObject

@property (nonatomic, assign) int name;
@end


@implementation A


@end




@interface ViewController ()
@property (nonatomic, strong) A * one;
@property (nonatomic, strong) A * two;
@property (nonatomic, strong) A * three;
@property (nonatomic, strong) NSMutableArray * arr;



@end

@implementation ViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    
    
     

    
    
    self.one = [[A alloc] init];
    self.one.name = 11;
//    wildPtr = &_one;
    self.two = [[A alloc] init];
    self.two.name = 1111;
    self.three = [[A alloc] init];
    self.three.name = 111111;
    [self.arr addObject: self.one];
    [self.arr addObject: self.two];
    [self.arr addObject: self.three];
    
}

- (IBAction)tap:(id)sender {
    dooo();
}


- (IBAction)secondTap:(id)sender {
  //  NSLog(@"%@", wildPtr);
}

@end
