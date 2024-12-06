<%@page import="java.sql.Connection"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.*"%>
<%@page import="java.sql.ResultSet"%>
<%@page language="java" contentType="text/html" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" href="styles.css"/>
    </head>
    <body>
        <%
            try {
            // Fazer a conexao com o banco de dados
            Connection conecta;
            PreparedStatement st;
            Class.forName("com.mysql.cj.jdbc.Driver");
            String url="jdbc:mysql://localhost:3306/agenda_telefonica";
            String user="root";
            String password="";
            conecta=DriverManager.getConnection(url,user,password);
            // Lista os dados  da tabela produto do banco de dados
            String sql=("SELECT * FROM contato");
            st=conecta.prepareStatement(sql);
            // ResultSet serve para guardar aquilo que é trazido do BD
            ResultSet rs=st.executeQuery();
            // Enquanto não chegar no final, ele vai executar
            // o que estiver dentro do while 
            // vamos montar uma tabela html
            // criando o titulo da tabela 
            // encerrar o código Java            
        %>
        <table target="centro" border="3">
            <tr>
                <th>ID</th>
                <th>Nome</th>
                <th>Número</th>
            </tr>
            <%
                while (rs.next()){                               
            %>
                <!--<!-- Finalizei o codigo java acima e agora vou 
                criar uma tabela html para mostrar os dados trazidos
                do BD-->
            <tr>
                <td>
                    <%= rs.getString("ID")%>
                </td>
                <td>
                    <%= rs.getString("nome")%>
                </td>
                <td>
                    <%= rs.getString("numero")%>
                </td>
                <td>
                    <a href="excluir.jsp?id=<%=rs.getString("id")%>">Excluir</a>
                    <a href="editar.jsp?id=<%=rs.getString("id")%>">Editar</a>
                </td>
            </tr>
            <%
                }
                %>
        </table>
        <% 
            } catch (Exception x) {
                out.print ("Mensagem de erro: " + x.getMessage());
            }
        %>
        

    </body>
</html>