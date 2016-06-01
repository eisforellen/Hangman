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
@property (strong, nonatomic) IBOutlet UILabel *inputErrorLabel;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _inputErrorLabel.text = @"";
    [self setupUI];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)createWordsArray {
    _words = @[@"QUICK", @"TAXES", @"JUMPS", @"ROCKS", @"FANCY",
               @"HIJACK", @"JUMPED", @"QUIVER", @"CHUNKY", @"PAJAMA",
               @"MUFFLED", @"BEJEWEL", @"SQUELCH", @"HAMMOCK", @"JACKETS"];
}

- (void)setMysteryWordLabel {
    NSMutableString *newMysteryWordLabel = [NSMutableString stringWithCapacity:[_mysteryWord length]];
    int i = 0;
    while (i < [_mysteryWord length]) {
        [newMysteryWordLabel appendString:@"_"];
        i++;
    }
    NSLog(@"%@", newMysteryWordLabel);
    _mysteryWordLabel.text = newMysteryWordLabel;
    
}

- (void)setupUI {
    // Create array of words
    [self createWordsArray];
    // Set mystery word
    uint32_t randomIndex = arc4random_uniform((u_int32_t)[_words count]);
    NSLog(@"%d is the index", randomIndex);
    _mysteryWord = [_words objectAtIndex:randomIndex];
    NSLog(@"%@ is the mystery word", _mysteryWord);
    // Set label in UI to have as many underscores as there are letters in mystery word
    [self setMysteryWordLabel];
    // Guess Counter - set to 10
    self.guessCounter = 10;
    self.guessCountLabel.text = [NSString stringWithFormat: @"Guesses Remaining: %d", self.guessCounter];
}


- (NSString *)checkForFormatAndNormalize:(NSString *)userInput {
    NSError *error;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"\[a-zA-z]" options:NSRegularExpressionCaseInsensitive error:&error];
    NSUInteger numberOfMatches = [regex numberOfMatchesInString:userInput options:0 range:NSMakeRange(0, [userInput length])];
    
    if ([userInput length] > 1 || numberOfMatches < 1) {
        _inputErrorLabel.text = @"Invalid input. One letter only";
        return nil;
    } else {
        _inputErrorLabel.text = @"";
        NSString *normalizedString = [userInput uppercaseString];
        return normalizedString;
    }
}

- (void)checkForMatchAndReplace:(NSString *)normalizedInput {
    for (int i = 0; i < [_mysteryWordLabel.text length]; i++) {
        NSString *stringToPotentiallyReplace = [NSString stringWithFormat:@"%c", [_mysteryWord characterAtIndex:i]];
        if ([stringToPotentiallyReplace isEqualToString:normalizedInput]) {
            NSRange range = NSMakeRange(i, 1);
            _mysteryWordLabel.text = [_mysteryWordLabel.text stringByReplacingCharactersInRange:range withString:normalizedInput];
        }
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

- (IBAction)guessButtonPressed:(UIButton *)sender {
    NSString *normalizedString = [self checkForFormatAndNormalize:_userInputTextField.text];
    if (normalizedString != nil) {
        [self checkForMatchAndReplace:normalizedString];
    }
    if ([self.mysteryWordLabel.text isEqualToString:_mysteryWord]){
        [self winnerAlert];
    }
    else if (_guessCounter == 0){
        [self gameOverAlert];
    } else {
        [self updateGuessCount];
    }
}

@end
