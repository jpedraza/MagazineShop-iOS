//
//  MSKeychainObject.m
//  Eon
//
//  Created by Ondrej Rafaj on 06/03/2013.
//  Copyright (c) 2013 LBi. All rights reserved.
//

#import "MSKeychainObject.h"
#import <Security/Security.h>


#define kMSKeychainObjectToken                          @"MSKeychainObjectToken"
#define kMSKeychainObjectUsername                       @"MSKeychainObjectUsername"
#define kMSKeychainObjectPassword                       @"MSKeychainObjectPassword"
#define kMSKeychainObjectUUID                           @"MSKeychainObjectUUID"
#define kMSKeychainObjectTokenDate                      @"MSKeychainObjectTokenDate"


@implementation MSKeychainObject


#pragma mark Keychain code

static NSString *serviceName = kMSConfigKeychainServiceName;

- (NSMutableDictionary *)newSearchDictionaryWithIdentifier:(NSString *)identifier {
    NSMutableDictionary *searchDictionary = [[NSMutableDictionary alloc] init];
    [searchDictionary setObject:(__bridge id)kSecClassGenericPassword forKey:(__bridge id)kSecClass];
    NSData *encodedIdentifier = [identifier dataUsingEncoding:NSUTF8StringEncoding];
    [searchDictionary setObject:encodedIdentifier forKey:(__bridge id)kSecAttrGeneric];
    [searchDictionary setObject:encodedIdentifier forKey:(__bridge id)kSecAttrAccount];
    [searchDictionary setObject:serviceName forKey:(__bridge id)kSecAttrService];
    return searchDictionary;
}

- (NSString *)searchKeychainCopyMatchingIdentifier:(NSString *)identifier {
    NSMutableDictionary *searchDictionary = [self newSearchDictionaryWithIdentifier:identifier];
    [searchDictionary setObject:(__bridge id)kSecMatchLimitOne forKey:(__bridge id)kSecMatchLimit];
    [searchDictionary setObject:(id)kCFBooleanTrue forKey:(__bridge id)kSecReturnData];
    CFDataRef cfresult = NULL;
    SecItemCopyMatching((__bridge CFDictionaryRef)searchDictionary, (CFTypeRef *)&cfresult);
    NSString *result = cfresult ? [[NSString alloc] initWithData:(__bridge_transfer NSData *)cfresult encoding:NSUTF8StringEncoding] : nil;
    return result;
}

- (BOOL)createKeychainValue:(NSString *)password forIdentifier:(NSString *)identifier {
    NSMutableDictionary *dictionary = [self newSearchDictionaryWithIdentifier:identifier];
    NSData *passwordData = [password dataUsingEncoding:NSUTF8StringEncoding];
    [dictionary setObject:passwordData forKey:(__bridge id)kSecValueData];
    
    OSStatus status = SecItemAdd((__bridge CFDictionaryRef)dictionary, NULL);
    if (status == errSecSuccess) {
        return YES;
    }
    return NO;
}

- (BOOL)updateKeychainValue:(NSString *)password forIdentifier:(NSString *)identifier {    
    NSMutableDictionary *searchDictionary = [self newSearchDictionaryWithIdentifier:identifier];
    NSMutableDictionary *updateDictionary = [[NSMutableDictionary alloc] init];
    NSData *passwordData = [password dataUsingEncoding:NSUTF8StringEncoding];
    [updateDictionary setObject:passwordData forKey:(__bridge id)kSecValueData];
    
    OSStatus status = SecItemUpdate((__bridge CFDictionaryRef)searchDictionary, (__bridge CFDictionaryRef)updateDictionary);
    if (status == errSecSuccess) {
        return YES;
    }
    return NO;
}

- (void)deleteKeychainValue:(NSString *)identifier {
    NSMutableDictionary *searchDictionary = [self newSearchDictionaryWithIdentifier:identifier];
    SecItemDelete((__bridge CFDictionaryRef)searchDictionary);
}

#pragma mark Initialization

+ (MSKeychainObject *)sharedKeychainObject {
    return [[MSKeychainObject alloc] init];
}

#pragma mark Settings

- (NSString *)authToken {
    NSString *token = [self searchKeychainCopyMatchingIdentifier:kMSKeychainObjectToken];
    return token;
}

- (void)setAuthToken:(NSString *)authToken {
    BOOL ok;
    if (self.authToken) {
        ok = [self updateKeychainValue:authToken forIdentifier:kMSKeychainObjectToken];
    }
    else {
        ok = [self createKeychainValue:authToken forIdentifier:kMSKeychainObjectToken];
    }
}

- (NSString *)username {
    NSString *username = [self searchKeychainCopyMatchingIdentifier:kMSKeychainObjectUsername];
    return username;
}

- (void)setUsername:(NSString *)username {
    BOOL ok;
    if (self.username) {
        ok = [self updateKeychainValue:username forIdentifier:kMSKeychainObjectUsername];
    }
    else {
        ok = [self createKeychainValue:username forIdentifier:kMSKeychainObjectUsername];
    }
}

- (NSString *)password {
    NSString *password = [self searchKeychainCopyMatchingIdentifier:kMSKeychainObjectPassword];
    return password;
}

- (void)setPassword:(NSString *)password {
    BOOL ok;
    if (self.password) {
        ok = [self updateKeychainValue:password forIdentifier:kMSKeychainObjectPassword];
    }
    else {
        ok = [self createKeychainValue:password forIdentifier:kMSKeychainObjectPassword];
    }
}

- (NSString *)uuid {
    NSString *uuid = [self searchKeychainCopyMatchingIdentifier:kMSKeychainObjectUUID];
    return uuid;
}

- (void)setUuid:(NSString *)uuid {
    BOOL ok;
    if (self.uuid) {
        ok = [self updateKeychainValue:uuid forIdentifier:kMSKeychainObjectUUID];
    }
    else {
        ok = [self createKeychainValue:uuid forIdentifier:kMSKeychainObjectUUID];
    }
}

- (NSDate *)userTokenDate {
    NSString *userTokenDate = [self searchKeychainCopyMatchingIdentifier:kMSKeychainObjectTokenDate];
    NSLog(@"User token date back: %@", userTokenDate);
    return nil;
}

- (void)setUserTokenDate:(NSDate *)userTokenDate {
    BOOL ok;
    NSString *userTokenDateString = [NSString stringWithFormat:@"%f", [userTokenDate timeIntervalSince1970]];
    if (self.uuid) {
        ok = [self updateKeychainValue:userTokenDateString forIdentifier:kMSKeychainObjectTokenDate];
    }
    else {
        ok = [self createKeychainValue:userTokenDateString forIdentifier:kMSKeychainObjectTokenDate];
    }
    NSLog(@"Did save User token date to keychain: %@", ok ? @"Yes" : @"No");
}

- (BOOL)isLoginDataAvailable {
    BOOL ok = (self.username && self.password && self.authToken);
    return ok;
}

- (void)logout {
    [self deleteKeychainValue:kMSKeychainObjectToken];
    [self deleteKeychainValue:kMSKeychainObjectUsername];
    [self deleteKeychainValue:kMSKeychainObjectPassword];
    [self deleteKeychainValue:kMSKeychainObjectUUID];
    [self deleteKeychainValue:kMSKeychainObjectTokenDate];
}


@end
