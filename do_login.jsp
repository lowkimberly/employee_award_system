<%@ page import="java.sql.*" %>
<%@ page import="java.net.URL" %>
<%@ page import=" java.util.*" %>
<%@ page import=" javax.naming.* "%>
<%@ page import=" javax.naming.directory.* "%>


<%
	String uid = request.getParameter("uid");
	String upass = request.getParameter("upass");
	
    if (uid == "" || upass == "") {
		out.println("<p>You didn't enter anything.</p>"); 
	}
 
 try
     {
		//Check LDAP for userid and password combination
		String BASE = "ou=People, o=airius.com";
		String FILTER = "uid="+uid; //kvaughan
		
		Hashtable<String,String> environment = new Hashtable<String,String>();
		environment.put(Context.INITIAL_CONTEXT_FACTORY,"com.sun.jndi.ldap.LdapCtxFactory");
		environment.put(Context.PROVIDER_URL,"ldap://bigyellowcat.cs.binghamton.edu:389");

		//use this to check login
		environment.put(Context.SECURITY_AUTHENTICATION, "simple");
		environment.put(Context.SECURITY_PRINCIPAL, "uid="+ uid+","+BASE);
		environment.put(Context.SECURITY_CREDENTIALS, upass);
		
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
			    out.println(attrname + valu);
				if (attrname.equals("sn: ")) session.setAttribute( "surname", valu);
				else if (attrname.equals("givenName: ")) session.setAttribute( "givenName", valu);
				else if (attrname.equals("departmentNumber: ")) session.setAttribute( "deptNumber", valu);
				else if (attrname.equals("ou: ") && valu.equals("Accounting")) session.setAttribute( "myou", "Accounting");
				else if (attrname.equals("ou: ") && valu.equals("Human Resources")) session.setAttribute( "myou", "HR");
				else if (attrname.equals("ou: ") && valu.equals("Product Testing")) session.setAttribute( "myou", "QA");
				else if (attrname.equals("ou: ") && valu.equals("Product Development")) session.setAttribute( "myou", "PD");				
			}
       }
	   
	   //found the user, check if admin
	   	BASE = "ou=Groups, o=airius.com";
		FILTER="cn=Directory Administrators";
		
		result = context.search(BASE, FILTER, scope);
		srchresults = (SearchResult) result.next();
	   
		dn = srchresults.getName();
		 attrs = srchresults.getAttributes();
		  ne = attrs.getAll();

		while (ne.hasMoreElements()) {
			 Attribute attr = (Attribute) ne.next();
			 String attrname = attr.getID() + ": ";
			 Enumeration values = attr.getAll();
			 while (values.hasMoreElements()) {
				String valu=values.nextElement().toString();
  			   //out.println(attrname + valu);
				if (attrname.equals("uniqueMember: ") && valu.equals("uid="+session.getAttribute("loggedInUser")+",ou=People,o=airius.com")) {
					session.setAttribute( "isAdmin", "true");
				}
			}
      	}
		//not an admin? Are they in the backup table?
			Class.forName ("com.mysql.jdbc.Driver").newInstance();
			String url = "jdbc:mysql://bigyellowcat.cs.binghamton.edu:3306/low";
			Connection con = DriverManager.getConnection(url,"low", "low0607");
			Statement stmt = con.createStatement();
			ResultSet rs = stmt.executeQuery( "select * from P4_Backups where uid='"+session.getAttribute("loggedInUser")+"';" );
			while(rs.next()) {
					session.setAttribute( "isAdmin", "true");
					session.setAttribute( "isBackup", "true");
			}

		//also are they a manager?
			 BASE = "ou=groups, o=airius.com";
			 FILTER="";
			if (session.getAttribute("myou").equals("Accounting"))		FILTER = "cn=Accounting Managers";
			else if (session.getAttribute("myou").equals("HR"))		FILTER = "cn=HR Managers";
			else if (session.getAttribute("myou").equals("QA"))		FILTER = "cn=QA Managers";
			else if (session.getAttribute("myou").equals("PD"))		FILTER = "cn=PD Managers";

					result = context.search(BASE, FILTER, scope);
			srchresults = (SearchResult) result.next();
			 dn = srchresults.getName();
			 attrs = srchresults.getAttributes();
			  ne = attrs.getAll();

			while (ne.hasMoreElements()) {
				 Attribute attr = (Attribute) ne.next();
				 String attrname = attr.getID() + ": ";
				 Enumeration values = attr.getAll();
				 while (values.hasMoreElements()) {
					String valu=values.nextElement().toString();
					if (attrname.equals("uniqueMember: ") && valu.equals("uid="+session.getAttribute("loggedInUser")+",ou=People,o=airius.com")) {
						session.setAttribute( "isManager", "true");
					}
				}
			}
	   
	   
		//found the user, go to entrance
		if (session.getAttribute("surname")!=null) {
			session.setAttribute( "loggedInUser", uid ); 
			String redirectURL = "entrance.jsp";
			response.sendRedirect(redirectURL); 
		}
	}
    catch (Exception e)
      {
		//out.println("Could not validate");
		out.println("Exception: " + e.toString());
      }
 
 %>
