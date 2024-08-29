<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Fitness Gym</title>
    <style>
        body {
            margin: 0;
            padding: 0;
            font-family: Arial, sans-serif;
            position: relative;
        }
        .hero-section {
            background: url('img1.png') no-repeat center center/cover;
            height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            text-align: center;
            color: #fff;
            flex-direction: column;
        }
        .hero-section h1 {
            font-size: 3rem;
            font-weight: bold;
            text-transform: uppercase;
            margin-bottom: 20px;
        }
        .hero-section p {
            font-size: 1.5rem;
            margin-bottom: 40px;
            max-width: 600px;
        }
        .hero-section a {
            background-color: #ff0;
            color: #000;
            padding: 15px 30px;
            font-size: 1.2rem;
            text-decoration: none;
            font-weight: bold;
            border: none;
            cursor: pointer;
            margin-right: 20px;
            transition: background-color 0.3s ease;
            display: inline-block;
        }
        .hero-section a:hover {
            background-color: #e0e000;
        }
        .button-container {
            margin-top: 20px;
        }
        .username-box {
            position: absolute;
            top: 20px;
            right: 20px;
            background: rgba(255, 255, 255, 0.8);
            padding: 10px 15px;
            border-radius: 5px;
            font-size: 0.9rem;
            font-weight: bold;
        }
    </style>
</head>
<body>

    
    

    <!-- Hero Section -->
    <div class="hero-section">
        <!-- Gym Name -->
        <h1>Fitness Gym</h1>

        <!-- Gym Quote -->
        <p>"Push yourself because no one else is going to do it for you."</p>

        <!-- Buttons for Login, Signup, Progress, and Goals -->
        <div class="button-container">
            
            <a href="history.jsp" style="margin-right: 10px;">Check Progress</a>
            <a href="inputfile.jsp">Set Goals</a>
        </div>
    </div>

</body>
</html>
