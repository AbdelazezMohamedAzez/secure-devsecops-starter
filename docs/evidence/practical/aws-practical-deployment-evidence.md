# AWS Practical Deployment Evidence

## Objective

This document captures practical AWS deployment evidence for the **Secure DevSecOps Starter** Flask application.

The goal was to deploy the application on AWS, validate it at runtime, scan the deployed container image, run DAST testing against the deployed endpoint, investigate the difference between CI and runtime scanning results, and then clean up all temporary AWS resources.

---

## Scope

This evidence focuses on the AWS practical part of Week 9.

The deployment was intentionally small and temporary to reduce cost and avoid leaving unnecessary cloud exposure.

Covered areas:

- EC2 runtime deployment
- Docker container execution
- Restricted Security Group access
- Runtime validation with browser and `curl`
- Trivy container image scanning
- CI vs runtime scan behavior investigation
- OWASP ZAP baseline DAST scan
- AWS cleanup confirmation

---

## Deployment Summary

| Item | Details |
|---|---|
| Cloud Provider | AWS |
| Runtime | EC2 |
| Application | Dockerized Flask application |
| Docker Image | `secure-devsecops-starter:week9` |
| Application Port | `5000` |
| Access Model | Temporary public endpoint restricted by Security Group |
| Security Group Rules | SSH and TCP/5000 restricted to my IP |
| Evidence Type | Runtime deployment, browser test, curl validation, Trivy scan, ZAP scan, cleanup |
| Cleanup Status | Completed |

---

## AWS Resources Used

The following AWS resources were used:

- EC2 instance
- Security Group
- Key Pair
- Root EBS volume attached to the EC2 instance
- Temporary public IPv4 address assigned to the instance

The following resources were intentionally **not** used:

- Load Balancer
- NAT Gateway
- RDS or other database services
- EKS or Kubernetes
- ECS
- Elastic IP
- Long-running managed services

This kept the deployment simple, temporary, and cost-controlled.

---

## Target Architecture

```text
User Browser / curl
        |
        | HTTP :5000
        |
AWS Security Group
        |
        | Allows TCP/5000 from my IP only
        |
EC2 Instance
        |
        | Docker
        |
Flask Container
```

Security approach:

- SSH access was restricted to my IP.
- Application port `5000` was restricted to my IP.
- The deployment was temporary and only used for evidence collection.
- No database or persistent backend service was created.
- No secrets were stored in the repository or Docker image.

---

## Deployment Steps

### 1. Connect to EC2

```bash
ssh -i secure-devsecops-key.pem ec2-user@<EC2_PUBLIC_IP>
```

For Ubuntu-based AMIs, the username would usually be:

```bash
ssh -i secure-devsecops-key.pem ubuntu@<EC2_PUBLIC_IP>
```

For this deployment, the working SSH user was:

```text
ec2-user
```

---

### 2. Install Git and Docker

For Amazon Linux:

```bash
sudo yum update -y
sudo yum install -y git docker
sudo systemctl enable docker
sudo systemctl start docker
```

Validate Docker:

```bash
sudo docker --version
sudo docker ps
```

---

### 3. Clone the Repository

```bash
git clone https://github.com/AbdelazezMohamedAzez/secure-devsecops-starter.git
cd secure-devsecops-starter
```

---

### 4. Build the Docker Image

```bash
sudo docker build -t secure-devsecops-starter:week9 .
```

---

### 5. Run the Flask Container

```bash
sudo docker run -d --name week9-flask -p 5000:5000 secure-devsecops-starter:week9
```

---

### 6. Validate Runtime

Validate that the container is running:

```bash
sudo docker ps
```

Validate locally from the EC2 instance:

```bash
curl http://localhost:5000
curl -I http://localhost:5000
```

Validate externally from browser:

```text
http://<EC2_PUBLIC_IP>:5000
```

Result:

```text
The application opened successfully from the browser.
```

---

## Runtime Evidence Collected

Evidence collected during the AWS runtime test:

- EC2 instance running
- Docker container running
- Application reachable on port `5000`
- Browser validation completed
- `curl` validation completed
- Security Group restricted to my IP

