const functions = require("firebase-functions");
const admin = require("firebase-admin");
const fetch = require("node-fetch");

// To avoid deployment errors, do not call admin.initializeApp() in your code

exports.customNaverToken = functions
  .region("us-central1")
  .https.onCall(async (data, context) => {
    const user = data.user;
    // Write your code below!
    res.set("Access-Control-Allow-Origin", "*");
    res.set("Access-Control-Allow-Methods", "GET, POST");
    res.set("Access-Control-Allow-Headers", "Content-Type");

    // Preflight request 처리
    if (req.method === "OPTIONS") {
      res.status(204).send("");
      return;
    }
    const client_id = "1ctb9frHDUaeRczLmGqT";
    const client_secret = "UlWvhBmi7t"; // If you want to be extra secure, put this in a Google Cloud Secret
    const redirect_uri = "saltwaterbetaver1://login-callback";

    const accessToken = await fetchNaverToken(
      code,
      state,
      client_id,
      client_secret,
      redirect_uri,
    );
    console.log("Naver access token:", accessToken);

    const naverProfile = await fetchNaverUserProfile(accessToken);
    console.log("Naver user profile:", naverProfile);

    const firebaseToken = await createFirebaseToken(naverProfile);
    console.log("Firebase token:", firebaseToken);

    // Write your code above!
    return {};
  });
async function fetchNaverToken(
  code,
  state,
  client_id,
  client_secret,
  redirect_uri,
) {
  const tokenUrl = `https://nid.naver.com/oauth2.0/token?grant_type=authorization_code&client_id=${client_id}&client_secret=${client_secret}&redirect_uri=${redirect_uri}&code=${code}&state=${state}`;

  console.log("Fetching Naver token from URL:", tokenUrl);

  const response = await fetch(tokenUrl);
  const data = await response.json();

  if (!response.ok) {
    console.error(
      "Error response from Naver:",
      response.status,
      response.statusText,
    );
    throw new Error(
      `Error from Naver: ${response.status} ${response.statusText}`,
    );
  }

  if (data.error) {
    console.error("Error data from Naver:", data.error, data.error_description);
    throw new Error(
      `Error from Naver: ${data.error} ${data.error_description}`,
    );
  }

  return data.access_token;
}

async function fetchNaverUserProfile(accessToken) {
  const profileUrl = "https://openapi.naver.com/v1/nid/me";

  console.log("Fetching Naver user profile...");

  const response = await fetch(profileUrl, {
    headers: {
      Authorization: `Bearer ${accessToken}`,
    },
  });
  const data = await response.json();

  if (!response.ok) {
    console.error(
      "Error fetching Naver user profile:",
      response.status,
      response.statusText,
    );
    throw new Error(
      `Error fetching Naver user profile: ${response.status} ${response.statusText}`,
    );
  }

  if (data.error) {
    console.error(
      "Error data from Naver profile:",
      data.error,
      data.error_description,
    );
    throw new Error(
      `Error from Naver: ${data.error} ${data.error_description}`,
    );
  }

  console.log(
    "Got the following data from Naver:",
    JSON.stringify(data.response),
  );
  return data.response;
}

async function createFirebaseToken(naverProfile) {
  const uid = naverProfile.id;

  console.log("Creating or updating Firebase user:", uid);

  try {
    await admin.auth().getUser(uid);
    console.log("User already exists in Firebase");
  } catch (error) {
    if (error.code === "auth/user-not-found") {
      console.log("User not found in Firebase, creating new user");
      await admin.auth().createUser({
        uid: uid,
        displayName: naverProfile.name,
        photoURL: naverProfile.profile_image,
        email: naverProfile.email,
        emailVerified: true,
      });
      console.log("New user created in Firebase");
    } else {
      console.error("Error checking Firebase user:", error);
      throw error;
    }
  }

  console.log("Creating custom token for user:", uid);
  return admin.auth().createCustomToken(uid);
}
