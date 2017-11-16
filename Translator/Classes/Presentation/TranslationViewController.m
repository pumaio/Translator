//
//  TranslationViewController.m
//  Translator
//
//  Created by MS on 13.11.2017.
//  Copyright © 2017 Personal Project. All rights reserved.
//

#import "TranslationViewController.h"

@interface TranslationViewController () <UITextViewDelegate>

@property (weak, nonatomic) IBOutlet UITextView *originalTextView;
@property (weak, nonatomic) IBOutlet UITextView *translatedTextView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;

@end

@implementation TranslationViewController

#pragma mark - Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addHideKeyboardRecognizer];
}

#pragma mark - Methods

- (void)addHideKeyboardRecognizer {
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard)];
    [self.view addGestureRecognizer:tap];
}

-(void)dismissKeyboard {
    [self.originalTextView resignFirstResponder];
}

- (void)translateOriginalText:(NSString *)originalText {
    self.translatedTextView.text = [NSString stringWithFormat:@"Переведено: %@", originalText];
}


#pragma mark - Text View Delegate

- (void)textViewDidEndEditing:(UITextView *)textView {
    [self translateOriginalText:textView.text];
}

#pragma mark - Actions

- (IBAction)favoriteButtonTapped:(id)sender {
}



@end
