<%@ page import="java.io.*, java.util.*" %>

<html>
<head>
    <title>TCA_main</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Webpage</title>
    <!-- Link to your external CSS file -->
    <link rel="stylesheet" href="styles.css">

</head>
<body>

<header>
    📊 Network Monitoring Dashboard
</header>
<div class="container">

    <!--.......................CHAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAARTS......................----------->
    <div class="column" id="charts">
    <h2>TCA Logs</h2>
    <table>
        <tr>
            <th>Date</th>
            <th>Time</th>
            <th>Pipe Name</th>
        </tr>
        <%
            // Path to logs.csv (adjust as needed to your server)
            String csvFile = application.getRealPath("/tca/logs.csv");
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

<!--..........FILTEEEEEEEEEEER &&&&&&&&&&& SUMMAAAAAAAAAAAAAAAAAAAAAAARY----------------------->    
<div class="column" id="parameters">
    <h2>Quick Links</h2>
    <li>
    <a href="report.jsp" target="_blank"> 95 Percentile</a>
    </li>
    </div>
</div>
</body>
</html>
