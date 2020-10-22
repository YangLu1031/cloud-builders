'use strict';

async function listBuilds() {
  const gcpMetadata = require('gcp-metadata');
  const projectId = await gcpMetadata.project('project-id');

  const {CloudBuildClient} = require('@google-cloud/cloudbuild');
  const cb = new CloudBuildClient();

  const [result] = await cb.listBuilds({projectId});

  var i = 0;
  for (i = 0; i < 10 && i < result.length; i++) {
    console.log("Build %s %s", result[i].id, result[i].status)
  }
  console.log("Listed %d builds for project %s.", i, projectId)
}

listBuilds().catch(console.error);
