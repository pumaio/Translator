//
//  TranslationViewController.m
//  Translator
//
//  Created by MS on 13.11.2017.
//  Copyright © 2017 Personal Project. All rights reserved.
//

#import "TranslationViewController.h"
#import "TranslationService.h"

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

#pragma mark - Keyboard

- (void)addHideKeyboardRecognizer {
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard)];
    [self.view addGestureRecognizer:tap];
}

-(void)dismissKeyboard {
    [self.originalTextView resignFirstResponder];
}

#pragma mark - Methods

- (void)translateOriginalText:(NSString *)originalText {
    self.translatedTextView.text = [NSString stringWithFormat:@"Переведено: %@", originalText];
}

#pragma mark - Text View Delegate

- (void)textViewDidEndEditing:(UITextView *)textView {
    TranslationService *service = [[TranslationService alloc] init];
    [service translateText:@"i'm belive i'm file" success:^(NSString *translation) {
        
    } failure:^(NSString *errorMessage) {
        
    }];
}

#pragma mark - Actions

- (IBAction)favoriteButtonTapped:(id)sender {
}



@end
