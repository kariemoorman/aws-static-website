## 10 Weeks of CloudOps Challenge

### WEEK 1: Static Website with CI/CD Implementation

<p align='center'><img src='/images/week_1.png'></p>


#### IaC & CI/CD
- <b>Terraform:</b> [tf](/tf/)
- <b>Github Actions Workflow:</b> [deploy.yml](/.github/workflows/deploy.yml)

#### Implementation

##### Step 1: 
- Build S3 bucket, write HTML to S3, add READ policy to S3, and configure static website documents using Terraform (see [step1](/tf/step1/)).

```tf
terraform init # Initialize working directory
terraform validate # Verify syntax and dependencies
terraform plan # Preview changes to be made
terraform apply -auto-approve # Apply changes to infrastructure
```

- Outcome: 
http://mookarie-cloudops-w1.s3-website-us-east-1.amazonaws.com 

<p align='center'><img src='/images/http_website.png' alt='http-site'/></p>

<br> 

##### Step 2: 
- Configure Cloudfront Distribution and Route53 using Terraform (see [step2](/tf/step2/)).

```tf
terraform init # Initialize working directory
terraform validate # Verify syntax and dependencies
terraform plan # Preview changes to be made
terraform apply -auto-approve # Apply changes to infrastructure
```

##### Step 3:
- Integrate AWS with Github Actions.


##### Step 4:
- Tear down infrastructure using Terraform.
```tf
cd tf/step2
terraform destroy -auto-approve
cd tf/step1
terraform destroy -auto-approve
```
---

#### Resources 
- <b>Challenge Source:</b> https://github.com/piyushsachdeva/10weeksofcloudops
- <b>Cloud Platform:</b> [AWS](https://aws.amazon.com) 
- <b>IaC Tooling:</b> [Terraform](https://www.terraform.io)
- <b>CI/CD:</b> [Github Actions](https://docs.github.com/en/actions)

---

<p align='center'><a href='https://choosealicense.com/licenses/mit/' target='_blank'>MIT License</a></p>
