import java.lang.*;


class Puzzle {

	// This class contains ASCII Codes for required colors.
	class ASCIIEscape {
		private String _esc = "\u001B[";

		String reset = _esc + "0m";
		String red = _esc + "31m";
		String green = _esc + "32m";
		String orange = _esc + "33m";
		String blue = _esc + "34m";
		String purple = _esc + "35m";
		String teal = _esc + "36m";
		String brown = _esc + "38;5;139;69;19m";
	}

	// The format string utility. Colors strings.
	String f(String str){
		char[] chrs = str.toCharArray();
		ASCIIEscape clr = new ASCIIEscape();
		StringBuilder mk = new StringBuilder();

		for (char unit: chrs) {
			switch (unit) {
				case 'L':
					mk.append(clr.green).append(unit).append(clr.reset);
					break;
				case 'W':
					mk.append(clr.blue).append(unit).append(clr.reset);
					break;
				case 'D':
					mk.append(clr.red).append(unit).append(clr.reset);
					break;
				case 'S':
					mk.append(clr.teal).append(unit).append(clr.reset);
					break;
				case 'B':
					mk.append(clr.brown).append(unit).append(clr.reset);
					break;
				default:
					mk.append(unit);
					break;
			}
		}
		return mk.toString();
	}

	class Environment {
		final String format = new StringBuilder("")
		.append(f("%s%s%s%s%s       %s%s%s%s\n"))
		.append(f("LLLL %s%s %s%s LLLL\n"))
		.append(f("LLLL %s%s %s%s LLLL\n"))
		.append(f("LLLLWWWWWWWLLLL\n"))
		.append(f("LLLLWWWWWWWLLLL\n"))
		.append(f("LLLLWWWWWWWLLLL\n"))
		.toString();

		String getState() {
			return 
		}
	}

	class Boat extends Environment {
		char[] members = new char[2];

	}

	class Left extends Environment {
		char[] members = new char[4];
	}

	class Right extends Environment {
		char[] members = new char[4];
	}


	public static void main(String[] args) {
		(new Puzzle()).start(args);
	}

	public void start(String[] args) {
		System.out.println(format);
	}

}