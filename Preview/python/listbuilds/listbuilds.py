import sys

from google import auth
from google.cloud.devtools.cloudbuild_v1.services.cloud_build import client

def listbuilds(project_id):
    cb = client.CloudBuildClient()
    builds = cb.list_builds(project_id=project_id)

    i = 0
    for b in builds:
        print("Build", b.id, b.status.name)
        i += 1
        if i == 10:
            break

    print("Listed {} builds for project {}.".format(i, project_id))
    return


if __name__ == '__main__':
    _, project_id = auth.default()
    listbuilds(project_id)
