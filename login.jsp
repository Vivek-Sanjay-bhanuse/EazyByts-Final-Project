
<%@page import="java.sql.*"%>
<%@page import="java.util.*"%>


<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Fitness Login Form</title>
    <style>
        body {
            margin: 0;
            font-family: 'Arial', sans-serif;
            background: url('img2.jpg') no-repeat center center fixed;
            background-size: cover;
        }

        .login-container {
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            background-color: rgba(0, 0, 0, 0.5); /* Dark overlay */
        }

        .login-form {
            background-color: rgba(255, 255, 255, 0.8); /* Semi-transparent white background */
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0px 0px 15px rgba(0, 0, 0, 0.3);
            width: 350px;
            text-align: center;
        }

        .login-form h2 {
            margin-bottom: 20px;
            font-size: 24px;
            color: #333;
            text-transform: uppercase;
            letter-spacing: 1.5px;
        }

        .input-group {
            margin-bottom: 20px;
            text-align: left;
        }

        .input-group label {
            display: block;
            margin-bottom: 5px;
            font-size: 14px;
            color: #333;
        }

        .input-group input {
            width: 100%;
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 5px;
            box-sizing: border-box;
            font-size: 14px;
        }

        .options {
            display: flex;
            justify-content: space-between;
            align-items: center;
            font-size: 14px;
            margin-bottom: 20px;
        }

        .options label {
            color: #333;
        }

        .options a {
            color: #d9534f;
            text-decoration: none;
        }

        .options a:hover {
            text-decoration: underline;
        }

        button {
            width: 100%;
            padding: 10px;
            background-color: #d9534f;
            border: none;
            border-radius: 5px;
            color: #fff;
            font-size: 16px;
            cursor: pointer;
        }

        button:hover {
            background-color: #c9302c;
        }
    </style>
</head>
<body>
    <div class="login-container">
        <div class="login-form">
            <h2>Fitness Login Form</h2>
            <form action="login.jsp" method="post">
                <div class="input-group">
                    <label for="username">Username</label>
                    <input type="text" id="username" name="username" placeholder="Username" required>
                </div>
                <div class="input-group">
                    <label for="password">Password</label>
                    <input type="password" id="password" name="password" placeholder="Password" required>
                </div>
                <div class="options">
                    <label>
                        <input type="checkbox" name="staySignedIn">
                        Stay Signed In
                    </label>
                    <a href="#">Forgot Password?</a>
                </div>
                <button type="submit">Log In</button>
            </form>
            <%
            String username = request.getParameter("username");
            String password = request.getParameter("password");

            if (username != null && password != null) {
                Connection conn = null;
                PreparedStatement ps = null;
                ResultSet rs = null;

                try {
                	String dbDriver = "org.postgresql.Driver";
                    String dbURL = "jdbc:postgresql://localhost:5432/fitness";
                    String dbUsername = "postgres";
                    String dbPassword = "root";

                    Class.forName(dbDriver);
                    conn = DriverManager.getConnection(dbURL, dbUsername, dbPassword);
                    ps = conn.prepareStatement("SELECT * FROM users WHERE username = ? AND password = ?");
                    ps.setString(1, username);
                    ps.setString(2, password);

                    rs = ps.executeQuery();

                    if (rs.next()) {
                        out.println("<p>Login successful! Welcome, " + username + ".</p>");
                        response.sendRedirect("portfolio.jsp");
                    } else {
                        out.println("<p>Invalid username or password. Please try again.</p>");
                    }
                } catch (Exception e) {
                    e.printStackTrace();
                    out.println("<p>Login failed. Please try again.</p>");
                } finally {
                    if (rs != null) rs.close();
                    if (ps != null) ps.close();
                    if (conn != null) conn.close();
                }
            }
        %>
        </div>
    </div>
</body>
</html>