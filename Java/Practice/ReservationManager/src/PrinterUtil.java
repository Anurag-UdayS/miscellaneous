package hotel;

import java.util.function.Consumer;

public class PrinterUtil {

	private static final String banner = "-".repeat(80);
	private static final Consumer<String> printer = System.out::print;

	public static class Menus {
		public static final String[] PLACE_TYPES = {
			"Private room",
			"Entire place",
			"Shared room",
			"Go to main menu"
		};

		public static final String[] MAIN_MENU_CHOICES = {
			"Search by location",
			"Browse by type of place",
			"Filter by rating",
			"Exit"
		};

		public static final String PAYMENT_CONFIRM_MESSAGE = toSuccessFormat(new StringBuilder()
			.append("> Congratulations! Your trip is booked.\n")
			.append("  A receipt has been sent to your email.\n")
			.append("  Details of your trip are shown below.\n")
			.append("  Your host will contact you before your trip.\n")
			.append("  Enjoy your stay!\n")
			.toString());

	}

	// The utility to make a string red.
	public static String toErrorFormat(String message) {
		return "\u001B[31m" + message + "\u001B[0m";
	}
	// The utility to make a string green.
	public static String toSuccessFormat(String message) {
		return "\u001B[32m" + message + "\u001B[0m";
	}
	// The utility to make a string orange/yellow.
	public static String toInfoFormat(String message) {
		return "\u001B[1;33m" + message + "\u001B[0m";
	}

	// The utility to center a string.
	public static String center(String original, int length, char padding) {
		String pad = "" + padding;
		int size = length - original.length();
		if (size < 0)
			return original;
		else if ( (size & 1) == 0) 
			return pad.repeat(size / 2) + original + pad.repeat(size / 2);
		else
			return pad.repeat(size / 2 + 1) + original + pad.repeat(size / 2);
	}

	public static String center(String original, int length) { return center(original, length, ' '); }

	public static String getBanner() {
		return banner;
	}

	public static String getHeading(String msg) {
		return String.format("\n%s\n%s\n%s\n%s\n%s\n", banner, banner, center("> " + msg + " <", 80), banner, banner);
	}

	public static String getMenu(String[] menu) {
		StringBuilder sb = new StringBuilder();
		for (int i = 0; i < menu.length; i++) 
			sb.append("\t")
				.append(i + 1)
				.append(") ")
				.append(menu[i])
				.append("\n");
		return sb.toString(); 
	}

	public static void showBanner() { printer.accept(banner + "\n"); }
	public static void showMenu(String[] menu) { printer.accept(getMenu(menu)); }
	public static void showHeading(String msg) { printer.accept(getHeading(msg)); }
}
