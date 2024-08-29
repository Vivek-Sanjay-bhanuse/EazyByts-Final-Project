<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Fitness Gym</title>
</head>
<body style="margin: 0; padding: 0; font-family: Arial, sans-serif;">

    <!-- Hero Section -->
    <div style="
        background: url('img1.png') no-repeat center center/cover;
        height: 100vh;
        display: flex;
        justify-content: center;
        align-items: center;
        text-align: center;
        color: #fff;
        position: relative;
        flex-direction: column;
    ">
        <!-- Gym Name -->
        <h1 style="font-size: 3rem; font-weight: bold; text-transform: uppercase; margin-bottom: 20px;">
            Fitness Gym
        </h1>

        <!-- Gym Quote -->
        <p style="font-size: 1.5rem; margin-bottom: 40px; max-width: 600px;">
            "Push yourself because no one else is going to do it for you."
        </p>

        <!-- Buttons for Login and Signup -->
        <div>
            <a href="login.jsp" style="
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
            " onmouseover="this.style.backgroundColor='#e0e000'" onmouseout="this.style.backgroundColor='#ff0'">
                Login
            </a>

            <a href="register.jsp" style="
                background-color: #ff0;
                color: #000;
                padding: 15px 30px;
                font-size: 1.2rem;
                text-decoration: none;
                font-weight: bold;
                border: none;
                cursor: pointer;
                transition: background-color 0.3s ease;
                display: inline-block;
            " onmouseover="this.style.backgroundColor='#e0e000'" onmouseout="this.style.backgroundColor='#ff0'">
                Signup
            </a>
        </div>
    </div>

</body>
</html>