Recommended screenshots:

```text
docs/evidence/practical/screenshots/aws-ec2-running.png
docs/evidence/practical/screenshots/aws-security-group-rules.png
docs/evidence/practical/screenshots/aws-app-browser-test.png
```

---

## Trivy Container Scan Evidence

Trivy was installed on the EC2 instance and used to scan the deployed Docker image.

### Install Trivy

```bash
curl -sfL https://raw.githubusercontent.com/aquasecurity/trivy/main/contrib/install.sh | sudo sh -s -- -b /usr/local/bin
trivy --version
```

### Run Trivy Scan

```bash
sudo trivy image --severity HIGH,CRITICAL secure-devsecops-starter:week9 | tee trivy-week9-aws.txt
```

Report saved under:

```text
docs/evidence/practical/reports/trivy-week9-aws.txt
```

---

## Trivy Result Summary

The AWS runtime Trivy scan identified HIGH and CRITICAL findings in the Debian base image used by the container.

| Area | Result |
|---|---|
| Target | `secure-devsecops-starter:week9` |
| Base OS | Debian 13.5 |
| Total HIGH/CRITICAL Findings | 11 |
| HIGH Findings | 9 |
| CRITICAL Findings | 2 |
| Python Application Dependency Findings | 0 |

Important note:

The findings were related to base operating system packages inside the container image, not the Flask application Python dependencies.

Python packages such as Flask, Gunicorn, Jinja2, Werkzeug, and related application dependencies showed `0` vulnerabilities in this scan.

---

## Key Vulnerability Examples

Examples of affected base image packages included:

| Package | Severity | Risk Type |
|---|---|---|
| `gzip` | HIGH | Buffer overflow vulnerability |
| `libacl1` | HIGH | Symlink traversal / privilege escalation risk |
| `ncurses` packages | HIGH | Buffer overflow risk |
| `perl-base` | CRITICAL / HIGH | Archive/path traversal and memory-related vulnerabilities |

These findings were documented as base image risks.

---

## CI vs Runtime Scan Investigation

A comparison was performed between the GitHub Actions Trivy scan and the AWS runtime Trivy scan.

### Observation

GitHub Actions previously passed.

The AWS runtime scan showed HIGH and CRITICAL vulnerabilities.

### Root Cause

The GitHub Actions workflow was configured with:

```yaml
ignore-unfixed: true
```

This means the CI scan ignored vulnerabilities that did not have a fixed version available.

The AWS runtime scan was executed without:

```bash
--ignore-unfixed
```

Because of that, the runtime scan exposed additional base image vulnerabilities that were hidden from the CI result.

### Security Lesson

This is an important DevSecOps lesson:

- A passing CI pipeline does not always mean zero runtime risk.
- Scanner configuration directly affects vulnerability visibility.
- `ignore-unfixed: true` can reduce noise, but it may hide base image risks.
- Runtime validation can reveal findings not visible in CI.
- Unfixed vulnerabilities should still be tracked, documented, and reviewed.

---

## Risk Assessment

| Risk | Source | Impact | Mitigation |
|---|---|---|---|
| Base image vulnerabilities | Debian OS packages | Container includes known vulnerable packages | Rebuild image when fixes become available |
| Critical Perl-related findings | Base OS package | Potential file/path handling risk depending on exploitability | Monitor fix availability and reduce unnecessary OS packages |
| CI visibility gap | `ignore-unfixed: true` | Findings may be hidden in CI | Document scanner behavior and review policy |
| Temporary public exposure | EC2 public IP and port 5000 | App accessible during testing | Restrict Security Group to my IP and delete resources after testing |
| Runtime drift | Runtime validation may reveal findings not shown in CI | Missed security risk | Compare CI and runtime scan behavior |

---

## Remediation Plan

Recommended remediation actions:

1. Rebuild the image regularly.
2. Update the Docker base image when patches become available.
3. Rescan the image after rebuilds.
4. Review whether `ignore-unfixed: true` should remain enabled in CI.
5. Track unfixed HIGH/CRITICAL findings as temporary accepted risk.
6. Consider using a smaller or more minimal base image if appropriate.
7. Keep Trivy scanning in CI and manual runtime validation.
8. Document scanner configuration clearly.
9. Avoid assuming that passing CI means zero container risk.

