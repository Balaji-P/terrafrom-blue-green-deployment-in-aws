A quick note on how I'm currently handling Blue/Green or A/B deployments with Terraform and AWS EC2 Auto Scaling.

In my particular use case, I want to be able to inspect an AMI deployment manually before disabling the previous deployment.

Hopefully someone finds this useful, and if you have and feedback please leave a comment or email me.

## Overview

I build my AMI's using Packer and Ansible.

Every time I build a new AMI, I want to create a new Launch Configuration (LC) and Auto Scaling Group (ASG) running this AMI,
and bring the fresh EC2 instances into circulation with my existing Load Balancer (ELB).

Finally, once I've verified the new ASG instances are working well, I will delete the old LC and ASG, which will shut down
any instances running the older AMI.

## Terraform Workflow

Here are the steps I follow to handle an AMI deployment:
(in this example, we're switching from Blue to Green)

 1. Update AMI ID for green module
 2. Enable green module
 3. Terraform `plan` then `apply`
 4. Verify new AMI deployment is working
 5. Disable blue module
 6. Terraform `plan` then `apply`

## Terraform Setup

My Terraform configuration has been split into two modules: `static` and `blue-green`.

The `blue-green` module contains configuration for:

  * Launch Configuration
  * Auto Scaling Group
   
The `static` module contains all other network configuration, such as the VPC and ELB.

Finally, these two modules are tied together with a modules.tf file in the main directory.

e.g:

  * /infrastructure
    * .terraform/
    * blue-green/
      * autoscaling.tf
      * launch_configuration.tf
      * variables.tf
    * static/
      * variables.tf
      * vpc.tf
      * sg.tf
      * elb.tf
      * outputs.tf
    * modules.tf
    * variables.tf

Where we run `terraform plan` and `terraform apply` in the `infrastructure/` directory.

That's about it. I've included a copy of modules.tf for you to see how this part of the puzzle works :)