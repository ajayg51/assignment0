# assignment0 -- De Nada Assignment - Use BLoC State Management tool

```

    *    An android/iOS app to get weather details of any place in [India, Nepal, Bhutan, Myanmar and Sri Lanka]
    *    Auto detects location, quits app on error and fetches device location weather info.

```
 

# bug
```

  $ App sometimes logs out by itself after choosing different location city and fetching weather info for it.


```

## Installation
<a href="https://github.com/ajayg51/assignment0/raw/main/app-contents/github-apk/app-release.apk">Click here to download apk</a>

##  Demo video

https://github.com/ajayg51/assignment0/assets/60037249/b103e6dc-4bec-404f-aa95-3a55689f611f





##   BLoC vs Getx

###   BLoC

```
     *   strong typing thus easy to catch errors 
     *   testability -> separation of business logic and presentation logic making it
     *   easier to write unit tests for app
     *   scalability -> scalable, suitable for all project sizes
     *   community support
```

###   GetX

```
     *   no strong typing -> debugging is difficult
     *   less testability
     *   less scalability
```

```
     *   strong typing thus easy to catch errors 
     *   testability -> separation of business logic and presentation logic making it
     *   easier to write unit tests for app
     *   scalability -> scalable, suitable for all project sizes
     *   community support
```

##  Problem statement 26 Feb 2024

![0](https://github.com/ajayg51/assignment0/assets/60037249/77c0a12d-3653-4540-a634-33c404a07947)
![1](https://github.com/ajayg51/assignment0/assets/60037249/265a4b42-e4bd-4427-a7bd-796f2d1b8bab)
![2](https://github.com/ajayg51/assignment0/assets/60037249/cbed2fb1-f7b5-4467-aab5-6ae449ab153d)


## Tech stack
```
    *  Dart
    *  Flutter
```

##  Libraries Used
```
      *    flutter_bloc for BLoC implementation, 

      *    dio for HTTP requests

      *    get_it for dependency injection. 

      *    auto_route for navigation   

      *    Hive for the local database 

```

##   Functionality
```
    1. Firebase Authentication with email. 

    2. Auth states should be saved locally.  Shows User details

    3. Gets the current location of your device 

    4. Fetches weather data from a weather API (OpenWeatherMap)

    5. Displays weather information for your location (e.g. weather conditions, temperature, location). 

    6. Saves locally the last fetched weather info, 

    In case of any network error shows the last weather info from the local db. 

    7. Fetches searched location weather data

```

##    UI/UX
```

    1. Splash screen 

    2. Auth screens for signup and sign-in. 

    3. Home screen where weather info is displayed and  signout button. 

    4. For selecting another location navigate to a different screen where the user can select or enter the new location. After selecting the new location, the screen will be
        popped and the data on the home screen should update with the newly selected location
```





