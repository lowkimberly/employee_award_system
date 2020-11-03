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
			String base_query = "select * from P4_Awarded where ";
			ResultSet rs = null;
			if(request.getParameter("adminsearch")!=null ) {

				if (request.getParameter("start_date")!="")		base_query = base_query + " date>='"+request.getParameter("start_date")+"' and ";
				if (request.getParameter("end_date")!="")		base_query = base_query + " date<='"+request.getParameter("end_date")+"' and ";
				if (request.getParameter("submitter_uid")!="")		base_query = base_query + " sub_uid='"+request.getParameter("submitter_uid")+"' and ";
				if (request.getParameter("submitter_last")!="")		base_query = base_query + " sub_lname='"+request.getParameter("submitter_last")+"' and ";
				
				if (request.getParameter("recipient_uid")!="")		base_query = base_query + " rec_mail='"+request.getParameter("recipient_uid")+"@airius.com' and ";
				if (request.getParameter("recipient_last")!="")		base_query = base_query + " rec_lname='"+request.getParameter("recipient_last")+"' and ";
				if (request.getParameter("sub_dept")!="")		base_query = base_query + " sub_dept='"+request.getParameter("sub_dept")+"' and ";
				if (request.getParameter("rec_dept")!="")		base_query = base_query + " rec_dept='"+request.getParameter("rec_dept")+"' and ";
				if (request.getParameter("prize")!="")			base_query = base_query + " prize='"+request.getParameter("prize")+"' and ";
				if (request.getParameter("award_date")!="")		base_query = base_query + " date='"+request.getParameter("award_date")+"' and ";

				base_query = base_query.substring(0, base_query.length() - 4);
				
				if (request.getParameter("limit_low")!="" && request.getParameter("limit_high")=="")		base_query = base_query + " limit "+request.getParameter("limit_low")+", 100 ";
				else if (request.getParameter("limit_low")=="" && request.getParameter("limit_high")!="")		base_query = base_query + " limit 0,"+request.getParameter("limit_high")+"  ";
				else if (request.getParameter("limit_low")!="" && request.getParameter("limit_high")!="")		base_query = base_query + " limit  "+request.getParameter("limit_low")+","+request.getParameter("limit_high")+"  ";
			 rs = stmt.executeQuery( base_query );

			 }
			

			out.println("<table style='border: 1px solid black;border-collapse:collapse;'><tr><td style='border: 1px solid black'>Submitter</td><td style='border: 1px solid black'>Sub. Dept.</td><td style='border: 1px solid black'>Receiver</td><td style='border: 1px solid black'>Rec. Dept.</td><td style='border: 1px solid black'>Mail</td><td style='border: 1px solid black'>Note</td><td style='border: 1px solid black'>Prize</td><td style='border: 1px solid black'>Date</td></tr>");

			while(rs!= null && rs.next()) {
				out.println("<form action='admin_search2.jsp' method='post'><tr><td style='border: 1px solid black'>");
			    out.println("<input type = 'text' name='sub_fname'  value='"+rs.getString("sub_fname")+"' >" + " " + "<input type = 'text' name='sub_mi' size=1 value='"+rs.getString("sub_mi")+"' >" + " " + "<input type = 'text' name='sub_lname'  value='"+rs.getString("sub_lname")+"' >");
				out.println("</td><td style='border: 1px solid black'>");
			    out.println("<input type = 'text' name='sub_dept' size=5 value='"+rs.getString("sub_dept")+"' >");
				out.println("</td><td style='border: 1px solid black'>");
			    out.println("<input type = 'text' name='rec_fname'  value='"+rs.getString("rec_fname")+"' >" + " " + "<input type = 'text' name='rec_mi'  size=1 value='"+rs.getString("rec_mi")+"' >" + " " + "<input type = 'text' name='rec_lname'  value='"+rs.getString("rec_lname")+"' >");
				out.println("</td><td style='border: 1px solid black'>");
			    out.println("<input type = 'text' name='rec_dept' size=5 value='"+rs.getString("rec_dept")+"' >");
				out.println("</td><td style='border: 1px solid black'>");
			    out.println("<input type = 'text' name='rec_mail'  value='"+rs.getString("rec_mail")+"' >");
				out.println("</td><td style='border: 1px solid black'>");
			    out.println("<input type = 'text' name='note'  value='"+rs.getString("note")+"' >");
				out.println("</td><td style='border: 1px solid black'>");
			    out.println("<input type = 'text' name='prize'  value='"+rs.getString("prize")+"' >");
				out.println("</td><td style='border: 1px solid black'>");
				 out.println("<input type = 'text' name='award_date'  value='"+rs.getString("date")+"' ><input type = 'submit' name='button' value = 'Edit' /><input type = 'submit' name='button' value = 'Delete' />");

				out.println("</td></tr>"+
				"<input type = 'hidden' name=aid value = '"+rs.getString("awardid")+"' />"
				+"</form>");
			}
			out.println("</table>");

%>
<hr>
<h3>Search</h3>
<form action="admin_search1.jsp" method="post">
<p>Start Date 			<input type = 'text' name="start_date"  /></p>
<p>End Date			<input type = 'text' name="end_date"  /></p>
<p>Submitter UID		<input type = 'text' name="submitter_uid"  /></p>
<p>Submitter Last Name	<input type = 'text' name="submitter_last"  /></p>
<p>Recipient UID		<input type = 'text' name="recipient_uid"  /></p>
<p>Recipient Last Name	<input type = 'text' name="recipient_last"  /></p>
<p>Submitter Department	<input type = 'text' name="sub_dept"  /></p>
<p>Recipient Department	<input type = 'text' name="rec_dept"  /></p>
<p>Award Chosen				<input type = 'text' name="prize"  /></p>
<p>Date of Award (YYYY-MM-DD):	<input type = 'text' name="award_date"  /></p>
<p>Min Results					<input type = 'text' name="limit_low"  /></p>
<p>Max Results					<input type = 'text' name="limit_high"  /></p>
<input type = 'hidden' name="adminsearch" value = 'true' />
<p><input type = 'submit' value = 'Submit' /></p>
</form>

<%



		

		}

	

    catch (Exception e)
      {
		out.println("Execption: " + e.toString());
      }
 

}
else out.println("Access denied.  Contact the YEA! Administrator at x3301");

 %>
