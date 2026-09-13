<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="UTF-8">

    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <title>Login | Campus Management System</title>


    <style>

        /* =====================================================
           RESET
           ===================================================== */

        * {
            box-sizing: border-box;
            margin: 0;
            padding: 0;
        }


        /* =====================================================
           BODY
           ===================================================== */

        body {

            min-height: 100vh;

            font-family:
                Inter,
                "Segoe UI",
                Roboto,
                Helvetica,
                Arial,
                sans-serif;

            background:
                #f4f6fc;

            color: #172033;

            overflow-x: hidden;
        }


        /* =====================================================
           MAIN LOGIN LAYOUT
           ===================================================== */

        .login-page {

            min-height: 100vh;

            display: flex;

            align-items: stretch;
        }


        /* =====================================================
           LEFT CAMPUS SECTION
           ===================================================== */

        .campus-section {

            width: 60%;

            min-height: 100vh;

            position: relative;

            overflow: hidden;

            background:
                linear-gradient(
                    135deg,
                    #312e81 0%,
                    #4f46e5 48%,
                    #6366f1 100%
                );
        }


        /* Campus SVG */

        .campus-illustration {

            position: absolute;

            width: 100%;

            height: 100%;

            inset: 0;
        }


        .campus-illustration svg {

            width: 100%;

            height: 100%;

            display: block;
        }


        /* Dark overlay */

        .campus-overlay {

            position: absolute;

            inset: 0;

            background:
                linear-gradient(
                    90deg,
                    rgba(17, 24, 39, 0.55),
                    rgba(79, 70, 229, 0.08)
                );

            pointer-events: none;
        }


        /* =====================================================
           CAMPUS CONTENT
           ===================================================== */

        .campus-content {

            position: absolute;

            left: 55px;
            bottom: 55px;

            max-width: 560px;

            color: white;

            z-index: 5;
        }


        .campus-badge {

            display: inline-flex;

            align-items: center;

            gap: 8px;

            padding: 7px 12px;

            border-radius: 50px;

            background:
                rgba(255, 255, 255, 0.13);

            border:
                1px solid rgba(255, 255, 255, 0.20);

            backdrop-filter: blur(10px);

            font-size: 11px;

            font-weight: 600;

            letter-spacing: 0.5px;

            margin-bottom: 18px;
        }


        .badge-dot {

            width: 7px;
            height: 7px;

            border-radius: 50%;

            background: #ffffff;

            box-shadow:
                0 0 10px rgba(255,255,255,0.8);
        }


        .campus-title {

            font-size: clamp(32px, 4vw, 52px);

            line-height: 1.08;

            font-weight: 750;

            letter-spacing: -1.5px;

            margin-bottom: 15px;
        }


        .campus-description {

            max-width: 500px;

            font-size: 14px;

            line-height: 1.7;

            color:
                rgba(255, 255, 255, 0.84);
        }


        /* =====================================================
           CAMPUS BRAND
           ===================================================== */

        .campus-brand {

            position: absolute;

            top: 32px;
            left: 38px;

            display: flex;

            align-items: center;

            gap: 11px;

            z-index: 5;

            color: white;
        }


        .brand-logo {

            width: 42px;
            height: 42px;

            border-radius: 12px;

            background:
                rgba(255,255,255,0.16);

            border:
                1px solid rgba(255,255,255,0.25);

            backdrop-filter: blur(10px);

            display: flex;

            align-items: center;
            justify-content: center;
        }


        .brand-logo svg {

            width: 22px;
            height: 22px;
        }


        .brand-name {

            font-size: 15px;

            font-weight: 700;
        }


        .brand-subtitle {

            margin-top: 2px;

            font-size: 10px;

            color:
                rgba(255,255,255,0.68);
        }


        /* =====================================================
           RIGHT LOGIN SECTION
           ===================================================== */

        .login-section {

            width: 40%;

            min-height: 100vh;

            display: flex;

            align-items: center;

            justify-content: center;

            padding: 40px;

            background: #f8f9fd;
        }


        .login-container {

            width: 100%;

            max-width: 390px;
        }


        /* =====================================================
           LOGIN HEADER
           ===================================================== */

        .login-header {

            margin-bottom: 27px;
        }


        .login-heading {

            font-size: 29px;

            font-weight: 750;

            color: #172033;

            letter-spacing: -0.7px;

            margin-bottom: 7px;
        }


        .login-subheading {

            font-size: 13px;

            line-height: 1.6;

            color: #8b97ad;
        }


        /* =====================================================
           LOGIN CARD
           ===================================================== */

        .login-card {

            background: #ffffff;

            border:
                1px solid #e9ecf3;

            border-radius: 16px;

            padding: 30px;

            box-shadow:
                0 15px 40px rgba(30, 41, 59, 0.08);
        }


        /* =====================================================
           LOGIN ICON
           ===================================================== */

        .login-icon {

            width: 45px;
            height: 45px;

            border-radius: 12px;

            background:
                #f0efff;

            color:
                #4f46e5;

            display: flex;

            align-items: center;
            justify-content: center;

            margin-bottom: 24px;
        }


        .login-icon svg {

            width: 22px;
            height: 22px;
        }


        /* =====================================================
           FORM
           ===================================================== */

        .form-group {

            margin-bottom: 19px;
        }


        .form-label {

            display: block;

            font-size: 12px;

            font-weight: 650;

            color: #374151;

            margin-bottom: 7px;
        }


        .input-wrapper {

            position: relative;
        }


        .input-icon {

            position: absolute;

            left: 13px;
            top: 50%;

            transform: translateY(-50%);

            color: #9aa3b7;

            pointer-events: none;
        }


        .input-icon svg {

            width: 18px;
            height: 18px;
        }


        .form-input {

            width: 100%;

            height: 46px;

            padding:
                0 13px 0 42px;

            border:
                1px solid #dfe3eb;

            border-radius: 9px;

            background: #ffffff;

            color: #172033;

            font-family: inherit;

            font-size: 13px;

            outline: none;

            transition:
                border-color 0.2s ease,
                box-shadow 0.2s ease,
                background 0.2s ease;
        }


        .form-input::placeholder {

            color: #b0b7c6;
        }


        .form-input:focus {

            border-color: #4f46e5;

            background: #ffffff;

            box-shadow:
                0 0 0 3px
                rgba(79, 70, 229, 0.12);
        }


        /* =====================================================
           LOGIN BUTTON
           ===================================================== */

        .login-button {

            width: 100%;

            height: 47px;

            margin-top: 5px;

            border: none;

            border-radius: 9px;

            background:
                linear-gradient(
                    135deg,
                    #4f46e5,
                    #6366f1
                );

            color: #ffffff;

            font-family: inherit;

            font-size: 13px;

            font-weight: 650;

            cursor: pointer;

            box-shadow:
                0 8px 18px
                rgba(79, 70, 229, 0.20);

            transition:
                transform 0.2s ease,
                box-shadow 0.2s ease,
                filter 0.2s ease;
        }


        .login-button:hover {

            transform: translateY(-1px);

            box-shadow:
                0 11px 23px
                rgba(79, 70, 229, 0.27);

            filter: brightness(1.03);
        }


        .login-button:active {

            transform: translateY(0);

            box-shadow:
                0 5px 12px
                rgba(79, 70, 229, 0.18);
        }


        /* =====================================================
           LOGIN BUTTON CONTENT
           ===================================================== */

        .button-content {

            display: flex;

            align-items: center;

            justify-content: center;

            gap: 8px;
        }


        .button-content svg {

            width: 17px;
            height: 17px;
        }


        /* =====================================================
           DIVIDER
           ===================================================== */

        .login-divider {

            height: 1px;

            background: #edf0f5;

            margin: 25px 0 18px;
        }


        /* =====================================================
           FOOTER
           ===================================================== */

        .login-footer {

            text-align: center;

            font-size: 10px;

            color: #a1aabc;

            line-height: 1.6;
        }


        .login-footer strong {

            color: #6366f1;

            font-weight: 600;
        }


        /* =====================================================
           RESPONSIVE
           ===================================================== */

        @media (max-width: 950px) {

            .campus-section {

                width: 52%;
            }

            .login-section {

                width: 48%;

                padding: 28px;
            }

            .campus-content {

                left: 35px;
                bottom: 40px;

                max-width: 430px;
            }

            .campus-title {

                font-size: 34px;
            }

        }


        @media (max-width: 750px) {

            .login-page {

                flex-direction: column;
            }

            .campus-section {

                width: 100%;

                min-height: 390px;

                height: 390px;
            }

            .login-section {

                width: 100%;

                min-height: auto;

                padding:
                    35px 20px 45px;
            }

            .campus-content {

                left: 25px;
                right: 25px;

                bottom: 30px;
            }

            .campus-title {

                font-size: 31px;
            }

            .campus-description {

                font-size: 12px;
            }

            .campus-brand {

                left: 25px;
                top: 22px;
            }

        }


        @media (max-width: 450px) {

            .campus-section {

                min-height: 350px;

                height: 350px;
            }

            .campus-title {

                font-size: 28px;
            }

            .campus-content {

                bottom: 25px;
            }

            .login-card {

                padding: 24px 20px;
            }

            .login-heading {

                font-size: 25px;
            }

        }

    </style>

