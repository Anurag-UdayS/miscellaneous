import java.util.Scanner;

public class test {

	//Method Main, For starting the program.
	public static void main(String[] args) {
		test _controller = new test();
		// Redirect program flow to a non-static method.
		_controller._start(_controller,args);
	}

	public void _start(test _controller, String[] args){
		_controller.init(args);
		_controller.start(args); 
	};
	//
	//
	//
	// ===================== Classes ====================
	//
	//
	//

	public class Colors {
		final String Base = "\u001B[";
		final String Reset = "0m";

		//-----------------------//
		final String Red = "31m";
		final String Green = "32m";
		final String Yellow = "33m";
		final String Cyan = "36m";
		//-----------------------//

		String Make_Red(String str){
			return Base + Red + str + Base + Reset;
		};

		String Make_Green(String str){
			return Base + Green + str + Base + Reset;
		};

		String Make_Yellow(String str){
			return Base + Yellow + str + Base + Reset;
		};

		String Make_Cyan(String str){
			return Base + Cyan + str + Base + Reset;
		};

	}

	// The Response Class for collection of responses.
	public class Response {
		int response_int;
		boolean response_bool;
		String response_str;
		Book response_book;
		Student response_student;

		boolean Success;
		String Message;

		public Response(boolean Success, String Message, int Data) {
			this.Success = Success;
			this.Message = Message;
			this.response_int = Data;
		};

		public Response(boolean Success, String Message, boolean Data) {
			this.Success = Success;
			this.Message = Message;
			this.response_bool = Data;
		};

		public Response(boolean Success, String Message, String Data) {
			this.Success = Success;
			this.Message = Message;
			this.response_str = Data;
		};

		public Response(boolean Success, String Message, Book Data) {
			this.Success = Success;
			this.Message = Message;
			this.response_book = Data;
		};

		public Response(boolean Success, String Message, Student Data) {
			this.Success = Success;
			this.Message = Message;
			this.response_student = Data;
		};

		public Response(boolean Success, String Message) {
			this.Success = Success;
			this.Message = Message;
		}
	}

	// The Book Class for maintaining records of books.
	public class Book{
		int ID;
		String Name;
		String Author;
		int Published;
		String Publisher;
		int Copies;

		public Book(){
			System.out.println("No Paramaters!!!");
		};

		public Book(int ID, String Name, String Author, int Published, String Publisher) {
			ID = ID;
			Name = Name;
			Author = Author;
			Published = Published;
			Publisher = Publisher;
			Copies = 1;
		}

		public Book(int ID, String Name, String Author, int Published, String Publisher, int Copies) {
			ID = ID;
			Name = Name;
			Author = Author;
			Published = Published;
			Publisher = Publisher;
			Copies = Copies;
		}
	}

	// The Student Class for maintaining records of students.
	public class Student{
		int ID;
		String Name;
		String Password;
		Book[] Books = new Book[0];

		public Student(){}

		public Student(int ID, String Name){
			this.ID = ID;
			this.Name = Name;
			this.Password = "Password";
		}

		public Student(int ID, String Name, String Password){
			this.ID = ID;
			this.Name = Name;
			this.Password = Password;
		}	
	}

	// Helper Class, for storing utility methods.
	public class Helper{
		
		//
		//
		//
		// ===================== Tables =====================
		//
		//
		//

		String[][] Callouts = {
			// [0] = Greeting
			{
				"============================================================",
				"Salutations!",
				"Welcome to the District Library!",
				"Please Login with your User ID/Name and Password in order to access the library books.",
				"============================================================",
			},
			// [1] = Prompt Login.
			{
				"============================================================",
				"Please Enter the next command.",
				"\t(name) (Name) or (1): Login by name.",
				"\t(id) (ID) or (2): Login by ID.",
				"============================================================",
			},
			// [2] = Prompt Login (Name Selected).
			{
				"============================================================",
				"Please Enter the full name of the User.",
				"============================================================",
			},
			// [3] = Prompt Login (UID Selected).
			{
				"============================================================",
				"Please Enter the User ID of the User.",
				"============================================================",
			},
			// [4] = Prompt Login (Ask for Password).
			{
				"============================================================",
				"User Selected. Enter Password.",
				"============================================================",
			},

			//----------------//

			// [5] = Prompt Home Screen Message.
			{
				"============================================================",
				"Welcome to the District Library Home Page.",
				"Please enter next command to proceed.",
				"============================================================",
				"\t(logout) (Logout) or (0): Logout of this menu and open login screen.",
				"\t(view) (View) or (1): View the books available in the library.",
				"\t(mybooks) (MyBooks) (my-books) (My-books) (My-Books) or (2): View books you have issued.",
				"\t(issue) (Issue) or (3): Open Issuing Menu (for issuing books).",
				"\t(submit) (Submit) or (4): Open Submission Menu (for submitting issued books).",
				"\t(bookdata) (BookData) or (5): Read the details of a book."
			}
		};



