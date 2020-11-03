<%@ page import="java.sql.*" %>
<%@ page import="java.net.URL" %>
<%@ page import=" java.util.*" %>
<%@ page import=" javax.naming.* "%>
<%@ page import=" javax.naming.directory.* "%>

<%
if (session.getAttribute("loggedInUser")!=null && session.getAttribute("isAdmin").equals("true")) {
	try     {
/*
		String BASE = "ou=Groups, o=airius.com";
		String FILTER="cn=Directory Administrators";
		boolean isAdmin=false;
		
		Hashtable<String,String> environment = new Hashtable<String,String>();
		environment.put(Context.INITIAL_CONTEXT_FACTORY,"com.sun.jndi.ldap.LdapCtxFactory");
		environment.put(Context.PROVIDER_URL,"ldap://bigyellowcat.cs.binghamton.edu:389");

		DirContext context = new InitialDirContext(environment);
		SearchControls scope = new SearchControls();
		scope.setSearchScope(SearchControls.SUBTREE_SCOPE);
		NamingEnumeration result = context.search(BASE, FILTER, scope);

		SearchResult srchresults = (SearchResult) result.next();
		String dn = srchresults.getName();
		String temp = "dn= " + dn + BASE;
		Attributes attrs = srchresults.getAttributes();
		NamingEnumeration  ne = attrs.getAll();

		while (ne.hasMoreElements()) {
			 Attribute attr = (Attribute) ne.next();
			 String attrname = attr.getID() + ": ";
			 Enumeration values = attr.getAll();
			 while (values.hasMoreElements()) {
				String valu=values.nextElement().toString();
  			   //out.println(attrname + valu);
				if (attrname.equals("uniqueMember: ") && valu.equals("uid="+session.getAttribute("loggedInUser")+",ou=People,o=airius.com")) {
					isAdmin=true;
				}
			}
      	}
		
		
		//is an admin
		if(isAdmin) {*/
		
		
			Class.forName ("com.mysql.jdbc.Driver").newInstance();
			String url = "jdbc:mysql://bigyellowcat.cs.binghamton.edu:3306/low";
			Connection con = DriverManager.getConnection(url,"low", "low0607");
			Statement stmt = con.createStatement();
			

			if( request.getParameter("new_max_sub")!= null &&  request.getParameter("new_max_sub")!= "" )
				 stmt.executeUpdate("update P4_Misc set numval='"+ request.getParameter("new_max_sub")+"' where mid=1 and data='max_submissions'; ");
			if( request.getParameter("delprize")!= null &&  request.getParameter("choice")!= "" )
				 stmt.executeUpdate("update P4_Award_Types set active=0 where prize='"+request.getParameter("choice")+"' ");
			if( request.getParameter("newprize")!= null && request.getParameter("prize")!="" &&  request.getParameter("description")!= "" )
				 stmt.executeUpdate("Insert into P4_Award_Types values(0,'"+request.getParameter("prize")+"','"+request.getParameter("description")+"',1);");
			if( request.getParameter("newnews")!= null && request.getParameter("start_date")!="" &&  request.getParameter("end_date")!= "" )
				 stmt.executeUpdate("Insert into P4_News values(0,'"+request.getParameter("start_date")+"','"+request.getParameter("end_date")+"','"+request.getParameter("content")+"', 1);");
			if( request.getParameter("editnews")!= null && request.getParameter("start_date")!="" &&  request.getParameter("end_date")!= "" && request.getParameter("end_date")!= "")
				 stmt.executeUpdate("Update P4_News set start_date='"+request.getParameter("start_date")+"', end_date='"+request.getParameter("end_date")+"', content='"+request.getParameter("content")
				 +"', active="+(request.getParameter("button").equals("Delete!")==false)+" where nid="+request.getParameter("to_edit")+" ;");
			if( request.getParameter("del_awards")!= null && request.getParameter("del_date")!="" && request.getParameter("confirm").equals("YES I AM SURE"))
				stmt.executeUpdate("delete from P4_Awarded where date < '"+ request.getParameter("del_date")+"'");
			if( request.getParameter("new_backup")!= null && request.getParameter("backupuid")!="" )
				 stmt.executeUpdate("Insert into P4_Backups values(0,'"+request.getParameter("backupuid")+"','"+session.getAttribute("loggedInUser")+"');");
			if( request.getParameter("delbackup")!= null && request.getParameter("delbackup").equals("Delete") && request.getParameter("delbackup2")!="" )
				 stmt.executeUpdate("delete from P4_Backups where bid='"+request.getParameter("delbackup2")+"'");
%>

<html xmlns = "http://www.w3.org/1999/xhtml">

   <head>
		<title>Yea System</title>
   </head>

   <body>
<%
			if( request.getParameter("new_max_sub")!= null &&  request.getParameter("new_max_sub")!= "" ) out.println("<p>Max submissions updated</p>");
			if( request.getParameter("delprize")!= null &&  request.getParameter("choice")!= "" ) out.println("<p>You have set a prize inactive.</p>");
			if( request.getParameter("newprize")!= null  ) out.println("<p>You have added a new prize.</p>");
			if( request.getParameter("newnews")!= null && request.getParameter("start_date")!="" &&  request.getParameter("end_date")!= "" ) out.println("<p>News item added.</p>");
			if( request.getParameter("editnews")!= null && request.getParameter("start_date")!="" &&  request.getParameter("end_date")!= "" ) out.println("<p>News item edited.</p>");
			if( request.getParameter("del_awards")!= null && request.getParameter("del_date")!="" && request.getParameter("confirm").equals("YES I AM SURE")) out.println("<p>Deleted.</p>");
			if( request.getParameter("new_backup")!= null && request.getParameter("backupuid")!="" )out.println("<p>Backup added</p>");
						if( request.getParameter("delbackup")!= null && request.getParameter("delbackup").equals("Delete") && request.getParameter("delbackup2")!="" ) out.println("<p>Backup deleted</p>");
%>

<ul>
<li><a href="admin_access_control.jsp">Access Control</a></li>
<li><a href="admin_award_data.jsp">Award Data</a></li>
<li>TQM Category</li>
<li><a href="admin_news.jsp">News</a></li>
<li><a href="admin_change_max.jsp">Change Max Submissions</a></li>
<li><a href="admin_search1.jsp">Search</a></li>
<li><a href="admin_delete_award.jsp">Delete Old Data</a></li>
</ul>
<p><a href="entrance.jsp">Back to Entrance</a></p>
	
	</body>
</html>

<%
		//}
	
	}
    catch (Exception e) {
		out.println("Execption: " + e.toString());
	}
}

else out.println("Access denied.  Contact the YEA! Administrator at x3301");

 %>
