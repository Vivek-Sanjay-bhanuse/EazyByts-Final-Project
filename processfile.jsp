<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, javax.sql.*"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Fitness Data Overview</title>
    <style>
        body {
            background-color: #1E1E1E;
            color: #fff;
            font-family: 'Arial', sans-serif;
            margin: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
        }

        .container {
            background-color: #282828;
            border-radius: 10px;
            box-shadow: 0 0 20px rgba(0, 0, 0, 0.2);
            padding: 20px;
            width: 80%;
            max-width: 800px;
        }

        h1 {
            text-align: center;
            margin-bottom: 20px;
        }

        .data {
            margin-bottom: 20px;
        }

        .data p {
            margin: 5px 0;
        }

        .chart {
            width: 100%;
            height: 200px;
            background-color: #393939;
            border-radius: 10px;
            position: relative;
            margin-bottom: 20px;
        }

        .chart .bar {
            width: 20%;
            height: 0;
            background-color: #4CAF50;
            border-radius: 5px;
            position: absolute;
            bottom: 0;
            display: inline-block;
            margin-right: 5px;
        }

        .chart .bar.red {
            background-color: #F44336;
        }

        .chart .bar.green {
            background-color: #4CAF50;
        }

        a {
            display: block;
            text-align: center;
            color: #4CAF50;
            text-decoration: none;
            font-weight: bold;
            margin-top: 20px;
        }

        a:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>Fitness Data Overview</h1>
        <%
            Connection conn = null;
            PreparedStatement pst = null;
            ResultSet rs = null;

            try {
                // Database connection parameters
                String jdbcURL = "jdbc:postgresql://localhost:5432/fitness";
                String dbUser = "postgres";
                String dbPassword = "root";

                // Load JDBC driver and establish connection
                Class.forName("org.postgresql.Driver");
                conn = DriverManager.getConnection(jdbcURL, dbUser, dbPassword);

                // Retrieve form data
                double reserveEnergy = Double.parseDouble(request.getParameter("reserveEnergy"));
                double weight = Double.parseDouble(request.getParameter("weight"));
                double stamina = Double.parseDouble(request.getParameter("stamina"));
                int calories = Integer.parseInt(request.getParameter("calories"));
                double temperature = Double.parseDouble(request.getParameter("temperature"));
                String hydration = request.getParameter("hydration");
                int steps = Integer.parseInt(request.getParameter("steps"));

                // Update today's performance in the database
                String sql = "INSERT INTO fitness_data (date, reserve_energy, weight, stamina, calories, temperature, hydration, steps) VALUES (CURRENT_DATE, ?, ?, ?, ?, ?, ?, ?)";
                pst = conn.prepareStatement(sql);
                pst.setDouble(1, reserveEnergy);
                pst.setDouble(2, weight);
                pst.setDouble(3, stamina);
                pst.setInt(4, calories);
                pst.setDouble(5, temperature);
                pst.setString(6, hydration);
                pst.setInt(7, steps);
                pst.executeUpdate();

                // Fetch updated data for the graph
                sql = "SELECT weight, calories, steps FROM fitness_data WHERE date = CURRENT_DATE";
                pst = conn.prepareStatement(sql);
                rs = pst.executeQuery();
        %>

        <div class="data">
            <p><strong>Reserve Energy Resources:</strong> <%= reserveEnergy %> %</p>
            <p><strong>Weight:</strong> <%= weight %> Kg</p>
            <p><strong>Stamina:</strong> <%= stamina %> %</p>
            <p><strong>Calories Burnt:</strong> <%= calories %></p>
            <p><strong>Temperature:</strong> <%= temperature %> °C</p>
            <p><strong>Current Hydration Level:</strong> <%= hydration %></p>
            <p><strong>Steps Taken Today:</strong> <%= steps %></p>
        </div>

        <h2>Today's Performance</h2>
        <div class="chart">
            <%
                // Initialize height values for the bars
                int caloriesHeight = 0;
                int weightHeight = 0;
                int stepsHeight = 0;

                while (rs.next()) {
                    caloriesHeight = rs.getInt("calories") / 2; // Adjust height scale as needed
                    weightHeight = (int) (rs.getDouble("weight") * 2); // Adjust height scale as needed
                    stepsHeight = rs.getInt("steps") / 50; // Adjust height scale as needed
            %>
            
            <div class="bar" style="height: <%= stepsHeight / 2.5%>px; background-color: #2196F3;">
            	<label> <%= rs.getInt("steps")%></label>
            </div>
            <%
                }
            } catch (SQLException e) {
            	out.println(e);
                e.printStackTrace();
            }
            %>
        </div>

        <a href="inputPage.jsp">Submit Another Entry</a>
    </div>
</body>
</html>
