package hotel;


import java.util.function.Predicate;
import java.util.function.Supplier;

public class Assertable<T> {
	private boolean value = false;
	private boolean tested = false;
	private boolean priority;
	private T instance;

	public Assertable(T t, boolean priority) {
		instance = t;
		this.priority = priority;
	}

	public Assertable<T> assertTest(Predicate<T> tester) {
		if (!tested || value != priority) 
			value = tester.test(instance);
		tested = true;
		return this;
	}

	public Assertable<T> assertTest(boolean newVal) {
		if (!tested || value != priority) 
			value = newVal;
		tested = true;
		return this;
	}

	public Assertable<T> assertElseWarn(Predicate<T> tester, String err) {
		boolean newVal = tester.test(instance);
		if (!tested || value != priority) 
			value = newVal;
		tested = true;
		if (!newVal) System.out.println(err);
		return this;
	}

	public Assertable<T> assertElseWarn(boolean newVal, String err) {
		if (!tested || value != priority) 
			value = newVal;
		tested = true;
		if (!newVal) System.out.println(err);
		return this;
	}

	public T get() {return instance;}
	public boolean isTrue() {return value;}
	public T getIfTrue() {if (value) return instance; else return null;}
	public T getIfTrueElseDo(Supplier<T> other) {if (value) return instance; else return other.get();}
}