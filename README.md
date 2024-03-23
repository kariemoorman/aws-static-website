## 10 Weeks of CloudOps Challenge

### WEEK 1: Static Website with CI/CD Implementation

<p align='center'><img src='/images/week1.png'></p>


#### IMPLEMENTATION

#### STEP 1: 
- Provision S3 bucket, write HTML to S3, add READ policy to S3, and configure static website documents using Terraform (see [step1](/tf/step1/)).


```tf
terraform init # Initialize working directory
terraform validate # Verify syntax and dependencies
terraform plan # Preview changes to be made
terraform apply -auto-approve # Apply changes to infrastructure
```

- <b>Outcome:</b> 
http://mookarie-cloudops-w1.s3-website-us-east-1.amazonaws.com 

<p align='center'><img src='/images/http_website.png' alt='http-site' width='60%'/></p>

<br> 

- <i>Current Issues: 
    - No custom domain name.
    - No cache for static files.
    - Public bucket; not aligned with security best practices.
    - Does not support HTTPS.</i>

<br> 

#### STEP 2: 
- Configure Cloudfront Distribution (see [step2_cf-only](/tf/step2_cf-only/)), Route53 and ACM using Terraform (see [step2_cf_rt53](/tf/step2_cf_rt53/)).

```tf
terraform init # Initialize working directory
terraform validate # Verify syntax and dependencies
terraform plan # Preview changes to be made
terraform apply -auto-approve # Apply changes to infrastructure
```

- <b>Outcome (before Route53):</b> https://d1v23uzmtzdfq0.cloudfront.net

<p align='center'><img src='/images/cloudfront_website.png' alt='cf-site' width='60%'></p>

<br>

#### STEP 3:
- Integrate AWS with Github Actions:
    - Create Github User in AWS (see [step3](/tf/step3/)).
    - Create Access Keys for Github User.
    - Add Access Keys to Github Secrets.
    - Sync Github Repo to S3 (see [sync_to_s3.yml](https://github.com/kariemoorman/10weeksofcloudops_w1/tree/main/.github/workflows/sync_to_s3.yml)).

<br> 

#### STEP 4:
- Tear down infrastructure using Terraform.
```tf
terraform destroy -auto-approve
```
---

#### RESOURCES 
- <b>Challenge Source:</b> [10weeksofcloudops](https://github.com/piyushsachdeva/10weeksofcloudops)
- <b>Cloud Platform:</b> [AWS](https://aws.amazon.com) 
- <b>IaC Tooling:</b> [Terraform](https://www.terraform.io)
- <b>CI/CD:</b> [Github Actions](https://docs.github.com/en/actions)

---

<p align='center'><a href='https://choosealicense.com/licenses/mit/' target='_blank'>MIT License</a></p>
