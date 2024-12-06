<%@page import="java.sql.Connection"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.*"%>
<%@page language="java" contentType="text/html" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Exclusão</title>
        <link rel="stylesheet" href="styles.css"/>
        <style>
            /* Estilizando os botões */
            button {
                font-size: 16px;
                padding: 10px 20px;
                margin: 5px; /* Botões mais próximos */
                cursor: pointer;
                border-radius: 5px;
                border: none;
                transition: background-color 0.3s ease;
            }
            /* Cor do botão "Sim" */
            button[type="submit"][value="Sim"] {
                background-color: #4CAF50; /* Verde */
                color: white;
            }
            /* Cor do botão "Não" */
            button[type="submit"][value="Não"] {
                background-color: #f44336; /* Vermelho */
                color: white;
            }
            /* Efeito de hover nos botões */
            button:hover {
                opacity: 0.8;
            }
            /* Estilizando o formulário */
            form {
                display: inline-block;
                margin-top: 20px;
            }
            /* Alinhando os botões na horizontal */
            .button-container {
                display: flex;
                justify-content: center;
                margin-top: 50px;
            }
        </style>
    </head>
    <body>
        <%
            // Recebe o código digitado no formulário (ID do contato)
            int id = Integer.parseInt(request.getParameter("id"));
            String confirmar = request.getParameter("confirmar");
            String numero = null;  // Variável para armazenar o número do contato

            if ("sim".equals(confirmar)) {
                // Se o parâmetro 'confirmar' for igual a 'sim', realiza a exclusão
                try {
                    // Conecta ao banco de dados chamado agenda_telefonica
                    Connection conecta;
                    PreparedStatement st;
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    String url = "jdbc:mysql://localhost:3306/agenda_telefonica";
                    String user = "root";
                    String password = "";
                    conecta = DriverManager.getConnection(url, user, password);
                    
                    // Primeiro, recupera o número do contato antes de excluí-lo
                    String sqlSelect = "SELECT numero FROM contato WHERE id=?";
                    st = conecta.prepareStatement(sqlSelect);
                    st.setInt(1, id);
                    ResultSet rs = st.executeQuery();
                    
                    if (rs.next()) {
                        numero = rs.getString("numero"); // Obtém o número do contato
                    }

                    // Excluindo o contato de código informado
                    String sqlDelete = "DELETE FROM contato WHERE id=?";
                    st = conecta.prepareStatement(sqlDelete);
                    st.setInt(1, id);
                    int resultado = st.executeUpdate(); // Executa o DELETE
                    
                    // Verifica se o contato foi excluído ou não
                    if (resultado == 0) {
                        out.print("<p style='color:blue;'>Este contato não está cadastrado.</p>");
                    } else {
                        out.print("<p style='color:green;font-size:25px'>O número " + numero + " foi excluído com sucesso.</p>");
                    }
                    
                    // Redireciona para a página principal (apresentacao.jsp) após 2 segundos
                    response.setHeader("Refresh", "2; URL=apresentacao.jsp");
                    
                } catch (Exception erro) {
                    String mensagemErro = erro.getMessage();
                    out.print("<p style='color:blue;font-size:25px'>Erro: " + mensagemErro + "</p>");
                }
            } else if ("nao".equals(confirmar)) {
                // Se o parâmetro 'confirmar' for igual a 'nao', volta para a página principal (apresentacao.jsp)
                out.print("<p style='color:green;font-size:25px'>Você clicou em 'Não'. A operação foi cancelada.</p>");
                
                // Redireciona para a página principal (apresentacao.jsp) após 2 segundos
                response.setHeader("Refresh", "2; URL=apresentacao.jsp");
            } else {
                // Caso o parâmetro 'confirmar' não tenha sido enviado, exibe a confirmação
                out.print("<h3>Você deseja excluir o contato com ID = " + id + "?</h3>");
                out.print("<div class='button-container'>");
                out.print("<form action='exclusao.jsp' method='get'>");
                out.print("<input type='hidden' name='id' value='" + id + "' />");
                out.print("<input type='hidden' name='confirmar' value='sim' />");
                out.print("<button type='submit' value='Sim'>Sim</button>");
                out.print("</form>");
                
                out.print("<form action='exclusao.jsp' method='get'>");
                out.print("<input type='hidden' name='id' value='" + id + "' />");
                out.print("<input type='hidden' name='confirmar' value='nao' />");
                out.print("<button type='submit' value='Não'>Não</button>");
                out.print("</form>");
                out.print("</div>");
            }
        %>
    </body>
</html>
