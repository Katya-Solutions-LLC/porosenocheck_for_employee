import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:nb_utils/nb_utils.dart';

class ZoomServices {
  static Future<ZoomMeetingRes> generateZoomMeetingLink({required String topic, required DateTime startTime, required int durationInMinuts}) async {
    ZoomMeetingRes zoomResponse = ZoomMeetingRes();
    String zoomAccountId = '5gGrLYSnTbuGLtVovJY95Q';
    String clientId = 'KrJ418qzTLaG3kVIlE0paA';
    String clientSecret = 'ltw2APYb84RH7Dwsqe42anDNIBla1Nh9';

    // The Zoom API endpoint for creating a meeting
    String zoomApiEndpoint = 'https://api.zoom.us/v2/users/me/meetings';

    // Create a JSON payload for the Zoom API request
    Map<String, dynamic> requestBody = {
      'topic': topic,
      'type': 2, // 2 means a scheduled meeting
      'start_time': startTime.toString(),
      'duration': durationInMinuts, // Meeting duration in minutes
    };

    // Generate the JSON Web Token (JWT) for Zoom API authentication
    String token = await generateJwt(clientId, clientSecret, zoomAccountId);

    // Make the API request to create a meeting
    final response = await http.post(
      Uri.parse(zoomApiEndpoint),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
      body: jsonEncode(requestBody),
    );

    log('RESPONSE.BODY: ${response.body}');
    // Parse the response and extract the join_url for the meeting
    zoomResponse = ZoomMeetingRes.fromJson(jsonDecode(response.body));
    return zoomResponse;
  }

  // Function to generate the JSON Web Token (JWT) for Zoom API authentication
  static Future<String> generateJwt(String cId, String cSecret, String accId) async {
    // Combine the clientId and clientSecret into a single string
    final String credentials = '$cId:$cSecret';

    // Base64 encode the credentials
    final String encodedCredentials = base64Encode(utf8.encode(credentials));
    var headers = {
      'Host': 'zoom.us',
      'Authorization': 'Basic $encodedCredentials',
    };
    var request = http.Request('POST', Uri.parse('https://zoom.us/oauth/token?grant_type=account_credentials&account_id=$accId'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      final res = await response.stream.bytesToString();
      log(res);
      return jsonDecode(res)["access_token"];
    } else {
      log(response.reasonPhrase);
    }
    return "";
  }
}

/*  ZoomServices.generateZoomMeetingLink(topic = "test meeting", startTime = DateTime.now().add(const Duration(minutes: 10)), durationInMinuts = 30).then((value) {
            log("zoom link: ${value.joinUrl}");
            log("zoom link: ${value.startUrl}");
          }); */

class ZoomMeetingRes {
  String uuid;
  int id;
  String hostId;
  String hostEmail;
  String topic;
  int type;
  String status;
  String startTime;
  int duration;
  String timezone;
  String createdAt;
  String startUrl;
  String joinUrl;
  String password;
  String h323Password;
  String pstnPassword;
  String encryptedPassword;

  bool preSchedule;

  ZoomMeetingRes({
    this.uuid = "",
    this.id = -1,
    this.hostId = "",
    this.hostEmail = "",
    this.topic = "",
    this.type = -1,
    this.status = "",
    this.startTime = "",
    this.duration = -1,
    this.timezone = "",
    this.createdAt = "",
    this.startUrl = "",
    this.joinUrl = "",
    this.password = "",
    this.h323Password = "",
    this.pstnPassword = "",
    this.encryptedPassword = "",
    this.preSchedule = false,
  });

  factory ZoomMeetingRes.fromJson(Map<String, dynamic> json) {
    return ZoomMeetingRes(
      uuid: json['uuid'] is String ? json['uuid'] : "",
      id: json['id'] is int ? json['id'] : -1,
      hostId: json['host_id'] is String ? json['host_id'] : "",
      hostEmail: json['host_email'] is String ? json['host_email'] : "",
      topic: json['topic'] is String ? json['topic'] : "",
      type: json['type'] is int ? json['type'] : -1,
      status: json['status'] is String ? json['status'] : "",
      startTime: json['start_time'] is String ? json['start_time'] : "",
      duration: json['duration'] is int ? json['duration'] : -1,
      timezone: json['timezone'] is String ? json['timezone'] : "",
      createdAt: json['created_at'] is String ? json['created_at'] : "",
      startUrl: json['start_url'] is String ? json['start_url'] : "",
      joinUrl: json['join_url'] is String ? json['join_url'] : "",
      password: json['password'] is String ? json['password'] : "",
      h323Password: json['h323_password'] is String ? json['h323_password'] : "",
      pstnPassword: json['pstn_password'] is String ? json['pstn_password'] : "",
      encryptedPassword: json['encrypted_password'] is String ? json['encrypted_password'] : "",
      preSchedule: json['pre_schedule'] is bool ? json['pre_schedule'] : false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uuid': uuid,
      'id': id,
      'host_id': hostId,
      'host_email': hostEmail,
      'topic': topic,
      'type': type,
      'status': status,
      'start_time': startTime,
      'duration': duration,
      'timezone': timezone,
      'created_at': createdAt,
      'start_url': startUrl,
      'join_url': joinUrl,
      'password': password,
      'h323_password': h323Password,
      'pstn_password': pstnPassword,
      'encrypted_password': encryptedPassword,
      'pre_schedule': preSchedule,
    };
  }
}