		// The Printer Utility
		public void Callout(int Idx) {
			for (String callout: Callouts[Idx]){
				System.out.println(callout);
			}
		};
		
		//
		//
		//
		// ==================== Bookshelf ===================
		//
		//
		//


		// Creating a Bookshelf:
		Book[] Bookshelf = {
			new Book(1,"Test","Auth",2021,"Pub",5),
			new Book(2,"Test","Auth",2021,"Pub",3),
			new Book(3,"Test","Auth",2021,"Pub",4),
			new Book(4,"Test","Auth",2021,"Pub",6),
			new Book(5,"Test","Auth",2021,"Pub",7),
			new Book(6,"Test","Auth",2021,"Pub",8),
			new Book(7,"Test","Auth",2021,"Pub",9),
			new Book(8,"Test","Auth",2021,"Pub",4),
			new Book(9,"Test","Auth",2021,"Pub",6),
			new Book(10,"Test","Auth",2021,"Pub",9),
		}; 



		// Bookshelf Methods: Get Book By ID:
		Response getBookById(int ID){
			for (Book book: Bookshelf) {
				if (book.ID == ID) {
					return new Response(true,"Success! Found Book.",book);
				} 
			}
			return new Response(false,"Failure! No Book Found With Given ID.");
		};

		// Bookshelf Methods: Get Book By Name:
		Response getBookByName(String Name){
			for (Book book: Bookshelf) {
				if (book.Name.equals(Name)) {
					return new Response(true,"Success! Found Book.",book);
				} 
			}
			return new Response(false,"Failure! No Book Found With Given Name.");
		};

		//
		//
		//
		// ===================== Student ====================
		//
		//
		//

		// Creating a Student Database:
		Student[] Database = {
			new Student(1325209001,"Anurag Tewary","Password"),
			new Student(1325209010,"Arun Dey","Password"),
			new Student(1325209008,"Bobby Raj Gorai","Password"),
			new Student(1325209009,"Chandan Mahanty","Password"),
			new Student(1325209004,"Rahul Pandey","Password"),
			new Student(1325209007,"Ram Das","Password"),
			new Student(1325209006,"Ronit Sharma","Password"),
			new Student(1325209002,"Rounak Mohata","Password"),
			new Student(1325209005,"Sneha Sinha","Password"),
			new Student(1325209003,"Sunil Dey","Password")
		};

		// Database Methods: Get Student by ID:
		Response _getStudentById(int ID){
			for (Student student: Database){
				if (student.ID == ID) {
					return new Response(true,"Success! Found Student.",student);
				}
			}
			return new Response(false,"Failure! No Student Found With Given ID.");
		};

		// Database Methods: Get Student by Name:
		Response _getStudentByName(String Name){
			System.out.println(Name);
			for (Student student: Database){
				if (student.Name.equals(Name)) {
					System.out.println("Sent!");
					return new Response(true,"Success! Found Student.",student);
				} 
			}
			return new Response(false,"Failure! No Student Found With Given Name.");
		};

		// Database Methods: Password Check:
		Response _checkPassword(String Password, Student student){
			if (student.Password.equals(Password)) {
				return new Response(true,"Password Matches.",true);
			}
			return new Response(false,"Failure! Password does not match.");
		};


		//
		//
		//
		// ====================== Login =====================
		//
		//
		//


		// Prompts: Check Password:
		Response promptCheckPassword(Scanner scanner, Colors colorController, Student student, int tries){
			Callout(4);
			System.out.print("Enter the Password for " + student.Name + "(" + Integer.toString(tries) + "tries left):");
			String pass = scanner.nextLine();

			if (tries > 0) {
				Response passMatch = _checkPassword(pass,student);
				if (passMatch.Success) {
					return new Response(true,"Matched Password!");
				} else {
					System.out.print(colorController.Make_Red("Password Did not match. Please retry."));
					return promptCheckPassword(scanner, colorController, student, tries - 1);
				}
			} else {
				System.out.print(colorController.Make_Red("Ran out of tries. Logging out."));
				return new Response(false, "Ran out of tries.");
			}
		};

		// Prompts: Get Student By Name:
		Response promptGetStudentByName(Scanner scanner, Colors colorController) {
			Callout(2);
			System.out.print("Enter Full Name Here: ");
			String name = scanner.nextLine();

			Response foundStudent = _getStudentByName(name);

			if (foundStudent.Success) {
				Student student = foundStudent.response_student;
				Response passCheck = promptCheckPassword(scanner, colorController, student, 3);
				if (passCheck.Success) {
					return new Response(true,"Logged in as " + student.Name + ".",student);
				};

			} else {
				System.out.println(colorController.Make_Red("Error! " + foundStudent.Message + " Please retry."));
				return promptGetStudentByName(scanner, colorController);
			}
		};

