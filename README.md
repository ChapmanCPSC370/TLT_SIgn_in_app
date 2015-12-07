#TLT SIgn-in app

**Description**:  An iOS app that allows students to sign into SI sessions with their smartphone.

- **Technology stack**: This iOS version of the app is done all in Xcode which integrates with github. The code is primarily in swift. This is a standalone project.
- **Status**:  Currently working on version 1.0 (beta).

## Dependencies

Needs [Xcode 7](https://developer.apple.com/xcode/download/) or higher and Swift 2 or higher. To install Xcode you need an Intel-based Mac running Mac OS X Snow Leopard or later. [Parse](https://www.parse.com) is needed for the backend.

##Getting Started

### Installation

If you want to completely fork the project:

1. Download Xcode from Mac app store.

2. Fork this repository and clone to desktop

3. Open TLT_SIgn_in_app.xcodeproj with Xcode.

4. [Install Parse](https://www.parse.com/apps/quickstart#parse_data/mobile/ios/swift/existing) (We are using parse 1.10.0)

###Usage

1. If first time user input firstname, lastname, and ID number. Then input current SI firstname and lastname.

2. Click submit. If SI data moves to tableview then the process is complete. If not, read/dismiss the error popup and reinput data. Tableview and user info will save to core data. [Design overview.](http://imgur.com/bL9h9jZ)

The [android version](https://play.google.com/store/apps/details?id=samyachour.tlt_sign_in_app_android) is just an app with a webview of [this](http://siandroidsignin.parseapp.com) webpage

**The online android web view form and iOS app will make sure**:

1. The user typed something in the text fields

2. What the user typed is in the correct format

3. The SI name that the user typed in exists in the database

4. The user has internet connection and can successfully update the parse database

### Getting help

If you have questions, concerns, bug reports, etc, please file an issue in this repository's Issue Tracker.

Instructions on how to [CONTRIBUTE](CONTRIBUTING.md).

###License

See the [MIT LICENSE](LICENSE.md) file for license rights and limitations.