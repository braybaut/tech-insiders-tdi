// +build integration

package test

import (
	"fmt"
	"testing"
	"time"

	http_helper "github.com/gruntwork-io/terratest/modules/http-helper"
	"github.com/gruntwork-io/terratest/modules/logger"
	"github.com/gruntwork-io/terratest/modules/retry"
	"github.com/gruntwork-io/terratest/modules/terraform"
	test_structure "github.com/gruntwork-io/terratest/modules/test-structure"
	"github.com/stretchr/testify/assert"
)

const AlbOutput = "alb_dns_name"

func TestHttpMicroserviceValidity(t *testing.T) {
	t.Parallel()

	workDir := ".."

	terratestOptions := &terraform.Options{
		TerraformDir: workDir,
		NoColor:      true,
	}

	test_structure.SaveTerraformOptions(t, workDir, terratestOptions)

	time.Sleep(200000 * time.Millisecond) // Wait until ECS task is updated

	// Run HTTP tests
	test_structure.RunTestStage(t, "microservice_tests", func() {
		terratestOptions := test_structure.LoadTerraformOptions(t, workDir)
		websiteEndpoint := terraform.OutputRequired(t, terratestOptions, AlbOutput)

		testURL(t, websiteEndpoint, "", 200, "Welcome to tech insiders")
	})
}

func testURL(t *testing.T, endpoint string, path string, expectedStatus int, expectedBody string) {
	url := fmt.Sprintf("%s://%s/%s", "http", endpoint, path)
	actionDescription := fmt.Sprintf("Calling %s", url)
	output := retry.DoWithRetry(t, actionDescription, 10, 10*time.Second, func() (string, error) {
		statusCode, body := http_helper.HttpGet(t, url, nil)
		if statusCode == expectedStatus {
			logger.Logf(t, "Got expected status code %d from URL %s", expectedStatus, url)
			return body, nil
		}
		return "", fmt.Errorf("got status %d instead of the expected %d from %s", statusCode, expectedStatus, url)
	})
	assert.Contains(t, output, expectedBody, "Body should contain expected text")
}
