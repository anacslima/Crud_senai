<%@page import="java.sql.Connection" %>
<%@page import="java.sql.DriverManager" %>
<%@page import="java.sql.PreparedStatement" %>
<%@page import="java.sql.ResultSet" %>
<%@page import="java.sql.SQLException" %>

<%@page language="java" contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Salvar</title>
    <link rel="stylesheet" href="styles.css"/>
</head>
<body>
    <%
        request.setCharacterEncoding("UTF-8"); // Configura o encoding da requisição para UTF-8
        String nome = request.getParameter("nome"); // Obtém o valor do campo 'nome' enviado pelo formulário
        String numero = request.getParameter("numero"); // Obtém o valor do campo 'numero' enviado pelo formulário

        // Verifica se o número tem exatamente 11 dígitos
        if (numero == null || numero.length() != 11) {
            out.print("<p style='color:red;font-size:25px'>O número de telefone deve ter exatamente 11 dígitos.</p>");
            
            // Redireciona o usuário de volta para a página de cadastro (adicionar.html) após 3 segundos
            response.setHeader("Refresh", "3; URL=adicionar.html"); // Redireciona para adicionar.html
        } else {
            Connection conecta = null; // Declara a variável de conexão com o banco
            PreparedStatement pst = null; // Declara a variável de PreparedStatement para executar comandos SQL
            ResultSet rs = null; // Declara a variável de ResultSet para armazenar os resultados da consulta

            try {
                Class.forName("com.mysql.cj.jdbc.Driver"); // Carrega o driver JDBC do MySQL
                String url = "jdbc:mysql://localhost:3306/agenda_telefonica?useUnicode=true&characterEncoding=UTF-8"; // URL de conexão com o banco de dados
                String user = "root"; // Nome do usuário do banco
                String password = ""; // Senha do usuário (vazia neste caso)
                conecta = DriverManager.getConnection(url, user, password); // Estabelece a conexão com o banco de dados
                
                // Verifica se o número já está cadastrado no banco
                String verificaSql = "SELECT COUNT(*) FROM contato WHERE numero = ?"; // Consulta para verificar a existência do número
                pst = conecta.prepareStatement(verificaSql); // Prepara a consulta
                pst.setString(1, numero); // Define o parâmetro da consulta com o número enviado
                rs = pst.executeQuery(); // Executa a consulta e armazena o resultado no ResultSet

                if (rs.next() && rs.getInt(1) > 0) { // Se o número já existe no banco, exibe uma mensagem
                    out.print("<p style='color:green;font-size:25px'>Este Número já está cadastrado.</p>");
                    
                    // Redireciona para a página de cadastro (adicionar.html) após 3 segundos
                    response.setHeader("Refresh", "3; URL=adicionar.html"); // Redireciona para adicionar.html
                } else {
                    // Caso o número não esteja cadastrado, prepara para inserir o novo contato
                    String sql = "INSERT INTO contato (nome, numero) VALUES (?, ?)"; // Comando SQL para inserir o contato
                    pst.close(); // Fecha o PreparedStatement anterior
                    pst = conecta.prepareStatement(sql); // Prepara o novo comando SQL

                    pst.setString(1, nome); // Define o nome como parâmetro da consulta
                    pst.setString(2, numero); // Define o número como parâmetro da consulta

                    pst.executeUpdate(); // Executa a inserção no banco de dados
                    out.print("<p style='color:green;font-size:25px'>Contato cadastrado com sucesso.</p>");
                    
                    // Redireciona para a página principal (apresentacao.jsp) após 3 segundos
                    response.setHeader("Refresh", "3; URL=apresentacao.jsp");
                }
            } catch (SQLException x) { // Captura erros relacionados a SQL
                String erro = x.getMessage(); // Obtém a mensagem de erro
                out.print("<p style='color:red;font-size:25px'>Mensagem de erro: " + erro + "</p>");
            } catch (Exception e) { // Captura qualquer erro inesperado
                out.print("<p style='color:red;font-size:25px'>Erro inesperado: " + e.getMessage() + "</p>");
            } finally { // Bloco final para garantir que os recursos sejam fechados
                if (rs != null) { // Se o ResultSet não for nulo, fecha ele
                    try {
                        rs.close();
                    } catch (SQLException e) {
                        out.print("<p style='color:red;font-size:25px'>Erro ao fechar o ResultSet: " + e.getMessage() + "</p>");
                    }
                }
                if (pst != null) { // Se o PreparedStatement não for nulo, fecha ele
                    try {
                        pst.close();
                    } catch (SQLException e) {
                        out.print("<p style='color:red;font-size:25px'>Erro ao fechar o PreparedStatement: " + e.getMessage() + "</p>");
                    }
                }
                if (conecta != null) { // Se a conexão não for nula, fecha ela
                    try {
                        conecta.close();
                    } catch (SQLException e) {
                        out.print("<p style='color:red;font-size:25px'>Erro ao fechar a conexão: " + e.getMessage() + "</p>");
                    }
                }
            }
        }
    %>

</body>
</html>