---

## OWASP ZAP DAST Evidence

OWASP ZAP baseline scan was executed against the temporary AWS endpoint while the Flask application was running on EC2.

The scan was executed from a Dockerized ZAP container and targeted the deployed application endpoint.

Generated report files:

```text
docs/evidence/practical/reports/zap-week9-aws.html
docs/evidence/practical/reports/zap-week9-aws.json
```

Evidence collected:

- ZAP baseline scan executed against the AWS deployment
- HTML report generated
- JSON report generated
- DAST performed after cloud deployment
- AWS endpoint removed after evidence collection

This confirms that DAST testing was performed against a real temporary cloud endpoint, not only during local development.

---

## ZAP Execution Note

When ZAP was first executed from inside a Docker container using:

```text
http://localhost:5000
```

the scan failed because `localhost` referred to the ZAP container itself, not the EC2 host.

The issue was resolved by targeting the EC2 host IP instead of container-local localhost.

Security lesson:

```text
When scanning containerized deployments, localhost depends on network context.
The scanner container and the target application container may not share the same loopback interface.
```

---

## AWS Cleanup Evidence

After collecting runtime, Trivy, and ZAP evidence, all temporary AWS resources were removed to avoid unnecessary cost and reduce exposure.

Cleanup actions completed:

- Docker container stopped
- Docker container removed
- EC2 instance terminated
- Temporary Security Group removed or confirmed no longer required
- Temporary Key Pair removed if created only for this test
- No Load Balancer was created
- No NAT Gateway was created
- No database was created
- No Kubernetes cluster was created
- No Elastic IP was left allocated

Cleanup status:

```text
AWS cleanup completed successfully.
```

Security lesson:

Temporary cloud environments should be deleted immediately after testing unless they are required for production or continuous validation.

---

## Evidence Checklist

| Evidence Item | Status |
|---|---|
| EC2 instance created | Done |
| Security Group restricted to my IP | Done |
| Docker installed | Done |
| Flask container deployed | Done |
| Browser test passed | Done |
| `curl` runtime validation | Done |
| Trivy runtime image scan completed | Done |
| Trivy report saved under `docs/evidence/practical/reports/` | Done |
| CI vs runtime scan difference investigated | Done |
| ZAP baseline scan completed | Done |
| ZAP HTML report saved | Done |
| ZAP JSON report saved | Done |
| AWS cleanup completed | Done |

---

## Files Added

Expected files for this evidence:

```text
docs/evidence/practical/aws-practical-deployment-evidence.md
docs/evidence/practical/reports/trivy-week9-aws.txt
docs/evidence/practical/reports/zap-week9-aws.html
docs/evidence/practical/reports/zap-week9-aws.json
```

Optional screenshot evidence:

```text
docs/evidence/practical/screenshots/aws-ec2-running.png
docs/evidence/practical/screenshots/aws-security-group-rules.png
docs/evidence/practical/screenshots/aws-app-browser-test.png
docs/evidence/practical/screenshots/aws-ec2-terminated.png
docs/evidence/practical/screenshots/aws-cleanup-confirmation.png
```

---

## Final Summary

This AWS practical deployment demonstrated a real cloud deployment workflow for the Secure DevSecOps Starter application.

The evidence shows that:

- The Flask application can run successfully as a Docker container on AWS EC2.
- Access can be restricted using Security Groups.
- Runtime validation confirmed that the deployed service was reachable.
- Trivy identified base image risks that were not visible in GitHub Actions because CI used `ignore-unfixed: true`.
- The Python application dependencies showed no vulnerabilities in this scan.
- OWASP ZAP DAST testing was performed against the temporary deployed AWS endpoint.
- All temporary AWS resources were removed after evidence collection.

This created a practical DevSecOps lesson:

```text
CI success should be supported by runtime validation, scanner configuration review, evidence collection, and disciplined cleanup.
```
