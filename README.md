# Pokemon
Overview
Pokémon App is a native iOS application that allows users to browse a list of Pokémon fetched from the public Pokémon API. Users can view detailed information about each Pokémon, search for specific Pokémon by name, and navigate through the list with pagination.
Libraries Used
	•	UIKit: Used for building the user interface and handling user interactions.
	•	URLSession: Used for making network requests to the Pokémon API.
App Architecture
The app follows a Model-View-Controller (MVC) architecture:
	•	Model: Represents the data structures used in the app, such as Pokémon objects and their attributes.
	•	View: Represents the visual elements of the app's user interface, including table view cells, search bar, and detail screens.
	•	Controller: Manages the flow of data between the model and view, including fetching data from the Pokémon API, handling user interactions, and updating the UI accordingly.
Building and Running the App
To build and run the app:
		Clone the repository to your local machine.
		Open the project in Xcode.
		Build and run the project on a simulator or a physical iOS device.
Ensure you have an active internet connection to fetch data from the Pokémon API.
Important Notes
	•	The app fetches Pokémon data from the public Pokémon API. Make sure you have a stable internet connection while using the app.
	•	Pagination is implemented to fetch additional Pokémon as the user scrolls through the list.
	•	Error handling is implemented to handle cases such as failed API requests or invalid Pokémon data.
	•	The app supports searching for Pokémon by name, allowing users to quickly find specific Pokémon.
