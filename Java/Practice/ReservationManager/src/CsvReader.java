package hotel;


import java.util.List;
import java.util.stream.Collectors;
import java.io.BufferedReader;
import java.io.FileReader;

public class CsvReader {
	
	public static List<Property> readPropertiesFromCSV(String fileName) throws java.io.IOException {
		return new BufferedReader(new FileReader(fileName))
			.lines()
			.filter(e -> e.split(",")[5].matches("^\\d+$"))
			.map(e -> createProperty(e.split(",")))
			.collect(Collectors.toList());
	}

	public static Property createProperty(String[] data) {
		String property = data[0];
		String location = data[1];
		String description = data[2];
		String placeType = data[3];
		String host = data[4];

		int maxGuests = Integer.parseInt(data[5]);
		
		float rating = Float.parseFloat(data[6]);
		float pricePerNight = Float.parseFloat(data[7]);
		float serviceFeePerNight = Float.parseFloat(data[8]);
		float cleaningFee = Float.parseFloat(data[9]);
		float weeklyDiscount = Float.parseFloat(data[10]);

		return new Property(property, location, description, placeType, host, maxGuests, rating, pricePerNight,
				serviceFeePerNight, cleaningFee, weeklyDiscount, new Mutable<Boolean>(false));
	}

}
