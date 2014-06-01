//
//  main.m
//  Stringz
//
//  Created by mm on 5/31/14.
//  Copyright (c) 2014 mm. All rights reserved.
//

#import <Foundation/Foundation.h>

int main(int argc, const char * argv[])
{

    @autoreleasepool {

        NSMutableString *str = [[NSMutableString alloc] init];
        for (int i = 0; i < 10; i++) {
            [str appendString:@"Aaron is cool!\n"];
        }

        NSError *error = nil;

        BOOL success = [str writeToFile:@"/tmp/cool.txt"
                             atomically:YES
                               encoding:NSUTF8StringEncoding
                                  error:&error];

        if (success){
            NSLog(@"done writing /tmp/cool.txt");
        } else {
            NSLog(@"writing /tmp/cool.txt failed: %@", [error localizedDescription]);
        }

        NSError *err = nil;
        NSString *str_in = [[NSString alloc] initWithContentsOfFile:@"/etc/resolv.conf"
                                                           encoding:NSASCIIStringEncoding
                                                              error:&err];

        if (!str_in) {
            NSLog(@"read failed: %@", [err localizedDescription]);
        } else {
            NSLog(@"resolv.conf looks like this: %@", str_in);
        }

        NSURL *url = [NSURL URLWithString:@"http://www.google.com/images/logos/ps_logo2.png"];
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        NSData *data = [NSURLConnection sendSynchronousRequest:request
                                             returningResponse:NULL
                                                         error:&error];
        if (!data) {
            NSLog(@"fetch failed: %@", [error localizedDescription]);
            return 1;
        }

        NSLog(@"the file is %lu bytes", [data length]);

        BOOL written = [data writeToFile:@"/tmp/google.png" options:0 error:&error];

        if (!written) {
            NSLog(@"write failed: %@", [error localizedDescription]);
            return 1;
        }

        NSLog(@"success!");

        NSData *readData = [NSData dataWithContentsOfFile:@"/tmp/google.png"];
        NSLog(@"the file read from disk has %lu bytes", [readData length]);

    }
    return 0;
}

