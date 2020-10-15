package main

import (
	"context"
	"flag"
	"fmt"
	"log"
	"os"

	"cloud.google.com/go/cloudbuild/apiv1"
	"cloud.google.com/go/compute/metadata"
	"google.golang.org/api/iterator"
	cloudbuildpb "google.golang.org/genproto/googleapis/devtools/cloudbuild/v1"
)

func main() {
	ctx := context.Background()

	n := flag.Uint("limit", 10, "number of builds to display")
	flag.Parse()

	projectID, err := metadata.NewClient(nil).ProjectID()
	if err != nil {
		log.Fatalf("Unable to discern project: %v", err)
	}

	c, err := cloudbuild.NewClient(ctx)
	if err != nil {
		log.Fatalf("Unable to instantiate cloudbuild client: %v", err)
	}
	defer func() {
		if err := c.Close(); err != nil {
			log.Fatalf("Close() failed: %v", err)
		}
	}()

	req := &cloudbuildpb.ListBuildsRequest{ProjectId: projectID}
	it := c.ListBuilds(ctx, req)
	var i uint = 0
	for ; i < *n; i++ {
		b, err := it.Next()
		if err == iterator.Done {
			break
		}
		if err != nil {
			log.Fatalf("ListBuilds failure: %v", err)
		}
		fmt.Println("Build", b.Id, b.Status)
	}

	fmt.Printf("Listed %d builds for project %q.\n", i, projectID)
	os.Exit(0)
}
