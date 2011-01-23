/*
 * AppController.j
 * Todos
 *
 * Created by Arunjit Singh on August 10, 2010.
 * Copyright 2010, ArunjitSingh All rights reserved.
 */

@import <Foundation/CPObject.j>
@import <AppKit/CPView.j>

@import "Todos.j"
@import "Task.j"
@import "RESTConnection.j"

@implementation CPCollectionView (SelectedItems) {}

- (CPSet)selectedItems {
  var indexes = [self selectionIndexes],
    index = [indexes firstIndex],
      set = [CPSet set];
  while (index !== CPNotFound) {
    [set addObject:[self itemAtIndex:index]];
    index = [indexes indexGreaterThanIndex:index];
  }
  
  return set;
}

@end

@implementation CPArray (MutateObjectsByPerformingSelector) {}

- (void)mutateObjectsByPerformingSelector:(SEL)aSelector {
  if (!aSelector) {
    [CPException raise:CPInvalidArgumentException
          reason:"- mutateObjectsByPerformingSelector: 'aSelector' can't be nil"];
  }

  var index = 0, 
    count = [self count];

  for(; index < count; ++index) {
    self[index] = objj_msgSend(self[index], aSelector);
  }
}

@end

var sortTasksByID = function(lhs, rhs, ctx) {
  // ignore ctx
  var LHS = parseInt(lhs.id, 36),
    RHS = parseInt(rhs.id, 36);
  if (LHS < RHS) {
    return CPOrderedAscending;
  } else if (LHS > RHS) {
    return CPOrderedDescending;
  }
  return CPOrderedSame;
}


@implementation AppController : CPObject {
  CPCollectionView  tasksList;
  RESTConnection    tasksConnection;
}

- (void)applicationDidFinishLaunching:(CPNotification)aNotification {
    var theWindow = [[CPWindow alloc] initWithContentRect:CGRectMakeZero()
                          styleMask:CPBorderlessBridgeWindowMask],
        contentView = [theWindow contentView];

    var fetchButton = [[CPButton alloc] initWithFrame:CGRectMake(10.0, 10.0, 90.0, 25.0)];
  [fetchButton setFont:[CPFont boldSystemFontOfSize:12.0]];
  [fetchButton setTitle:@"Fetch"];
  [fetchButton setAction:@selector(fetchTasks:)];
  [contentView addSubview:fetchButton];

  var createButton = [[CPButton alloc] initWithFrame:CGRectMake(110.0, 10.0, 90.0, 25.0)];
  [createButton setFont:[CPFont boldSystemFontOfSize:12.0]];
  [createButton setTitle:@"New"];
  [createButton setAction:@selector(createTask:)];
  [contentView addSubview:createButton];

  var deleteButton = [[CPButton alloc] initWithFrame:CGRectMake(210.0, 10.0, 90.0, 25.0)];
  [deleteButton setFont:[CPFont boldSystemFontOfSize:12.0]];
  [deleteButton setTitle:@"Delete"];
  [deleteButton setAction:@selector(deleteTasks:)];
  [contentView addSubview:deleteButton];
  
  var editButton = [[CPButton alloc] initWithFrame:CGRectMake(310.0, 10.0, 90.0, 25.0)];
  [editButton setTag:0];
  [editButton setFont:[CPFont boldSystemFontOfSize:12.0]];
  [editButton setTitle:@"Edit"];
  [editButton setAction:@selector(updateTask:)];
  [contentView addSubview:editButton];
  
  var doneButton = [[CPButton alloc] initWithFrame:CGRectMake(410.0, 10.0, 110.0, 25.0)];
  [doneButton setTag:1];
  [doneButton setFont:[CPFont boldSystemFontOfSize:12.0]];
  [doneButton setTitle:@"Toggle Done"];
  [doneButton setAction:@selector(updateTask:)];
  [contentView addSubview:doneButton];

  var resultsArea = [[CPScrollView alloc] initWithFrame:CGRectMake(0.0, 40.0,
                              CGRectGetWidth([contentView bounds]),
                              CGRectGetHeight([contentView bounds]) - 40.0)];
  [resultsArea setAutoresizingMask:CPViewWidthSizable | CPViewHeightSizable];
  [resultsArea setAutohidesScrollers:YES];
  
  [contentView addSubview:resultsArea];
  
  var taskItem = [[CPCollectionViewItem alloc] init];
  [taskItem setView:[[TaskViewCell alloc] initWithFrame:CGRectMakeZero()]];
  
  tasksList = [[CPCollectionView alloc] initWithFrame:CGRectMake(0,0,
                              CGRectGetWidth([contentView bounds]),
                              25.0)];
  [tasksList setDelegate:self];
  [tasksList setItemPrototype:taskItem];
  
  [tasksList setMinItemSize:CGSizeMake(CGRectGetWidth([contentView bounds])-20.0, 25.0)];
  [tasksList setMaxItemSize:CGSizeMake(CGRectGetWidth([contentView bounds])-20.0, 25.0)];
  
  [tasksList setAutoresizingMask:CPViewWidthSizable];
  
  [tasksList setAllowsMultipleSelection:YES];
  
  [resultsArea setDocumentView:tasksList];
  
  tasksConnection = [RESTConnection new];
  
    [theWindow orderFront:self];

    // Uncomment the following line to turn on the standard menu bar.
    //[CPMenu setMenuBarVisible:YES];
    [self fetchTasks:nil];
}


