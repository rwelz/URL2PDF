//
//  main.m
//  URL2PDF
//
//  Created by Scott Garner on 5/29/12.
//  Modified by welz.willi@gmail.com (c) 1/27/17
//  Copyright (c) 2012 Project J38. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WebKit/WebKit.h"
#import "PDFDownloader.h"
#include <getopt.h>

NSString * const kDefaultDirectory = @"~/URL2PDF Output/";

void printUsage() {
    printf("The original URL2PDF 6.1 (c) 2012 Scott Garner\n");
    printf("URL2PDF 6.3.0 (c) 2017 Robert Welz\n");
    printf("------------------------------------------------------\n");
    printf("Options:\n");
    printf("  --help                        -h      Displays this message\n");
    printf("  --url=<URL>                   -u      URL to download - needs to start with http:// or https://\n");
    printf("  --enable-javascript=<BOOL>    -j      Enable javascript, YES or NO - NO is default if paramter not given\n");
    printf("  --script=<STRING>             -s      Script function in web page to execute.\n                                        Needs --enable-javascript=YES or -j YES\n                                        For example: -s \"javascript:$.showMore('description')\",\"javascript:$.showMore('release_notes')\"\n                                        Multiple script functions must be separated by ',' but no whitespace.\n");
    printf("  --print-paginate=<BOOL>       -g      Enable pagination, YES or NO - NO is default if paramter not given\n");
    printf("  --print-backgrounds=<BOOL>    -b      Print Backgrounds, YES or NO - YES is default if paramter not given\n");
    printf("  --load-images=<BOOL>          -i      Load Images, YES or NO - YES is default if paramter not given\n");
    printf("  --print-orientation=<VALUE>   -o      Orientation, Portrait or Landscape - Landscape is default if paramter not given\n");
    printf("  --autosave-name=<VALUE>       -n      Filename source: URL or Title - Filename from page title is default if paramter not given\n");
    printf("  --autosave-path=<PATH>        -p      Save path - ~/URL2PDF Output/ is default if paramter not given\n");
    printf("  --open-file=<BOOL>            -c      Opens folder containing pdf after successful download\n");
    printf("  --open-folder=<BOOL>          -d      Opens pdf in viewer after successful download\n");
    printf("  --autosave-path=<PATH>        -p      Save path - ~/URL2PDF Output/ is default if paramter not given\n");
    printf("\n  Example:\n  url2pdf -u http://www.apple.de\n");
}

