//
//  ViewController.m
//  MySafari
//
//  Created by Bradley Walker on 10/1/14.
//  Copyright (c) 2014 BlackSummerVentures. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UIWebViewDelegate, UITextFieldDelegate>
@property IBOutlet UIWebView *webView;
@property (strong, nonatomic) IBOutlet UITextField *urlTextField;
@property (weak, nonatomic) IBOutlet UIButton *backButton;
@property (weak, nonatomic) IBOutlet UIButton *forwardButton;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)onBackButtonPressed:(id)sender {
    [self.webView goBack];
    if ([self.webView canGoBack]) {
        self.backButton.enabled = YES;
    } else {
        self.backButton.enabled = NO;
    }
}


- (IBAction)onForwardButtonPressed:(id)sender {
    [self.webView goForward];
    if ([self.webView canGoForward]) {
        self.forwardButton.enabled = YES;
    } else {
        self.forwardButton.enabled = NO;
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    NSString *urlString = self.urlTextField.text;
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:urlRequest];
    
    if ([self.urlTextField.text containsString:@"http://"]) {
        return YES;
    } else {
        return NO;
    }
}

- (void)webViewDidStartLoad:(UIWebView *)webView {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}
- (IBAction)onStopLoadingButtonPressed:(id)sender {
    [self.webView stopLoading];
}
- (IBAction)onReloadButtonPressed:(id)sender {
    [self.webView reload];
}


@end
