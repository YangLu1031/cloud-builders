'use strict';

// usage: node list-builds.js <PROJECT_ID>

async function listBuilds(
  projectId = 'YOUR_PROJECT_ID'
) {
  const {CloudBuildClient} = require('@google-cloud/cloudbuild');

  const cb = new CloudBuildClient();

  const request = {
      projectId: projectId,
      pageSize: 10,
  };

  const [result] = await cb.listBuilds(request);
  console.table(result, ['id', 'status']);
}

const args = process.argv.slice(2);
listBuilds(...args).catch(console.error);
