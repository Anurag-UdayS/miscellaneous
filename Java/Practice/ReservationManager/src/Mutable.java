package hotel;

public class Mutable<T> {
	T field;
	public Mutable(){};
	public Mutable(T t) {field = t;} 

	public T get() {return field;}
	public void set(T t) {field = t;} 
}
