//
//  FavoritesViewController.m
//  Translator
//
//  Created by MS on 13.11.2017.
//  Copyright © 2017 Personal Project. All rights reserved.
//

#import "FavoritesViewController.h"
#import <Realm.h>
#import "FavoriteTranslation.h"
#import "TranslationService.h"

@interface FavoritesViewController () <UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) RLMResults *favorites;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) TranslationService *service;

@end

@implementation FavoritesViewController

#pragma mark - Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.service = [[TranslationService alloc] init];
    
    [self loadData];
}

- (void)loadData {
    self.favorites = [self.service getAllFavorites];
    [self.tableView reloadData];
}
#pragma mark - Methods

#pragma mark - Table View

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.favorites count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *reuseIdentifier = @"FavoriteCellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    
    if (cell == nil) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:reuseIdentifier];
    }
    
    FavoriteTranslation *translation = [self.favorites objectAtIndex:indexPath.row];
    cell.textLabel.text = translation.originalText;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    self.selectedTranslation = [self.favorites objectAtIndex:indexPath.row];
    [self performSegueWithIdentifier:@"SegueFromFavoritesToTranslation" sender:self];
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        FavoriteTranslation *translation = [self.favorites objectAtIndex:indexPath.row];
        [self.service deleteTranslation:translation];
        [self loadData];
    }
}

@end
