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
<%
	String aid = request.getParameter( "aid" );
	
		try {
			//mysql
			Class.forName ("com.mysql.jdbc.Driver").newInstance();
			String url = "jdbc:mysql://bigyellowcat.cs.binghamton.edu:3306/low";
			Connection con = DriverManager.getConnection(url,"low", "low0607");
			Statement stmt = con.createStatement();
			ResultSet rs = stmt.executeQuery( "select * from P4_Award_Types where active=1;" );

			out.println("<table style='border: 1px solid black;border-collapse:collapse;'><tr><td style='border: 1px solid black'>Choose</td><td style='border: 1px solid black'>Name.</td><td style='border: 1px solid black'>Description</td></tr><form action='view_award.jsp' method='post'>");

			while(rs.next()) {
				out.println("<tr><td style='border: 1px solid black'>");
			    out.println("	<input type='radio' name='choice' value='"+rs.getString("prize")+"'>");
				out.println("</td><td style='border: 1px solid black'>");
			    out.println(rs.getString("prize"));
				out.println("</td><td style='border: 1px solid black'>");
			    out.println(rs.getString("desc") );
				out.println("</td></tr>");
			}
	
			out.println("<input type='hidden' name='aid' value="+aid+">      <input type='hidden' name='sub_lname' value="+session.getAttribute( "surname" )+">                 <input type = 'submit' value = 'Submit' />	<input type='reset' value='Reset'></form></table>");


		}
		catch(Exception e)  {
		       out.println("Exception "+e.toString());
		}
		 
	
%>

		<p><a href="entrance.jsp">Back to Entrance</a></p>
	
	</body>
</html>
<%
}
else out.println("Please log in");
%>

