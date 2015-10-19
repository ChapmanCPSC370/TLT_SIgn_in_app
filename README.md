#TLT SIgn-in app

**Description**:  An iOS (and potentially later Android too) app that allows students to sign into SI sessions with their smartphone.

- **Technology stack**: This iOS version of the app is done all in Xcode which integrates with github. The code is primarily in swift. This is a standalone project.
- **Status**:  Currently working on version 1.0 (beta).

## Dependencies

Needs Xcode 7.0.1 or higher and Swift 2.0 or higher. To install Xcode you need an Intel-based Mac running Mac OS X Snow Leopard or later. No external libraries or frameworks needed at this point in development.

## Installation

Download

##Usage

1. Select if you are an SI or a student

2. If SI, input your name and ID number. If it matches up with a value in the list of current TLT SI's then you can input your SI sessions (can be repeating or single event).
If Student, input your name and ID number. You can then say which SI you are attending. 
Potentially use geolocation to verify.

3. The settings that will be saved: account info (name and ID number), repeating SI sessions, and selection of SI or student. There will be a settings page where you can switch from SI to student or vice versa in case you are both. It will also include your personal settings.

## Getting help

If you have questions, concerns, bug reports, etc, please file an issue in this repository's Issue Tracker.

Instructions on how to contribute here: [CONTRIBUTING](CONTRIBUTING.md).

