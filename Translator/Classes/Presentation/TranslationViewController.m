//
//  TranslationViewController.m
//  Translator
//
//  Created by MS on 13.11.2017.
//  Copyright © 2017 Personal Project. All rights reserved.
//

#import "TranslationViewController.h"
#import "TranslationService.h"
#import "FavoritesViewController.h"
#import "FavoriteTranslation.h"
#import <AVFoundation/AVFoundation.h>

@interface TranslationViewController () <UITextViewDelegate>

@property (weak, nonatomic) IBOutlet UITextView *originalTextView;
@property (weak, nonatomic) IBOutlet UITextView *translatedTextView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;

@property (strong, nonatomic) NSString *originalText;
@property (strong, nonatomic) NSString *translatedText;
@property (weak, nonatomic) IBOutlet UIButton *playPauseButton;

@property (strong, nonatomic) TranslationService *service;
@property (strong, nonatomic) AVSpeechSynthesizer *synthesizer;
@property (nonatomic) BOOL speechPaused;

@end

@implementation TranslationViewController

#pragma mark - Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addHideKeyboardRecognizer];
    self.service =  [[TranslationService alloc] init];
    
    self.synthesizer = [[AVSpeechSynthesizer alloc] init];
    self.synthesizer.delegate = self;
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
    __weak TranslationViewController *weakSelf = self;
    [self.service translateText:originalText success:^(NSString *translation) {
        weakSelf.translatedText = translation;
        [self.activityIndicator stopAnimating];
        [weakSelf reloadData];
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

- (void)reloadData {
    self.originalTextView.text = self.originalText;
    self.translatedTextView.text = self.translatedText;
}

#pragma mark - Text View Delegate

- (void)textViewDidEndEditing:(UITextView *)textView {
    if (textView.text.length > 0) {
        [self translateOriginalText:textView.text];
    }
}

#pragma mark - AVSpeechSynthesizer

-(void)speechSynthesizer:(AVSpeechSynthesizer *)synthesizer didFinishSpeechUtterance:(AVSpeechUtterance *)utterance {
    self.speechPaused = NO;
    [self.playPauseButton setSelected:NO];
    NSLog(@"Playback finished");
}


#pragma mark - Actions

- (IBAction)favoriteButtonTapped:(id)sender {
    [self.service saveTranslationWithOriginalText:self.originalText
                                   translatedText:self.translatedText];
}

- (IBAction)playPauseButtonTapped:(UIButton *)sender {
    if (self.speechPaused == NO) {
        [self.playPauseButton setSelected:YES];
        [self.synthesizer continueSpeaking];
        self.speechPaused = YES;
    } else {
        [self.playPauseButton setSelected:NO];
        self.speechPaused = NO;
        [self.synthesizer pauseSpeakingAtBoundary:AVSpeechBoundaryImmediate];
    }
    if (self.synthesizer.speaking == NO) {
        AVSpeechUtterance *utterance = [[AVSpeechUtterance alloc] initWithString:self.translatedText];
        utterance.voice = [AVSpeechSynthesisVoice voiceWithLanguage:@"en-au"];
        [self.synthesizer speakUtterance:utterance];
    }
}

#pragma mark - Navigation

- (IBAction)returnFromFavorites:(UIStoryboardSegue *)segue {
    if ([segue.identifier isEqualToString:@"SegueFromFavoritesToTranslation"]) {
        FavoritesViewController *sourceVC = (FavoritesViewController *)segue.sourceViewController;
        FavoriteTranslation *selectedTranslation = sourceVC.selectedTranslation;
        self.originalText = selectedTranslation.originalText;
        self.translatedText = selectedTranslation.translatedText;
        [self reloadData];
    }
}

@end
