package database;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.sql.ResultSet;



public class Util_Login {
	
	public static String encrypt(String password) {
		MessageDigest md;
		try {
			md = MessageDigest.getInstance("SHA");
		} catch (NoSuchAlgorithmException e) {
			e.printStackTrace();
			return "";
		}
		String result = hexToString(getHash(password, md));
		password += result;
		// salting
		result = hexToString(getHash(password, md));
		return result;
	}

	private static byte[] getHash(String password, MessageDigest md) {
		byte[] bytes = password.getBytes();
		byte[] hash = md.digest(bytes);
		return hash;
	}
	public static String hexToString(byte[] bytes) {
		StringBuffer buff = new StringBuffer();
		for (int i=0; i<bytes.length; i++) {
			int val = bytes[i];
			val = val & 0xff;  // remove higher bits, sign
			if (val<16) buff.append('0'); // leading 0
			buff.append(Integer.toString(val, 16));
		}
		return buff.toString();
	}
	
	public static boolean checkLogin(String username, String password) {
		String hash = encrypt(password);
		String query = "SELECT * FROM users WHERE username=\"" + username + "\" AND password=\"" + hash + "\";";
		ResultSet result = MyDB.queryDatabase(query);
		return !MyDB.resultIsEmpty(result);
	}
	
	public static boolean addLogin(String username, String password) {
		String check_query = "SELECT * FROM users WHERE username=\"" + username + "\";";
		ResultSet result = MyDB.queryDatabase(check_query);
		if (!MyDB.resultIsEmpty(result)) return false;
		
		String hashed_password = encrypt(password);
		String update = "INSERT INTO users VALUES(\"" + username + "\",\"" + hashed_password + "\",\"\",0, 0)";
		MyDB.updateDatabase(update);
		return true;
	}
	

}
