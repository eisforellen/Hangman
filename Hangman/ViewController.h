//
//  ViewController.h
//  Hangman
//
//  Created by Ellen Mey on 5/31/16.
//  Copyright © 2016 Ellen Mey. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property(strong, nonatomic)NSArray *words;
@property(strong, nonatomic)NSString *mysteryWord;

- (void)checkForMatchAndReplace:(NSString *)userInput;
- (void)setupUI;
@end

