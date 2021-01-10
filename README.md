# Weather App

This Weather application is developed using Flutter Framework. I have followed clean code architecture, used [flutter bloc](https://pub.dev/packages/flutter_bloc) for state management and [dartz](https://pub.dev/packages/dartz) which makes error handling easier. 

This app basically have 3 screens namely splash screen, login or sign up screen and dashboard screen to display weather information. 

To authenticate user, I have used [firebase authenticaton](https://pub.dev/packages/firebase_auth). Once the user is authenticatd, whenever he opens the app, he will be directly taken to dashboard screen after splash srcreen. 

To get details about weather depending upon the city, I have used [Open Weather API](https://openweathermap.org/). [Firebase remote config](https://pub.dev/packages/firebase_remote_config) is used to secure the weather app api key.

This app uses current location to fetch weather information. If location permission is denied, then default location coordinate is used. In addition to this, user can manually enter city name to check the weather.

For project demo, I have attached a video below.
<p align="center">
<img src="demo.gif" width="220" height="450"/>
</p>
