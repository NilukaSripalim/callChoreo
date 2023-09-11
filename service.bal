import ballerina/io;
import ballerina/http;
import ballerina/net;

// Define a Ballerina service that listens for incoming HTTP requests.
service /countryService on new http:Listener(8080) {

    // Define a resource that responds to GET requests on the root path.
    resource function get getCountryByIP(http:Request req) returns string? {
        // Extract the client's IP address from the request.
        string clientIP = check req.remoteAddress.toString();
        
        // Specify the URL of the IPinfo.io API with the client's IP address.
        string ipInfoApiUrl = "https://ipinfo.io/" + clientIP + "/country";
        
        // Make an HTTP GET request to the API.
        http:Request apiRequest = new;
        apiRequest.setUri(ipInfoApiUrl);
        
        http:Response apiResponse = check http:Client.get(apiRequest);
        
        // Check if the HTTP request was successful.
        if (apiResponse.statusCode == http:StatusOK) {
            // Extract the country code from the response.
            string countryCode = check apiResponse.getJsonPayload().toString();
            return getCountryNameFromCode(countryCode);
        } else {
            // Handle the error case.
            io:println("Failed to retrieve country information. Status code: " + apiResponse.statusCode.toString());
            return ();
        }
    }
    
    // Helper function to get the country name from a country code.
    private string? getCountryNameFromCode(string countryCode) {
        // You can implement a mapping from country codes to country names here.
        // Example: "US" -> "United States", "CA" -> "Canada", etc.
        
        // For simplicity, let's return the country code as is.
        return countryCode;
    }
}






