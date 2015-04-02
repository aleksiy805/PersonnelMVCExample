//
//  PersonnelViewController.m
//  PersonnelMVCExample
//
//  Created by Alexey Nikolaev on 1/17/15.
//  Copyright (c) 2015 Alexey Nikolaev. All rights reserved.
//

#import "PersonnelViewController.h"
#import "PersonnelView.h"
#import "EmployerTableViewCell.h"
#import "EmployeeTableViewCell.h"
#import "HumanInformationViewController.h"
#import "HumansModel.h"

static NSString * const kPersonnelEmployersCommonName  = @"Employers";
static NSString * const kPersonnelEmployeesCommonName  = @"Employees";

@interface PersonnelViewController () <UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) HumansModel  *humansModel;
@end

@implementation PersonnelViewController

@dynamic selfView;

#pragma mark -
#pragma mark Initializations And Deallocations

#pragma mark -
#pragma mark View's Lifecircle

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    UITableView *tableView = self.selfView.tableView;
    [tableView deselectRowAtIndexPath:[tableView indexPathForSelectedRow]
                             animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    HumansModel *model = [HumansModel new];
    
    self.humansModel = model;
    [model generateModels];
}

#pragma mark -
#pragma mark Interface Handlers

- (IBAction)onRefresh:(id)sender {
    [self.humansModel generateModels];
    [self.selfView.tableView reloadData];
}

- (IBAction)onEdit:(id)sender {
    [self.selfView.tableView setEditing:!self.selfView.tableView.isEditing animated:YES];
}

#pragma mark -
#pragma mark Accessors
// if you will inherit from viewController this @dynamic getter will allow obtain base view properties and methods
- (PersonnelView *)selfView {
    if ([self.view isKindOfClass:[PersonnelView class]]) {
        return (PersonnelView *)self.view;
    }
    
    return nil;
}

#pragma mark -
#pragma mark Public Methods

/*
Did use didSelectRowAtIndexPath: instead of prepareForSegue: because of strange crash
when HumanInformationViewController is displayed on the screen

 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    HumanInformationViewController *controller = segue.destinationViewController;
    HumanModel *model = [self modelByIndexPath:[self.selfView.tableView indexPathForCell:sender]];
    
    controller.humanModel = model;
    [self.navigationController pushViewController:controller animated:YES];
}*/

#pragma mark -
#pragma mark Private Methods

- (HumanModel *)modelByIndexPath:(NSIndexPath *)indexPath {
    HumansModel *humansModel = self.humansModel;
    NSUInteger section = indexPath.section;
    NSUInteger row = indexPath.row;
    NSArray *array = nil;
    
    if (0 == section) {
        array = humansModel.emploers;
    } else {
        array = humansModel.emploees;
    }
    
    return [array objectAtIndex:row];
}

#pragma mark -
#pragma mark UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    HumansModel *humansModel = self.humansModel;
    
    if (0 == section) {
        return [humansModel.emploers count];
    }
    
    return [humansModel.emploees count];
}

- (NSString *)tableView:(UITableView *)tableView
titleForHeaderInSection:(NSInteger)section
{
    if (0 == section) {
        return kPersonnelEmployersCommonName;
    }
    
    return kPersonnelEmployeesCommonName;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSUInteger section = indexPath.section;
    Class class = nil;
    
    if (0 == section) {
        class = [EmployerTableViewCell class];
    } else {
        class = [EmployeeTableViewCell class];
    }
    NSString *classString = NSStringFromClass(class);
    HumanViewCell *cell = [tableView dequeueReusableCellWithIdentifier:classString];
    HumanModel *humanModel = [self modelByIndexPath:indexPath];
    
    if (0 == section) {
        EmployerTableViewCell *emploerCell = (EmployerTableViewCell *)cell;
        emploerCell.positionLabel.text = humanModel.position;
    }
    cell.nameLabel.text = humanModel.firstName;
    cell.model = humanModel;
    
    cell.showsReorderControl = NO;
    
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView
canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (1 == indexPath.section) {
        return YES;
    }
    
    return NO;
}

- (void)tableView:(UITableView *)tableView
commitEditingStyle:(UITableViewCellEditingStyle)editingStyle
forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        NSUInteger index = indexPath.row;
        HumansModel *humansModel = self.humansModel;
        
        if (0 == indexPath.section) {
            [humansModel removeEmployerAtIndex:index];
        } else {
            [humansModel removeEmploeeAtIndex:index];
        }
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}

- (void)tableView:(UITableView *)tableView
moveRowAtIndexPath:(NSIndexPath *)fromIndexPath
      toIndexPath:(NSIndexPath *)toIndexPath
{
    HumansModel *humansModel = self.humansModel;
    
    if (0 == fromIndexPath.section) {
        [humansModel replaceEmployerPositionFromIndex:fromIndexPath.row
                                              toIndex:toIndexPath.row];
    } else {
        [humansModel replaceEmploeePositionFromIndex:fromIndexPath.row
                                             toIndex:toIndexPath.row];
    }
}

#pragma mark -
#pragma mark UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
    HumanInformationViewController *controller = [storyboard instantiateViewControllerWithIdentifier:@"HumanInformationViewController"];
    HumanModel *model = [self modelByIndexPath:indexPath];
    
    controller.humanModel = model;
    [self.navigationController pushViewController:controller animated:YES];
}

- (void)tableView:(UITableView *)tableView
didEndDisplayingCell:(UITableViewCell *)cell
forRowAtIndexPath:(NSIndexPath *)indexPath
{
    HumanViewCell *emploeesCell = (HumanViewCell *)cell;
    emploeesCell.model = nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (0 == indexPath.section) {
        return 70.f;
    }
    
    return 44.f;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView
           editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (0 == indexPath.section) {
        return UITableViewCellEditingStyleNone;
    }
    
    return UITableViewCellEditingStyleDelete;
}

- (BOOL)tableView:(UITableView *)tableView
canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (NSIndexPath *)tableView:(UITableView *)tableView
targetIndexPathForMoveFromRowAtIndexPath:(NSIndexPath *)sourceIndexPath
       toProposedIndexPath:(NSIndexPath *)proposedDestinationIndexPath
{
    if (sourceIndexPath.section != proposedDestinationIndexPath.section) {
        return sourceIndexPath;
    }
    
    return proposedDestinationIndexPath;
}

@end
