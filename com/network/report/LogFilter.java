package com.network.report;

import java.io.*;
import java.text.*;
import java.util.*;

public class LogFilter {

    public static List<String[]> filterLogsByDate(String csvPath, String startDateStr, String endDateStr) {
        List<String[]> filteredLogs = new ArrayList<>();
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");

        try {
            Date startDate = sdf.parse(startDateStr);
            Date endDate = sdf.parse(endDateStr);

            BufferedReader br = new BufferedReader(new FileReader(csvPath));
            String line;

            while ((line = br.readLine()) != null) {
                String[] data = line.split(",");
                if (data.length >= 2) {
                    String dateStr = data[0].trim();
                    Date logDate = sdf.parse(dateStr);

                    if (!logDate.before(startDate) && !logDate.after(endDate)) {
                        filteredLogs.add(data);
                    }
                }
            }

            br.close();
        } catch (Exception e) {
            e.printStackTrace();
        }

        return filteredLogs;
    }

    public static Map<String, Integer> countPipes(List<String[]> logs) {
        Map<String, Integer> pipeCounter = new HashMap<>();
        for (String[] data : logs) {
            if (data.length >= 2) {
                String pipeName = data[1].trim();
                if (!pipeName.isEmpty()) {
                    pipeCounter.put(pipeName, pipeCounter.getOrDefault(pipeName, 0) + 1);
                }
            }
        }
        return pipeCounter;
    }
}