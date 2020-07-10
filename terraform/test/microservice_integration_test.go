// +build integration

package test

import (
	"testing"

	"github.com/gruntwork-io/terratest/modules/terraform"
)

func TestMicroserviceValidity(t *testing.T) {
	t.Parallel()

	workDir := ".."
	/*
		awsDefaultRegion := os.Getenv("AWS_DEFAULT_REGION")
		awsProfile := os.Getenv("AWS_PROFILE")
		policyName := os.Getenv("TF_VAR_policy_name")
	*/

	terratestOptions := &terraform.Options{
		TerraformDir: workDir,
		/*
			EnvVars: map[string]string{
				"AWS_DEFAULT_REGION": awsDefaultRegion,
				"AWS_PROFILE":        awsProfile,
				"TF_VAR_policy_name": policyName,
			},
		*/
		NoColor: true,
	}

	t.Logf("Running in %s", workDir)

	//defer terraform.Destroy(t, terratestOptions)
	terraform.InitAndPlan(t, terratestOptions)
}
