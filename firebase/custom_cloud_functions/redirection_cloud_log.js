const functions = require("firebase-functions");
const admin = require("firebase-admin");
// To avoid deployment errors, do not call admin.initializeApp() in your code

exports.redirectionCloudLog = functions
  .region("us-central1")
  .https.onCall((data, context) => {
    const logParam = data.logParam;
    // Write your code below!
    console.log(logParam);

    // Write your code above!
  });
