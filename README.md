# azuredevops-iac-template-pipeline

Proof of Concept for Azure DevOps for Infrastructure as Code

My motivation here is, to explore some features from Azure DevOps, with minimal dependency from Marketplace Tasks, to understand how much Azure DevOps is customizable :);

This pipeline is to be used for `IaC (Infrastructure as code)`, adopting [Terraform](https://www.terraform.io/) and using **Microsoft Azure** as Cloud Provider;

## Structure

Initially, was designed to simulate deploy in 4 environments like:

* Development (DEV);
* Quality Assurance (QA);
* User Acceptante Tests (UAT);
* Production (PRD);

And contains these stages for each process like Continuous Integration and Continuous Delivery
environment.

**Continuous Integration**: This flow execute these steps:

* Install (TFENV);
* Format (Terraform);
* Init (Terraform);
* Workspace (Terraform);
* Validate (Terraform);
* Lint (TFLint);
* SAST (TFSec);
* Plan (Terraform);
* Apply (Terraform);
* Cache (Azure Tasks);
  
**Continuous Delivery**: This flow execute these steps:

* Install (TFENV);
* Init (Terraform);
* Workspace (Terraform);
* Validate (Terraform);
* Plan (Terraform);
* Apply (Terraform);
  
**Pull Request**: This flow execute these steps:

* Pull Request ENV (more information below)
* Install (TFENV);
* Init (Terraform);
* Workspace (Terraform);
* Validate (Terraform);
* Lint (TFLint);
* SAST (TFSec);
* Plan (Terraform);
* Apply (Terraform);
* Pull Request Comment (Github)

> :information_source: **note**
> 
> This step has a specilized task `pullrequest-env.yaml` wich determine what will be the target environment to run `terraform plan` based on source and target branch:
> 
> eg. If there's a Pull Request opened with this caracteristics
> 
>   **source branch**: "refs/heads/dev"
>   **target branch**: "refs/heads/qa"
> 
> The Pull request will execute the terraform plan, using the workspace from target branch, in this case will be (QA).

### **Folder structure**

```
.
├── LICENSE
├── README.md
├── azure-pipelines.yaml
├── container-image
│   └── Dockerfile
├── example-iac
│   ├── README.md
│   ├── main.tf
│   ├── outputs.tf
│   └── variables.tf
├── pipeline
│   └── terraform.yaml
├── pipeline-jobs
│   ├── terraform-cd.yaml
│   ├── terraform-ci.yaml
│   └── terraform-pr.yaml
└── pipeline-tasks
    ├── github-pullrequest-comment.yaml
    ├── pullrequest-env.yaml
    ├── terraform-apply.yaml
    ├── terraform-cache.yaml
    ├── terraform-fmt.yaml
    ├── terraform-init.yaml
    ├── terraform-plan-to-json.yaml
    ├── terraform-plan.yaml
    ├── terraform-validate.yaml
    ├── terraform-workspace.yaml
    ├── tfenv-terraform-install.yaml
    ├── tflint-run.yaml
    └── tfsec-run.yaml
```

* **[container-image/*](container-image)**: Contains Dockerfile to build the base image that will be used for all steps from pipeline;
* **[example-iac/*](example-iac)**: In this folder, contains a Terraform code example (If you haven't any code to dry-run this pipeline as example);
* **[pipeline/*](pipeline)**: Has the file `terraform.yaml` that orchestrate all stages, importing templates per environment target;
* **[pipeline-jobs/*](pipeline-jobs)**: Has the specific files (eg, `terraform-cd.yaml` and `terraform-ci.yaml`) with logical sequence to execute CI, CD and Pull Request steps;
* **[pipeline-tasks/*](pipeline-tasks)**: Has the tasks to execute specialized jobs (eg, `terraform-init.yaml`), and some tasks are reused for compose jobs on `pipeline-jobs` layer;

## What provide

* [TFENV](https://github.com/tfutils/tfenv) - Its a easier Terraform version management;
* TFLINT
* TFSEC
* Terraform
  * Workspace
  * validate
  * fmt

## Requirements

* Azure (Cloud Computing)
  * Active [Subscription](https://learn.microsoft.com/pt-br/azure/azure-portal/get-subscription-tenant-id)
  * Configure a [Service Principal with a Client Secret](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/guides/service_principal_client_secret);
  
* Azure DevOps
  * Configure a [Variable Group Name](https://learn.microsoft.com/en-us/azure/devops/pipelines/scripts/cli/pipeline-variable-group-secret-nonsecret-variables?view=azure-devops)
  * Configure a [Blob Storage for Terraform Backend](https://learn.microsoft.com/en-us/azure/developer/terraform/store-state-in-azure-storage?tabs=azure-cli);
  * Configure [Environment Deploy](https://learn.microsoft.com/en-us/azure/devops/pipelines/process/environments?view=azure-devops) with these names **"DEV, QA, UAT and PRD"**;

* Github
  * Configure a [Github Token](https://docs.github.com/en/authentication/keeping-your-account-and-data-secure/creating-a-personal-access-token) with `repo:` permission (to allow write comments on Pull Requests );

* Docker image
  * It's necessary to build de Docker image [Dockerfile](container-image/Dockerfile), Azure Container Registry is recommenden********

## How to use

* Complete requirements above;******

## motivations

* Don't use tasks
** easier todo maintenance
* Don't use release flow
* Why do not use Atlantis
* Checkov was an alternative
* Why didn't adopted release steps
* Why don't run build inside host 

## References

* https://www.terraform-best-practices.com/