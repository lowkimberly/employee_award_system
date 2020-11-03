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
	String rec_fname = request.getParameter( "rec_fname" );
	String rec_mi = request.getParameter( "rec_mi" );
	String rec_lname = request.getParameter( "rec_lname" );
	String rec_dept = request.getParameter( "rec_dept" );
	String rec_mail = request.getParameter( "rec_mail" );
	String note = request.getParameter( "note" );
	//String cert = request.getParameter( "cert" );

	if ( rec_fname == null || rec_fname=="" ||  rec_lname == null || rec_lname=="" ||  rec_dept == null || rec_dept=="" ||  rec_mail == null || rec_mail=="" ||  note == null || note=="") {
%>	
               <form action = "submit_award.jsp" method = "post">
			   <p>Enter ALL fields</p>
               <p>Receiver first name:	<input type = "text" name = "rec_fname" /></p>
			   <p>Middle initial: 		<input type = "text" name = "rec_mi" /><p>
			   <p>Reciever last name:	<input type = "text" name = "rec_lname" /><p>
			   <p>Department: 			<input type = "text" name = "rec_dept" /><p>
			   <p>Mail: 				<input type = "text" name = "rec_mail" /><p>
			   <p>Note: 				<input type = "text" name = "note" /><p>
			   <!-- p>Certificate: 			<input type = "text" name = "cert" /><p -->
			   <input type = "hidden" name = "sub_fname" value= <%= session.getAttribute("givenName") %> />
			   <input type = "hidden" name = "sub_lname" value=<%= session.getAttribute("surname") %> />
			   <input type = "hidden" name = "sub_dept" value=<%= session.getAttribute("deptNumber") %> />
                 <p> <input type = "submit" value = "Submit" />
 <input type="reset" value="Reset">
               </p>
            </form>
<%
		}
		else {
			Class.forName ("com.mysql.jdbc.Driver").newInstance();
			String url = "jdbc:mysql://bigyellowcat.cs.binghamton.edu:3306/low";
			Connection con = DriverManager.getConnection(url,"low", "low0607");
			Statement stmt = con.createStatement();

			String mytest = "insert into P4_Awarded values (0,'"+session.getAttribute("givenName")+"', '', '"+session.getAttribute("surname")+"', '"+session.getAttribute("deptNumber")+
			"', '"+rec_fname+"','"+rec_mi+"', '"+rec_lname+"', '"+rec_dept+"', '"+rec_mail+"', '"+note+"', '', NOW() , '"+session.getAttribute("loggedInUser")+"' )";
			//out.println(mytest);
			ResultSet rs = stmt.executeQuery("select count(*) as rowcount from P4_Awarded where sub_fname='"+session.getAttribute("givenName")+"' and sub_lname='"+session.getAttribute("surname")+"' ");
			rs.next();
			int count = rs.getInt("rowcount");
	
			rs = stmt.executeQuery("select * from P4_Misc where data='max_submissions'");
			rs.next();
			int max = rs.getInt("numval");






			if (count >=max) out.println ("You have already submitted the maximum amount!");
			else {
				//send emails at this point
				stmt.executeUpdate(mytest);
			}
		}
   
%>
			

		<p><a href="entrance.jsp">Back to Entrance</a></p>
	
	</body>
</html>
<%
}
else out.println("Please log in");
%>