- (void)renderResults:(CPArray)results {
  [results mutateObjectsByPerformingSelector:@selector(objectFromJSON)];
  [results sortUsingFunction:sortTasksByID context:nil]
  [tasksList setContent:results];
  [tasksList reloadContent];
}

- (void)didFetchData:(CPString)data {
  data = [data objectFromJSON];
  if (data.status && typeof(data.results) !== "undefined") {
    [self renderResults:data.results];
  }
//  [tasksList setSelectionIndexes:[[CPIndexSet alloc] init]];
}

- (void)didUpdateData:(CPString)data {
  data = [data objectFromJSON];
  if (data.status) {
    [self fetchTasks:nil];
  }
}

/* =======================
 * @action Actions
 * =======================
 */

- (void)fetchTasks:(id)sender {
  [tasksConnection setGETConnection:
    [CPURLConnection connectionWithRequest:[Todos fetchRequest]
                    delegate:self]];
//  tasksConnection = [CPURLConnection connectionWithRequest:[Todos fetchRequest]
//                          delegate:self];
}

- (void)createTask:(id)sender {
  var desc = prompt("Enter task description: ");
  if (desc && desc.length) {
    var task = [Task taskWithTask:desc];
    [tasksConnection setPOSTConnection: 
      [CPURLConnection connectionWithRequest:[Todos createRequestWithHTTPBody:[task JSONString]]
                        delegate:self]];
  }
}

- (void)deleteTasks:(id)sender {
  var selectedItems = [[tasksList selectedItems] allObjects],
    count = [selectedItems count];
  while (count--) {
    var taskItem = [selectedItems objectAtIndex:count],
      task = [Task taskFromJSObject:[taskItem representedObject]];
    [tasksConnection setDELETEConnection:
          [CPURLConnection connectionWithRequest:[task deleteRequest]
                          delegate:self]];
  }
}

- (void)updateTask:(id)sender {
  var selectedItems = [[tasksList selectedItems] allObjects],
    count = [selectedItems count];
  while (count--) {
    var taskItem = [selectedItems objectAtIndex:count],
      task = [Task taskFromJSObject:[taskItem representedObject]],
      requiresUpdate = NO;
      
    if ([sender tag] == 0) {
        var desc = prompt("Enter task description: ", [task task]);
      if (desc && desc.length) {
        [task setTask:desc];
        requiredUpdate = YES;
      }
    } else {
      [task toggleCompleted];
      requiresUpdate = YES;
    }
    
    if (requiresUpdate) {
      [tasksConnection setPUTConnection: 
        [CPURLConnection connectionWithRequest:[task updateRequestWithHTTPBody:[task JSONString]]
                          delegate:self]];
    }
  }
}

/* =======================
 * CPURLConnection methods
 * =======================
 */

- (void)connection:(CPURLConnection)aConnection didReceiveData:(CPString)data {
  if (aConnection == [tasksConnection GETConnection]) {
    [self didFetchData:data];
  } else {
    [self didUpdateData:data];
  }
}

- (void)connection:(CPURLConnection)aConnection didFailWithError:(CPString)error {
  alert(error);
}

@end

@implementation TaskViewCell : CPView {
  CPTextField _label;
  Task    task  @accessors;
}

- (void)setRepresentedObject:(JSObject)anObject {
  task = [Task taskFromJSObject:anObject];
//  console.log(anObject);
  
  if (!_label) {  
    _label = [[CPTextField alloc] initWithFrame:CGRectMakeZero()];
    [_label setFrameOrigin:CGPointMake(10.0, 2.0)];
    [_label setLineBreakMode:CPLineBreakByWordWrapping];    
    [self addSubview:_label];
  }
  if ([task isCompleted]) {
    [_label setFont:[CPFont systemFontOfSize:14.0]];
  } else {
    [_label setFont:[CPFont boldSystemFontOfSize:14.0]];
  }
  [_label setStringValue:[task task]];
  [_label sizeToFit];
}

- (void)setSelected:(BOOL)isSelected {
  [self setBackgroundColor:(isSelected ? [CPColor blueColor] : nil)];
  [_label setTextColor:(isSelected ? [CPColor whiteColor] : [CPColor blackColor])];
}

@end