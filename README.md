# Dropt (abandoned)

"Dropt" is a dead man's switch that sends an SOS message if the user is incapacitated. 

(This app is mostly complete, but has been abandoned due to conflicts with Apple's App Store policies. It started as a standalone passcode function (thus the name PASSWORD in the project files), but grew into a larger "dead man's switch" application.)

It currently allows the user to create, verify and save a passcode to the keychain which then enables them to activate the app. They can also import contacts from iOS and save them to core data. If the user grabs and holds the phone with their finger(s) on the activation screen and then releases the phone (due to being attacked, injured, etc.), a countdown timer initiates. The user then has 7 seconds to re-enter their passcode before an "alarm" is issued.

The app would have ultimately sent a text message with an alert and geolocation data to the imported contacts. This specific function runs afoul of Apple's policies, so I abandoned the app with this funciton left incomplete.

Project status at time of abandoment:

- Creation, verification and storage of passcode via custom UI (passcode saved to keychain) -> working
- Importing and deletion of user contacts, which are saved to core data -> working
- SMS function to send alarm with geolocation data -> unfinished (calls Apple's message view controller function, but no core data is added to function)
- Custom SMS message field -> never created
- Function to adjust timer length -> never created
 - UI -> mostly complete (passcode screen lacks back button; functions currently linked to "check" button, which is to be deleted; internal "delete" button needs to be deleted; background colors need to be changed; UI elements need to be adjusted for aesthetics/user-friendliness)
 - Code -> needs to be significantly cleaned up; many functions that should be moved into model classes currently exist in the view controllers 

Thanks for checking out my (incomplete) app! 


