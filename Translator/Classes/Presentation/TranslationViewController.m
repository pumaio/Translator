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

@property (strong, nonatomic) NSString *originalText;
@property (strong, nonatomic) NSString *translatedText;

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
    self.originalText = originalText;
    [self.activityIndicator startAnimating];
    TranslationService *service = [[TranslationService alloc] init];
    __weak TranslationViewController *weakSelf = self;
    [service translateText:originalText success:^(NSString *translation) {
        weakSelf.translatedText = translation;
        [self.activityIndicator stopAnimating];
        [weakSelf showTranslation];
    } failure:^(NSString *errorMessage) {
        [self.activityIndicator stopAnimating];
        [self showErrorWithMessage:errorMessage];
    }];
}

- (void)showErrorWithMessage:(NSString *)message {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Ошибка" message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction* ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
    [alertController addAction:ok];
    [self presentViewController:alertController animated:YES completion:nil];
}

- (void)showTranslation {
    self.translatedTextView.text = self.translatedText;
}

#pragma mark - Text View Delegate

- (void)textViewDidEndEditing:(UITextView *)textView {
    [self translateOriginalText:textView.text];
}

#pragma mark - Actions

- (IBAction)favoriteButtonTapped:(id)sender {
}



@end