</head>


<body>


<div class="login-page">


    <!-- =====================================================
         LEFT SIDE — CAMPUS HERO
         ===================================================== -->

    <section class="campus-section">


        <!-- BRAND -->

        <div class="campus-brand">

            <div class="brand-logo">

                <svg
                    viewBox="0 0 24 24"
                    fill="none"
                    stroke="currentColor"
                    stroke-width="1.8"
                    stroke-linecap="round"
                    stroke-linejoin="round">

                    <path d="M5 4h14"/>
                    <path d="M5 4v16"/>
                    <path d="M5 20h14"/>
                    <path d="M19 4v16"/>

                    <path d="M9 8h6"/>
                    <path d="M9 12h6"/>
                    <path d="M9 16h4"/>

                </svg>

            </div>


            <div>

                <div class="brand-name">
                    Campus CMS
                </div>

                <div class="brand-subtitle">
                    Campus Management System
                </div>

            </div>

        </div>


        <!-- =================================================
             CAMPUS SVG

             ViewBox = 1500 x 500
             3:1 Twitter/X header proportion
             ================================================= -->

        <div class="campus-illustration">

            <svg
                viewBox="0 0 1500 500"
                preserveAspectRatio="xMidYMid slice"
                xmlns="http://www.w3.org/2000/svg">


                <!-- SKY -->

                <defs>

                    <linearGradient
                        id="sky"
                        x1="0"
                        y1="0"
                        x2="1"
                        y2="1">

                        <stop
                            offset="0%"
                            stop-color="#312e81"/>

                        <stop
                            offset="55%"
                            stop-color="#4f46e5"/>

                        <stop
                            offset="100%"
                            stop-color="#818cf8"/>

                    </linearGradient>


                    <linearGradient
                        id="building"
                        x1="0"
                        y1="0"
                        x2="0"
                        y2="1">

                        <stop
                            offset="0%"
                            stop-color="#ffffff"/>

                        <stop
                            offset="100%"
                            stop-color="#e0e7ff"/>

                    </linearGradient>


                    <linearGradient
                        id="ground"
                        x1="0"
                        y1="0"
                        x2="0"
                        y2="1">

                        <stop
                            offset="0%"
                            stop-color="#4f46e5"/>

                        <stop
                            offset="100%"
                            stop-color="#312e81"/>

                    </linearGradient>

                </defs>


                <!-- SKY -->

                <rect
                    width="1500"
                    height="500"
                    fill="url(#sky)"/>


                <!-- SUN -->

                <circle
                    cx="1210"
                    cy="110"
                    r="62"
                    fill="#ffffff"
                    opacity="0.18"/>

                <circle
                    cx="1210"
                    cy="110"
                    r="42"
                    fill="#ffffff"
                    opacity="0.20"/>


                <!-- CLOUDS -->

                <g
                    fill="#ffffff"
                    opacity="0.10">

                    <circle cx="250" cy="100" r="35"/>
                    <circle cx="290" cy="90" r="48"/>
                    <circle cx="340" cy="105" r="32"/>

                    <rect
                        x="245"
                        y="100"
                        width="115"
                        height="28"
                        rx="14"/>

                </g>


                <!-- DISTANT BUILDINGS -->

                <g opacity="0.25"
                   fill="#ffffff">

                    <rect
                        x="70"
                        y="270"
                        width="190"
                        height="120"/>

                    <rect
                        x="285"
                        y="235"
                        width="150"
                        height="155"/>

                    <rect
                        x="1120"
                        y="250"
                        width="170"
                        height="140"/>

                    <rect
                        x="1300"
                        y="225"
                        width="130"
                        height="165"/>

                </g>


                <!-- MAIN CAMPUS BUILDING -->

                <rect
                    x="455"
                    y="205"
                    width="590"
                    height="215"
                    rx="4"
                    fill="url(#building)"/>


                <!-- MAIN ROOF -->

                <path
                    d="M420 210 L750 105 L1080 210 Z"
                    fill="#eef2ff"/>

                <path
                    d="M440 205 L750 115 L1060 205"
                    fill="none"
                    stroke="#c7d2fe"
                    stroke-width="8"/>


                <!-- CENTER TOWER -->

                <rect
                    x="680"
                    y="135"
                    width="140"
                    height="285"
                    fill="#ffffff"/>


                <!-- TOWER ROOF -->

                <path
                    d="M655 140 L750 80 L845 140 Z"
                    fill="#e0e7ff"/>


                <!-- CAMPUS NAME -->

                <text
                    x="750"
                    y="180"
                    text-anchor="middle"
                    font-family="Segoe UI, Arial"
                    font-size="19"
                    font-weight="700"
                    fill="#4f46e5">

                    CAMPUS

                </text>


                <!-- WINDOWS -->

                <g
                    fill="#6366f1"
                    opacity="0.72">

                    <!-- Left -->

                    <rect x="490" y="245" width="48" height="48" rx="3"/>
                    <rect x="560" y="245" width="48" height="48" rx="3"/>
                    <rect x="490" y="315" width="48" height="48" rx="3"/>
                    <rect x="560" y="315" width="48" height="48" rx="3"/>

                    <!-- Center -->

                    <rect x="715" y="215" width="70" height="50" rx="3"/>
                    <rect x="715" y="285" width="70" height="50" rx="3"/>

                    <!-- Right -->

                    <rect x="892" y="245" width="48" height="48" rx="3"/>
                    <rect x="962" y="245" width="48" height="48" rx="3"/>
                    <rect x="892" y="315" width="48" height="48" rx="3"/>
                    <rect x="962" y="315" width="48" height="48" rx="3"/>

                </g>


                <!-- MAIN ENTRANCE -->

                <path
                    d="M710 420 V355
                       Q750 320 790 355
                       V420 Z"
                    fill="#312e81"/>


                <!-- ENTRANCE DOORS -->

                <rect
                    x="728"
                    y="365"
                    width="44"
                    height="55"
                    fill="#818cf8"/>

                <line
                    x1="750"
                    y1="365"
                    x2="750"
                    y2="420"
                    stroke="#312e81"
                    stroke-width="2"/>


                <!-- COLUMNS -->

                <g
                    fill="#eef2ff">

                    <rect x="445" y="210" width="18" height="210"/>
                    <rect x="1037" y="210" width="18" height="210"/>

                </g>


                <!-- FRONT STEPS -->

                <rect
                    x="660"
                    y="420"
                    width="180"
                    height="12"
                    fill="#e0e7ff"/>

                <rect
                    x="645"
                    y="432"
                    width="210"
                    height="12"
                    fill="#c7d2fe"/>

                <rect
                    x="625"
                    y="444"
                    width="250"
                    height="12"
                    fill="#a5b4fc"/>


                <!-- PATH -->

                <path
                    d="M705 456
                       L795 456
                       L980 500
                       L520 500 Z"
                    fill="#818cf8"
                    opacity="0.55"/>


                <!-- TREES -->

                <g>

                    <!-- Tree 1 -->

                    <rect
                        x="350"
                        y="335"
                        width="15"
                        height="90"
                        fill="#312e81"/>

                    <circle
                        cx="357"
                        cy="320"
                        r="48"
                        fill="#c7d2fe"/>

                    <circle
                        cx="325"
                        cy="335"
                        r="32"
                        fill="#a5b4fc"/>

                    <circle
                        cx="390"
                        cy="340"
                        r="30"
                        fill="#a5b4fc"/>


                    <!-- Tree 2 -->

                    <rect
                        x="1120"
                        y="340"
                        width="15"
                        height="85"
                        fill="#312e81"/>

                    <circle
                        cx="1127"
                        cy="325"
                        r="45"
                        fill="#c7d2fe"/>

                    <circle
                        cx="1098"
                        cy="340"
                        r="30"
                        fill="#a5b4fc"/>

                    <circle
                        cx="1158"
                        cy="340"
                        r="30"
                        fill="#a5b4fc"/>

                </g>


                <!-- GROUND -->

                <path
                    d="M0 420
                       Q300 390 600 430
                       Q900 465 1200 420
                       Q1380 395 1500 420
                       V500
                       H0 Z"
                    fill="url(#ground)"/>


                <!-- FOREGROUND TREES -->

                <g
                    opacity="0.85">

                    <circle
                        cx="110"
                        cy="430"
                        r="58"
                        fill="#4338ca"/>

                    <circle
                        cx="1375"
                        cy="430"
                        r="65"
                        fill="#3730a3"/>

                </g>


            </svg>

        </div>


        <!-- OVERLAY -->

        <div class="campus-overlay"></div>


        <!-- CAMPUS TEXT -->

        <div class="campus-content">

            <div class="campus-badge">

                <span class="badge-dot"></span>

                <span>
                    SMART CAMPUS PLATFORM
                </span>

            </div>


            <h1 class="campus-title">
                Everything your campus needs,
                in one place.
            </h1>


            <p class="campus-description">

                Campus Management System brings students,
                faculty and administrators together through
                a simple and organized digital campus.

            </p>

        </div>

    </section>



    <!-- =====================================================
         RIGHT SIDE — LOGIN
         ===================================================== -->

    <section class="login-section">


        <div class="login-container">


            <!-- LOGIN HEADER -->

            <div class="login-header">

                <h2 class="login-heading">
                    Welcome back
                </h2>

                <p class="login-subheading">

                    Sign in to access your Campus Management
                    System account.

                </p>

            </div>


            <!-- LOGIN CARD -->

            <div class="login-card">


                <!-- LOGIN ICON -->

                <div class="login-icon">

                    <svg
                        viewBox="0 0 24 24"
                        fill="none"
                        stroke="currentColor"
                        stroke-width="1.8"
                        stroke-linecap="round"
                        stroke-linejoin="round">

                        <rect
                            x="4"
                            y="3"
                            width="16"
                            height="18"
                            rx="2"/>

                        <path d="M8 7h8"/>
                        <path d="M8 11h8"/>
                        <path d="M8 15h4"/>

                    </svg>

                </div>


                <!-- LOGIN FORM -->

                <form
                    action="login"
                    method="post">


                    <!-- EMAIL -->

                    <div class="form-group">

                        <label
                            class="form-label"
                            for="email">

                            Email Address

                        </label>


                        <div class="input-wrapper">

                            <div class="input-icon">

                                <svg
                                    viewBox="0 0 24 24"
                                    fill="none"
                                    stroke="currentColor"
                                    stroke-width="1.8"
                                    stroke-linecap="round"
                                    stroke-linejoin="round">

                                    <rect
                                        x="3"
                                        y="5"
                                        width="18"
                                        height="14"
                                        rx="2"/>

                                    <path
                                        d="M3 7l9 6 9-6"/>

                                </svg>

                            </div>


                            <input
                                class="form-input"
                                type="email"
                                id="email"
                                name="email"
                                placeholder="Enter your email"
                                autocomplete="email"
                                required>

                        </div>

                    </div>


                    <!-- PASSWORD -->

                    <div class="form-group">

                        <label
                            class="form-label"
                            for="password">

                            Password

                        </label>


                        <div class="input-wrapper">

                            <div class="input-icon">

                                <svg
                                    viewBox="0 0 24 24"
                                    fill="none"
                                    stroke="currentColor"
                                    stroke-width="1.8"
                                    stroke-linecap="round"
                                    stroke-linejoin="round">

                                    <rect
                                        x="4"
                                        y="10"
                                        width="16"
                                        height="11"
                                        rx="2"/>

                                    <path
                                        d="M8 10V7a4 4 0 0 1 8 0v3"/>

                                    <circle
                                        cx="12"
                                        cy="15.5"
                                        r="1"/>

                                </svg>

                            </div>


                            <input
                                class="form-input"
                                type="password"
                                id="password"
                                name="password"
                                placeholder="Enter your password"
                                autocomplete="current-password"
                                required>

                        </div>

                    </div>


                    <!-- LOGIN BUTTON -->

                    <button
                        class="login-button"
                        type="submit">

                        <span class="button-content">

                            <span>
                                Sign In
                            </span>

                            <svg
                                viewBox="0 0 24 24"
                                fill="none"
                                stroke="currentColor"
                                stroke-width="2"
                                stroke-linecap="round"
                                stroke-linejoin="round">

                                <path d="M5 12h14"/>
                                <path d="M13 6l6 6-6 6"/>

                            </svg>

                        </span>

                    </button>


                </form>


                <!-- DIVIDER -->

                <div class="login-divider"></div>


                <!-- FOOTER -->

                <div class="login-footer">

                    Secure access to your
                    <strong>Campus CMS</strong>
                    account.

                </div>


            </div>

        </div>

    </section>


</div>


</body>

</html>