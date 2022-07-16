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
    // 分配 10 个 int 类型的内存
    int* p1 = (int*)malloc(40);
    
    for(int i = 0;i < 10;i++){
        *(p1 + i) = i;
    }
    free(p1);
    for(int i = 0;i < 10;i++){
        //看野指针的效果
       cout << *(p1 + i) << endl;
    }
    cout << "end ... " << endl;
}





@interface ViewController ()


@end

@implementation ViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    
    

    
}

- (IBAction)tap:(id)sender {
    dooo();
}


@end
