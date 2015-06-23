//
//  MainMenuViewController.m
//  ErrorCrawl
//
//  Created by Vineet Tiwari on 2015-06-21.
//  Copyright (c) 2015 vinny.co. All rights reserved.
//

#import "MenuViewController.h"
#import "GameViewController.h"

@interface MenuViewController ()

@property (weak, nonatomic) IBOutlet UIButton *playButton;

@end

@implementation MenuViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
  self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
  if (self) {
    // Custom initialization
  }
  return self;
}

- (void)viewDidLoad {
  [super viewDidLoad];

//   Start background music
}

- (IBAction)playBottonTapped:(UIButton *)sender {

  [self performSegueWithIdentifier:@"ToGameView" sender:sender];
}

@end
