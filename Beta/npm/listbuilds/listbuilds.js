'use strict';

// usage: node list-builds.js

async function listBuilds() {
  const gcpMetadata = require('gcp-metadata');
  const projectId = await gcpMetadata.project('project-id');

  const {CloudBuildClient} = require('@google-cloud/cloudbuild');
  const cb = new CloudBuildClient();

  const request = {projectId};
  const [result] = await cb.listBuilds(request);

  console.table(result, ['id', 'status']);
}

listBuilds().catch(console.error);
