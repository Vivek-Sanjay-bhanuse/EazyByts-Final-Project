<%@page import="java.sql.*"%>
<%@page import="java.util.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Fitness Registration Form</title>
    <style>
        body {
            margin: 0;
            font-family: 'Arial', sans-serif;
            background: url('img2.jpg') no-repeat center center fixed;
            background-size: cover;
        }

        .registration-container {
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            background-color: rgba(0, 0, 0, 0.5); /* Dark overlay */
        }

        .registration-form {
            background-color: rgba(255, 255, 255, 0.8); /* Semi-transparent white background */
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0px 0px 15px rgba(0, 0, 0, 0.3);
            width: 350px;
            text-align: center;
        }

        .registration-form h2 {
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

        .input-group input, .input-group select {
            width: 100%;
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 5px;
            box-sizing: border-box;
            font-size: 14px;
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
    <div class="registration-container">
        <div class="registration-form">
            <h2>Fitness Registration Form</h2>
            <form action="register.jsp" method="post">
                <div class="input-group">
                    <label for="name">Name</label>
                    <input type="text" id="name" name="name" placeholder="Enter your full name" required>
                </div>
                <div class="input-group">
                    <label for="email">Email ID</label>
                    <input type="email" id="email" name="email" placeholder="Enter your email" required>
                </div>
                <div class="input-group">
                    <label for="gender">Gender</label>
                    <select id="gender" name="gender" required>
                        <option value="">Select Gender</option>
                        <option value="male">Male</option>
                        <option value="female">Female</option>
                        <option value="other">Other</option>
                    </select>
                </div>
                <div class="input-group">
                    <label for="age">Age</label>
                    <input type="number" id="age" name="age" placeholder="Enter your age" min="0" required>
                </div>
                <div class="input-group">
                    <label for="mobile">Mobile No</label>
                    <input type="tel" id="mobile" name="mobile" placeholder="Enter your mobile number" required>
                </div>
                <div class="input-group">
                    <label for="username">Username</label>
                    <input type="text" id="username" name="username" placeholder="Choose a username" required>
                </div>
                <div class="input-group">
                    <label for="password">Password</label>
                    <input type="password" id="password" name="password" placeholder="Choose a password" required>
                </div>
                <button type="submit">Register</button>
            </form>
             <% 
        if ("POST".equalsIgnoreCase(request.getMethod())) {
            String name = request.getParameter("name");
            String email = request.getParameter("email");
            String gender = request.getParameter("gender");
            int age = Integer.parseInt(request.getParameter("age"));
            String mobile = request.getParameter("mobile");
            String username = request.getParameter("username");
            String password = request.getParameter("password");

            Connection conn = null;
            PreparedStatement pstmt = null;

            try {
                // Load the PostgreSQL driver (if not already loaded)
                String dbDriver = "org.postgresql.Driver";
                    String dbURL = "jdbc:postgresql://localhost:5432/fitness";
                    String dbUsername = "postgres";
                    String dbPassword = "root";

                    Class.forName(dbDriver);
                    conn = DriverManager.getConnection(dbURL, dbUsername, dbPassword);


                // SQL query
                String sql = "INSERT INTO users (name, email, gender, age, mobile, username, password) VALUES (?, ?, ?, ?, ?, ?, ?)";
                pstmt = conn.prepareStatement(sql);

                // Set parameters
                pstmt.setString(1, name);
                pstmt.setString(2, email);
                pstmt.setString(3, gender);
                pstmt.setInt(4, age);
                pstmt.setString(5, mobile);
                pstmt.setString(6, username);
                pstmt.setString(7, password);

                // Execute the update
                pstmt.executeUpdate();

                // Redirect after successful registration
                response.sendRedirect("login.jsp");

            } catch (Exception e) {
                e.printStackTrace();
                out.println("<p>Error occurred: " + e.getMessage() + "</p>");
            } finally {
                try {
                    if (pstmt != null) pstmt.close();
                    if (conn != null) conn.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        }
    %>
        </div>
    </div>
</body>
</html>

























<!-- 
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Register</title>
    <link rel="stylesheet" href="styles.css">
</head>
<body>
    <div class="container">
        <h2>Register</h2>
        <form name="authForm" action="register.jsp" method="post" onsubmit="return validateForm()">
            <input type="text" name="username" placeholder="Username" required>
            <input type="password" name="password" placeholder="Password" required>
            <input type="email" name="email" placeholder="Email" required>
            <button type="submit">Register</button>
        </form>
        
            String username = request.getParameter("username");
            String password = request.getParameter("password");
            String email = request.getParameter("email");

            if (username != null && password != null && email != null) {
                Connection conn = null;
                PreparedStatement ps = null;

                try {
                	String dbDriver = "org.postgresql.Driver";
                    String dbURL = "jdbc:postgresql://localhost:5432/fitness";
                    String dbUsername = "postgres";
                    String dbPassword = "root";

                    Class.forName(dbDriver);
                    conn = DriverManager.getConnection(dbURL, dbUsername, dbPassword);
                    ps = conn.prepareStatement("INSERT INTO users (username, password, email) VALUES (?, ?, ?)");
                    ps.setString(1, username);
                    ps.setString(2, password);
                    ps.setString(3, email);

                    ps.executeUpdate();
                    out.println("<p>Registration successful!</p>");
                } catch (Exception e) {
                    e.printStackTrace();
                    out.println("<p>Registration failed. Please try again.</p>");
                } finally {
                    if (ps != null) ps.close();
                    if (conn != null) conn.close();
                }
            }
        %>
        
    </div>
    <script src="scripts.js"></script>
</body>
</html>
 -->