import java.io.IOException;

import com.google.cloud.ServiceOptions;
import com.google.cloud.devtools.cloudbuild.v1.CloudBuildClient;
import com.google.cloudbuild.v1.Build;

public class ListBuilds {
    public static void main(String[] args) {
		int limit = 10;
		if (args.length == 1) {
			limit = Integer.parseInt(args[0]);
		}
		String projectId = ServiceOptions.getDefaultProjectId();

		int n = 0;
        try (CloudBuildClient cb = CloudBuildClient.create()) {
            for (Build b : cb.listBuilds(projectId, "").iterateAll()) {
                System.out.printf("Build: %s %s\n", b.getId(), b.getStatus());
				n++;
				if (n==limit) {
					break;
				}
            }
        } catch (IOException e) {
			System.err.printf("ERROR: %s.\n", e);
		}
        System.out.printf("Listed %d builds for project %s.\n", n, projectId);
    }
}
