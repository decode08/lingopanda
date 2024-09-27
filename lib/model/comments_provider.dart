import 'dart:convert';
import 'dart:developer';

import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:lingopanda/model/comments_model.dart';
import 'package:lingopanda/res/app_url.dart';

class CommentsProvider extends ChangeNotifier {
  List<CommentsModel> comments = [];
  bool mask_email = true;

  CommentsProvider() {
    _initialize();
  }

  Future<void> _initialize() async {
    await _fetchComments();
    await _fetchRemoteConfig();
  }

  Future<void> _fetchComments() async {
    try {
      final response = await http.get(Uri.parse(AppUrl.comments_url));
      if (response.statusCode == 200) {
        final List<dynamic> jsonComments = json.decode(response.body);
        comments =
            jsonComments.map((json) => CommentsModel.fromJson(json)).toList();
        notifyListeners();
      } else {
        log('Failed to load comments: ${response.statusCode}');
      }
    } catch (e) {
      log('Error fetching comments: $e');
    }
  }

  Future<void> _fetchRemoteConfig() async {
    try {
      final remoteConfig = FirebaseRemoteConfig.instance;

      // Set up the configuration settings
      await remoteConfig.setConfigSettings(RemoteConfigSettings(
        fetchTimeout: const Duration(seconds: 0),
        minimumFetchInterval: Duration.zero,
      ));

      // Fetch and activate the remote config
      await remoteConfig.fetchAndActivate();

      // Retrieve the boolean value from the remote config
      mask_email = remoteConfig.getBool('mask_email');

      log('maskEmail value from remote config: $mask_email');
      notifyListeners();
    } catch (e) {
      log('Error fetching remote config: $e');
    }
  }

  String getMaskedEmail(String email) {
    if (mask_email) {
      String maskedEmail = email.replaceRange(3, email.indexOf('@'), '****');
      return maskedEmail;
    } else {
      return email;
    }
  }
}
