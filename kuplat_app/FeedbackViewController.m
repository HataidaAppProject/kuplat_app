//
//  FeedbackViewController.m
//  kuplat_app
//
//  Created by 青野和巳 on 2014/11/20.
//  Copyright (c) 2014年 Wakabayashi.Lab. All rights reserved.
//

#import "FeedbackViewController.h"

@interface FeedbackViewController ()

@end

@implementation FeedbackViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    /*
    CTFeedbackViewController *feedbackViewController = [CTFeedbackViewController controllerWithTopics:CTFeedbackViewController.defaultTopics localizedTopics:CTFeedbackViewController.defaultLocalizedTopics];
    feedbackViewController.toRecipients = @[@"a.wakabayashi2014@gmail.com"];
    feedbackViewController.useHTML = NO;
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:feedbackViewController];
    [self presentViewController:navigationController animated:YES completion:nil];
    */
    CTFeedbackViewController *feedbackViewController = [CTFeedbackViewController controllerWithTopics:CTFeedbackViewController.defaultTopics localizedTopics:CTFeedbackViewController.defaultLocalizedTopics];
    feedbackViewController.toRecipients = @[@"ctfeedback@example.com"];
    feedbackViewController.useHTML = NO;
    [feedbackViewController.view setBackgroundColor:[UIColor redColor]];
    [self.navigationController pushViewController:feedbackViewController animated:YES];
    // Do any additional setup after loading the view.
    NSLog(@"test");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
