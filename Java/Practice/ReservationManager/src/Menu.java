package hotel;


import java.util.List;
import java.util.ArrayList;
import java.util.Optional;

import java.util.stream.Stream;
import java.util.stream.Collectors;

import java.util.function.Consumer;
import java.util.function.Supplier;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;

// This class is responsible for the functioning of the menu system
public class Menu {

	private ArrayList<Supplier<List<Property>>> mainMethods = new ArrayList<>();
	private List<Property> properties;

	private Reservation reservation;

	private String name;

	String nameRegex = "^[A-Za-z ,.'-]+$";
	String emailRegex = "^[a-zA-Z\\d-\\.]+@([a-zA-Z\\d-]+\\.)+[\\w-]{2,4}$";
	

	public Menu(String name) throws Exception { 
		this.name = name;

		properties = CsvReader.readPropertiesFromCSV("../assets/Melbnb.csv");

		mainMethods.add(this::location);
		mainMethods.add(this::placeType);
		mainMethods.add(this::rating);
		mainMethods.add(() -> {System.exit(0); return null;});
	}

	public String getName() { return this.name; }

	// --------------------------------------------------------------------------- //
	// 								Part 0: Main menu (core)
	// --------------------------------------------------------------------------- //

	// The method to operate Melbnb
	public void run() throws Exception {
		// Step 0: Displaying menu.
		PrinterUtil.showBanner();
		System.out.println( String.format("\n%s\n",PrinterUtil.center("Welcome to " + name + "!", 80)) );
		PrinterUtil.showBanner();
		PrinterUtil.showHeading("Select from main menu");
		PrinterUtil.showMenu(PrinterUtil.Menus.MAIN_MENU_CHOICES);
		PrinterUtil.showBanner();

		// Step 1: Filtering by selection.
		int input = ScannerUtil.nextValidInt("Please select (numeric index) from the menu: ",
			PrinterUtil.toErrorFormat("Please select a valid menu option."),
			n -> n > 0 && n < 5) - 1;

		List<Property> choices = mainMethods.get(input).get();
		
		// Step 1.1: Check if no Property is found, then restart.
		// Choices will be null whenever "Return to main menu" is selected.

		if (choices == null) {
			restart();
			return;
		}

		// Step 2: Selection of Property.
		Property selectedProperty = choose(choices);

		// Step 2.1: Check if Property is reserved, then restart.
		if (selectedProperty.isReserved().get()) {
			System.out.println(PrinterUtil.toErrorFormat("Property is already reserved."));
			restart();
			return;
		}

		// Step 3: Selection of date.
		String[] dates = requestDates();

		// Step 3.1: Show the property data.
		PrinterUtil.showHeading("Show property details.");
		System.out.println(selectedProperty.toString(Long.parseLong(dates[2])));

		// Step 4: Check if user wants to confirm to reserve and pay.
		if (!toReserveAndPay()) {
			restart();
			return;
		}

		// Step 5: Collect the personal data of the User.
		String[] personalInfo = requestPersonalInfo();
		int guests = requestGuestsCount(selectedProperty);

		// Step 6: Create a reservation object and print the booking info.
		reservation = new Reservation(selectedProperty, dates[0], dates[1], Long.parseLong(dates[2]),
			personalInfo[0], personalInfo[1], personalInfo[2], guests);
		selectedProperty.isReserved().set(true);
		finalMessage();

		// Final: Restart.
		restart();
	}

	public void restart() throws Exception {
		System.out.println(PrinterUtil.toInfoFormat("Returning to the main-menu"));
		run();
	}

	// --------------------------------------------------------------------------- //
	// 								Part 1: Selection Filter
	// --------------------------------------------------------------------------- //

	// The method to search by location.
	private List<Property> location() {
		PrinterUtil.showHeading("Browse by location");

		String input = ScannerUtil.nextValidString("Please provide a location: ", PrinterUtil.toErrorFormat("Please provide a valid location."));
		List<Property> locations = getLocations(input);

		if (!showMenu(locations, "Select from matching list")) return location();
		return locations;
	}

