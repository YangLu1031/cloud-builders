package main

import (
	"context"
	"fmt"
	"log"
	"os"

	"cloud.google.com/go/cloudbuild/apiv1"
	"google.golang.org/api/iterator"
	cloudbuildpb "google.golang.org/genproto/googleapis/devtools/cloudbuild/v1"
)

func main() {
	ctx := context.Background()

	if len(os.Args) != 2 {
		log.Fatalf("Usage: %v <projectID>", os.Args[0])
	}
	projectID := os.Args[1]

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
	for {
		b, err := it.Next();
		if err == iterator.Done {
			break
		}
		if err != nil {
			log.Fatalf("ListBuilds failure: %v", err)
		}
		fmt.Println("Build", b.Id, b.Status)
	}

	os.Exit(0)
}
