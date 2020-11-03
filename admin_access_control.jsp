<%@ page import="java.sql.*" %>
<%@ page import="java.net.URL" %>
<%@ page import=" java.util.*" %>
<%@ page import=" javax.naming.* "%>
<%@ page import=" javax.naming.directory.* "%>

<%
if (session.getAttribute("loggedInUser")!=null && session.getAttribute("isAdmin").equals("true")) {
try     {

					Class.forName ("com.mysql.jdbc.Driver").newInstance();
			String url = "jdbc:mysql://bigyellowcat.cs.binghamton.edu:3306/low";
			Connection con = DriverManager.getConnection(url,"low", "low0607");
			Statement stmt = con.createStatement();
			ResultSet rs = stmt.executeQuery( "select * from P4_Backups where backup_for='"+session.getAttribute("loggedInUser")+"';" );

			out.println("<table style='border: 1px solid black;border-collapse:collapse;'><tr><td style='border: 1px solid black'>Userid</td></tr>");

			while(rs.next()) {
				out.println("<tr><td style='border: 1px solid black'><form action='admin_home.jsp' method='post'>");
			    out.println("	<input type='submit' name='delbackup' value='Delete'>");
			    out.println("	<input type='hidden' name='delbackup2' value='"+rs.getString("bid")+"'>");
				out.println(rs.getString("uid"));
				out.println("</form></td></tr>");
			}
	
			out.println(" </table>");
if (session.getAttribute("isAdmin").equals("true") && session.getAttribute("isBackup")==null) {
%>
<hr>
Add new backup:
<form action="admin_home.jsp" method="post">
Uid: <input type = 'text' name="backupuid"  /><br>
<input type = 'hidden' name="new_backup" value = 'true' />
<p><input type = 'submit' value = 'Submit' /></p>
</form>

<%



		}

		}

	

    catch (Exception e)
      {
		out.println("Execption: " + e.toString());
      }
 

}
else out.println("Access denied.  Contact the YEA! Administrator at x3301");

 %>
