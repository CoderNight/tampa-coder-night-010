//
//  TDMChessBoard.h
//  ChessValidator
//
//  Created by Craig Clayton on 10/29/13.
//  Copyright (c) 2013 Craig Clayton. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TDMChessBoard : NSObject

@property (strong, nonatomic) NSString* board;
@property (strong, nonatomic) NSString* boardContent;
@property (strong, nonatomic) NSMutableDictionary* dictBoard;
@property (strong, nonatomic) NSMutableArray* arrMoves;
@property (strong, nonatomic) NSMutableArray* arrResults;


- (id)initWithBoard:(NSString *)board andMoves:(NSArray *)moves;

@end
