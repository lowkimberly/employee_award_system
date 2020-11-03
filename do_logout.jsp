<%@ page import="java.sql.*" %>
<%@ page import="java.net.URL" %>
<%@ page import=" java.util.*" %>
<%@ page import=" javax.naming.* "%>
<%@ page import=" javax.naming.directory.* "%>


<%
					session.setAttribute( "isAdmin", null);
					session.setAttribute( "isBackup", null);
					session.setAttribute( "isManager", null);
					session.setAttribute( "myou", null);
					session.setAttribute( "surname", null);
					session.setAttribute( "givenName", null);
					session.setAttribute( "deptNumber", null);
					session.setAttribute( "loggedInUser", null);
			response.sendRedirect("login.jsp"); 
 %>
