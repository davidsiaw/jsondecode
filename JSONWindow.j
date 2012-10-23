@import <Foundation/CPObject.j>

@import "MNTableViewController.j"

@implementation ViewObjectButtonColumnView : CPView 
{ 
    CPButton button; 
	var obj @accessors;
} 

- (id)init
{
	self = [super init];
    if (self)
    {
		obj = {};
		return self;
	}
}

- (void)setObjectValue:(id)str
{
	button = [CPButton buttonWithTitle:"{...}"];
	[self addSubview:button];
	[button setTag: str];
	[button setTarget:self];
	[button setAction:@selector(show:)];
}

- (void)show:(id)sender
{
	var window = [[JSONWindow alloc] initWithObject:[sender tag]];
    [window showWindow:self];
}

@end

@implementation JSONWindow : CPWindowController
{
	MNTableViewController tableViewController;
}

- (id)initWithObject:(id)anObject
{
	var theWindow = [[CPPanel alloc]
		initWithContentRect:CGRectMake(50, 50, 225, 125) 
		styleMask:CPHUDBackgroundWindowMask | CPClosableWindowMask | CPResizableWindowMask];
		
	[theWindow setTitle:@"JSON Window"];
	[theWindow setFloatingPanel:YES];
	
	self = [super initWithWindow:theWindow];
    if (self)
    {
		var contentView = [theWindow contentView];
		
		tableViewController = [[MNTableViewController alloc] init];
		var tableView = [tableViewController view];
			
		[[tableViewController view] setAutoresizingMask:CPViewWidthSizable|CPViewHeightSizable];
		[[tableViewController view] setFrame:[contentView bounds]];
		[contentView addSubview: tableView];
		
		var i = 0;
		var data = anObject;
		if ( Object.prototype.toString.call( anObject ) === '[object Array]' )
		{
			data = anObject;
		}
		else
		{
			data = [anObject];
		}
		
		
		var columns = {};
		var contents = [];
		
		for (i=0;i<data.length;i++)
		{
			var content = {};
			for (var key in data[i])
			{
				if (Object.prototype.toString.call( data[i][key] ) === '[object Object]' || 
					Object.prototype.toString.call( data[i][key] ) === '[object Array]'
				)
				{
					var button = [[ViewObjectButtonColumnView alloc] init];
					if (!columns[key])
					{
						columns[key] = true;
						[tableViewController addColumn:key.toString() withView:button];
					}
				}
				else
				{
					if (!columns[key])
					{
						columns[key] = true;
						[tableViewController addColumn:key.toString()];
					}
				}
				content[key] = data[i][key];
			}
			contents.push(content);
		}
		
		[[tableViewController arrayController] setContent:[CPArray arrayWithArray:contents]];
		[[tableViewController tableView] reloadData];
	
		
		
	}
	
    return self;
}

@end
