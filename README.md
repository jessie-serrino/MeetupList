# Tendigi Coding Challenge
I was asked to create an app that pulls the latest results on technology meetups using Meetup's open_events API. This is the result of that work.

## Architecture
The project was divided up into 4 main sections: models, views, view controllers, and utilities. I chose these sections to make sure that there was one section of the code base responsible for each of the following needs
* A clean representation of data (Model)
* All background processing  (Utilities)
* Strictly aesthetics (View)
* Interactor between all of these pieces (View Controller)

Each step made it easier for me to understand dependencies when a certain part broke. Here is a more in-depth description about how these pieces work together

### Models
Models were based out of the data that Meetup returned back. This was divided into two basic categories: Meetup and Venue. These classes were to represent the data at hand, not to manipulate it.

### Views
There was only one true view declared (outside of the storyboard). This was the Spinning Wheel View, used to wait for loading.

### View Controllers
There were three view controllers:
* **MapViewController** (helping the user determine where they want to search for meetups)
* **MeetupTableViewController** (displaying to the user all available meetups)
* **MeetupDetailViewController** (displaying to the user more information about a specific meetup)

These were left as "dumb" as possible, as they should not do any of the core processing of the application by themselves.

### Utilities
There were three main utilites.
At the core of it all, **DataRequester** changed standard AFNetworking requests into more palatable requests for another class.

**MeetupProvider** was a subclass of DataRequester. It was used as a facade for meetup information, to not expose to the ViewControllers all information about meetups themselves. It was the source of this information by both requesting and providing data about meetups.

**MeetupInteractor** basically made all of the information coming from the server palatable. It was used exclusively to help construct models out of raw data.

### Cocoa Extensions
I also wrote a few Cocoa Extensions. One was to make NSURLs that include parameters for a query. The other was to center the map view on a specific coordinate and box size.


## Developer's Notes
This was a fun project-- very similar to what I tried to do with Congressive. Thanks for reviewing it, and I look forward to hearing your feedback.
