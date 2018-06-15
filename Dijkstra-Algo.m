
#import "Dijkstra-Algo.h"



@implementation Dijkstra_Algo


-(void)algo:(NSDictionary*)graph source:(NSString *)source destination:(NSString *)destination {

	NSMutableDictionary *results = [NSMutableDictionary new];

	NSMutableDictionary *q = [NSMutableDictionary new];

	for ( NSString *vertexName in graph.allKeys ) {
		NSMutableDictionary *vertexData = [[NSMutableDictionary alloc] initWithDictionary:graph[vertexName]];
		vertexData[@"dist"] = [NSNumber numberWithInteger:NSIntegerMax];
		q[vertexName] = vertexData;
	}

	q[source][@"dist"] = [NSNumber numberWithInteger:0];

	while ( q.allKeys.count > 0 ) {

		NSString *uKey = q.allKeys.firstObject;
		for ( NSString *vertexName in q.allKeys ) {
			if ( [q[vertexName][@"dist"] integerValue] < [q[uKey][@"dist"] integerValue] ) {
				uKey = vertexName;
			}
		}

		NSDictionary *u = q[uKey];
		results[uKey] = q[uKey];
		[q removeObjectForKey:uKey];

		if ( [uKey isEqualToString:destination] ) {
			break;
		}

		for ( NSString *vertex in u.allKeys )
			if ( vertex.length == 1 ) {
				NSInteger alt = [u[@"dist"] integerValue] + [u[vertex] integerValue];
				if ( alt < [q[vertex][@"dist"] integerValue] ) {
					q[vertex][@"dist"] = [NSNumber numberWithInteger:alt];
					q[vertex][@"prev"] = uKey;
					results[vertex] = q[vertex];
				}
			}
	}

	NSMutableArray *path = [NSMutableArray new];
	[path addObject:destination];
	while ( results[destination][@"prev"] ) {
		[path insertObject:results[destination][@"prev"] atIndex:0];
		destination = results[destination][@"prev"];
	}

	for ( NSString *vertexName in path ) {
		NSLog( @"%@", vertexName );
	}
}

-(void)calculateShortestPath;
{
	NSDictionary *graph =
   						@{
						@"S": @{@"A":@7, @"B":@2, @"C": @3},
						@"A": @{@"S":@7, @"B":@3, @"D": @4},
						@"B": @{@"S":@2, @"A":@3, @"H": @1, @"D":@4},
						@"D": @{@"A":@4, @"B":@4, @"F": @5},
						@"H": @{@"B":@1, @"F":@3},
						@"F": @{@"D":@5, @"H":@3},
						};

	[self algo:graph source: @"F" destination:@"S"];
}

@end
