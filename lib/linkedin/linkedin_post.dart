import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:sky_board/main.dart';

class LinkedinPost {
  static Future<String?> postToLinkedin(
      String bodyDescription, String? link) async {
    var authResponse = await http.get(
        Uri(scheme: "https", host: "api.linkedin.com", path: "v2/userinfo"),
        headers: {
          "Authorization":
              "Bearer ${supabase.auth.currentSession?.providerToken}"
        });

    Uri uri =
        Uri(scheme: "https", host: "api.linkedin.com", path: "v2/ugcPosts");

    String body = jsonEncode({
      "author": "urn:li:person:${jsonDecode(authResponse.body)["sub"]}",
      "lifecycleState": "PUBLISHED",
      "specificContent": {
        "com.linkedin.ugc.ShareContent": {
          "shareCommentary": {"text": bodyDescription},
          "shareMediaCategory": "NONE"
        }
      },
      "visibility": {"com.linkedin.ugc.MemberNetworkVisibility": "CONNECTIONS"}
    });

    if (link != null) {
      body = jsonEncode({
        "author": "urn:li:person:${jsonDecode(authResponse.body)["sub"]}",
        "lifecycleState": "PUBLISHED",
        "specificContent": {
          "com.linkedin.ugc.ShareContent": {
            "shareCommentary": {
              "text":
                  "$bodyDescription\n\n\nShared From SkyBoard on ${DateFormat('EEEE, MMM d, yyyy @').add_jm().format(DateTime.now())}",
            },
            "shareMediaCategory": "ARTICLE",
            "media": [
              {
                "status": "READY",
                "originalUrl": link,
              },
            ],
          }
        },
        "visibility": {"com.linkedin.ugc.MemberNetworkVisibility": "PUBLIC"}
      });
    }

    var response1 = await http.post(uri,
        headers: {
          "X-Restli-Protocol-Version": "2.0.0",
          "Authorization":
              "Bearer ${supabase.auth.currentSession?.providerToken}"
        },
        body: body);

    return response1.statusCode.toString();
  }
}
