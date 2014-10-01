//
//  ViewController.m
//  MySafari
//
//  Created by Bradley Walker on 10/1/14.
//  Copyright (c) 2014 BlackSummerVentures. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UIWebViewDelegate, UITextFieldDelegate, UIAlertViewDelegate, UIScrollViewDelegate>
@property IBOutlet UIWebView *webView;
@property (strong, nonatomic) IBOutlet UITextField *urlTextField;
@property (weak, nonatomic) IBOutlet UIButton *backButton;
@property (weak, nonatomic) IBOutlet UIButton *forwardButton;
@property (weak, nonatomic) IBOutlet UINavigationItem *navigationTitle;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.webView.scrollView.delegate = self;
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

- (void) loadPage: (NSString *)urlString {
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:urlRequest];
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {

    if (![textField.text containsString:@"http://"]) {
        NSString *firstHalfOfURL = [textField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
        NSString *http = @"http://";
        self.urlTextField.text = [http stringByAppendingString:firstHalfOfURL];
    }   
    [self loadPage:self.urlTextField.text];
    return YES;
}

- (IBAction)showAlertView:(id)sender {
    UIAlertView *alert = [[UIAlertView alloc] init];
    alert.title = @"Coming Soon";
    [alert addButtonWithTitle:@"Close"];
    [alert show];
}

- (void)webViewDidStartLoad:(UIWebView *)webView {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    self.urlTextField.text = self.webView.request.URL.absoluteString;
    NSString *urlTitleString = [self.webView stringByEvaluatingJavaScriptFromString:@"document.title"];
    self.navigationTitle.title = urlTitleString;
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    CGPoint translation = [scrollView.panGestureRecognizer translationInView:scrollView.superview];
    
    if(translation.y > 0)
    {
        self.urlTextField.alpha = 1;
        NSLog(@"Down %f", translation.y);
    }
    
    if(translation.y < 0)
    {
        self.urlTextField.alpha = 0;
        NSLog(@"Up %f", translation.y);
    }
}

- (IBAction)onStopLoadingButtonPressed:(id)sender {
    [self.webView stopLoading];
}
- (IBAction)onReloadButtonPressed:(id)sender {
    [self.webView reload];
}


@end
