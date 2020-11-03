<%@ page import="java.sql.*" %>
<%@ page import="java.net.URL" %>
<%@ page import=" java.util.*" %>
<%@ page import=" javax.naming.* "%>
<%@ page import=" javax.naming.directory.* "%>

<%
if (session.getAttribute("loggedInUser")!=null && session.getAttribute("isAdmin").equals("true")) {
//if no post data do this
try     {/*

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
	   
		if(isAdmin) {*/
					Class.forName ("com.mysql.jdbc.Driver").newInstance();
			String url = "jdbc:mysql://bigyellowcat.cs.binghamton.edu:3306/low";
			Connection con = DriverManager.getConnection(url,"low", "low0607");
			Statement stmt = con.createStatement();
			ResultSet rs = stmt.executeQuery( "select * from P4_News where active=1;" );

			out.println(" "+
			"<table style='border: 1px solid black;border-collapse:collapse;'><tr><td></td><td style='border: 1px solid black'>Start</td><td style='border: 1px solid black'>End</td><td style='border: 1px solid black'>Content</td></tr>"
			);

			while(rs.next()) {
			out.println("<form action='admin_home.jsp' method='post'>");
				out.println("<tr><td style='border: 1px solid black'>");
			    out.println("	<input type = 'submit' name='button' value = 'Edit!' /><input type = 'submit' name='button' value = 'Delete!' /><input type='hidden' name='to_edit' value='"+rs.getString("nid")+"'>");
				out.println("</td><td style='border: 1px solid black'> <input type = 'text' name='start_date' value='"+rs.getString("start_date")+"' />");
				out.println("</td><td style='border: 1px solid black'> <input type = 'text' name='end_date' value='"+rs.getString("end_date")+"' />");
				out.println("</td><td style='border: 1px solid black'> <input type = 'text' name='content' value='"+rs.getString("content")+"' />");

				out.println("<input type = 'hidden' name='editnews' value = 'true' /> </form>");
				out.println("</td></tr>");
				
			}
	
			out.println(" </table>  ");
%>
<hr>
Enter a news item:
<form action="admin_home.jsp">
<p>Start: <input type = 'text' name="start_date"  /></p>
<p>End: <input type = 'text' name="end_date" /></p>
<p>Content: <textarea rows=3 cols=32 name="content" />Put news here</textarea></p>
<input type = 'hidden' name="newnews" value = 'true' />
<p><input type = 'submit' value = 'Submit' /></p>
</form>

<%



		//}

		}

	

    catch (Exception e)
      {
		out.println("Execption: " + e.toString());
      }
 

}
else out.println("Access denied.  Contact the YEA! Administrator at x3301");

 %>
