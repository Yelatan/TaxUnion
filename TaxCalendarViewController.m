//
//  TaxCalendarViewController.m
//  SidebarMenu
//
//  Created by Bakbergen on 30.06.16.
//  Copyright © 2016 AppCoda. All rights reserved.
//

#import "TaxCalendarViewController.h"
#import "CalendarKit.h"
#import "CKDemoViewController.h"
#import "NSCalendarCategories.h"
#import "NSDate+Components.h"
#import <QuartzCore/QuartzCore.h>

@interface TaxCalendarViewController() <CKCalendarViewDataSource, CKCalendarViewDelegate>

@end

@implementation TaxCalendarViewController

-(void) viewDidLoad{
    [super viewDidLoad];
    
    self.navigationController.navigationItem.title = @"asd";
    // 1. Instantiate a CKCalendarView
    CKCalendarView *calendar = [CKCalendarView new];
    
    // 2. Optionally, set up the datasource and delegates
    [calendar setDelegate:self];
    [calendar setDataSource:self];
    
//     3. Present the calendar
    [[self view] addSubview:calendar];
}

- (NSArray *)calendarView:(CKCalendarView *)calendarView eventsForDate:(NSDate *)date {
    //  An event for the new MBCalendarKit release.
    
    NSMutableArray *eventsList = [NSMutableArray new];
    NSString *title = NSLocalizedString(@"Консалтинг отчет 2016.07.01", @"");
    NSDate *date2 = [NSDate dateWithDay:2 month:7 year:2016];
//    for (int i = 0; i< (arc4random()); i++) {
        CKCalendarEvent *calendarEvents = [CKCalendarEvent eventWithTitle:title andDate:date2 andInfo:nil];
        [eventsList addObject:calendarEvents];
//    }
//    NSString *title2 = NSLocalizedString(@"ИП должен сдать отчет 2016.06.05", @"ass Bakbergen");
//    NSDate *date2 = [NSDate dateWithDay:21 month:6 year:2016];
//    CKCalendarEvent *mockingJay = [CKCalendarEvent eventWithTitle:title2 andDate:date2 andInfo:nil];
    return eventsList;
}


- (void)calendarView:(CKCalendarView *)CalendarView willSelectDate:(NSDate *)date {
    NSLog(@"%s",__PRETTY_FUNCTION__);
}

- (void)calendarView:(CKCalendarView *)CalendarView didSelectDate:(NSDate *)date {
    NSLog(@"%s",__PRETTY_FUNCTION__);
}

//  A row is selected in the events table. (Use to push a detail view or whatever.)
- (void)calendarView:(CKCalendarView *)CalendarView didSelectEvent:(CKCalendarEvent *)event {
    NSLog(@"%s",__PRETTY_FUNCTION__);
}

@end
