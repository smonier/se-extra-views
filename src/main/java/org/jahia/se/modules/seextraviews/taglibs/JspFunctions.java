package org.jahia.se.modules.seextraviews.taglibs;

import net.htmlparser.jericho.Element;
import net.htmlparser.jericho.Source;
import org.apache.commons.io.FileUtils;
import org.apache.commons.io.IOUtils;
import org.apache.commons.lang.StringUtils;
import org.jahia.api.Constants;
import org.jahia.services.content.JCRContentUtils;
import org.jahia.services.content.JCRNodeWrapper;
import org.json.JSONException;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.TimeZone;
import javax.jcr.RepositoryException;
import java.io.File;
import java.io.IOException;
import java.nio.charset.StandardCharsets;
import java.util.List;
import java.util.Calendar;
import java.time.ZoneId;
import java.time.ZonedDateTime;
import java.time.format.DateTimeFormatter;
import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import org.json.JSONObject;

public final class JspFunctions {
    private static final Logger logger = LoggerFactory.getLogger(JspFunctions.class);

    private JspFunctions() {
        // Utility class doesn't have a constructor
    }

    public static String loadSvgContent(JCRNodeWrapper node) throws RepositoryException {
        if (!node.isNodeType(Constants.JAHIANT_FILE)) {
            logger.error("Node {} is not a file.", node.getPath());
            throw new RepositoryException();
        }
        if (!StringUtils.endsWith(node.getName(), ".svg")) {
            logger.error("File {} is not a SVG file.", node.getPath());
        }

        File file = null;
        try {
            file = JCRContentUtils.downloadFileContent(node);
            Source source = new Source(IOUtils.toString(file.toURI(), StandardCharsets.UTF_8));
            List<Element> bodyElementList = source.getAllElements("svg");
            if (bodyElementList.size() > 0) {
                Element bodyElement = bodyElementList.get(bodyElementList.size() - 1);
                return bodyElement.getContent().toString();
            }
            logger.error("Invalid content for file: {}", node.getPath());
            throw new RepositoryException();
        } catch (IOException e) {
            logger.error("Invalid file {}: {}", node.getPath(), e.getMessage());
            if (logger.isDebugEnabled()) {
                logger.error("", e);
            }
            throw new RepositoryException(e);
        } finally {
            FileUtils.deleteQuietly(file);
        }
    }

    public static String formatDateStringForJCR(String dateString) {
        SimpleDateFormat inputFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        // Assuming the original date string is in server's default timezone
        inputFormat.setTimeZone(TimeZone.getDefault());
        
        SimpleDateFormat outputFormat = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss.SSSXXX");
        // Set the timezone to UTC as JCR typically expects
        outputFormat.setTimeZone(TimeZone.getTimeZone("UTC"));
        
        try {
            Date date = inputFormat.parse(dateString);
            return outputFormat.format(date);
        } catch (ParseException e) {
            e.printStackTrace();
            return null; // Or handle this more gracefully
        }
    }

    public static String addOneDay(String dateString) {
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'");
        sdf.setTimeZone(TimeZone.getTimeZone("UTC")); // Ensure parsing in UTC
        try {
            Date date = sdf.parse(dateString);

            // Add one day
            Calendar calendar = Calendar.getInstance(TimeZone.getTimeZone("UTC"));
            calendar.setTime(date);
            calendar.add(Calendar.DAY_OF_MONTH, 1);

            // Return the new date as a string
            return sdf.format(calendar.getTime());
        } catch (ParseException e) {
            e.printStackTrace();
            return null; // Or handle this more gracefully depending on your requirements
        }
    }

    public static String transformDateString(String dateString) {
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        try {
            Date date = sdf.parse(dateString); // Parse the input string to a Date object.
            ZonedDateTime zdt = ZonedDateTime.ofInstant(date.toInstant(), ZoneId.systemDefault())
                    .withHour(0).withMinute(0).withSecond(0).withNano(0); // Convert to ZonedDateTime at midnight.

            DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd'T'HH:mm:ss.SSSXXX");
            return zdt.format(formatter); // Format and return the ZonedDateTime as a string.
        } catch (ParseException e) {
            e.printStackTrace(); // Handle parsing exceptions.
            return null; // Or handle it in another way that fits your application's requirements.
        }
    }

    public static String fetchThumbnailUrl(String videoId) {
        // Build the URL from the videoId
        String urlString = String.format(
                "http://fast.wistia.net/oembed?url=http://home.wistia.com/medias/%s&embedType=async&videoWidth=640",
                videoId
        );

        try {
            URL url = new URL(urlString);
            HttpURLConnection connection = (HttpURLConnection) url.openConnection();

            // Set request method to GET
            connection.setRequestMethod("GET");

            // Set request headers if necessary, e.g., for authentication or setting accept type
            connection.setRequestProperty("Accept", "application/json");

            // Check response code
            int responseCode = connection.getResponseCode();
            if (responseCode == HttpURLConnection.HTTP_OK) { // success
                BufferedReader in = new BufferedReader(new InputStreamReader(connection.getInputStream()));
                String inputLine;
                StringBuilder response = new StringBuilder();

                while ((inputLine = in.readLine()) != null) {
                    response.append(inputLine);
                }
                in.close();

                // Convert response to JSONObject and extract the thumbnail_url
                JSONObject jsonResponse = new JSONObject(response.toString());
                logger.info("Wistia Thumbnail URL: " + jsonResponse.getString("thumbnail_url"));
                return jsonResponse.getString("thumbnail_url");

            } else {
                logger.error("GET request not successful. Response code: " + responseCode);
                return null;
            }
        } catch (IOException | JSONException e) {
            e.printStackTrace();
            return null;
        }
    }

}
