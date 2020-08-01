package main

import (
	"context"
	"fmt"
	"log"
	"os"

	"google.golang.org/api/cloudbuild/v1"
)

func main() {
	ctx := context.Background()

	if len(os.Args) != 2 {
		log.Fatalf("Usage: %v <projectID>", os.Args[0])
	}
	projectID := os.Args[1]

	svc, err := cloudbuild.NewService(ctx)
	if err != nil {
		log.Fatalf("Unable to instantiate cloudbuild service: %v", err)
	}

	resp, err := svc.Projects.Builds.List(projectID).Context(ctx).Do()
	if err != nil {
		log.Fatalf("ListBuilds failed: %v", err)
	}

	fmt.Println("I'm listing builds from Go! I found", len(resp.Builds), "builds.")
	for _, b := range resp.Builds {
		fmt.Println("Build", b.Id, b.Status)
	}

	os.Exit(0)
}
