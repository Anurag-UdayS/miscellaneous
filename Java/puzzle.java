import java.lang.*;
import java.util.Scanner;


class Puzzle {

	// Boat class contains ASCII Codes for required colors.
	public static class ASCIIEscape {
		public static String _esc = "\u001B[";

		public static String reset = _esc + "0m";
		public static String red = _esc + "31m";
		public static String green = _esc + "32m";
		public static String orange = _esc + "33m";
		public static String blue = _esc + "34m";
		public static String purple = _esc + "35m";
		public static String teal = _esc + "36m";
		public static String brown = _esc + "38;5;139;69;19m";
	}

	// The format string utility. Colors strings.
	public static String f(String str){
		char[] chrs = str.toCharArray();
		StringBuilder mk = new StringBuilder();

		for (char unit: chrs) {
			switch (unit) {
				case 'L':
					mk.append(ASCIIEscape.green).append(unit).append(ASCIIEscape.reset);
					break;
				case 'W':
					mk.append(ASCIIEscape.blue).append(unit).append(ASCIIEscape.reset);
					break;
				case 'D':
					mk.append(ASCIIEscape.red).append(unit).append(ASCIIEscape.reset);
					break;
				case 'S':
					mk.append(ASCIIEscape.teal).append(unit).append(ASCIIEscape.reset);
					break;
				case 'B':
					mk.append(ASCIIEscape.brown).append(unit).append(ASCIIEscape.reset);
					break;
				default:
					mk.append(unit);
					break;
			}
		}
		return mk.toString();
	}

	public static class Environment {
		public static final String format = (new StringBuilder())
		.append(f("%s%s%s%s%s       %s%s%s%s\n"))
		.append(f("LLLL %s%s %s%s LLLL\n"))
		.append(f("LLLL %s%s %s%s LLLL\n"))
		.append(f("LLLLWWWWWWWLLLL\n"))
		.append(f("LLLLWWWWWWWLLLL\n"))
		.append(f("LLLLWWWWWWWLLLL\n"))
		.toString();

		public static final String help = (new StringBuilder())
		.append(ASCIIEscape._esc + ASCIIEscape.purple)
		.append("\t".repeat(5)).append("HELP MENU\n")
		.append("=".repeat(100)).append("\n\n\n")
		.append("This is a help menu for all commands of the game subsystem. ")
		.append("As many functions have multiple interactions, ")
		.append("they will be listed in the reverse order.\n\n\n")
		.append("\t\tFunction\t\t\t\tCommand\n")
		.append("\tDisplay the help menu (this).\t\t\t   ?\n")
		.toString();

		public static String getState() {
			return "null";
		}

		public boolean checkMembers(char[] members) {
			for (char member: members) {
				if (member != ' ') return true;
			}
			return false;
		}

		public boolean checkStatus(String side) {
			return countMembers(side, 'S') >= countMembers(side,'D');
		}


		public static int countMembers(String side, char selectedMember){
			int counter = 0;
			int temp;
			if (side == "right") {	
				for (char member: Right.members){
					temp = member == selectedMember ? counter++ : null; 
				}
			} else {
				for (char member: Left.members){
					temp = member == selectedMember ? counter++ : null; 
				}
			}

			for (char member: Boat.members){
				temp = member == selectedMember ? counter++ : null; 
			}

			return counter;
		}

		public void alert(String str){};

	}

	public static class Boat extends Environment {
		public static boolean left = true;
		public static boolean right = false;
		public static char[] members = new char[2];

		void RowBoat(){
			if (!checkMembers(Boat.members)) {
				alert("Cannot row boat. No members in boat. Please add atleast 1 member");
				return;
			}

			String side = Boat.left ? "left":"right";
			if (!checkStatus(side)) return;

			Boat.left = !Boat.left;
			Boat.right = !Boat.right;

		}

	}

	public static class Left extends Environment {
		static char[] members = new char[4];
	}

	public static class Right extends Environment {
		static char[] members = new char[4];
	}


	public static void main(String[] args) {
		Scanner read = new Scanner(System.in);
		System.out.println("Welcome to my implementaion of Saints and Demon Puzzle! (Tip: Enter '?' to know about all commands).");
		System.out.println("Enter Command Here:");
		System.out.println(Environment.help);
	}

}