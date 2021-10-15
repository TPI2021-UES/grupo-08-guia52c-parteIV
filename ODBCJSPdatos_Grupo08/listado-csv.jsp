<%@page  import="java.sql.*,net.ucanaccess.jdbc.*" %>
<%@page import="java.io.*" %>

<%!
public Connection getConnection() throws SQLException {

   String driver = "sun.jdbc.odbc.JdbcOdbcDriver";
   String userName="grupo08",password="books08";
   String fullConnectionString = "jdbc:odbc:registro";
   Connection conn = null;
   try{
      Class.forName("sun.jdbc.odbc.JdbcOdbcDriver");
      conn = DriverManager.getConnection(fullConnectionString,userName,password);
   }
   catch (Exception e) {
      System.out.println("Error: " + e);
   }
   return conn;
}
%>


<%
   ServletContext context = request.getServletContext();
Connection conexion = getConnection();

String queryBase = "select li.isbn, li.titulo, li.autor, li.fechaPublicacion, edi.id, edi.nombre from libros as li inner join Editorial as edi on li.idEditorial = edi.id";
if(!conexion.isClosed()) {
    PrintWriter writer = response.getWriter();
    Statement st = conexion.createStatement();
    ResultSet re = st.executeQuery(queryBase);
    String isbn="";
    String titulo = "";
    String autor = "";
    String fechaPublicacion = "";
    String nombre="";
    while(re.next()) {
        isbn=re.getString("isbn");
        titulo=re.getString("titulo");
        autor=re.getString("autor");
        fechaPublicacion=re.getString("fechaPublicacion");
        nombre=re.getString("nombre");  

        writer.append(isbn).append(",");
        writer.append(titulo).append(",");
        writer.append(autor).append(",");
        writer.append(fechaPublicacion).append(",");
        writer.append(nombre).append("\n");
    }
}
response.setHeader("Content-Type", "text/csv");
response.setHeader("Content-Disposition", "attachment; filename=libros.csv");
response.setStatus(response.SC_ACCEPTED);
%>