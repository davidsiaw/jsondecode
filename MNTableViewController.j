//	MNTableViewController

@import <AppKit/AppKit.j>
@import "MNSampleDataView.j"

@implementation MNTableViewController : CPViewController {

	CPArrayController arrayController @accessors;
	
	CPScrollView scrollView @accessors;
	CPTableView tableView @accessors;
	CPView dataViewPrototype @accessors;
	
	var columnArray;
}

- (id) initWithCibName:(CPString)aCibNameOrNil bundle:(CPBundle)aCibBundleOrNil {

	self = [super initWithCibName:aCibNameOrNil bundle:aCibBundleOrNil];
	if (!self) return nil;

	[self mnConfigure];

	return self;

}

- (id) initWithCoder:(CPCoder)aCoder {

	self = [super initWithCoder:aCoder];
	if (!self) return nil;

	[self mnConfigure];	

	return self;

}

- (void) mnConfigure {

	[self setArrayController:[[CPArrayController alloc] init]];
	[self setDataViewPrototype:[[MNSampleDataView alloc] init]];

}

- (CPScrollView) view {

	return [super view];
}

- (void) loadView {

	scrollView = [[CPScrollView alloc] init];
	tableView = [[CPTableView alloc] initWithFrame:[scrollView bounds]];

	[tableView setDataSource:self];
	[tableView setDelegate:self];
	[tableView setRowHeight:32];
	[tableView setColumnAutoresizingStyle:CPTableViewUniformColumnAutoresizingStyle];
	[tableView setGridStyleMask:CPTableViewSolidHorizontalGridLineMask | CPTableViewSolidVerticalGridLineMask];
	[tableView setAllowsColumnResizing:YES];
	[tableView setUsesAlternatingRowBackgroundColors:YES];
	[tableView setSelectionHighlightColor:[CPColor lightGrayColor]];
	

	[scrollView setAutoresizingMask:CPViewWidthSizable|CPViewHeightSizable];
	[scrollView setDocumentView:tableView];
	[scrollView setHasHorizontalScroller:NO];
	[self setView:scrollView];
	
	columnArray = [];

}

- (void) addColumn:(CPString)name {
	var newColumn = [[CPTableColumn alloc] initWithIdentifier:name];
	[newColumn setDataView:[self dataViewPrototype]];
	[[newColumn headerView] setStringValue:name];
	[tableView addTableColumn:newColumn];
	columnArray.push(name);
}

- (void) addColumn:(CPString)name withView:(CPView)viewPrototype {
	var newColumn = [[CPTableColumn alloc] initWithIdentifier:name];
	[newColumn setDataView:viewPrototype];
	[[newColumn headerView] setStringValue:name];
	[tableView addTableColumn:newColumn];
	columnArray.push(name);
}

- (int) numberOfRowsInTableView:(CPTableView)inTableView {

	return [[arrayController arrangedObjects] count] || 0;

}

- (id) tableView:(CPTableView)inTableView objectValueForTableColumn:(CPTableColumn)inTableColumn row:(int)inRow 
{
	var ident = [inTableColumn identifier];
	return [arrayController arrangedObjects][inRow][ident];
}

@end