NSMutableDictionary* parseOptions(const int argc, char **argv) {
    int option;
    
    if (argc == 0) {
        printUsage();
        exit(EXIT_FAILURE);
    }
    
    // Defaults
    
    
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                                       [NSNull null] , @"url",
                                       //kDefaultDirectory, @"savePath",
                                       [NSNumber numberWithInt:1], @"fileNameFrom",
                                       [NSNumber numberWithInt:1], @"printOrientation",
                                       [NSNumber numberWithBool:NO], @"printPaginate",
                                       [NSNumber numberWithBool:YES], @"printBackgrounds",
                                       [NSNumber numberWithBool:YES], @"loadImages",
                                       [NSNumber numberWithBool:NO], @"enableJavaScript",
                                       [NSNumber numberWithBool:NO], @"openFile",
                                       [NSNumber numberWithBool:NO], @"openFolder",
                                       nil];
    
    // Option Table
    
    char *shortOptions = "hu:j:s:g:b:i:o:n:c:d:p:";
    const struct option longOptions[] = {
        {"help",                no_argument,        NULL,   'h'},
        {"url",                 required_argument,  NULL,   'u'},
        {"enable-javascript",   required_argument,  NULL,   'j'},
        {"script",              required_argument,  NULL,   's'},
        {"print-paginate",      required_argument,  NULL,   'g'},
        {"print-backgrounds",   required_argument,  NULL,   'b'},
        {"load-images",         required_argument,  NULL,   'i'},
        {"print-orientation",   required_argument,  NULL,   'o'},
        {"autosave-name",       required_argument,  NULL,   'n'},
        {"autosave-path",       required_argument,  NULL,   'p'},
        {"open-file",           required_argument,  NULL,   'c'},
        {"open-folder",         required_argument,  NULL,   'd'},
        {NULL,                  0,                  NULL,   0},
    };
    
    bool noParameterGiven = YES;
    while ((option = getopt_long(argc, argv, shortOptions, longOptions, NULL)) != -1) {
        
        switch(option) {
            case 'h':
                noParameterGiven = NO;
                printUsage();
                exit(EXIT_SUCCESS);
                
            case 'f':
                noParameterGiven = NO;
                [parameters setObject:[NSString stringWithFormat:@"%s",optarg] forKey:@"pdf"];
                break;
                
            case 'u':
                noParameterGiven = NO;
                [parameters setObject:[NSString stringWithFormat:@"%s",optarg] forKey:@"url"];
                break;
                
            case 'j':
                noParameterGiven = NO;
                if (strcasecmp(optarg,"YES") == 0)
                    [parameters setObject:[NSNumber numberWithBool:YES] forKey:@"enableJavaScript"];
                else if (strcasecmp(optarg,"NO") == 0)
                    [parameters setObject:[NSNumber numberWithBool:NO] forKey:@"enableJavaScript"];
                else {
                    printf("Invalid argument for --enable-javascript\n");
                    exit(EXIT_FAILURE);
                }
                break;
            
            case 's':
                noParameterGiven = NO;
                [parameters setObject:[NSString stringWithFormat:@"%s",optarg] forKey:@"scripts"];
                break;
                
            case 'g':
                noParameterGiven = NO;
                if (strcasecmp(optarg,"YES") == 0)
                    [parameters setObject:[NSNumber numberWithBool:YES] forKey:@"printPaginate"];
                else if (strcasecmp(optarg,"NO") == 0)
                    [parameters setObject:[NSNumber numberWithBool:NO] forKey:@"printPaginate"];
                else {
                    printf("Invalid argument for --print-paginate\n");
                    exit(EXIT_FAILURE);
                }
                break;
                
            case 'i':
                noParameterGiven = NO;
                if (strcasecmp(optarg,"YES") == 0)
                    [parameters setObject:[NSNumber numberWithBool:YES] forKey:@"loadImages"];
                else if (strcasecmp(optarg,"NO") == 0)
                    [parameters setObject:[NSNumber numberWithBool:NO] forKey:@"loadImages"];
                else {
                    printf("Invalid argument for --load-images\n");
                    exit(EXIT_FAILURE);
                }
                break;
                
            case 'b':
                noParameterGiven = NO;
                if (strcasecmp(optarg,"YES") == 0)
                    [parameters setObject:[NSNumber numberWithBool:YES] forKey:@"printBackgrounds"];
                else if (strcasecmp(optarg,"NO") == 0)
                    [parameters setObject:[NSNumber numberWithBool:NO] forKey:@"printBackgrounds"];
                else {
                    printf("Invalid argument for --print-backgrounds\n");
                    exit(EXIT_FAILURE);
                }
                break;
                
            case 'o':
                noParameterGiven = NO;
                if (strcasecmp(optarg,"Portrait") == 0)
                    [parameters setObject:[NSNumber numberWithInt:0] forKey:@"printOrientation"];
                else if (strcasecmp(optarg,"Landscape") == 0)
                    [parameters setObject:[NSNumber numberWithInt:1] forKey:@"printOrientation"];
                else {
                    printf("Invalid argument for --print-orientation\n");
                    exit(EXIT_FAILURE);
                }
                break;
                
            case 'n':
                noParameterGiven = NO;
                if (strcasecmp(optarg,"URL") == 0)
                    [parameters setObject:[NSNumber numberWithInt:0] forKey:@"fileNameFrom"];
                else if (strcasecmp(optarg,"Title") == 0)
                    [parameters setObject:[NSNumber numberWithInt:1] forKey:@"fileNameFrom"];
                else {
                    printf("Invalid argument for --autosave-name\n");
                    exit(EXIT_FAILURE);
                }
                break;
                
            case 'p':
                noParameterGiven = NO;
                [parameters setObject:[[NSString stringWithFormat:@"%s",optarg]stringByExpandingTildeInPath] forKey:@"savePath"];
                break;
                
            case 'c':
                noParameterGiven = NO;
                if (strcasecmp(optarg,"YES") == 0)
                    [parameters setObject:[NSNumber numberWithBool:YES] forKey:@"openFile"];
                else
                    [parameters setObject:[NSNumber numberWithBool:NO] forKey:@"openFile"];
                break;
                
            case 'd':
                noParameterGiven = NO;
                if (strcasecmp(optarg,"YES") == 0)
                    [parameters setObject:[NSNumber numberWithBool:YES] forKey:@"openFolder"];
                else
                    [parameters setObject:[NSNumber numberWithBool:NO] forKey:@"openFolder"];
                break;
                
            default:
                printUsage();
                exit(EXIT_FAILURE);
        }
    }
    
    if(noParameterGiven == YES)
    {
        printUsage();
        exit(EXIT_SUCCESS);
    }
    
    if ([parameters objectForKey:@"url"] == [NSNull null]) {
        printf("Missing required parameter --url\n");
        exit(EXIT_FAILURE);
    }
    
    return parameters;
}


