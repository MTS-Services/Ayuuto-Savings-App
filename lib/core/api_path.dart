class ApiPath {

 static String baseUrl = "https://flutterbackendexpressjs-production.up.railway.app/";

 static String userCreateUrl = "${baseUrl}api/users/create";

 static String groupCreateUrl = "${baseUrl}api/groups/create";
 static String activeFetchUrl = "${baseUrl}api/groups/activegroupdetails/";
 static String completeFetchUrl = "${baseUrl}api/groups/completedgroupdetails/";
 static String groupUserUrl = "${baseUrl}api/users";
 static String inviteCodeUrl = "${baseUrl}api/invitations/accept";

 static String inviteUserUrl(String groupId) => "${baseUrl}api/groups/$groupId/invite";
}
