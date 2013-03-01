package objects;

public class Achievement {
	
	private final int ID;
	private final String name;
	private final String text;
	
	public Achievement(int ID, String name, String text) {
		this.ID = ID;
		this.name = name;
		this.text = text;
	}

	public Achievement() {
		this(0, "", "");
	}

}
