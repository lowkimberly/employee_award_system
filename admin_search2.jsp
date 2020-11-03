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

				if (request.getParameter("aid")!="" && request.getParameter("button")!= null && request.getParameter("button").equals("Edit"))	{

					stmt.executeUpdate("update P4_Awarded set sub_fname='"+request.getParameter("sub_fname")+"', sub_mi='"+request.getParameter("sub_mi")+"', sub_lname='"+request.getParameter("sub_lname")+"', sub_dept='"+request.getParameter("sub_dept")+"', rec_fname='"+request.getParameter("rec_fname")+"', rec_mi='"+request.getParameter("rec_mi")+"', rec_lname='"+request.getParameter("rec_lname")+"', rec_dept='"+request.getParameter("rec_dept")+"', rec_mail='"+request.getParameter("rec_mail")+"', note='"+request.getParameter("note")+"', prize='"+request.getParameter("prize")+"', date='"+request.getParameter("award_date")+"' where awardid='"+request.getParameter("aid")+"' ");
					}
				else if (request.getParameter("aid")!="" && request.getParameter("button").equals("Delete"))	stmt.executeUpdate(" delete from P4_Awarded where awardid='"+request.getParameter("aid")+"' ");

			out.println("Successfully edited. <a href='admin_search1.jsp'>Go Back.</a>");
		}

	

    catch (Exception e)
      {
		out.println("Execption: " + e.toString());
      }
 

}
else out.println("Access denied.  Contact the YEA! Administrator at x3301");

 %>
