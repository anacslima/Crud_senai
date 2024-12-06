<%@page import="java.sql.Connection"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.*"%>
<%@page language="java" contentType="text/html" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Exclus�o</title>
        <link rel="stylesheet" href="styles.css"/>
        <style>
            /* Estilizando os bot�es */
            button {
                font-size: 16px;
                padding: 10px 20px;
                margin: 2px; /* Reduzido para aproximar os bot�es */
                cursor: pointer;
                border-radius: 5px;
                border: none;
                transition: background-color 0.3s ease;
            }
            /* Cor do bot�o "Sim" */
            button[type="submit"][value="Sim"] {
                background-color: #4CAF50; /* Verde */
                color: white;
            }
            /* Cor do bot�o "N�o" */
            button[type="submit"][value="N�o"] {
                background-color: #f44336; /* Vermelho */
                color: white;
            }
            /* Efeito de hover nos bot�es */
            button:hover {
                opacity: 0.8;
            }
            /* Estilizando o formul�rio */
            form {
                display: inline-block;
                margin-top: 20px;
            }
            /* Alinhando os bot�es na horizontal */
            .button-container {
                justify-content: center;
                margin-top: 50px;
                margin-left: 10%;
            }
        </style>
    </head>
    <body>
        <%
            // Recebe o c�digo digitado no formul�rio
            int id = Integer.parseInt(request.getParameter("id"));
            String confirmar = request.getParameter("confirmar");
            String numero = null;  // Vari�vel para armazenar o n�mero do contato

            if ("sim".equals(confirmar)) {
                // Se o par�metro 'confirmar' for igual a 'sim', realiza a exclus�o
                try {
                    // Conecta ao banco de dados chamado agenda_telefonica
                    Connection conecta;
                    PreparedStatement st;
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    String url = "jdbc:mysql://localhost:3306/agenda_telefonica";
                    String user = "root";
                    String password = "";
                    conecta = DriverManager.getConnection(url, user, password);
                    
                    // Primeiro, recupera o n�mero do contato antes de exclu�-lo
                    String sqlSelect = "SELECT numero FROM contato WHERE id=?";
                    st = conecta.prepareStatement(sqlSelect);
                    st.setInt(1, id);
                    ResultSet rs = st.executeQuery();
                    
                    if (rs.next()) {
                        numero = rs.getString("numero"); // Obt�m o n�mero do contato
                    }

                    // Excluindo o contato de c�digo informado
                    String sqlDelete = "DELETE FROM contato WHERE id=?";
                    st = conecta.prepareStatement(sqlDelete);
                    st.setInt(1, id);
                    int resultado = st.executeUpdate(); // Executa o DELETE
                    
                    // Verifica se o contato foi exclu�do ou n�o
                    if (resultado == 0) {
                        out.print("Este contato n�o est� cadastrado.");
                    } else {
                        out.print("<p style='color:green;font-size:25px'>O n�mero " + numero + " foi exclu�do com sucesso.</p>");
                    }
                } catch (Exception erro) {
                    String mensagemErro = erro.getMessage();
                    out.print("<p style='color:blue;font-size:25px'>Erro: " + mensagemErro + "</p>");
                }
            } else if ("nao".equals(confirmar)) {
                // Se o par�metro 'confirmar' for igual a 'nao', volta para a p�gina anterior
                out.print("<p>Opera��o cancelada. Voltando � p�gina anterior...</p>");
            } else {
                // Caso o par�metro 'confirmar' n�o tenha sido enviado, exibe a confirma��o
                out.print("<h3>Voc� deseja excluir o contato com ID = " + id + "?</h3>");
                out.print("<div class='button-container'>");
                out.print("<form action='exclusao.jsp' method='get'>");
                out.print("<input type='hidden' name='id' value='" + id + "' />");
                out.print("<input type='hidden' name='confirmar' value='sim' />");
                out.print("<button type='submit' value='Sim'>Sim</button>");
                out.print("</form>");
                
                out.print("<form action='exclusao.jsp' method='get'>");
                out.print("<input type='hidden' name='id' value='" + id + "' />");
                out.print("<input type='hidden' name='confirmar' value='nao' />");
                out.print("<button type='submit' value='N�o'>N�o</button>");
                out.print("</form>");
                out.print("</div>");
            }
        %>
    </body>
</html>
