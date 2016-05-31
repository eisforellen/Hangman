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
    _mysteryWord = @"ACME";
    [self setupUI];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setupUI {
    NSMutableString *newMysteryWordLabel = [NSMutableString stringWithCapacity:[_mysteryWord length]];
    int i = 0;
    while (i < [_mysteryWord length]) {
        [newMysteryWordLabel appendString:@"_"];
        i++;
    }
    NSLog(@"%@", newMysteryWordLabel);
    _mysteryWordLabel.text = newMysteryWordLabel;
}

- (void)checkForMatchAndReplace:(NSString *)userInput {
    for (int i = 0; i < [_mysteryWordLabel.text length]; i++) {
        NSString *stringToPotentiallyReplace = [NSString stringWithFormat:@"%c", [_mysteryWord characterAtIndex:i]];
        if ([stringToPotentiallyReplace isEqualToString:userInput]) {
            NSRange range = NSMakeRange(i, 1);
            _mysteryWordLabel.text = [_mysteryWordLabel.text stringByReplacingCharactersInRange:range withString:userInput];
        }
    }
}

- (IBAction)guessButtonPressed:(UIButton *)sender {
    [self checkForMatchAndReplace:_userInputTextField.text];
}

@end
