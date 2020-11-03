<%@ page import="java.sql.*" %>
<%@ page import="java.net.URL" %>
<%@ page import=" java.util.*" %>
<%@ page import=" javax.naming.* "%>
<%@ page import=" javax.naming.directory.* "%>

<%
if (session.getAttribute("loggedInUser")!=null && session.getAttribute("isAdmin").equals("true")) {
//if no post data do this
try     {

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
	  //is an admin and no post data.
		//if(isAdmin) {
%>

<html xmlns = "http://www.w3.org/1999/xhtml">

   <head>
		<title>Yea System</title>
   </head>

   <body>

               <form action = "admin_home.jsp" method = "post">
               <p>New Max Submissions:	<input type = "text" name = "new_max_sub" /></p>
                <p> <input type = "submit" value = "Submit" />
               </p>
            </form>
	
	</body>
</html>

<%
		//}
		////////////////////////////
		

	
}
    catch (Exception e)
      {
		out.println("Execption: " + e.toString());
      }
 
}
else out.println("Access denied.  Contact the YEA! Administrator at x3301");

 %>
