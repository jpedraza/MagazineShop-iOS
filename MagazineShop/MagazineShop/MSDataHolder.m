//
//  MSDataHolder.m
//  MagazineShop
//
//  Created by Ondrej Rafaj on 30/04/2013.
//  Copyright (c) 2013 PublishTheMag.com. All rights reserved.
//

#import "MSDataHolder.h"
#import "MSProduct.h"


#define kMSDataHolderProductAvailabilityKey                     @"MSDataHolderProductAvailabilityKey"


@implementation MSDataHolder


#pragma mark Initialization

+ (MSDataHolder *)sharedObject {
    static MSDataHolder *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[MSDataHolder alloc] init];
    });
    return sharedInstance;
}

#pragma mark Products

- (MSProduct *)productAtIndex:(NSInteger)index {
    return [_products objectAtIndex:index];
}

- (MSProduct *)productForIdentifier:(NSString *)identifier {
    for (MSProduct *product in _products) {
        if ([product.identifier isEqualToString:identifier]) {
            return product;
        }
    }
    return nil;
}

+ (void)resetProductAvailability {
    [[NSUserDefaults standardUserDefaults] setObject:[NSDictionary dictionary] forKey:kMSDataHolderProductAvailabilityKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

#pragma mark Core data

+ (MSMagazines *)registerMagazineWithInfo:(NSDictionary *)info {
    MSMagazines *m = [self magazineForIdentifier:[info objectForKey:@"identifier"]];
    if (m) {
        return m;
    }
    NSError *error;
    MSMagazines *magazine = [NSEntityDescription insertNewObjectForEntityForName:@"MSMagazines" inManagedObjectContext:kManagedObject];
    [magazine setName:[info objectForKey:@"name"]];
    [magazine setIdentifier:[info objectForKey:@"identifier"]];
    [kManagedObject save:&error];
    if (error) {
        // TODO: Tracking error
        NSLog(@"Error saving: %@", [error localizedDescription]);
    }
    return magazine;
}

+ (MSMagazines *)magazineForIdentifier:(NSString *)identifier {
    NSError *error;
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:[NSEntityDescription entityForName:@"MSMagazines" inManagedObjectContext:kManagedObject]];
    
    NSString *complexPredicateFormat = [NSString stringWithFormat:@"identifier ==[c] '%@'", identifier];
    NSPredicate *complexPredicate = [NSPredicate predicateWithFormat:complexPredicateFormat argumentArray:nil];
    [request setPredicate:complexPredicate];
    
    NSArray *arr = [kManagedObject executeFetchRequest:request error:&error];
    if (error || [arr count] == 0) {
        return nil;
    }
    return (MSMagazines *)[arr objectAtIndex:0];
}

+ (NSArray *)pagesForMagazineWithIdentifier:(NSString *)identifier {
    NSError *error;
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:[NSEntityDescription entityForName:@"MSMagazinePages" inManagedObjectContext:kManagedObject]];
    
    NSString *complexPredicateFormat = [NSString stringWithFormat:@"identifier ==[c] '%@'", identifier];
    NSPredicate *complexPredicate = [NSPredicate predicateWithFormat:complexPredicateFormat argumentArray:nil];
    [request setPredicate:complexPredicate];
    
    NSArray *arr = [kManagedObject executeFetchRequest:request error:&error];
    if (error) {
        // TODO: Tracking error
        return [NSArray array];
    }
    return arr;
}


@end
