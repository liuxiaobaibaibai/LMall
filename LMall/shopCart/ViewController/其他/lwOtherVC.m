//
//  lwOtherVC.m
//  shopCart
//
//  Created by lw on 16/4/29.
//  Copyright © 2016年 lw. All rights reserved.
//

#import "lwOtherVC.h"

#import "lwSliderView.h"



@interface lwOtherVC ()
<
    NSStreamDelegate
>

{
    NSInputStream *inputStream;
    NSOutputStream *outputStream;
}

@end

@implementation lwOtherVC

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)stream:(NSStream *)aStream handleEvent:(NSStreamEvent)eventCode{
    switch (eventCode) {
        case <#constant#>:
            <#statements#>
            break;
            
        default:
            break;
    }
}



@end
