#TLT SIgn-in app

**Description**:  An iOS (and potentially later Android too) app that allows students to sign into SI sessions with their smartphone.

- **Technology stack**: This iOS version of the app is done all in Xcode which integrates with github. The code is primarily in swift. This is a standalone project.
- **Status**:  Currently working on version 1.0 (beta).

## Dependencies

Needs Xcode 7 or higher and Swift 2 or higher. To install Xcode you need an Intel-based Mac running Mac OS X Snow Leopard or later. Parse is needed for the backend.

## Installation

If you want to completely fork the project:

1. Download Xcode from Mac app store.

2. Fork this repository and download all project files.

3. Open TLT_SIgn_in_app.xcodeproj with Xcode.

4. Go to 'Source Control' >> 'TLT_SIgn_in_app - Master' >> 'Configure TLT_SIgn_in_app...'

5. Navigate to Remotes and click the '+' in the bottom left. Write the name of the project and copy and paste the HTTPS clone url of your forked repo. Click add remote.

6. Whenever you commit changes make sure the checkbox for 'Push to Remote' is checked.

If you want to edit specific files (ie Viewcontroller.swift)

1. Download Xcode from Mac app store.

2. Fork this repository and download all project files.

3. Open TLT_SIgn_in_app.xcodeproj with Xcode.

4. Push any edits made to individual files

##Usage

1. If first time user input firstname, lastname, and ID number. Then input current SI firstname, lastname, and date separated by forward slashes.

2. Click submit. If SI data moves to tableview then the process is complete. If not reinput data. Tableview and user info will save to core data. [Design overview.](Design_overview.png)

## Getting help

If you have questions, concerns, bug reports, etc, please file an issue in this repository's Issue Tracker.

Instructions on how to [CONTRIBUTE](CONTRIBUTING.md).
