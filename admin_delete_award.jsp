<%@ page import="java.sql.*" %>
<%@ page import="java.net.URL" %>
<%@ page import=" java.util.*" %>
<%@ page import=" javax.naming.* "%>
<%@ page import=" javax.naming.directory.* "%>

<%
if (session.getAttribute("loggedInUser")!=null && session.getAttribute("isAdmin").equals("true")) {

try     {


%>

<form action="admin_home.jsp" method="post">
<p>Delete awards before: <input type = 'text' name="del_date"  /></p>
<p>Enter 'YES I AM SURE' if absolutely sure: <input type = 'text' name="confirm"  /></p>
<input type = 'hidden' name="del_awards" value = 'true' />
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