	// The method to browse type of place.
	private List<Property> placeType() {
		PrinterUtil.showHeading("Browse by type of place");
		PrinterUtil.showMenu(PrinterUtil.Menus.PLACE_TYPES);
		PrinterUtil.showBanner();

		int input = ScannerUtil.nextValidInt("Please select (numeric index from above): ", 
			PrinterUtil.toErrorFormat("Please select a type of place from the list above (numeric index)."),
			n -> n > 0 && n <= 4) - 1;

		if (input == 3) return null;

		String placeType = PrinterUtil.Menus.PLACE_TYPES[input];
		List<Property> placeTypes = getPlaceTypes(placeType);

		if (!showMenu(placeTypes, "Select from private room list")) return placeType();
		return placeTypes;
	}

	// The method to filter rating.
	private List<Property> rating() {
		PrinterUtil.showHeading("Browse by rating");

		float input = ScannerUtil.nextValidFloat("Please provide the minimum rating: ",
			PrinterUtil.toErrorFormat("Please provide a valid minimum rating between range [0-5]"),
			d -> d >= 0.0 && d <= 5.0);

		List<Property> ratings = getRatings(input);
		if (!showMenu(ratings, "Select from private room list")) return rating();
		return ratings;
	}

	// --------------------------------------------------------------------------- //

	// Stream getters fot the filters.
	private List<Property> getLocations(String location) {
		return properties.stream()
			.filter(p -> p.location().toLowerCase().contains(location.toLowerCase()))
			.collect(Collectors.toList());
	}

	private List<Property> getPlaceTypes(String placeType) {
		return properties.stream()
			.filter(p -> p.placeType().equals(placeType))
			.collect(Collectors.toList());
	}

	private List<Property> getRatings(float rating) {
		return properties.stream()
			.filter(p -> p.rating() >= rating)
			.collect(Collectors.toList());
	}	

	// --------------------------------------------------------------------------- //

	// Displayer for the filters
	private boolean showMenu(List<Property> menu, String message){
		Optional<String> unit = menu.stream()
			.map(p -> p.property())
			.findAny();

		String[] menuArray = menu.stream()
			.map(p -> p.isReserved().get() ? PrinterUtil.toErrorFormat(p.property()) : PrinterUtil.toSuccessFormat(p.property()))
			.toArray(String[]::new);

		unit.ifPresentOrElse(e -> {
			PrinterUtil.showHeading(message);
			PrinterUtil.showMenu(menuArray);
			PrinterUtil.showBanner();
		}, () -> {
			System.out.println(PrinterUtil.toErrorFormat("No such element found."));
		});

		return unit.isPresent();
	}

	// --------------------------------------------------------------------------- //
	// 								Part 2: Room Selection
	// --------------------------------------------------------------------------- //

	private Property choose(List<Property> choices) {

		int selectedChoice = ScannerUtil.nextValidInt("Please select (numeric index) from the list above: ",
			PrinterUtil.toErrorFormat("Please select a valid list option."),
			n -> n > 0 && n <= choices.size()) - 1;
		return choices.get(selectedChoice);
	}

	// --------------------------------------------------------------------------- //
	// 								Part 3: Date Selection
	// --------------------------------------------------------------------------- //

	private String[] requestDates() {
		PrinterUtil.showHeading("Select Dates");
		DateTimeFormatter format = DateTimeFormatter.ofPattern("dd/MM/uuuu");

		String checkin = ScannerUtil.nextValidDate("Please provide a check-in date (dd/mm/yyyy): ",
			PrinterUtil.toErrorFormat("Please provide a valid check-in date (dd/mm/yyyy)."));
		
		String checkout = ScannerUtil.nextValidDate("Please provide a checkout date (dd/mm/yyyy): ",
			PrinterUtil.toErrorFormat("Please provide a valid checkout date (dd/mm/yyyy)."));

		Long dateDelta = LocalDate.parse(checkout, format).toEpochDay() - LocalDate.parse(checkin, format).toEpochDay();

		if (dateDelta >= 0) 
			return new String[] {checkin, checkout, dateDelta.toString()};

		System.out.println(PrinterUtil.toErrorFormat("Checkout date must be after check-in date."));
		return requestDates();
	}

