//
//  LevelSelectViewController.m
//  ErrorCrawl
//
//  Created by Vineet Tiwari on 2015-06-21.
//  Copyright (c) 2015 vinny.co. All rights reserved.
//

#import "LevelSelectViewController.h"
#import "GameViewController.h"

@interface LevelSelectViewController ()

@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;
@property (weak, nonatomic) IBOutlet UIScrollView *scroller;
@property (weak, nonatomic) IBOutlet UIButton *level1Button;
@property (weak, nonatomic) IBOutlet UIButton *level2Button;

@end

@implementation LevelSelectViewController

- (void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];

  CGFloat screenWidth = self.view.bounds.size.width;
  self.scroller.contentSize = CGSizeMake(screenWidth * 3, self.view.bounds.size.height);

  // Place the first level in the center of the screen
  CGRect r = self.level1Button.frame;
  CGFloat x = (screenWidth - r.size.width) * 0.5;
  r.origin.x = x;
  self.level1Button.frame = r;

  // Set the buttons apart by a screen's width
  r = self.level2Button.frame;
  x += screenWidth;
  r.origin.x = x;
  self.level2Button.frame = r;

  r = self.level2Button.frame;
  x += screenWidth;
  r.origin.x = x;
  self.level2Button.frame = r;

  // Enable pagination
  self.scroller.pagingEnabled = YES;

}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
  self.pageControl.currentPage = (NSInteger)(scrollView.contentOffset.x / self.view.frame.size.width + 0.5);
  //NSLog(@"current page %d", self.pageControl.currentPage);
}

- (IBAction)backToMain:(id)sender {

  [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)toGameView:(id)sender {

  [self performSegueWithIdentifier:@"ToGameView" sender:sender];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
  if ([segue.identifier isEqualToString:@"ToGameView"]) {

    GameViewController *gvc = segue.destinationViewController;
    UIButton *button = (UIButton *)sender;
    NSString *levelText = button.titleLabel.text;
    gvc.currentLevel = [[levelText substringFromIndex:5] intValue];
  }
}

@end





























