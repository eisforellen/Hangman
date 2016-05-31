//
//  ViewController.m
//  Hangman
//
//  Created by Ellen Mey on 5/31/16.
//  Copyright © 2016 Ellen Mey. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *mysteryWordLabel;
@property (weak, nonatomic) IBOutlet UITextField *userInputTextField;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)guessButtonPressed:(UIButton *)sender {
}

@end
