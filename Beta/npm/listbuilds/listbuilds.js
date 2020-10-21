'use strict';

// title: List Builds
// description: lists builds
// usage: node list-builds.js <PROJECT_ID>

// [START cloudbuild_list_buildS]
async function listBuilds(
  projectId = 'YOUR_PROJECT_ID'
) {
  // Imports the Google Cloud client library
  const {CloudBuildClient} = require('@google-cloud/cloudbuild');

  // Creates a client
  const cb = new CloudBuildClient();

  // What project should we list triggers for?
  const request = {
      projectId: projectId,
      pageSize: 10,
  };

  const [result] = await cb.listBuilds(request);
  console.table(result, ['id', 'status']);
}
// [END cloudbuild_list_builds]

const args = process.argv.slice(2);
listBuilds(...args).catch(console.error);
