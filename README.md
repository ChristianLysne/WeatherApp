# WeatherApp
Weather app in Swift

#Screenshot
![alt tag](https://cloud.githubusercontent.com/assets/12391750/16547281/89167db0-4168-11e6-8a05-1a69113d96b5.png)

#Features
The app displays today's weather for the users current location. It provides information about temperature (current, min, max), rain, wind force and direction. It provides error messages if the user does not have network access or the request times out (with a retry button), if the data could not be parsed and if the location could not be found (Remember to simulate a location on your simulator). If the permission for the user's location is denied then an error message will be displayed, together with a button to take the user to the settings page to update the permission.

#Architecture - Clean Swift
Clean-Swift architecture is used in this project to provide good boundaries between interaction, view and business logic. The viewcontrollers output is the interactors input. The interactors output is the presenters input. The presenters output is the viewcontrollers input. This creates a unidirectional flow of data, where each input/output is implemented using protocols. This makes the individual components easy to mock and test. In this project the Interactor does the work of fetching the data and updating the user's location. The presenter recieves the model and turns it into a viewmodel that it can pass on to the viewcontroller. The viewcontroller just displays whatever data it is given. When the user interacts with buttons (like the try-again button), the viewController then outputs that user interaction, which is the Interactors input, and the Interactor begins the relevant work for that interaction. More on Clean-Swift can be found here: [Clean-Swift](http://clean-swift.com)
![alt tag](https://cloud.githubusercontent.com/assets/12391750/16547283/8caf44b6-4168-11e6-9736-af1c6b9fd646.png)

#Testing
This project has mocked everything that have to do with networking code, using [Masilotti's approach](http://masilotti.com). This makes sure that unit tests and UI-tests can run without being dependent on network access or the speed of the network. The UI-tests runs with static responses and the unit tests use a mocked HTTP client to give the wanted response, status code and error for each test.

#Future improvements
Better transition between states (loading, error, display weather).
Display forecasts for the next 7 days.
Option for Celsius, Fahrenheit or Kelvin.
