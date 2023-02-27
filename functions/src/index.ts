import * as functions from "firebase-functions";
import * as admin from "firebase-admin";

admin.initializeApp();

// ! 여기서 snapshot이란, onCreate이라는 메소드의 걸맞게 video가 만들어진 순간의 그 비디오를 가르킨다.
// ! ref는 해당 snapshot의 document에 접근한다. document는 그냥 그 object라고 생각해도 무방 (firebase에서는 하나하나의 데이터를 document라고 하니까)

export const onVideoCreated = functions.firestore
  .document("videos/{videoId}")
  .onCreate(async (snapshot, context) => {
    await snapshot.ref.update({ hello: "from functions" });
  });
