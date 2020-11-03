<%@ page import="java.sql.*" %>
<%@ page import="java.net.URL" %>
<%@ page import=" java.util.*" %>
<%@ page import=" javax.naming.* "%>
<%@ page import=" javax.naming.directory.* "%>

<%

if (session.getAttribute("loggedInUser")!=null && session.getAttribute("isManager").equals("true")) {
%>
<html xmlns = "http://www.w3.org/1999/xhtml">
   <head>
		<title>Yea System</title>
   </head>

   <body>
<%
	//if no post data do this
	try    {
		if (request.getParameter( "date" )=="" || request.getParameter( "date" )==null || request.getParameter( "rotaryval" )=="" || request.getParameter( "rotaryval" )=="" ) {
			/*String BASE = "ou=groups, o=airius.com";
			String FILTER="";
			if (session.getAttribute("myou").equals("Accounting"))		FILTER = "cn=Accounting Managers";
			else if (session.getAttribute("myou").equals("HR"))		FILTER = "cn=HR Managers";
			else if (session.getAttribute("myou").equals("QA"))		FILTER = "cn=QA Managers";
			else if (session.getAttribute("myou").equals("PD"))		FILTER = "cn=PD Managers";

			boolean isManager=false;
		
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
					if (attrname.equals("uniqueMember: ") && valu.equals("uid="+session.getAttribute("loggedInUser")+",ou=People,o=airius.com")) {
						isManager=true;
					}
				}
			}*/
	   
			//if(isManager) {
		%>
            <form action = "run_reports.jsp" method = "post">
				<p>Since: <input type = "text" name = "date" /></p>
			   
				<p><input type='radio' name='rotary' value='onlydept' checked> Dept number </p>
				<p><input type='radio' name='rotary' value='deptsub'> Dept number with subordinate departments </p>
				<p><input type='radio' name='rotary' value='employee'> Employee uid </p>
				<p><input type='text' name='rotaryval'></p>

				<p>Submitter <input type='radio' name='sub' value='submitter' checked></p>
				<p>Receiver <input type='radio' name='sub' value='receiver'></p>
				
                <p> <input type = "submit" value = "Submit" /></p>
            </form>
		<%
			//}
	}
	else {

	//we have post data run the report instead
		Class.forName ("com.mysql.jdbc.Driver").newInstance();
		String url = "jdbc:mysql://bigyellowcat.cs.binghamton.edu:3306/low";
		Connection con = DriverManager.getConnection(url,"low", "low0607");
		Statement stmt = con.createStatement();

		/*
		date is required
		
		dept only + submitters
		dept and sub + submitters
		employee id + submitter
		
		dept only + receiver
		dept and sub + receiver
		employee id + receiver
		
		*/
		String partq="select * from P4_Awarded where date >='"+request.getParameter( "date" )+"' and ";

		if 		(request.getParameter( "rotary" ).equals("onlydept") && request.getParameter("sub").equals("submitter"))	partq = partq+ "sub_dept= '" + request.getParameter( "rotaryval" )+"' ";
		else if (request.getParameter( "rotary" ).equals("onlydept") && request.getParameter("sub").equals("receiver"))		partq = partq+ "rec_dept= '" + request.getParameter( "rotaryval" )+"' ";
		else if (request.getParameter( "rotary" ).equals("deptsub") && request.getParameter("sub").equals("submitter"))		partq = partq+ "sub_dept= '" + request.getParameter( "rotaryval" )+"' ";
		else if (request.getParameter( "rotary" ).equals("deptsub") && request.getParameter("sub").equals("receiver"))		partq = partq+ "rec_dept= '" + request.getParameter( "rotaryval" )+"' ";

		else if (request.getParameter( "rotary" ).equals("employee") && request.getParameter( "sub" ).equals("submitter"))	partq = partq+ "sub_uid= '" +  request.getParameter( "rotaryval" )+"' ";
		else if (request.getParameter( "rotary" ).equals("employee") && request.getParameter( "sub" ).equals("receiver"))	partq = partq+ "rec_mail= '" + request.getParameter( "rotaryval" )+"@airius.com' ";

		ResultSet rs = stmt.executeQuery( partq);


			out.println(
"<table style='border: 1px solid black;border-collapse:collapse;'>" + 

"<tr>" +
"<td style='border: 1px solid black'>Submitter</td>" +
"<td style='border: 1px solid black'>Sub. Dept.</td>" +
"<td style='border: 1px solid black'>Receiver</td>" +
"<td style='border: 1px solid black'>Rec. Dept.</td>" +
"<td style='border: 1px solid black'>Mail</td>" +
"<td style='border: 1px solid black'>Note</td>" +
"<td style='border: 1px solid black'>Prize</td>" +
"<td style='border: 1px solid black'>Date</td>" +
"</tr>");

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
					out.println(rs.getString("prize"));
				out.println("</td><td style='border: 1px solid black'>");
					out.println(rs.getString("date"));
				
				


				out.println("</td></tr>");
			}
			out.println("</table>");
}

	   }
    catch (Exception e)
      {
		out.println("Execption: " + e.toString());
      }

	  %>

		<p><a href="entrance.jsp">Back to Entrance</a></p>
	
	</body>
</html>
<%
}



else out.println("Please log in");
%>

