<%@page import="java.sql.Connection"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.ResultSet"%>
<%@page language="java" contentType="text/html" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Alterar Contato</title>
    <link rel="stylesheet" href="styles.css"/> 
</head>
<body>
    <%
        String idParam = request.getParameter("id"); // Recebe o ID do contato a alterar
        String mensagemErro = null;

        if (idParam != null && !idParam.isEmpty()) {
            int id = Integer.parseInt(idParam); // Converte o ID para inteiro

            Connection conecta = null;
            PreparedStatement st = null;
            ResultSet resultado = null;

            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                String url = "jdbc:mysql://localhost:3306/agenda_telefonica";
                String user = "root";
                String password = "";
                conecta = DriverManager.getConnection(url, user, password);
                
                // Busca o contato pelo ID recebido
                String sql = "SELECT * FROM contato WHERE id=?";
                st = conecta.prepareStatement(sql);
                st.setInt(1, id); // Usa o ID como parâmetro
                resultado = st.executeQuery();
                
                // Verifica se o contato foi encontrado
                if (!resultado.next()) { 
                    mensagemErro = "<p style='color:red;font-size:25px'>Contato não encontrado</p>";
                } else {
                    // Armazena os dados do contato se encontrado
                    String nome = resultado.getString("nome");
                    String numero = resultado.getString("numero");
        %>
        <form method="post" action="editarcontato.jsp">
            <p>
                <label for="nome">Nome do Contato:</label>
                <input type="text" name="nome" id="nome" value="<%= nome %>">
            </p>
            <p>
                <label for="numero">Número:</label>
                <input type="number" name="numero" id="numero" value="<%= numero %>">
            </p>
            <input type="hidden" name="id" value="<%= id %>"> <!-- Passa o ID para a edição -->
            <input type="submit" value="Salvar">
            <button type="button" onclick="window.history.back()">Voltar</button>
        </form>
        <%
                }
            } catch (Exception e) {
                mensagemErro = "<p style='color:red;'>Erro ao acessar o banco de dados: " + e.getMessage() + "</p>";
            } finally {
                // Fecha os recursos
                if (resultado != null) try { resultado.close(); } catch (Exception e) {}
                if (st != null) try { st.close(); } catch (Exception e) {}
                if (conecta != null) try { conecta.close(); } catch (Exception e) {}
            }
        } else {
            mensagemErro = "<p style='color:red;'>ID inválido.</p>";
        }

        // Exibe mensagem de erro se houver
        if (mensagemErro != null) {
            out.print(mensagemErro);
        }
    %>

    <%
        // Verifique se o formulário de edição foi enviado e, após a alteração, redirecione
        String nomeEditado = request.getParameter("nome");
        String numeroEditado = request.getParameter("numero");
        
        if (nomeEditado != null && numeroEditado != null && idParam != null) {
            // Atualizar no banco de dados
            try {
                int id = Integer.parseInt(idParam);
                Connection conecta = DriverManager.getConnection("jdbc:mysql://localhost:3306/agenda_telefonica", "root", "");
                String sqlUpdate = "UPDATE contato SET nome=?, numero=? WHERE id=?";
                PreparedStatement stUpdate = conecta.prepareStatement(sqlUpdate);
                stUpdate.setString(1, nomeEditado);
                stUpdate.setString(2, numeroEditado);
                stUpdate.setInt(3, id);
                int resultado = stUpdate.executeUpdate();
                
                // Se a atualização for bem-sucedida, redireciona
                if (resultado > 0) {
                    response.sendRedirect("apresentacao.jsp"); // Redireciona para a tela principal
                } else {
                    out.print("<p style='color:red;'>Erro ao salvar as alterações.</p>");
                }
            } catch (Exception e) {
                out.print("<p style='color:red;'>Erro ao acessar o banco de dados: " + e.getMessage() + "</p>");
            }
        }
    %>
</body>
</html>
