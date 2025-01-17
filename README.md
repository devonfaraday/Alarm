# Alarm

Students will build a simple alarm app to practice intermediate table view features, protocols, the delegate pattern, NSCoding, UILocalNotifications, and UIAlertControllers.

Students who complete this project independently are able to:

### Part One - Intermediate TableViews, Delegate Pattern

* Implement a master-detail interface
* Implement the `UITableViewDataSource` protocol
* Implement a static `UITableView`
* Create a custom `UITableViewCell`
* Write a custom delegate protocol
* Wire up view controllers to model object controllers
* Work with `NSDate` and `NSDateComponents`
* Add staged data to a model object controller

### Part Two - NSCoding, Protocol Extensions, UILocalNotifications, UIAlertControllers

* Create model objects that conform to the `NSCoding` protocol
* Create model object controllers that use `NSKeyedArchiver` and `NSKeyedUnarchiver` for data persistence
* Present and respond to user input from `UIAlertController`s
* Schedule and cancel `UILocalNotification`s 
* Create custom protocols
* Implement protocol functions using protocol extensions to define protcol function behavior across all conforming types

## Part One - Intermediate TableViews, Delegate Pattern

### View Hierarchy

Set up a basic List-Detail view hierarchy using a UITableViewController for a AlarmListTableViewController and a AlarmDetailTableViewController. Use the provided screenshots as a reference.


### Custom Table View Cell

Build a custom table view cell to display alarms. The cell should display the alarm time and name and have a switch that will toggle whether or not the alarm is enabled.

It is best practice to make table view cells reusable between apps. As a result, you will build a `SwitchTableViewCell` rather than an `AlarmTableViewCell` that can be reused any time you want a cell with a switch. You will create outlets and actions from Interface Builder in this custom cell, and create an `alarm` property with a `didSet` observer used to populate the cell with details about the alarm.



### Static Table View

Build a static table view as the detail view for creating and editing alarms.

 Static table views do not need to have UITableViewDataSource functions implemented. Instead, you can create outlets and actions from your prototype cells directly onto the view controller (in this case `AlarmDetailTableViewController`) as you would with other types of views.

### Understanding Alarm Model Object

You have been given a file called ``Alarm.swift`` that contains your Alarm model object. This model object makes extensive use of NSDates and NSDateComponents. Although we did not make you create this class from scratch, we expect you to understand why it was made and how each line of code works.

Create an Alarm model class that will hold a fireTimeFromMidnight, name, an enabled property, and computed properties for fireDate and fireTimeAsString. The fireTimeFromMidnight property will store the time of day that the alarm should go off. The fireDate property will be used in part 2 of this project to schedule notifications to the user for the alarm, and the fireTimeAsString will be used to display the time of day that the alarm should go off.

1. Your Alarm class will keep track of the time each day that the alarm should file, the name of the alarm, and whether or not the alarm is enabled. `fireTimeFromMidnight` stores an NSTimeInterval, which represents the number of seconds from midnight. `name` is simply a `String` representing the name, and `enabled` is a `Bool` that we will set to true if the alarm is enabled and false otherwise.
2. A UUID is a Universally Unique Identifier. The `uuid` on the Alarm object will be used later to schedule and cancel local notifications
2. Add properties for `fireTimeFromMidnight` as an `NSTimeInterval`, `name` as a `String`, `enabled` as a `Bool`, and `uuid` as a `String`. A UUID is a Universally Unique Identifier. This will be used in part two of this project for identifying, scheduling, and canceling local notifications.
4. The computed property for `fireDate` is a computed property that each day will compute the `NSDate` that should be used to schedule a local notification for that alarm.
6. `fireTimeAsString` will be used to represent the time you want the alarm to fire. This is simply for the UI.

### Controller Basics

Create an `AlarmController` model object controller that will manage and serve `Alarm` objects to the rest of the application. 

### Controller Staged Data Using a Mock Data Function

Add mock alarm data to the AlarmController. Once there is mock data, teams can serialize work, with some working on the views with visible data and others working on implementing the controller logic. This is a quick way to get objects visible so you can begin building the views.

There are many ways to add mock data to model object controllers. We will do so using a computed property.



### Wire up the Alarm List Table View and implement the property observer pattern on the `SwitchTableViewCell` class.

Fill in the table view data source functions required to display the view.




-------------------------------------------------------------------------------------------------------------



2. Add a `didSet` observer that updates the labels to the time and name of the alarm, and updates the `alarmSwitch.on` property so that the switch reflects the proper alarm `enabled` state.
--------------------------------------------------------------------------------------------------------------



### Custom Protocol


### Wire up the Alarm Detail Table View

