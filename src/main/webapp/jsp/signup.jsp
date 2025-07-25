<%@ page
session="false" %>
<!DOCTYPE html>
<html>
  <head>
    <title>Sign Up Page - CMS</title>
    <style>
      * {
        margin: 0;
        padding: 0;
        box-sizing: border-box;
      }

      body {
        font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
        min-height: 100vh;
        display: flex;
        align-items: center;
        justify-content: center;
        padding: 20px;
      }

      .container {
        background: rgba(255, 255, 255, 0.95);
        backdrop-filter: blur(10px);
        padding: 40px;
        border-radius: 20px;
        box-shadow: 0 20px 40px rgba(0, 0, 0, 0.1);
        width: 100%;
        max-width: 450px;
        text-align: center;
        position: relative;
        overflow: hidden;
      }

      .container::before {
        content: '';
        position: absolute;
        top: 0;
        left: 0;
        right: 0;
        height: 4px;
        background: linear-gradient(90deg, #667eea, #764ba2, #f093fb);
        border-radius: 20px 20px 0 0;
      }

      .logo {
        width: 60px;
        height: 60px;
        background: linear-gradient(135deg, #667eea, #764ba2);
        border-radius: 50%;
        margin: 0 auto 20px;
        display: flex;
        align-items: center;
        justify-content: center;
        color: white;
        font-size: 24px;
        font-weight: bold;
      }

      h2 {
        color: #333;
        margin-bottom: 30px;
        font-size: 28px;
        font-weight: 600;
        position: relative;
      }

      .form-group {
        margin-bottom: 25px;
        text-align: left;
      }

      label {
        display: block;
        margin-bottom: 8px;
        color: #555;
        font-weight: 500;
        font-size: 14px;
        text-transform: uppercase;
        letter-spacing: 0.5px;
      }

      input[type="text"],
      input[type="password"],
      select {
        width: 100%;
        padding: 15px 20px;
        border: 2px solid #e1e5e9;
        border-radius: 10px;
        font-size: 16px;
        transition: all 0.3s ease;
        background: #f8f9fa;
        outline: none;
        font-family: inherit;
      }

      input[type="text"]:focus,
      input[type="password"]:focus,
      select:focus {
        border-color: #667eea;
        background: white;
        box-shadow: 0 0 0 3px rgba(102, 126, 234, 0.1);
        transform: translateY(-2px);
      }

      input[type="text"]:hover,
      input[type="password"]:hover,
      select:hover {
        border-color: #764ba2;
      }

      select {
        cursor: pointer;
      }

      select option {
        padding: 10px;
        background: white;
        color: #333;
      }

      .register-btn {
        width: 100%;
        padding: 15px;
        background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
        color: white;
        border: none;
        border-radius: 10px;
        font-size: 16px;
        font-weight: 600;
        cursor: pointer;
        transition: all 0.3s ease;
        text-transform: uppercase;
        letter-spacing: 1px;
        margin-bottom: 20px;
        position: relative;
        overflow: hidden;
      }

      .register-btn::before {
        content: '';
        position: absolute;
        top: 0;
        left: -100%;
        width: 100%;
        height: 100%;
        background: linear-gradient(90deg, transparent, rgba(255,255,255,0.2), transparent);
        transition: left 0.5s;
      }

      .register-btn:hover::before {
        left: 100%;
      }

      .register-btn:hover {
        transform: translateY(-2px);
        box-shadow: 0 10px 25px rgba(102, 126, 234, 0.3);
      }

      .register-btn:active {
        transform: translateY(0);
      }

      .login-link {
        color: #667eea;
        text-decoration: none;
        font-weight: 500;
        transition: all 0.3s ease;
        position: relative;
      }

      .login-link::after {
        content: '';
        position: absolute;
        width: 0;
        height: 2px;
        bottom: -2px;
        left: 50%;
        background: linear-gradient(90deg, #667eea, #764ba2);
        transition: all 0.3s ease;
        transform: translateX(-50%);
      }

      .login-link:hover::after {
        width: 100%;
      }

      .login-link:hover {
        color: #764ba2;
      }

      .divider {
        margin: 20px 0;
        position: relative;
        text-align: center;
        color: #999;
        font-size: 14px;
      }

      .divider::before {
        content: '';
        position: absolute;
        top: 50%;
        left: 0;
        right: 0;
        height: 1px;
        background: #e1e5e9;
        z-index: 1;
      }

      .divider span {
        background: rgba(255, 255, 255, 0.95);
        padding: 0 15px;
        position: relative;
        z-index: 2;
      }

      .error-message {
        background: #fee;
        color: #c33;
        padding: 12px;
        border-radius: 8px;
        margin-bottom: 20px;
        border: 1px solid #fcc;
        font-size: 14px;
      }

      .success-message {
        background: #efe;
        color: #3c3;
        padding: 12px;
        border-radius: 8px;
        margin-bottom: 20px;
        border: 1px solid #cfc;
        font-size: 14px;
      }

      .password-strength {
        margin-top: 8px;
        font-size: 12px;
      }

      .strength-bar {
        width: 100%;
        height: 4px;
        background: #e1e5e9;
        border-radius: 2px;
        overflow: hidden;
        margin-top: 5px;
      }

      .strength-fill {
        height: 100%;
        width: 0%;
        transition: all 0.3s ease;
        border-radius: 2px;
      }

      .strength-weak { background: #dc3545; width: 25%; }
      .strength-fair { background: #ffc107; width: 50%; }
      .strength-good { background: #28a745; width: 75%; }
      .strength-strong { background: #007bff; width: 100%; }

      .role-info {
        background: #f8f9fa;
        border: 1px solid #e9ecef;
        border-radius: 8px;
        padding: 15px;
        margin-top: 10px;
        font-size: 13px;
        color: #6c757d;
        text-align: left;
      }

      .role-info h4 {
        color: #495057;
        margin-bottom: 8px;
        font-size: 14px;
      }

      .role-info ul {
        margin: 0;
        padding-left: 20px;
      }

      .role-info li {
        margin-bottom: 3px;
      }

      @media (max-width: 480px) {
        .container {
          padding: 30px 20px;
          margin: 10px;
        }

        h2 {
          font-size: 24px;
        }

        input[type="text"],
        input[type="password"],
        select,
        .register-btn {
          padding: 12px 15px;
          font-size: 15px;
        }
      }

      .loading {
        opacity: 0.7;
        pointer-events: none;
      }

      .loading .register-btn {
        background: #ccc;
      }

      @keyframes fadeIn {
        from {
          opacity: 0;
          transform: translateY(30px);
        }
        to {
          opacity: 1;
          transform: translateY(0);
        }
      }

      .container {
        animation: fadeIn 0.8s ease-out;
      }

      .particle {
        position: absolute;
        background: rgba(255, 255, 255, 0.1);
        border-radius: 50%;
        pointer-events: none;
        animation: float 6s ease-in-out infinite;
      }

      @keyframes float {
        0%, 100% {
          transform: translateY(0px) rotate(0deg);
          opacity: 0.7;
        }
        50% {
          transform: translateY(-20px) rotate(180deg);
          opacity: 0.3;
        }
      }

      .input-icon {
        position: relative;
      }

      .input-icon::after {
        content: '';
        position: absolute;
        right: 15px;
        top: 50%;
        transform: translateY(-50%);
        width: 16px;
        height: 16px;
        opacity: 0;
        transition: opacity 0.3s ease;
      }

      .input-valid::after {
        content: '✓';
        color: #28a745;
        opacity: 1;
        font-weight: bold;
        font-size: 16px;
      }

      .input-invalid::after {
        content: '✗';
        color: #dc3545;
        opacity: 1;
        font-weight: bold;
        font-size: 16px;
      }
    </style>
  </head>
  <body>
    <div class="container">
      <h2>Create New Account</h2>
      <form action="../signup" method="post">
        <label for="username">Username:</label><br />
        <input type="text" id="username" name="username" required /><br /><br />

        <label for="password">Password:</label><br />
        <input
          type="password"
          id="password"
          name="password"
          required
        /><br /><br />

        <label for="role">Select Role:</label><br />
        <select id="role" name="role" required>
          <option value="EMPLOYEE">Employee</option>
          <option value="ADMIN">Admin</option></select
        ><br /><br />

        <button type="submit" class="register-btn">Register</button>
      </form>
      <br />
      <a href="../index.jsp">Already have an account? Login</a>
    </div>
  </body>
</html>
