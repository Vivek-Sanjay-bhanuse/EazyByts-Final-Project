<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Fitness Data Input</title>
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
            max-width: 600px;
        }

        h1 {
            text-align: center;
        }

        .form-group {
            margin-bottom: 15px;
        }

        .form-group label {
            display: block;
            margin-bottom: 5px;
        }

        .form-group input, .form-group select {
            width: 100%;
            padding: 10px;
            border: 1px solid #444;
            border-radius: 5px;
            background-color: #393939;
            color: #fff;
        }

        .form-group button {
            background-color: #4CAF50;
            color: #fff;
            border: none;
            padding: 10px 20px;
            border-radius: 5px;
            cursor: pointer;
            width: 100%;
        }

        .form-group button:hover {
            background-color: #45a049;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>Input Fitness Data</h1>
        <form action="processfile.jsp" method="post">
        	<div class="form-group">
                <label for="steps">Steps Taken Today:</label>
            	<input type="number" id="steps" name="steps" required><br>
            </div>
            
            <div class="form-group">
                <label for="reserveEnergy">Reserve Energy Resources (%):</label>
                <input type="number" id="reserveEnergy" name="reserveEnergy" step="0.1" required>
            </div>
            <div class="form-group">
                <label for="weight">Weight (Kg):</label>
                <input type="number" id="weight" name="weight" step="0.1" required>
            </div>
            <div class="form-group">
                <label for="stamina">Stamina (%):</label>
                <input type="number" id="stamina" name="stamina" step="0.1" required>
            </div>
            <div class="form-group">
                <label for="calories">Calories Burnt:</label>
                <input type="number" id="calories" name="calories" required>
            </div>
            <div class="form-group">
                <label for="temperature">Temperature (°C):</label>
                <input type="number" id="temperature" name="temperature" step="0.1" required>
            </div>
            <div class="form-group">
                <label for="hydration">Current Hydration Level:</label>
                <select id="hydration" name="hydration" required>
                    <option value="Low">Low</option>
                    <option value="Moderate">Moderate</option>
                    <option value="High">High</option>
                </select>
            </div>
            <div class="form-group">
                <button type="submit">Submit Data</button>
            </div>
        </form>
    </div>
</body>
</html>
