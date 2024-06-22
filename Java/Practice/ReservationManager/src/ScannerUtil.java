package hotel;

import java.util.Scanner;
import java.util.NoSuchElementException;
import java.util.function.Predicate;

public class ScannerUtil {
	// Date		: 3[0-1]|[1-2]\\d|0[1-9] 
	// Month	: 1[0-2]|0[1-9]
	// Year		: \\d{4}
	private static final String dateRegex = "^(3[0-1]|[1-2]\\d|0[1-9])/(1[0-2]|0[1-9])/(\\d{4})$";

	private static final Scanner sc = new Scanner(System.in);

	// --------------------------------------------------------------------------- //

	// The utility method to read user string input.
	public static String nextValidString(String prompt, String err) {
		System.out.print(prompt);
		String line = sc.nextLine().trim();
		if (!line.isEmpty())
			return line;

		System.out.println(err);
		return nextValidString(prompt, err);
	}

	// --------------------------------------------------------------------------- //

	// The utility method to read a string and return it's boolean representation.
	public static boolean parseNextBoolean(String prompt, String err) {
		System.out.print(prompt);
		
		switch (sc.nextLine().trim().toLowerCase()) {
			case "t":
			case "true":
			case "y":
			case "yes":
			case "1":
			case "":
				return true;

			case "f":
			case "false":
			case "n":
			case "no":
			case "0":
				return false;

			default:
				System.out.println(err);
				return parseNextBoolean(prompt, err);

		}

	}

	// --------------------------------------------------------------------------- //


	// The utility method to read user float input.
	public static float nextValidFloat(String prompt, String err) {
		try {
			System.out.print(prompt);
			float d = sc.nextFloat();
			sc.nextLine();
			return d;
		} catch (NoSuchElementException e) {
			System.out.println(err);
			sc.nextLine();
			return nextValidFloat(prompt, err);
		}
	}

	public static float nextValidFloat(String prompt) {
		return nextValidFloat(prompt, PrinterUtil.toErrorFormat(prompt));
	}

	public static float nextValidFloat(String prompt, String err, Predicate<Float> checker) {
		float f = nextValidFloat(prompt, err);
		if (checker.test(f)) return f;
		System.out.println(err);
		return nextValidFloat(prompt, err, checker);
	}

	// --------------------------------------------------------------------------- //

	// The utility method to read user class integer input.
	public static int nextValidInt(String prompt, String err) {
		try {
			System.out.print(prompt);
			int i = sc.nextInt();
			sc.nextLine();
			return i;
		} catch (NoSuchElementException e) {
			System.out.println(err);
			sc.nextLine();
			return nextValidInt(prompt, err);
		}
	}

	public static int nextValidInt(String prompt) {
		return nextValidInt(prompt, PrinterUtil.toErrorFormat(prompt));
	}

	public static int nextValidInt(String prompt, String err, Predicate<Integer> checker) {
		int i = nextValidInt(prompt, err);
		if (checker.test(i)) return i;
		System.out.println(err);
		return nextValidInt(prompt, err, checker);
	}

	// --------------------------------------------------------------------------- //

	// The utility method to read a Date string in the dd/mm/yyyy format.
	public static String nextValidDate(String prompt, String err) {
		System.out.print(prompt);
		String date = sc.nextLine().trim();
		if (date.matches(dateRegex)) return date;
		System.out.println(err);
		return nextValidDate(prompt, err);
	}
}