int main(const int argc, char **argv)
{
    
    @autoreleasepool {
        
        [NSApplication sharedApplication];
        
        //        NSArray *input = [[NSArray alloc] initWithObjects:
        //                          [NSURL URLWithString:@"http://cargocollective.com/coryschmitz"],
        //                          [NSURL URLWithString:@"http://mareodomo.com/"],
        //                          [NSURL URLWithString:@"http://appleinsider.com/"],
        //                          [NSURL URLWithString:@"http://bing.com/"],
        //                          [NSURL URLWithString:@"http://google.com/"],
        //                          [NSURL URLWithString:@"http://yahoo.com/"],
        //                          nil];
        
        NSMutableDictionary *parameters = parseOptions(argc, argv);
        //        NSLog(@"%@",parameters);
        
        NSString *scripts = [parameters objectForKey:@"scripts"];
        NSArray *scriptsToExecute = [scripts componentsSeparatedByString:@","];
        if((scriptsToExecute != nil) && ([scriptsToExecute count] != 0))
        {
            for(NSString *script in scriptsToExecute)
            {
                if([script isEqualToString:@""])
                {
                    printf("Error: No whitespace allowed to separate script parameters!\n");
                    exit(EXIT_FAILURE);
                }
            }
        }
            
            
            
        
        BOOL openFolder = [[ parameters objectForKey:@"openFolder"] boolValue];
        BOOL openFile = [[ parameters objectForKey:@"openFile"] boolValue];
        NSString *savePath = [ parameters objectForKey:@"savePath"];
        
        if((savePath == nil) || ([savePath isEqualToString:@""]))
        {
            [parameters setObject:[NSString stringWithFormat:@"%s",[kDefaultDirectory UTF8String]] forKey:@"savePath"];
            
            // create directory
            
            NSFileManager *fileManager= [NSFileManager defaultManager];
            NSError *error = nil;
            if(![fileManager createDirectoryAtPath:[kDefaultDirectory stringByExpandingTildeInPath] withIntermediateDirectories:NO attributes:nil error:&error]) {
                // An error has occurred, do something to handle it
                NSError *undelyingError = [[error userInfo] objectForKey:NSUnderlyingErrorKey];
                if([undelyingError code] != 17) // suppress directory exist error
                    NSLog(@"Failed to create directory \"%@\". Error: %@", kDefaultDirectory, error);
            }
        }
        
        
        
        
        NSArray *input = [[NSArray alloc] initWithObjects:
                          [NSURL URLWithString:[parameters objectForKey:@"url"]],
                          nil];
        
        PDFDownloader *downloader = [[PDFDownloader alloc] init];
        
        NSArray *output = [downloader downloadURLs:input parameters:parameters];
        if(openFolder == YES)
        {
            if([output count] > 0)
            {
                NSURL *fileURL = [NSURL fileURLWithPath: output[0]];
                NSURL *folderURL = [fileURL URLByDeletingLastPathComponent];
                [[NSWorkspace sharedWorkspace] openURL: folderURL];
            }
        }
        if(openFile == YES)
        {
            for (NSString *savePath in output)
            {
                NSURL *fileURL = [NSURL fileURLWithPath: savePath];
                [[NSWorkspace sharedWorkspace] openURL: fileURL];
            }
        }
    }
    return 0;
}


