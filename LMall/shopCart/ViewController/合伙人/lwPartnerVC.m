//
//  lwPartnerVC.m
//  shopCart
//
//  Created by lw on 16/4/18.
//  Copyright © 2016年 lw. All rights reserved.
//

#import "lwPartnerVC.h"
#import <JavaScriptCore/JavaScriptCore.h>


@interface lwPartnerVC ()

<
    UIWebViewDelegate,
    MBProgressHUDDelegate
>

{
    UIWebView *myWebView;
    MBProgressHUD *HUD;
}

@end

@implementation lwPartnerVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadVC];
}

/**
 *  页面将要加载的时候
 *  @param  animated
 */
- (void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBarHidden = NO;
    self.title = @"成为合伙人";
}

/**
 *  加载视图
 */
- (void)loadVC{
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"beacomePartnerVC" withExtension:@"html" subdirectory:@"partner"];
    myWebView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, lW, lH)];
    [myWebView loadRequest:[NSURLRequest requestWithURL:url]];
    myWebView.delegate = self;
    [self.view addSubview:myWebView];
}

/**
 *  加载数据
 */
- (void)loadData{
    NSString *param = @"123456";
    [myWebView stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"initDataSource(%@)",param]];
}

/**
 *  页面开始加载的回调
 *  @param  webView 回调的网页
 */
- (void)webViewDidStartLoad:(UIWebView *)webView{
    
}

/**
 *  网页加载完成
 *  @param  webView 回调的网页
 */
- (void)webViewDidFinishLoad:(UIWebView *)webView{
    JSContext *context = [webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    context[@"payment"] = ^(){
        NSMutableArray *argsArray = [NSMutableArray array];
        NSArray *args = [JSContext currentArguments];
        for (JSValue *jsVal in args) {
            [argsArray addObject:jsVal];
        }
        NSError *error;
        NSData *data = [[NSString stringWithFormat:@"%@",argsArray[0]] dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary *rootDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
        NSString *payType = [NSString stringWithFormat:@"%@",rootDict[@"payType"]];
        NSString *partnerType = rootDict[@"partnerType"];
        [self startPay:partnerType Type:payType];
    };
    
    
    context[@"showToast"] = ^(){
        NSMutableArray *argsArray = [NSMutableArray array];
        NSArray *args = [JSContext currentArguments];
        for (JSValue *jsVal in args) {
            [argsArray addObject:jsVal];
        }
        NSData *data = [[NSString stringWithFormat:@"%@",argsArray[0]] dataUsingEncoding:NSUTF8StringEncoding];
       
        NSString *msg = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        [self showToast:msg];
    };
}

/**
 *  加载失败的页面
 *  @param  webView 当前页面视图
 *  @param  error   回调的错误信息
 */
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    
}


/**
 *  开始支付
 *  @param  price       价格
 *  @param  partnerType 合伙人类型
 */
- (void)startPay:(NSString *)partnerType Type:(NSString *)payType{
    // 前往支付
//    [lwPayCommon pay:lwPayTypeAlipay Order:gen_guid()];
    [lwPayCommon pay:[payType intValue] Price:partnerType];
}


- (void)showToast:(NSString *)msg{
    dispatch_async(dispatch_get_main_queue(), ^{
        HUD = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
        [[[UIApplication sharedApplication] keyWindow] addSubview:HUD];
        HUD.mode = MBProgressHUDModeCustomView;
        
        HUD.delegate = self;
        HUD.labelText = msg;
        
        [HUD show:YES];
        [HUD hide:YES afterDelay:1.5];
    });
}

- (void)dealloc{
    [self removeHUD];
}

- (void)hudWasHidden:(MBProgressHUD *)hud {
    // Remove HUD from screen when the HUD was hidded
    [HUD removeFromSuperview];
    HUD = nil;
}

- (void)removeHUD{
    [HUD removeFromSuperview];
}


@end
