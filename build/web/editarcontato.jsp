<%@page import="java.sql.Connection"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.*"%>
<%@page import="java.sql.ResultSet"%>

<%@page language="java" contentType="text/html" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Atualizar Contato</title>
        <link rel="stylesheet" href="styles.css"/> 
    </head>
    <body>
        <%
            int id;
            String nome;
            String numero;

            try {
                id = Integer.parseInt(request.getParameter("id"));
                nome = request.getParameter("nome");
                numero = request.getParameter("numero");

                // Validação: verificar se o número contém apenas dígitos
                if (numero == null || !numero.matches("\\d+")) {
                    out.print("Por favor, insira um número válido.");
                } else {
                    // Conecta ao banco de dados chamado agenda_telefonica
                    Connection conecta;
                    PreparedStatement pst;
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    String url = "jdbc:mysql://localhost:3306/agenda_telefonica";
                    String user = "root";
                    String password = "";
                    conecta = DriverManager.getConnection(url, user, password);

                    // Instrução SQL
                    String sql = "UPDATE contato SET nome=?, numero=? WHERE id=?";
                    pst = conecta.prepareStatement(sql);
                    pst.setString(1, nome);
                    pst.setString(2, numero);
                    pst.setInt(3, id);
                    pst.executeUpdate();

                    // Mensagem de sucesso
                    out.print("<p style='color:green;font-size:25px'>Os dados do contato " + id + " foram alterados com sucesso.</p>");

                    // Redireciona para a tela principal após 2 segundos
                    response.setHeader("Refresh", "2; URL=apresentacao.jsp");
                }
            } catch (NumberFormatException e) {
                out.print("ID inválido. Por favor, insira um número válido.");
            } catch (Exception e) {
                out.print("Ocorreu um erro: " + e.getMessage());
            }
        %>
    </body>
</html>
