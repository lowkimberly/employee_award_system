<%@ page import="java.sql.*" %>
<%@ page import="java.net.URL" %>
<%@ page import=" java.util.*" %>
<%@ page import=" javax.naming.* "%>
<%@ page import=" javax.naming.directory.* "%>
<jsp:useBean id="mySQLBean"  class="mySQLBean.class" scope="scope"/> 

<%
if (session.getAttribute("loggedInUser")!=null) {
%>
<html xmlns = "http://www.w3.org/1999/xhtml">
   <head>
		<title>Yea System</title>
   </head>

   <body>
<%
	String sub_lname = request.getParameter( "sub_lname" );
	String choice = request.getParameter( "choice" );
	
	//came from entrance?
	if ((sub_lname==null || sub_lname=="") && choice==null) {
%>	
		<form action = "view_award.jsp" method = "post">
			<p>Enter a last name: </p>
			<p><input type = "text" name = "sub_lname" />
				<input type = "submit" value = "Submit" />
			</p>
		</form>
<%
	}
	else {
	//actual view award
		try {
			//mysql
			Class.forName ("com.mysql.jdbc.Driver").newInstance();
			String url = "jdbc:mysql://bigyellowcat.cs.binghamton.edu:3306/low";
			Connection con = DriverManager.getConnection(url,"low", "low0607");
			Statement stmt = con.createStatement();

			if (choice!=null) {
				Statement stmt2 = con.createStatement();
				out.println("You have chosen "+choice+"! You will get your prize in 1 week." );
				stmt2.executeUpdate( "update P4_Awarded set prize='"+choice+"' where prize='' and rec_fname='"+session.getAttribute( "givenName" )+"' and rec_lname='"+session.getAttribute( "surname" )+"' and awardid='" +request.getParameter( "aid" )+"';" );
			}
			
			ResultSet rs = stmt.executeQuery( "select * from P4_Awarded where sub_lname='"+sub_lname+"' or rec_lname='"+sub_lname+"' ;" );
			


			out.println("<table style='border: 1px solid black;border-collapse:collapse;'><tr><td style='border: 1px solid black'>Submitter</td><td style='border: 1px solid black'>Sub. Dept.</td><td style='border: 1px solid black'>Receiver</td><td style='border: 1px solid black'>Rec. Dept.</td><td style='border: 1px solid black'>Mail</td><td style='border: 1px solid black'>Note</td><td style='border: 1px solid black'>Prize</td><td style='border: 1px solid black'>Date</td></tr>");

			while(rs.next()) {
				out.println("<tr><td style='border: 1px solid black'>");
			    out.println(rs.getString("sub_fname") + " " + rs.getString("sub_mi") + " " + rs.getString("sub_lname"));
				out.println("</td><td style='border: 1px solid black'>");
			    out.println(rs.getString("sub_dept"));
				out.println("</td><td style='border: 1px solid black'>");
			    out.println(rs.getString("rec_fname") + " " + rs.getString("rec_mi") + " " + rs.getString("rec_lname"));
				out.println("</td><td style='border: 1px solid black'>");
			    out.println(rs.getString("rec_dept"));
				out.println("</td><td style='border: 1px solid black'>");
			    out.println(rs.getString("rec_mail"));
				out.println("</td><td style='border: 1px solid black'>");
			    out.println(rs.getString("note"));
				out.println("</td><td style='border: 1px solid black'>");

			    if (rs.getString("prize").equals("") && session.getAttribute("givenName").equals(rs.getString("rec_fname")) && session.getAttribute("surname").equals(rs.getString("rec_lname"))) {
					out.println("<a href='select_prize.jsp?aid="+rs.getString("awardid")+"'>Select a prize</a>");
				
				}
			    else out.println(rs.getString("prize"));
				out.println("</td><td style='border: 1px solid black'>");
				 out.println(rs.getString("date"));

				out.println("</td></tr>");
			}
			out.println("</table>");

	

		}
		catch(Exception e)  {
		       out.println("Exception "+e.toString());
		}
		 
	}
%>

		<p><a href="entrance.jsp">Back to Entrance</a></p>
	
	</body>
</html>
<%
}

%>

