import * as functions from "firebase-functions";
import * as admin from "firebase-admin";

admin.initializeApp();

// ! 여기서 snapshot이란, onCreate이라는 메소드의 걸맞게 video가 만들어진 순간의 그 비디오를 가르킨다.
// ! ref는 해당 snapshot의 document에 접근한다. document는 그냥 그 object라고 생각해도 무방 (firebase에서는 하나하나의 데이터를 document라고 하니까)
// ! child-process-promise라는 패키지는 터미널에서 어떤 명령어 실행을 하기위한 패키지
// ! db.collection().doc().collection().doc().set() 저 부분은 users 라는 콜렉션의 특정 유저에게 videos라는 콜렉션의 특정 비디오와 관계를 갖게하는 statement다.
// ! SQL에서 relation과 유사한거라고 봐도 무방할듯

export const onVideoCreated = functions.firestore
  .document("videos/{videoId}")
  .onCreate(async (snapshot, context) => {
    const spawn = require("child-process-promise").spawn;
    const video = snapshot.data();
    await spawn("ffmpeg", [
      "-i",
      video.fileUrl,
      "-ss",
      "00:00:01.000",
      "-vframes",
      "1",
      "-vf",
      "scale=150:-1",
      `/tmp/${snapshot.id}.jpg`,
    ]);

    const storage = admin.storage();
    const [file, _] = await storage.bucket().upload(`/tmp/${snapshot.id}.jpg`, {
      destination: `thumbnails/${snapshot.id}.jpg`,
    });
    await file.makePublic();
    await snapshot.ref.update({ thumbnailUrl: file.publicUrl() });

    const db = admin.firestore();
    await db
      .collection("users")
      .doc(video.creatorUid)
      .collection("videos")
      .doc(snapshot.id)
      .set({
        thumbnailUrl: file.publicUrl(),
        videoId: snapshot.id,
      });
  });
