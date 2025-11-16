<%@ page import="java.io.*, java.util.*" %>

<html lang="en">
<head>
    <title>TCA_main</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Webpage</title>
    <!-- Link to your external CSS file -->
    <link href="css/bootstrap.min.css" rel="stylesheet">
   <script src="css/bootstrap.min.js"></script>

</head>
<body>
<!--..............HEADER/NAVBAR.----------->
<nav class="navbar navbar-expand-lg navbar-dark bg-dark static-top">
  <div class="container">
    <a class="navbar-brand" href="#">
      <img src="https://placeholder.pics/svg/150x50/888888/EEE/Logo" alt="..." height="36">
    </a>
    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
      <span class="navbar-toggler-icon"></span>
    </button>
  
  </div>
</nav>
<!--..............QUICKMENU/SIDEBAR/LEFTSIDE.----------->


<!--..............QUICKMENU/SIDEBAR/LEFTSIDE.----------->
<div class="container text-center">
  <div class="row justify-content-start">
    <div class="col-4">
      <h2>TCA Logs</h2>
        <table class="table table-striped table-bordered">
            <tr>
                <th>Date</th>
                <th>Time</th>
                <th>Pipe Name</th>
            </tr>
            <%
                // Path to logs.csv (adjust as needed to your server)
                String csvFile = application.getRealPath("model/logs.csv");
                String line = "";
                String cvsSplitBy = ",";

                try (BufferedReader br = new BufferedReader(new FileReader(csvFile))) {
                    while ((line = br.readLine()) != null) {
                        String[] data = line.split(cvsSplitBy);
                        if(data.length >= 3) {
            %>
                            <tr>
                                <td><%= data[0] %></td>
                                <td><%= data[1] %></td>
                                <td><%= data[2] %></td>
                            </tr>
            <%
                        }
                    }
                } catch (IOException e) {
                    out.println("<tr><td colspan='2'>Error loading data: " + e.getMessage() + "</td></tr>");
                }
            %>
        </table>
    </div>

    <div class="col-4">
      Quick Links
        <table class="table table-striped table-bordered">
            <tr>
                <th>Date</th>
                
            </tr>
          <tr>
                                <td>Get Reports</td>
                            </tr>
       
        </table>
    </div>
    <div class="col-4">
      Column
    </div>
  </div>

</div>
<!--..............QUICKMENU/SIDEBAR/LEFTSIDE.----------->

</body>
</html>
