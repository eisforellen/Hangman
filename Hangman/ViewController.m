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
@property (weak, nonatomic) IBOutlet UILabel *guessCountLabel;
@property int guessCounter;

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
    
    // Guess Counter - set to 10
    self.guessCounter = 10;
    self.guessCountLabel.text = [NSString stringWithFormat: @"Guesses Remaining: %d", self.guessCounter];
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
    if ([self.mysteryWordLabel.text isEqualToString:_mysteryWord]){
        [self winnerAlert];
    }
    else if (_guessCounter == 0){
        [self gameOverAlert];
    } else {
    [self updateGuessCount];
    }
}

-(void)updateGuessCount{
    self.guessCounter --;
    self.guessCountLabel.text = [NSString stringWithFormat: @"Guesses Remaining: %d", self.guessCounter];
}

// Alert pops up after user has guessed 10 times. If you click cancel the alert goes away and nothing happens. If you click restart the setupUI is called.
-(void)gameOverAlert{
    UIAlertController *alert = [UIAlertController
                                alertControllerWithTitle:@"Game Over!"
                                message:[NSString stringWithFormat: @"The word was %@", _mysteryWord]
                                preferredStyle:UIAlertControllerStyleAlert];

    UIAlertAction* restart = [UIAlertAction
                         actionWithTitle:@"Restart"
                         style:UIAlertActionStyleDefault
                         handler:^(UIAlertAction * action)
                         {
                             [self setupUI];
                             NSLog(@"Restart worked");
                             [alert dismissViewControllerAnimated:YES completion:nil];
                             
                         }];
//    UIAlertAction* cancel = [UIAlertAction
//                             actionWithTitle:@"Cancel"
//                             style:UIAlertActionStyleDefault
//                             handler:^(UIAlertAction * action)
//                             {
//                                 [alert dismissViewControllerAnimated:YES completion:nil];
//                                 
//                             }];
    
    [alert addAction:restart];
//    [alert addAction:cancel];
    [self presentViewController:alert animated:YES completion:nil];
}
-(void)winnerAlert{
    UIAlertController *alert = [UIAlertController
                                alertControllerWithTitle:@"You won!"
                                message:[NSString stringWithFormat: @"You figured out the word was %@", _mysteryWord]
                                preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* restart = [UIAlertAction
                              actionWithTitle:@"Restart"
                              style:UIAlertActionStyleDefault
                              handler:^(UIAlertAction * action)
                              {
                                  [self setupUI];
                                  NSLog(@"Restart worked");
                                  [alert dismissViewControllerAnimated:YES completion:nil];
                                  
                              }];

    [alert addAction:restart];
    [self presentViewController:alert animated:YES completion:nil];
}

@end
