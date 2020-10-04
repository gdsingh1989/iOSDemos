State restoration refers to the process of preserving and restoring the state of your app. In plain language, you restore your app such that user can continue where they left off. This gives an impression to the user that app had been already running. UIKit is responsible for preservation and restoration of your app. UIKit preserves the state of your views and view controllers into an encrypted file on disk. For enabling state restoration on your app, follow these steps:

1.Enable support for state preservation and restoration. You do this by adding the following delegates into the app delegate of the app: 

func application(_ application: UIApplication, shouldSaveApplicationState coder: NSCoder) -> Bool {
return true
}

func application(_ application: UIApplication, shouldRestoreApplicationState coder: NSCoder) -> Bool {
return true
}

These delegates tell the UIKit that it needs to preserve the state of the app. The shouldSaveApplicationState delegate is called when the app goes to background state. The shouldRestoreApplicationState delegate is called when you launch your app , if preserved state information is available.

2. Assign Restoration Identifiers to view controllers that you want to restore. This also includes any root level objects. UIKit preserves those view controllers which have a valid restoration identifier.

3. Encode any custom information that you want to save. You do this by providing an method definition of :

func encodeRestorableState(with coder: NSCoder) {}

During the preservation UIKit calls this method of the view controller. You should save any information which you need at the time of restoration.

4. Decode any available information and use it .You do this inside the following method :

override func decodeRestorableState(with coder: NSCoder) {}

When you relaunch your app and it has state information preserved, UIKit consults the App Delegate shouldRestoreApplicationState delegate to determine if restoration should proceed. UIKit calls each view controller's decodeRestorableState(with:) method to restore its state.
