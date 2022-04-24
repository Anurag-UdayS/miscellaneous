package hotel;
// This class is responsible for creating the property objects

public record Property(String property, String location, String description, String placeType, String host, int maxGuests,
		float rating, float pricePerNight, float serviceFeePerNight, float cleaningFee, float weeklyDiscount, Mutable<Boolean> isReserved) {

	private float[] calculatePrice(long nights) {
		float discountedPrice = pricePerNight * (100.0f - weeklyDiscount) / 100.0f;
		float totalFee = (discountedPrice * nights) + (serviceFeePerNight * nights) + cleaningFee;
		return new float[] {discountedPrice, totalFee};
	}

	public String toString(long nights) {
		float[] data = calculatePrice(nights);

		StringBuilder sb = new StringBuilder();
		sb.append("%-26s:\t%s hosted by%s\n"); // Property, Host
		sb.append("%-26s:\t%s\n"); // Place Type
		sb.append("%-26s:\t%s\n"); // Location
		sb.append("%-26s:\t%.1f\n"); // Rating
		sb.append("%-26s:\t%s\n"); // Description
		sb.append("%-26s:\t%d\n"); // Number of Guests
		sb.append("%-26s:\t$%.2f\t($%.2f * %d nights)\n"); // Price	(price * n nights)
		sb.append("%-26s:\t$%.2f\t($%.2f * %d nights)\n"); // Discounted Price	(d_price * n nights)
		sb.append("%-26s:\t$%.2f\t($%.2f * %d nights)\n"); // Service Fee	(s_fee * n nights)
		sb.append("%-26s:\t$%.2f\n"); // Cleaning Fee
		sb.append("%-26s:\t$%.2f\n"); // Total Fee

		
		return String.format(sb.toString(),
			"Property", property, host,
			"Type of place", placeType,
			"Location", location,
			"Rating", rating,
			"Description", description,
			"Maximum number of Guests", maxGuests,
			"Price", pricePerNight * nights, pricePerNight, nights,
			"Discounted Price", data[0] * nights, data[0], nights,
			"Service Fee", serviceFeePerNight * nights, serviceFeePerNight, nights,
			"Cleaning Fee", cleaningFee,
			"Total", data[1]
		);

	}
}