	// --------------------------------------------------------------------------- //
	// 					Part 4: Confirm Reservation And Payment
	// --------------------------------------------------------------------------- //

	private boolean toReserveAndPay() {
		boolean confirm = ScannerUtil.parseNextBoolean("Would you like to reserve the property? [Y/n]: ",
			PrinterUtil.toErrorFormat("Please enter a valid choice [Y/yes/true/1/n/no/false/0]."));
		if (!confirm) return false;

		return ScannerUtil.parseNextBoolean("Confirm and Pay? [Y/n]: ",
			PrinterUtil.toErrorFormat("Please enter a valid choice [Y/yes/true/1/n/no/false/0]."));
	}

	// --------------------------------------------------------------------------- //
	// 						Part 5: Personal Info Collection
	// --------------------------------------------------------------------------- //

	private String[] requestPersonalInfo() {
		return new String[] {
			requestFirstName(),
			requestSurname(),
			requestEmail()
		};
	}

	// --------------------------------------------------------------------------- //

	private String requestFirstName() {
		return new Assertable<String>(ScannerUtil.nextValidString("Please provide your first name: ", 
			PrinterUtil.toErrorFormat("First name cannot be null.")), false)
			.assertElseWarn(s -> !s.matches("^\\d+$"), PrinterUtil.toErrorFormat("First name cannot be a number."))
			.assertElseWarn(s -> s.length() > 1 && s.length() <= 30, PrinterUtil.toErrorFormat("First name must be between [2-30] characters long."))
			.assertElseWarn(s -> s.matches(nameRegex), 
				PrinterUtil.toErrorFormat("First name can contain only the characters a-z, A-Z, space, period, comma, hyphen and apostrophe."))
			.getIfTrueElseDo(this::requestFirstName);
	}

	private String requestSurname() {
		return new Assertable<String>(ScannerUtil.nextValidString("Please provide your surname: ", 
			PrinterUtil.toErrorFormat("Surname cannot be null.")), false)
			.assertElseWarn(s -> !s.matches("^\\d+$"), PrinterUtil.toErrorFormat("Surname cannot be a number."))
			.assertElseWarn(s -> s.length() > 1 && s.length() <= 30, PrinterUtil.toErrorFormat("Surname must be between [2-30] characters long."))
			.assertElseWarn(s -> s.matches(nameRegex), 
				PrinterUtil.toErrorFormat("Surname can contain only the characters a-z, A-Z, space, period, comma, hyphen and apostrophe."))
			.getIfTrueElseDo(this::requestSurname);
	}

	private String requestEmail() {
		return new Assertable<String>(ScannerUtil.nextValidString("Please provide your email address: ", 
			PrinterUtil.toErrorFormat("Email address cannot be null.")), false)
			.assertElseWarn(s -> !s.matches("^\\d+$"), PrinterUtil.toErrorFormat("Email Address cannot be a number."))
			.assertElseWarn(s -> s.length() > 2 && s.length() <= 60, PrinterUtil.toErrorFormat("Email Address must be between [3-60] characters long."))
			.assertElseWarn(s -> s.matches(emailRegex), 
				PrinterUtil.toErrorFormat("Email Address must be of correct format."))
			.getIfTrueElseDo(this::requestEmail);
	}

	// --------------------------------------------------------------------------- //

	private int requestGuestsCount(Property property) {
		return new Assertable<Integer> (ScannerUtil.nextValidInt("Please provide the number of guests: ",
			PrinterUtil.toErrorFormat("Capacity of Property exceeded. (Max number of guests is " + property.maxGuests() + ")."),
			n -> n <= property.maxGuests()), false)
		.assertElseWarn(n -> n > 0, PrinterUtil.toErrorFormat("Atleast one guest may visit."))
		.getIfTrueElseDo(() -> this.requestGuestsCount(property));
	}

	// --------------------------------------------------------------------------- //
	// 						Part 6: Final Output
	// --------------------------------------------------------------------------- //

	private void finalMessage() {
		PrinterUtil.showBanner();
		System.out.println(PrinterUtil.Menus.PAYMENT_CONFIRM_MESSAGE);
		PrinterUtil.showBanner();
		System.out.println(reservation);
		PrinterUtil.showBanner();
	}
}
