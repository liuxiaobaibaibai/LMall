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
    UIWebViewDelegate
>

@end

@implementation lwPartnerVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self loadVC];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBarHidden = NO;
    self.title = @"成为合伙人";
}

- (void)loadVC{
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"partnerVC" withExtension:@"html" subdirectory:@"partner"];
    UIWebView *myWebView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, lW, lH)];
    [myWebView loadRequest:[NSURLRequest requestWithURL:url]];
    myWebView.delegate = self;
    [self.view addSubview:myWebView];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    
}

- (void)webViewDidFinishLoad:(UIWebView *)webView{
    JSContext *context = [webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    NSMutableArray *argsArray = [NSMutableArray array];
    context[@"payment"] = ^(){
        NSArray *args = [JSContext currentArguments];
        for (JSValue *jsVal in args) {
            [argsArray addObject:jsVal];
        }
        NSError *error;
        NSData *data = [[NSString stringWithFormat:@"%@",argsArray[0]] dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary *rootDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
        
        NSString *price = [NSString stringWithFormat:@"%@",rootDict[@"price"]];
        NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
        [user setObject:rootDict forKey:@"order"];
        [user synchronize];
        
        price = [NSString stringWithFormat:@"%d",[price intValue]*100];
        // 调用支付
        [self startPay:price];
    };
}

- (void)webViewDidStartLoad:(UIWebView *)webView{
    
}

@end
