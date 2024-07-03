class AppConstants{
  static const HereMapsApiKey="a6Cu9ofVjPskWntuBdtPMC_F9jXzF3d4U1ceUjJd_lQ";
  static const HEREMAPSBaseURL="https://discover.search.hereapi.com/v1/geocode?";

  static String requestUrl(String query){
    return '${AppConstants.HEREMAPSBaseURL}q=${Uri.encodeComponent(query)}&apiKey=${AppConstants.HereMapsApiKey}';
  }
}
sealed class StatusCode{
  static int OK=200;
  static int FAILED=400;
}
