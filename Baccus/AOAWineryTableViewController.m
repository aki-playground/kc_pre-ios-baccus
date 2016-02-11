//
//  AOAWineryTableViewController.m
//  Baccus
//
//  Created by Akixe on 8/2/16.
//  Copyright © 2016 Akixe. All rights reserved.
//

#import "AOAWineryTableViewController.h"
#import "AOAWineViewController.h"

@interface AOAWineryTableViewController ()

@end

@implementation AOAWineryTableViewController


-(id) initWithModel: (AOAWineryModel *) aModel
              style: (UITableViewStyle) aStyle{
    if(self = [super initWithStyle: aStyle]){
        self.model = aModel;
        self.title = @"Baccus";
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section {

    if (section == RED_WINE_SECTION){
        return [self.model redWineCount];
    }else if(section == WHITE_WINE_SECTION){
        return self.model.whiteWineCount;
    }else{
        return [self.model otherWineCount];
    }
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed: 0.5
                                                                           green: 0
                                                                            blue: 0.13
                                                                           alpha: 1];
}

- (NSString *)      tableView:(UITableView *)tableView
      titleForHeaderInSection:(NSInteger)section {
    if(section == RED_WINE_SECTION){
        return @"Red Wines";
    } else if (section == WHITE_WINE_SECTION) {
        return @"White Wines";
    } else {
        return @"Other Wines";
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: @"reuseIdentifier"];
    if(cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle: UITableViewCellStyleSubtitle
                                      reuseIdentifier: @"reuseIdentifier"];
    }
    
    AOAWineModel *wine = nil;
    
    if (indexPath.section == RED_WINE_SECTION){
        wine = [self.model redWineAtIndex:indexPath.row];
    } else if (indexPath.section == WHITE_WINE_SECTION){
        wine = [self.model whiteWineAtIndex:indexPath.row];
    } else {
        wine = [self.model otherWineAtIndex:indexPath.row];
    }
    cell.imageView.image = wine.photo;
    cell.textLabel.text = wine.name;
    cell.detailTextLabel.text = wine.wineCompanyName;
    
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

-(void)         tableView:(UITableView *)tableView
  didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    AOAWineModel *wine = nil;
    
    if(indexPath.section == RED_WINE_SECTION){
        wine = [self.model redWineAtIndex:indexPath.row];
    } else if (indexPath.section == WHITE_WINE_SECTION){
        wine = [self.model whiteWineAtIndex:indexPath.row];
    } else {
        wine = [self.model otherWineAtIndex:indexPath.row];
    }
    
    //Delegado

    [self.delegate wineryTableViewController:self
                             didSelectedWine:wine];
    
    
    //Notificación
    NSNotification *n = [NSNotification notificationWithName:NEW_WINE_NOTIFICATION_NAME
                                                      object: self
                                                    userInfo:@{WINE_KEY: wine}];
    
    [[NSNotificationCenter defaultCenter] postNotification:n];
    
    [self saveLastSelectedWineSection:indexPath.section
                                  row:indexPath.row];
}

#pragma mark - User Defaults
-(NSDictionary *) setDefaults
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSDictionary *defaultWineCoords = @{SECTION_KEY:@(RED_WINE_SECTION), ROW_KEY: @0};
    
    [defaults setObject:defaultWineCoords
                 forKey:LAST_WINE_KEY];
    
    [defaults synchronize];
    
    return defaultWineCoords;
}

-(void) saveLastSelectedWineSection:(NSUInteger)section
                                row:(NSUInteger)row
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSDictionary *wineCoords = @{ SECTION_KEY : @(section),
                                  ROW_KEY :@(row)};
    [defaults setObject:wineCoords
                 forKey:LAST_WINE_KEY];
    
    [defaults synchronize];
}

-(AOAWineModel *) wineForIndexPath:(NSIndexPath *)indexPath
{
    AOAWineModel *wine = nil;
    
    if(indexPath.section == RED_WINE_SECTION){
        wine = [self.model redWineAtIndex:indexPath.row];
    } else if (indexPath.section == WHITE_WINE_SECTION){
        wine = [self.model whiteWineAtIndex:indexPath.row];
    } else {
        wine = [self.model otherWineAtIndex:indexPath.row];
    }
    
    return wine;
}

-(AOAWineModel *) lastSelectedWine
{
    NSIndexPath *indexPath = nil;
    NSDictionary *coords = nil;
    
    coords = [[NSUserDefaults standardUserDefaults] objectForKey:LAST_WINE_KEY];
    if (coords == nil){
        coords = [self setDefaults];
    }
    
    indexPath = [NSIndexPath indexPathForRow:[[coords objectForKey:ROW_KEY] integerValue]
                                   inSection:[[coords objectForKey:SECTION_KEY] integerValue]];
    
    return [self wineForIndexPath:indexPath];
}

@end
