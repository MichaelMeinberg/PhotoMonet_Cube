//
//  iCA_WebPage_ViewController.m
//  PhotoMonet Cube
//
//  Created by Michael on 12/18/14.
//  Copyright (c) 2014 Michael. All rights reserved.
//

#import "iCA_WebPage_ViewController.h"

@interface iCA_WebPage_ViewController ()
@property (weak, nonatomic) IBOutlet UIWebView *webPage;
@end

@implementation iCA_WebPage_ViewController





- (void)viewDidLoad
{
    [super viewDidLoad];
    NSURL *url = [NSURL URLWithString:@"http://www.iChoiceAppDesign.com"];
    NSURLRequest *req = [NSURLRequest requestWithURL:url];
    [self.webPage loadRequest:req];
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}





@end