Create functions on the detail table view controller to display an existing alarm and setup the view properly.


2. Create a private `updateViews()` function that will populate the date picker and alarm title text field with the current alarm's date and title. This function that will hide the enable button if `self.alarm` is nil, and otherwise will set the enable button to say "Disable" if the alarm in `self.alarm` is enabled, and "Enable" if it is disabled. You may consider changing background color and font color properties as well to make the difference between the two button states clear.
	*note: You must guard against the alarm being nil, or the view controller's view not yet being loaded and properly handle these cases.
3. Create a `didSet` property observer on the `alarm` property that will call `updateViews()` when the alarm property changes.
4. In `viewDidLoad`, call `updateViews()` to display an alarm if there is an existing alarm.

### Prepare For Segue

Fill in the `prepareForSegue` function on the `AlarmListTableViewController` to properly prepare the next view controller for the segue.

1. On the `AlarmListTableViewController`, add an if statement to the `prepareForSegue` function checking that the segue's identifier matches the identifier of the segue that goes from a cell to the detail view.
2. Get the destination view controller from the segue and cast it as an `AlarmDetailTableViewController`.
3. Get the indexPath of the selected cell from the table view.
4. Use the `indexPath.row` to get the correct alarm that was tapped from the `AlarmController.sharedInstance.alarms` array.
5. Set the `alarm` property on the destination view controller equal to the above alarm.
    * If the compiler presents an error when trying to do this, you either forgot to cast the destination view controller as an `AlarmDetailTableViewController` or forgot to give the `AlarmDetailTableViewController` a property title `alarm` of type `Alarm?`.
    * At this point you should be able to run your project and see your table view populated with your mock alarms, displaying the proper switch state. You should also be able to delete rows, and segue to a detail view from a cell. This detail view should display the proper time of the alarm, the proper title, and the proper state of the enable/disable button.

### Final functionality on the detail view

Fill in the `saveButtonTapped` function on the detail view so that you can add new alarms and edit existing alarms.

1. Use `DateHelper.thisMorningAtMidnight` to find the time interval between this morning at midnight and the `datePicker.date`.
2. Unwrap `self.alarm` and if there is an alarm, call your `AlarmController.sharedInstance.updateAlarm` function and pass it the time interval you just created and the title from the title text field.
3. If there is no alarm, call your `AlarmController.sharedInstance.addAlarm` function to create and add a new alarm.
    * note: You should be able to run the project and have what appears to be a fully functional app. You should be able to add, edit, and delete alarms, and enable/disable alarms. We have not yet covered how to alert the user when time is up, so that part will not work yet, but we'll get there.

## Part Two - NSCoding, Protocol Extensions, UILocalNotifications, UIAlertControllers

### Conform to the NSCoding Protocol

Make your `Alarm` object conforom to the NSCoding protocol so that we persist alarms across app launches using NSKeyedArchiver and NSKeyedUnarchiver.

1. Adopt the NSCoding protocol and add the required `init?(coder aDecoder: NSCoder)` and `encodeWithCoder(aCoder: NSCoder)` functions. You should review NSCoding in the documentation before continuing.
2. Inside each, you will use the NSCoder provided from the initializer or function to either encode your properties using `aCoder.encodeObject(object, forKey: key)` or decode your properties using `aDecoder.decodeObjectForKey(key)`. 
    * note: It is best practice to create static internal keys to use in encoding and decoding (ex. `private let kName = "name"`)

### Persistence With NSKeyedArchiver and NSKeyedUnarchiver

Add persistence using NSKeyedArchiver and NSKeyedUnarchiver to the AlarmController. Archiving is similar to working with NSUserDefaults, but uses NSCoders to serialize and deserialize objects instead of our `initWithDictionary` and `dictionaryRepresentation` functions. Both are valuable to know and be comfortable with.

NSKeyedArchiver serializes objects and saves them to a file on the device. NSKeyedUnarchiver pulls that file and deserializes the data back into our model objects.

Because of the way that iOS implements security and sandboxing, each application has it's own 'Documents' directory that has a different path each time the application is launched. When you want to write to or read from that directory, you need to first search for the directory, then capture the path as a reference to use where needed.

It is best to separate that logic into a separate function that returns the path. Here is an example function:

```
static private var persistentAlarmsFilePath: String? {
    let directories = NSSearchPathForDirectoriesInDomains(.documentDirectory, .allDomainsMask, true)
    guard let documentsDirectory = directories.first as NSString? else { return nil }
    return documentsDirectory.appendingPathComponent("Alarms.plist")
}
```

This function accepts a string as a key and will return the path to a file in the Documents directory with that name. 

