<%@ page import="java.sql.*" %>
<%@ page import="java.net.URL" %>
<%@ page import=" java.util.*" %>
<%@ page import=" javax.naming.* "%>
<%@ page import=" javax.naming.directory.* "%>

<%

if (session.getAttribute("loggedInUser")!=null) {
%>
<html xmlns = "http://www.w3.org/1999/xhtml">

   <head>
		<title>Yea System</title>
   </head>

   <body>

<ul>
<li><a href="guidelines.jsp">View Program Guidelines</a></li>
<li><a href="submit_award.jsp">Submit an Award</a></li>
<li><a href="view_award.jsp">View Awards</a></li>
<li><a href="run_reports.jsp">Reports</a></li>
<li><a href="admin_home.jsp">Admin</a></li>
<li><a href="do_logout.jsp">Logout</a></li>
</ul>
<p><a href="login.jsp">Back to Login</a></p>
	
	</body>
</html>
<%


					Class.forName ("com.mysql.jdbc.Driver").newInstance();
			String url = "jdbc:mysql://bigyellowcat.cs.binghamton.edu:3306/low";
			Connection con = DriverManager.getConnection(url,"low", "low0607");
			Statement stmt = con.createStatement();
			ResultSet rs = stmt.executeQuery( "select * from P4_News where active=1;" );

			out.println(" "+
			"<table style='border: 1px solid black;border-collapse:collapse;'><tr><td style='border: 1px solid black'>Date</td><td style='border: 1px solid black'></td></tr>"
			);

			while(rs.next()) {

				out.println("<tr>");
				out.println("<td style='border: 1px solid black'> "+rs.getString("start_date")+" ");
				out.println("</td><td style='border: 1px solid black'> "+rs.getString("content")+" ");

	
				out.println("</td></tr>");
				
			}
	
			out.println(" </table>  ");


}
else out.println("Please log in");
%>
