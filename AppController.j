@import <Foundation/CPObject.j>
@import <LPKit/LPMultiLineTextField.j>

@import "JSONWindow.j"

@implementation AppController : CPObject
{
	LPMultiLineTextField textField;
}

- (void)applicationDidFinishLaunching:(CPNotification)aNotification
{
    var theWindow = [[CPWindow alloc] initWithContentRect:CGRectMakeZero() styleMask:CPBorderlessBridgeWindowMask],
        contentView = [theWindow contentView];
	
	var monospace = [CPFont fontWithName:"Courier New" size:14];
	
	textField = [[LPMultiLineTextField alloc] initWithFrame:[contentView bounds] ];
	[textField setAutoresizingMask:CPViewHeightSizable | CPViewWidthSizable ];
	[textField setBezeled:YES];
	[textField setBezelStyle:CPTextFieldSquareBezel];
	[textField setEditable:YES];
	[textField setFont:monospace];
	[contentView addSubview:textField];
	
	var menu = [[CPApplication sharedApplication] mainMenu];
	[menu removeItem:[menu itemWithTitle:"Save"]];
	[menu removeItem:[menu itemWithTitle:"Open"]];
	
	var btnDecodeJSON = [menu itemWithTitle:"New"];
	[btnDecodeJSON setTitle:"Decode!"];
	[btnDecodeJSON setTarget:self];
	[btnDecodeJSON setAction:@selector(decode:)];
	
    [CPMenu setMenuBarVisible:YES];
    [theWindow orderFront:self];
}

- (void)decode:(id)sender
{
	CPLog("decode! clicked");
	var json = [textField stringValue];
	try
	{
		var object = JSON.parse(json);
	}
	catch(e)
	{
		CPLog(e);
		return;
	}
	
	var window = [[JSONWindow alloc] initWithObject:object];
    [window showWindow:self];
	
}



@end

