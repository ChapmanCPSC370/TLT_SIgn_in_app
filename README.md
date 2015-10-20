#TLT SIgn-in app

**Description**:  An iOS (and potentially later Android too) app that allows students to sign into SI sessions with their smartphone.

- **Technology stack**: This iOS version of the app is done all in Xcode which integrates with github. The code is primarily in swift. This is a standalone project.
- **Status**:  Currently working on version 1.0 (beta).

## Dependencies

Needs Xcode 7 or higher and Swift 2 or higher. To install Xcode you need an Intel-based Mac running Mac OS X Snow Leopard or later. No additional libraries or frameworks needed at this point in development.

## Installation

1. Download Xcode from Mac app store.

2. Fork this repository and download all project files.

3. Open TLT_SIgn_in_app.xcodeproj with Xcode.

4. Go to 'Source Control' >> 'TLT_SIgn_in_app - Master' >> 'Configure TLT_SIgn_in_app...'

5. Navigate to Remotes and click the '+' in the bottom left. Write the name of the project and copy and paste the HTTPS clone url of your forked repo. Click add remote.

6. Whenever you commit changes make sure the checkbox for 'Push to Remote' is checked.

##Usage

1. Select if you are an SI or a student

2. If SI, input your name and ID number. If it matches up with a value in the list of current TLT SI's then you can input your SI sessions (can be repeating or single event).
If Student, input your name and ID number. You can then say which SI you are attending. 
Potentially use geolocation to verify.

3. The settings that will be saved: account info (name and ID number), repeating SI sessions, and selection of SI or student. There will be a settings page where you can switch from SI to student or vice versa in case you are both. It will also include your personal settings.

## Getting help

If you have questions, concerns, bug reports, etc, please file an issue in this repository's Issue Tracker.

Instructions on how to [CONTRIBUTE](CONTRIBUTING.md).

