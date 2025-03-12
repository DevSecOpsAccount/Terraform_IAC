package test

import (
	"flag"
	"testing"
	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/stretchr/testify/assert"
)  

func TestEC2Instance(t *testing.T) {

	tfvarsFile := flag.String("tfvars", "terratest.tfvars", "Path to the .tfvars file")
	flag.Parse()

	terraformOptions := &terraform.Options{
		TerraformDir: "../modules",
		VarFiles: []string{*tfvarsFile},
	}

	defer terraform.Destroy(t, terraformOptions)
	terraform.InitAndApply(t, terraformOptions)

	instance_type := terraform.Output(t, terraformOptions, "instance_type")
	instanceName := terraform.Output(t, terraformOptions, "instanceName")

	t.Logf("instance_type: %s", instance_type)
	t.Logf("instanceName: %s", instanceName)
	
	assert.Equal(t, "terratest-VM", instanceName)
	assert.Equal(t, "t2.micro", instance_type)
}


// package test

// import (
// 	"flag"
// 	"testing"
// 	"github.com/gruntwork-io/terratest/modules/terraform"
// 	"github.com/stretchr/testify/assert"
// )  

// func TestEC2Instance(t *testing.T) {

// 	tfvarsFile := flag.String("tfvars", "int.tfvars", "Path to the .tfvars file")
// 	flag.Parse()

// 	terraformOptions := &terraform.Options{
// 		TerraformDir: "../modules",
// 		VarFiles: []string{*tfvarsFile},
// 	}

// 	defer terraform.Destroy(t, terraformOptions)
// 	terraform.InitAndApply(t, terraformOptions)
// 	instance_type := terraform.Output(t, terraformOptions, "instance_type")
// 	instanceName := terraform.Output(t, terraformOptions, "instanceName")
	
	

// 	assert.Equal(t, "Server", instanceName)
// 	assert.Equal(t, "t2.micro", instance_type)
// }
