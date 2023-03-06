import 'package:flutter_test/flutter_test.dart';
import 'package:tiktok/features/videos/models/video_model.dart';

void main() {
  group(
    "VideoModel test",
    () {
      test(
        "constructor",
        () {
          final video = VideoModel(
            id: "id",
            title: "title",
            description: "description",
            fileUrl: "fileUrl",
            thumbnailUrl: "thumbnailUrl",
            creatorUid: "creatorUid",
            creator: "creator",
            likes: 1,
            comments: 1,
            createdAt: 1,
          );

          expect(video.id, "id");
        },
      );

      test(
        ".fromJson Constructor",
        () {
          final json = {
            "title": "title",
            "description": "description",
            "fileUrl": "fileUrl",
            "thumbnailUrl": "thumbnailUrl",
            "creatorUid": "creatorUid",
            "creator": "creator",
            "likes": 1,
            "comments": 1,
            "createdAt": 1,
          };
          final video = VideoModel.fromJson(json: json, videoId: "videoId");

          expect(video.id, "videoId");
          expect(video.comments, isInstanceOf<int>());
        },
      );

      test(
        "toJson method",
        () {
          final video = VideoModel(
            id: "id",
            title: "title",
            description: "description",
            fileUrl: "fileUrl",
            thumbnailUrl: "thumbnailUrl",
            creatorUid: "creatorUid",
            creator: "creator",
            likes: 1,
            comments: 1,
            createdAt: 1,
          );
          final parsedJsonVideo = video.toJson();
          expect(parsedJsonVideo["id"], "id");
          expect(parsedJsonVideo["likes"], isInstanceOf<int>());
        },
      );
    },
  );
}