		// Prompts: Get Student By ID:
		Response promptGetStudentById(Scanner scanner, Colors colorController) {
			Callout(3);
			System.out.print("Enter User ID Here: ");
			String id = scanner.nextLine();

			Response foundStudent = _getStudentById(Integer.parseInt(id));

			if (foundStudent.Success) {
				Student student = foundStudent.response_student;
				Response passCheck = promptCheckPassword(scanner, colorController, student, 3);
				if (passCheck.Success) {
					return new Response(true,"Logged in as " + student.Name + ".",student);
				};

			} else {
				System.out.println(colorController.Make_Red("Error! " + foundStudent.Message + " Please retry."));
				return promptGetStudentById(scanner, colorController);
			}
		};

		// Prompts: Prompt Login:
		Response promptLogin(Scanner scanner, Colors colorController) {
			Callout(1);
			System.out.print("Enter Command Here: ");
			String command = scanner.nextLine();


			switch(command) {
				case "name": 
					return promptGetStudentByName(scanner,colorController);					
				case "Name":
					return promptGetStudentByName(scanner,colorController);	
				case "1":
					return promptGetStudentByName(scanner,colorController);	

				//
				case "id":
					return promptGetStudentById(scanner,colorController);	
				case "ID":
					return promptGetStudentById(scanner,colorController);
				case "2":
					return promptGetStudentById(scanner,colorController);

				//	
				case "logout":
					System.out.println(colorController.Make_Yellow("Currently not logged in any account. Please retry."));
					return promptLogin(scanner, colorController);
				case "Logout":
					System.out.println(colorController.Make_Yellow("Currently not logged in any account. Please retry."));
					return promptLogin(scanner, colorController);
				case "0":
					System.out.println(colorController.Make_Yellow("Currently not logged in any account. Please retry."));
					return promptLogin(scanner, colorController);

				//	
				default:
					System.out.println(colorController.Make_Red("Error! Command not found. Please retry."));
					return promptLogin(scanner,colorController);
			}
		};



		//
		//
		//
		//
		//
		//

		// Prompts: Prompt Student Home:
		Response showStudentHome(Student student, Scanner scanner, Colors colorController){
			Callout(5); // Student Home Screen Message.
			System.out.print("Enter Command Here: ");
			String command = scanner.nextLine();

			//logout view mybooks submit issue bookdata

			switch(command) {

				case "logout":
					return new Response(true, "Requested Logout.","logout");
				case "Logout":
					return new Response(true, "Requested Logout.","logout");
				case "0":
					return new Response(true, "Requested Logout.","logout");

				case "view": 
					return promptViewBooks(student,scanner,colorController);					
				case "View":
					return promptViewBooks(student,scanner,colorController);	
				case "1":
					return promptViewBooks(student,scanner,colorController);	

				//
				case "mybooks":
					return promptViewStudentBooks(student,scanner,colorController);	
				case "MyBooks":
					return promptViewStudentBooks(student,scanner,colorController);
				case "my-books":
					return promptViewStudentBooks(student,scanner,colorController);
				case "My-Books":
					return promptViewStudentBooks(student,scanner,colorController);
				case "2":
					return promptViewStudentBooks(student,scanner,colorController);

				//
				case "submit": 
					return promptSubmitBooks(student,scanner,colorController);					
				case "Submit":
					return promptSubmitBooks(student,scanner,colorController);	
				case "3":
					return promptSubmitBooks(student,scanner,colorController);	

				//
				case "issue": 
					return promptIssueBooks(student,scanner,colorController);					
				case "Issue":
					return promptIssueBooks(student,scanner,colorController);	
				case "4":
					return promptIssueBooks(student,scanner,colorController);

				//
				case "bookdata":
					return promptViewStudentBooks(student,scanner,colorController);	
				case "BookData":
					return promptViewStudentBooks(student,scanner,colorController);
				case "book-data":
					return promptViewStudentBooks(student,scanner,colorController);
				case "Book-Data":
					return promptViewStudentBooks(student,scanner,colorController);
				case "5":
					return promptViewStudentBooks(student,scanner,colorController);

				//	
				default:
					System.out.println(colorController.Make_Red("Error! Command not found. Please retry."));
					return promptLogin(scanner,colorController);
			}
		}
	}; 

	//
	//
	//
	// ================= Initialization =================
	//
	//
	//

	public void init(String[] args){

	};

	//
	//
	//
	// ===================== Caller =====================
	//
	//
	//

	public void start(String[] args) {
		// Initialization
		Helper _methods = new Helper();
		Colors colorController = new Colors();
		Scanner scanner = new Scanner(System.in);

		// Code
		_methods.Callout(0); // Greeting
		
		Response login = _methods.promptLogin(scanner,colorController);
		Student student = login.response_student;

		// Checks if account is an admin account.
		if (student.ID == 0) {
			//_methods.showAdminHome(student,scanner,colorController);
		} else {
			_methods.showStudentHome(student,scanner,colorController);
		}


	};
	
}