1. Add a private, static, computed property called `persistentAlarmsFilePath` which returns the correct path to the alarms file in the app's documents directory as described above.
2. Write a private function called `saveToPersistentStorage()` that will save the current alarms array to a file using NSKeyedArchiver
    * note: ``NSKeyedArchiver.archiveRootObject(self.alarms, toFile: persistentAlarmsFilePath)`
3. Write a function called `loadFromPersistentStorage()` that will load saved Alarm objects and set self.alarms to the results
    * note: Capture the data using `NSKeyedUnarchiver.unarchiveObjectWithFile(persistentAlarmsFilePath)`, unwrap the Optional results and set self.alarms
3. Call the `loadFromPersistentStorage()` function when the AlarmController is initialized
4. Call the `saveToPersistentStorage()` any time that the list of alarms is modified
    * note: You should now be able to see that your alarms are saved between app launches.

### Register the App for UILocalNotifications

Register for local notifications when the app launches.

1. In the `AppDelegate.swift` file in the `application(_:didFinishLaunchingWithOptions:)` function, create an instance of UIUserNotificationSettings.
2. Using the above settings, register user notification settings with the application's shared application.
    * note: Without this, the user will not ever be notified, even if you have schedule a local notification

### Schedule and Cancel Local Notifications using a Custom Protocol and Extension

You will need to schedule local notifications each time you enable an alarm, and cancel local notifications each time you disable an alarm. Seeing as you can enable/disable an alarm from both the list and detail view, we normally would need to write a `scheduleLocalNotification(for alarm: Alarm)` function and a `cancelLocalNotification(for alarm: Alarm)` function on both of our view controllers. However, using a custom protocol and a protocol extension, we can write those functions only once, and use them in each of our view controllers as if we had written them in each view controller.

1. In your `AlarmController` file but outside of the class, create a `protocol AlarmScheduler`. This protocol will need two functions: `scheduleLocalNotification(for alarm: Alarm)` and `cancelLocalNotification(for alarm: Alarm)`.
2. Below your protocol, create a protocol extension, `extension AlarmScheduler`. In there, you can create default implementations for the two protocol functions.
3. Your `scheduleLocalNotification(for alarm: Alarm)` function should create an instance of a UILocalNotification, give it an alert title, alert body, and fire date. You will also need to set it's `category` property to something unique (hint: the unique identifier we put on each alarm object is pretty unique). It should also be set to repeat at one day intervals. You will then need to schedule this local notification with the application's shared application.
4. Your `cancelLocalnotification(for alarm: Alarm)` function will need to get all of the application's scheduled notifications using `UIApplication.sharedApplication.scheduledLocalNotifications`. This will give you an array of local notifications. You can loop through them and cancel the local notifications whose category matches the alarm using `UIApplication.sharedApplication.cancelLocalNotification(notification: notification)`.
5. Now go to your list view controller and detail view controller and make them conform to the `AlarmScheduler` protocol. Notice how the compiler does not make you implement the schedule and cancel functions from the protocol. This is because by adding an extension to the protocol, we have created the implementation of these functions for all classes that conform to the protocol.
6. Go to your `AlarmListTableViewController`. In your `switchCellSwitchValueChanged` function you will need to schedule a notification if the switch is being turned on, and cancel the notification if the switch is being turned off. You will also need to cancel the notification when you delete an alarm.
7. Go to your `AlarmDetailTableViewController`. Your `enableButtonTapped` action will need to either schedule or cancel a notification depending on its state, and will also need to call your `AlarmController.sharedInstance.toggleEnabled(for alarm: Alarm)` function if it isn't being called already. Your `saveButtonTapped` method will need to schedule a notification when saving a brand new alarm, and will need to cancel and re-set a notification when saving existing alarms (this is because the user may have changed the time for the alarm).

### Present a UIAlertController

At this point, the app should schedule alarms, and should present local notifications to the user when the app is not opened and the alarm goes off. We still want to present an alert to the user when the app is open and the alarm goes off.

1. Go to the `AppDelegate.swift` file and add the function `application(application: UIApplication, didReceiveLocalNotification notification: UILocalNotification)`. This will be called when a local notification fires and the user has the app opened.
2. Initialize a UIAlertController of style `.Alert`. Add a dismiss action to it, and present it from the `window?.rootViewController` property.

The app should now be finished. Run it, look for bugs, and fix anything that seems off.

## Contributions

Please refer to CONTRIBUTING.md.

## Copyright

© DevMountain LLC, 2015-2016. Unauthorized use and/or duplication of this material without express and written permission from DevMountain, LLC is strictly prohibited. Excerpts and links may be used, provided that full and clear credit is given to DevMountain with appropriate and specific direction to the original content.
