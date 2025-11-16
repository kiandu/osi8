
<%@ page import="java.io.*, java.util.*" %>
<%@ page import="java.io.*, java.util.*, java.text.*" %>
<%
  
    // Get date range from request
    String startParam = request.getParameter("start-date");
    String endParam = request.getParameter("end-date");


    Date startDate = null, endDate = null;
    SimpleDateFormat logFormat = new SimpleDateFormat("yyy-MM-dd");

    try {
        if (startParam != null && !startParam.isEmpty()) {
            startDate = logFormat.parse(startParam);
        }
        if (endParam != null && !endParam.isEmpty()) {
            endDate = logFormat.parse(endParam);
        }
    } catch (Exception e) {
        out.println("<p style='color:red;'>Invalid date input: " + e.getMessage() + "</p>");
    }

    Map<String, Integer> pipeCounter = new HashMap<>();
    String csvPath = application.getRealPath("model/logs.csv");

    try (BufferedReader br = new BufferedReader(new FileReader(csvPath))) {
        String line;
        while ((line = br.readLine()) != null) {
            String[] data = line.split(",");
            if (data.length < 2) continue;

            String dateStr = data[0].trim();
            String pipeName = data[2].trim();

            try {
                Date logDate = logFormat.parse(dateStr);

                boolean inRange = true;
                if (startDate != null && logDate.before(startDate)) inRange = false;
                if (endDate != null && logDate.after(endDate)) inRange = false;

                if (inRange && !pipeName.isEmpty()) {
                    pipeCounter.put(pipeName, pipeCounter.getOrDefault(pipeName, 0) + 1);
                }
            } catch (ParseException pe) {
                // Skip invalid dates
            }

        }

    } catch (Exception e) {
        out.println("<p style='color:red;'>Error reading logs.csv: " + e.getMessage() + "</p>");
    }

    // Sort the pipeCounter into a LinkedHashMap
            List<Map.Entry<String, Integer>> entries = new ArrayList<>(pipeCounter.entrySet());
            entries.sort((a, b) -> b.getValue().compareTo(a.getValue()));

            Map<String, Integer> sortedCounter = new LinkedHashMap<>();
            for (Map.Entry<String, Integer> entry : entries) {
                sortedCounter.put(entry.getKey(), entry.getValue());
            }

%>
<!--..........HTMLHTMLHTMLHTMLHTMLHTMLHTMLHTMLHTMLHTML------------------>  

<html lang="en">
<head>
    <title>TCA Report</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>tca</title>
    <!-- Link to your external CSS file -->
    <link rel="stylesheet" href="styles.css">
</head>
<body>

<header>
    DI Customers 95% Bandwidht Usage Reports.
</header>

<div class="container">

  
    <div class="column" id="parameters">
    <h2>Filter Reports By:</h2>

    <form method="get" action="report.jsp">
        <label for="start-date">Start Date:</label><br>
        <input type="date" id="start-date" name="start-date" required="true"><br>

        <label for="end-date">End Date:</label><br>
        <input type="date" id="end-date" name="end-date" required="true"><br>

        <label for="pipe-name">Pipe Name:</label><br>
            <label>
            <input type="checkbox" name="include-empty"> Specify Pipe
            </label><br>
        <input type="text" id="pipe-name" name="pipe-name" placeholder="Enter pipe name"><br>

        <label for="threshold">Min Occurrence:</label><br>
        <input type="number" id="threshold" name="threshold" min="1"><br>

        <label for="sort-by">Sort By:</label><br>
        <select id="sort-by" name="sort-by">
            <option value="date">Date</option>
            <option value="pipe">Pipe Name</option>
            <option value="frequency">Frequency</option>
        </select><br><br>

        <button type="submit" name="submit" value="true">Generate Report</button><br>
         <button id="reset_button" type="button" value="true">Clear Summary</button>
    </form>
   
    </div>

    <!--.......................CHAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAARTS......................----------->
    <div class="column" id="charts">

        <h2>Summary</h2>
        <p>From: <%=startParam%>, To: <%=endParam %> </p>

        <table border="1" cellpadding="6" cellspacing="0">
        <tr><th>Pipe Name</th><th>Occurrences</th></tr>
        <%
            for (Map.Entry<String,Integer> entry : sortedCounter.entrySet()) {
        %>
            <tr>
                <td><%= entry.getKey() %></td>
                <td><%= entry.getValue() %></td>
            </tr>
        <%
            }
            if (sortedCounter.isEmpty()) {
        %>
            <tr><td colspan="2">No records found for selected range.</td></tr>
        <%
            }
        %>
        </table>
</div>
    <!--.......................Sorted Table.....................----------->


    <!--.......................INSIIIIIIIIIIIIIIIIIIIIGHTS.....................----------->
    <div class="column" id="insights">
        <h2>Export Reports</h2>
     
        <p>From: <%=startParam%>, To: <%=endParam %> </p>

    </div>
</div>

</body>
</html>

