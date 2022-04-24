package hotel;

public record Reservation (Property property, String checkInDate, String checkOutDate, long nights,
	String firstName, String lastName, String email, int guests) {

	private float calculatePrice() {
		float discountedPrice = property.pricePerNight() * (100.0f - property.weeklyDiscount()) / 100.0f;
		float totalFee = (discountedPrice * nights) + (property.serviceFeePerNight() * nights) + property.cleaningFee();
		return totalFee;
	}

	@Override
	public String toString() {
		StringBuilder sb = new StringBuilder();
		sb.append("%-26s:\t%s %s\n");
		sb.append("%-26s:\t%s\n");
		sb.append("%-26s:\t%s hosted by %s\n");
		sb.append("%-26s:\t%d guests\n");
		sb.append("%-26s:\t%s\n");
		sb.append("%-26s:\t%s\n\n");
		sb.append("%-26s:\t$%.2f\n");
		
		return String.format(sb.toString(),
			"Name", firstName, lastName,
			"Email", email,
			"Your stay", property.property(), property.host(),
			"Who's coming", guests,
			"Check-in date", checkInDate,
			"Check-out date", checkOutDate,
			"Total payment", calculatePrice()
		);
	}

}
