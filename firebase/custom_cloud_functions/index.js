const admin = require("firebase-admin/app");
admin.initializeApp();

const createCustomToken = require("./create_custom_token.js");
exports.createCustomToken = createCustomToken.createCustomToken;
const customNaverToken = require("./custom_naver_token.js");
exports.customNaverToken = customNaverToken.customNaverToken;
const redirectionCloudLog = require("./redirection_cloud_log.js");
exports.redirectionCloudLog = redirectionCloudLog.redirectionCloudLog;
