// +build static

package test

import (
	"testing"

	"github.com/gruntwork-io/terratest/modules/terraform"
)

func TestMicroserviceValidity(t *testing.T) {
	t.Parallel()

	workDir := ".."

	terratestOptions := &terraform.Options{
		TerraformDir: workDir,
		NoColor:      true,
	}
	tfPlanOutput := "microservice-terraform.tfplan"
	terraform.Init(t, terratestOptions)
	terraform.RunTerraformCommand(t, terratestOptions, terraform.FormatArgs(terratestOptions, "plan", "-out="+tfPlanOutput)...)
}
