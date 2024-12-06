<%@page import="java.sql.Connection"%> <!-- Importa a classe Connection para gerenciar a conex�o com o banco de dados -->
<%@page import="java.sql.DriverManager"%> <!-- Importa a classe DriverManager para gerenciar os drivers JDBC -->
<%@page import="java.sql.*"%> <!-- Importa todas as classes necess�rias de java.sql para trabalhar com JDBC -->
<%@page import="java.sql.ResultSet"%> <!-- Importa a classe ResultSet para trabalhar com os dados retornados do banco -->
<%@page language="java" contentType="text/html" pageEncoding="ISO-8859-1"%> <!-- Define a linguagem como Java e o tipo de conte�do como HTML -->

<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8"> <!-- Define a codifica��o de caracteres para UTF-8 -->
        <meta name="viewport" content="width=device-width, initial-scale=1.0"> <!-- Define a configura��o de responsividade para dispositivos m�veis -->
        <link rel="stylesheet" href="styles.css"/> <!-- Link para o arquivo de estilo externo (CSS) -->
    </head>
    <body>
        <%
            try {
                // Faz a conex�o com o banco de dados
                Connection conecta; 
                PreparedStatement st; // Prepara a instru��o SQL
                Class.forName("com.mysql.cj.jdbc.Driver"); // Carrega o driver JDBC do MySQL
                String url="jdbc:mysql://localhost:3306/agenda_telefonica"; // Define o URL de conex�o com o banco de dados
                String user="root"; // Define o usu�rio do banco
                String password=""; // Define a senha (vazia neste caso)
                conecta=DriverManager.getConnection(url, user, password); // Estabelece a conex�o com o banco de dados
                
                // Consulta SQL para listar todos os contatos
                String sql=("SELECT * FROM contato"); 
                st=conecta.prepareStatement(sql); // Prepara a consulta SQL
                
                // ResultSet serve para armazenar os dados retornados do banco de dados
                ResultSet rs=st.executeQuery(); // Executa a consulta e armazena o resultado

                // Enquanto o ResultSet tiver dados, o c�digo dentro do while ser� executado
        %>
        
        <!-- Cria��o da tabela HTML para exibir os dados do banco -->
        <table border="3">
            <tr>
                <th>Nome</th> <!-- Cabe�alho da coluna "Nome" -->
                <th>N�mero</th> <!-- Cabe�alho da coluna "N�mero" -->
                <th>A��es</th> <!-- Cabe�alho da coluna "A��es" -->
            </tr>
            
            <%
                while (rs.next()) { // Loop para percorrer todos os registros retornados
            %>
            
            <!-- Para cada linha do ResultSet, cria-se uma nova linha na tabela -->
            <tr>
                <td>
                    <%= rs.getString("nome") %> <!-- Exibe o nome do contato -->
                </td>
                <td>
                    <%= rs.getString("numero") %> <!-- Exibe o n�mero do contato -->
                </td>
                <td>
                    <!-- Links para editar ou excluir o contato, passando o ID como par�metro na URL -->
                    <a href="excluir.jsp?id=<%= rs.getString("id") %>">Excluir</a>
                    <a href="editar.jsp?id=<%= rs.getString("id") %>">Editar</a>
                </td>
            </tr>
            
            <%
                }
            %>
        </table>

        <% 
            } catch (Exception x) { // Bloco de captura de exce��es, caso ocorra algum erro na execu��o
                out.print("Mensagem de erro: " + x.getMessage()); // Exibe a mensagem de erro no caso de falha
            }
        %>

    </body>
</html>
