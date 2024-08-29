<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, javax.sql.*"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>7-Day Activity Progress</title>
    <style>
        body {
            background-color: #1E1E1E;
            color: #fff;
            font-family: 'Arial', sans-serif;
            margin: 0;
            padding: 20px;
        }
        .activity {
            background-color: #282828;
            border-radius: 10px;
            box-shadow: 0 0 20px rgba(0, 0, 0, 0.2);
            padding: 20px;
            max-width: 1000px;
            margin: 0 auto;
            position: relative;
        }
        .activity h3 {
            text-align: center;
            margin-bottom: 20px;
        }
        .chart {
            display: flex;
            align-items: flex-end;
            position: relative;
            height: 300px;
            background-color: #393939;
            border-radius: 10px;
            padding: 10px;
            margin-bottom: 40px;
        }
        .bar {
            width: 12.5%;
            border-radius: 5px;
            margin-right: 5px;
            transition: background-color 0.3s ease;
            position: relative;
        }
        .bar.calories {
            background-color: #F44336;
        }
        .bar.weight {
            background-color: #4CAF50;
        }
        .bar.steps {
            background-color: #2196F3;
        }
        .days {
            display: flex;
            justify-content: space-between;
            position: absolute;
            bottom: 10px;
            width: 100%;
            font-size: 14px;
        }
        .day {
            text-align: center;
        }
        .scale {
            font-size: 14px;
            color: #ccc;
            position: absolute;
            bottom: 2px;
            right: 10px;
            background-color: #282828;
            padding: 10px;
            border-radius: 5px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.3);
        }
        .legend {
            font-size: 14px;
            color: #ccc;
            position: absolute;
            bottom: 168px;
            right: 10px;
            background-color: #282828;
            padding: 10px;
            border-radius: 5px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.3);
            margin-top: 60px; /* Adjust spacing between scale and legend */
        }
        .color-box {
            display: inline-block;
            width: 15px;
            height: 15px;
            border-radius: 3px;
            margin-right: 10px;
        }
    </style>
</head>
<body>
    <div class="activity">
        <h3>7-Day Activity Progress</h3>
        <div class="chart">
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

                    // SQL to fetch data for the last 7 days
                    String sql = "SELECT date, calories, weight, steps FROM fitness_data WHERE date >= CURRENT_DATE - INTERVAL '7 days' ORDER BY date DESC";
                    pst = conn.prepareStatement(sql);
                    rs = pst.executeQuery();

                    // Arrays to store data for chart
                    int[] caloriesData = new int[7];
                    double[] weightData = new double[7];
                    int[] stepsData = new int[7];
                    String[] days = new String[7];
                    int[] gaps = new int[6]; // Gaps between consecutive days

                    // Populate data arrays
                    int index = 0;
                    while (rs.next() && index < 7) {
                        caloriesData[index] = rs.getInt("calories");
                        weightData[index] = rs.getDouble("weight");
                        stepsData[index] = rs.getInt("steps");
                        days[index] = rs.getDate("date").toString();
                        index++;
                    }

                    // Fill remaining days with 0 if less than 7 days
                    for (; index < 7; index++) {
                        caloriesData[index] = 0;
                        weightData[index] = 0;
                        stepsData[index] = 0;
                        days[index] = "";
                    }

                    // Calculate gaps between consecutive days
                    for (int i = 0; i < 6; i++) {
                        gaps[i] = Math.abs(caloriesData[i] - caloriesData[i + 1]);
                    }
            %>

            <%-- Generate bars for calories, weight, and steps --%>
            <%
                for (int i = 0; i < 7; i++) {
                    int caloriesHeight = caloriesData[i] / 10; // Scale calories by 100
                    int weightHeight = (int) (weightData[i] / 1); // Scale weight by 10
                    int stepsHeight = stepsData[i] / 100; // Scale steps by 1000
            %>
            <div class="bar calories" style="height: <%= caloriesHeight %>px; margin-right: 5px;"></div>
            <div class="bar weight" style="height: <%= weightHeight %>px; margin-right: 5px;"></div>
            <div class="bar steps" style="height: <%= stepsHeight %>px; margin-right: 5px;"></div>
            <% } %>

            <div class="days">
                <%
                    for (String day : days) {
                        %>
                        <div class="day"><%= day %></div>
                        <% } %>
            </div>

            
        </div>

        <div class="gap">
            <%-- Display gaps between consecutive days --%>
            <p><strong>Gap between consecutive days (Calories Burnt):</strong></p>
            <%
                for (int i = 0; i < gaps.length; i++) {
                    %>
                    <p>Day <%= i + 1 %> to Day <%= i + 2 %>: <%= gaps[i] %> calories</p>
                    <div class="scale">
                <p>Scale:</p>
                <p>Calories: 10 per unit</p>
                <p>Weight: 1 per unit</p>
                <p>Steps: 100 per unit</p>
            </div>

            <div class="legend">
                <p><span class="color-box" style="background-color: #F44336;"></span> Calories Burnt</p>
                <p><span class="color-box" style="background-color: #4CAF50;"></span> Weight</p>
                <p><span class="color-box" style="background-color: #2196F3;"></span> Steps</p>
            </div>
                    <% }
            } catch (SQLException e) {
            	out.println(e);
                e.printStackTrace();
            }
            %>
        </div>
    </div>
</body>
</html>
