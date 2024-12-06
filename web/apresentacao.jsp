<%@page import="java.sql.Connection"%> <!-- Importa a classe Connection para gerenciar a conexão com o banco de dados -->
<%@page import="java.sql.DriverManager"%> <!-- Importa a classe DriverManager para gerenciar os drivers JDBC -->
<%@page import="java.sql.*"%> <!-- Importa todas as classes necessárias de java.sql para trabalhar com JDBC -->
<%@page import="java.sql.ResultSet"%> <!-- Importa a classe ResultSet para trabalhar com os dados retornados do banco -->
<%@page language="java" contentType="text/html" pageEncoding="ISO-8859-1"%> <!-- Define a linguagem como Java e o tipo de conteúdo como HTML -->

<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8"> <!-- Define a codificação de caracteres para UTF-8 -->
        <meta name="viewport" content="width=device-width, initial-scale=1.0"> <!-- Define a configuração de responsividade para dispositivos móveis -->
        <link rel="stylesheet" href="styles.css"/> <!-- Link para o arquivo de estilo externo (CSS) -->
    </head>
    <body>
        <%
            try {
                // Faz a conexão com o banco de dados
                Connection conecta; 
                PreparedStatement st; // Prepara a instrução SQL
                Class.forName("com.mysql.cj.jdbc.Driver"); // Carrega o driver JDBC do MySQL
                String url="jdbc:mysql://localhost:3306/agenda_telefonica"; // Define o URL de conexão com o banco de dados
                String user="root"; // Define o usuário do banco
                String password=""; // Define a senha (vazia neste caso)
                conecta=DriverManager.getConnection(url, user, password); // Estabelece a conexão com o banco de dados
                
                // Consulta SQL para listar todos os contatos
                String sql=("SELECT * FROM contato"); 
                st=conecta.prepareStatement(sql); // Prepara a consulta SQL
                
                // ResultSet serve para armazenar os dados retornados do banco de dados
                ResultSet rs=st.executeQuery(); // Executa a consulta e armazena o resultado

                // Enquanto o ResultSet tiver dados, o código dentro do while será executado
        %>
        
        <!-- Criação da tabela HTML para exibir os dados do banco -->
        <table border="3">
            <tr>
                <th>Nome</th> <!-- Cabeçalho da coluna "Nome" -->
                <th>Número</th> <!-- Cabeçalho da coluna "Número" -->
                <th>Ações</th> <!-- Cabeçalho da coluna "Ações" -->
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
                    <%= rs.getString("numero") %> <!-- Exibe o número do contato -->
                </td>
                <td>
                    <!-- Links para editar ou excluir o contato, passando o ID como parâmetro na URL -->
                    <a href="excluir.jsp?id=<%= rs.getString("id") %>">Excluir</a>
                    <a href="editar.jsp?id=<%= rs.getString("id") %>">Editar</a>
                </td>
            </tr>
            
            <%
                }
            %>
        </table>

        <% 
            } catch (Exception x) { // Bloco de captura de exceções, caso ocorra algum erro na execução
                out.print("Mensagem de erro: " + x.getMessage()); // Exibe a mensagem de erro no caso de falha
            }
        %>

    </body>
</html>
