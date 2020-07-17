// +build integration

package test

import (
	"fmt"
	"testing"
	"time"

	http_helper "github.com/gruntwork-io/terratest/modules/http-helper"
	"github.com/gruntwork-io/terratest/modules/logger"
	"github.com/gruntwork-io/terratest/modules/retry"
	"github.com/stretchr/testify/assert"
)

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
