package objects;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Date;
import java.util.List;

import database.QuizUtils;
import database.UserUtils;

public class Quiz {

	private int id;
	private String title;
	private String instructions;
	private boolean isRandomPages;
	private boolean isInstantCorrection;
	private boolean canPractice;
	private String category;
	private List<String> tags;
	private User owner;
	private Date timeCreated;
	private int numPlays;

	// For when we retrieve from the database
	public Quiz(ResultSet rs) {
		if (rs != null) {
			try {
				this.id = rs.getInt("id");
				this.title = rs.getString("title");
				this.instructions = rs.getString("instructions");
				this.isRandomPages = rs.getInt("isRandomPages") == 1;
				this.isInstantCorrection = rs.getInt("isInstantCorrection") == 1;
				this.canPractice = rs.getInt("canPractice") == 1;
				this.category = rs.getString("category");
				this.tags = QuizUtils.separateByNullChar(rs.getString("tags"));
				this.owner = UserUtils.getUser(rs.getString("owner"));
				this.timeCreated = rs.getTimestamp("timeCreated");
				this.numPlays = rs.getInt("numPlays");
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
	}

	// For when a user creates a new quiz
	public Quiz(String title, String instructions, boolean isRandomPages,
			boolean isInstantCorrection, boolean canPractice, String category,
			List<String> tags, User owner, Date timeCreated, int numPlays) {
		this.id = QuizUtils.getNextId();
		this.title = title;
		this.instructions = instructions;
		this.isRandomPages = isRandomPages;
		this.isInstantCorrection = isInstantCorrection;
		this.canPractice = canPractice;
		this.category = category;
		this.tags = tags;
		this.owner = owner;
		this.timeCreated = timeCreated;
	}

	public int getId() {
		return id;
	}

	public String getTitle() {
		return title;
	}

	public String getInstructions() {
		return instructions;
	}

	public boolean isRandomPages() {
		return isRandomPages;
	}

	public boolean isInstantCorrection() {
		return isInstantCorrection;
	}

	public boolean isCanPractice() {
		return canPractice;
	}

	public String getCategory() {
		return category;
	}

	public List<String> getTags() {
		return tags;
	}

	public User getOwner() {
		return owner;
	}

	public Date getTimeCreated() {
		return timeCreated;
	}

	public int getNumPlays() {
		return numPlays;
	}

}
