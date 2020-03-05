import * as functions from "firebase-functions";
import * as admin from "firebase-admin";
import { DocumentSnapshot } from "firebase-functions/lib/providers/firestore";

admin.initializeApp();

// // Start writing Firebase Functions
// // https://firebase.google.com/docs/functions/typescript
//
export const helloWorld = functions.https.onRequest((request, response) => {
  response.send("Hello from Firebase!");
});

// Take the text parameter passed to this HTTP endpoint and insert it into the
// Realtime Database under the path /messages/:pushId/original
export const addMessage = functions.https.onRequest(async (req, res) => {
    // Grab the text parameter.
    const original = req.query.text;
    // Push the new message into the Realtime Database using the Firebase Admin SDK.
    const snapshot = await admin.firestore().collection('messages').add({original: original});
    // Redirect with 303 SEE OTHER to the URL of tres.json({result: `Message with ID: ${writeResult.id} added.`});
    res.json({result: `Message with ID: ${snapshot.id} added.`});
  });

  exports.makeUppercase = functions.firestore.document('/messages/{pushId}/original')
    .onCreate((snap: DocumentSnapshot, context) => {
// [END makeUppercaseTrigger]
      // [START makeUppercaseBody]
      // Grab the current value of what was written to the Cloud Firestore.
      if(snap && snap.data()){
        const original = snap.data()!.original;
        console.log('Uppercasing', context.params.documentId, original);
        const uppercase = original.toUpperCase();
        // You must return a Promise when performing asynchronous tasks inside a Functions such as
        // writing to the Cloud Firestore.
        // Setting an 'uppercase' field in the Cloud Firestore document returns a Promise.
        return snap.ref.set({uppercase}, {merge: true});
      } else {
          return null;
      }
      
      // [END makeUppercaseBody]
    });