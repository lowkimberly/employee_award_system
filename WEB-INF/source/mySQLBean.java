
import java.sql.*;
import java.net.URL;
import java.util.*;
import javax.naming.*;
import javax.naming.directory.*;
import java.io.Serializable;

public class mySQLBean implements Serializable {
	public mySQLBean() {
	}

	public ResultSet doQuery(String query) {
	try {
			Class.forName ("com.mysql.jdbc.Driver").newInstance();
			String url = "jdbc:mysql://bigyellowcat.cs.binghamton.edu:3306/low";
			Connection con = DriverManager.getConnection(url,"low", "low0607");
			Statement stmt = con.createStatement();
			ResultSet rs = stmt.executeQuery(query );
			return rs;
}
catch (Exception e) {
ResultSet r=null;
return  r;
}
	}
	public int doUpdate(String query) {
try {
			Class.forName ("com.mysql.jdbc.Driver").newInstance();
			String url = "jdbc:mysql://bigyellowcat.cs.binghamton.edu:3306/low";
			Connection con = DriverManager.getConnection(url,"low", "low0607");
			Statement stmt = con.createStatement();
			int rs = stmt.executeUpdate( query);
			return rs;
} 
catch(Exception e) {
return -1;
}
	}
}
