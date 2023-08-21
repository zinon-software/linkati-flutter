
import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/social_media_link.dart';

class CloudManager {
  final CollectionReference linksCollection =
      FirebaseFirestore.instance.collection('social_media_links');

  Future<void> addSocialMediaLink(SocialMediaLink link) async {
    try {
      await linksCollection.add(link.toMap());
      print('Social media link added successfully.');
    } catch (e) {
      print('Error adding social media link: $e');
    }
  }
}