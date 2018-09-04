//
//  ViewController.m
//  NENSlideMenuDemo
//
//  Created by weuse_hao on 2018/9/4.
//  Copyright © 2018 weuse_hao. All rights reserved.
//

#import "ViewController.h"
#import <NENSlideManager.h>
@interface ViewController ()
@property (nonatomic, strong) NENSlideManager *slideManager;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    UIViewController *destinationVC = segue.destinationViewController;
    NENSlideManager *slideManager = [[NENSlideManager alloc] initWithMenuController:destinationVC mainController:self];
    // 确保它不是临时变量
    self.slideManager = slideManager;
    slideManager.targetEdge = UIRectEdgeLeft;
    slideManager.MenuWidth = 270;
}

- (IBAction)unwindSegue:(UIStoryboardSegue *)sender{
    NSLog(@"unwindSegue %@", sender);
}

@end
