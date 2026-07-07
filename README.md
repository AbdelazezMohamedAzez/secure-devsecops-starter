# Secure DevSecOps Starter

A hands-on Python Flask API project used to practice and demonstrate DevSecOps fundamentals, secure CI/CD pipelines, automated security gates, container hardening, shift-left security, runtime DAST, practical multi-cloud secure deployment evidence, and software supply chain security.

---

## Project Overview

This project started as a simple Flask API and was gradually upgraded into a hardened DevSecOps starter pipeline.

The main goal is to demonstrate how security checks can be integrated into the software delivery lifecycle before code is merged, deployed, or exposed to a cloud environment.

The pipeline does not only generate security reports. It also enforces blocking security gates when high-risk issues are detected.

The repository also includes practical cloud deployment evidence across AWS and GCP, showing both VM-based and managed serverless container deployment models. Week 10 extends the project into software supply chain security using SBOM generation, SBOM vulnerability scanning, and image signing strategy documentation.

---

## What This Project Includes

- Python Flask API
- Dockerized application
- GitHub Actions CI pipeline
- Least-privilege GitHub Actions permissions
- Branch-based PR workflow
- Secret scanning using Gitleaks
- SAST scanning using Semgrep
- Code scanning using CodeQL
- Python dependency vulnerability scanning using pip-audit
- Container vulnerability scanning using Trivy
- DAST scanning using OWASP ZAP Baseline Scan
- Dependency update automation using Dependabot
- Local pre-commit security checks
- Docker non-root user hardening
- Basic Flask security headers
- Security scan reports uploaded as GitHub Actions artifacts
- AWS EC2 practical deployment evidence
- GCP Cloud Run practical deployment evidence
- Artifact Registry image deployment evidence
- Runtime Trivy scan evidence
- OWASP ZAP DAST evidence against deployed cloud endpoints
- CI vs runtime container scan investigation
- Temporary cloud resource cleanup documentation
- SBOM generation using Syft
- SBOM vulnerability scanning using Grype
- Software supply chain security workflow
- Cosign image signing strategy documentation

---

## Tech Stack

| Area | Tool / Service |
|---|---|
| Application | Python Flask |
| Web Server | Gunicorn |
| Containerization | Docker |
| CI/CD | GitHub Actions |
| Secret Scanning | Gitleaks |
| SAST | Semgrep |
| Code Scanning | CodeQL |
| Dependency Scanning | pip-audit |
| Container Scanning | Trivy |
| DAST | OWASP ZAP Baseline Scan |
| Dependency Automation | Dependabot |
| Local Security Checks | pre-commit |
| Cloud Runtime - AWS | EC2 |
| Cloud Runtime - GCP | Cloud Run |
| GCP Container Registry | Artifact Registry |
| GCP Build | Cloud Build |
| GCP Logs | Cloud Logging |
| IaC Security Related Project | Terraform + Checkov |
| SBOM Generation | Syft |
| SBOM Vulnerability Scanning | Grype |
| Image Signing Strategy | Cosign |
| Supply Chain Automation | GitHub Actions |

---

## Weekly Progress and Documentation Index

This section is the main roadmap of the repository. Each week summarizes the security work completed and links to the related documentation or evidence files.

| Week | Focus Area | What Was Completed | Documentation / Evidence |
|---|---|---|---|
| Week 1 | DevSecOps Foundation | Built the Flask API, Dockerized the app, added GitHub Actions CI, Gitleaks, Semgrep, pip-audit, Trivy, and fixed early findings. | Main README sections: [CI/CD Pipeline](#cicd-pipeline), [Security Gates](#security-gates), [Security Reports and Observability](#security-reports-and-observability) |
| Week 2 | CI/CD Hardening | Added branch-based PR workflow, least-privilege GitHub Actions permissions, workflow concurrency, blocking security gates, CodeQL, Dependabot, pre-commit hooks, and Docker non-root hardening. | [GitHub Actions Hardening](#github-actions-hardening), [CodeQL Code Scanning](#codeql-code-scanning), [Dependabot Automation](#dependabot-automation), [Shift-Left Security with pre-commit](#shift-left-security-with-pre-commit) |
| Week 6 | OWASP ZAP DAST | Added OWASP ZAP Baseline Scan against a running Flask container, generated HTML/Markdown/JSON reports, uploaded artifacts, and added security headers to reduce passive findings. | [docs/week-6-dast-report.md](docs/week-6-dast-report.md) |
| Week 7 | Container Security | Hardened Docker execution by adding a non-root user, ownership-safe copy behavior, and container runtime security documentation. | [Security Finding and Remediation: Docker Running as Root](#security-finding-and-remediation-docker-running-as-root) |
| Week 8 | Multi-Cloud IaC Security | Completed in a separate repo: Terraform security baselines for AWS and GCP, Checkov scanning, CI gates, and remediation evidence. | [Multi-Cloud IaC Security Scanning](https://github.com/AbdelazezMohamedAzez/multi-cloud-iac-security-scanning) |
| Week 9 | Multi-Cloud Secure Deployment | Added AWS/GCP secure deployment planning, AWS EC2 practical deployment, GCP Cloud Run practical deployment, runtime Trivy scan, ZAP scans against cloud endpoints, CI vs runtime scan investigation, and cleanup evidence. | [docs/week-9-multicloud-secure-deployment.md](docs/week-9-multicloud-secure-deployment.md), [AWS Practical Evidence](docs/evidence/practical/aws-practical-deployment-evidence.md), [GCP Practical Evidence](docs/evidence/practical/gcp-practical-deployment-evidence.md) |
| Week 10 | Software Supply Chain Security | Generated SBOM with Syft, scanned the SBOM with Grype, documented vulnerability triage, added Cosign image signing strategy, and automated SBOM evidence through GitHub Actions. | [docs/week-10-supply-chain-security.md](docs/week-10-supply-chain-security.md), [Week 10 Reports](docs/evidence/week-10/reports/) |

---

## Documentation Map

The `docs/` folder contains the detailed evidence behind the weekly summaries.

| File | Purpose |
|---|---|
| [docs/week-6-dast-report.md](docs/week-6-dast-report.md) | Week 6 OWASP ZAP DAST report and runtime web security testing notes |
| [docs/week-9-multicloud-secure-deployment.md](docs/week-9-multicloud-secure-deployment.md) | Week 9 multi-cloud secure deployment overview |
| [docs/week-10-supply-chain-security.md](docs/week-10-supply-chain-security.md) | Week 10 software supply chain security, SBOM generation, Grype scan, Cosign signing strategy, and automation notes |
| [docs/evidence/aws-secure-deployment-evidence.md](docs/evidence/aws-secure-deployment-evidence.md) | AWS secure deployment planning evidence |
| [docs/evidence/gcp-secure-deployment-plan.md](docs/evidence/gcp-secure-deployment-plan.md) | GCP secure deployment planning evidence |
| [docs/evidence/aws-vs-gcp-security-comparison.md](docs/evidence/aws-vs-gcp-security-comparison.md) | AWS vs GCP security comparison |
| [docs/evidence/week-9-final-evidence-checklist.md](docs/evidence/week-9-final-evidence-checklist.md) | Week 9 final evidence checklist |
| [docs/evidence/practical/aws-practical-deployment-evidence.md](docs/evidence/practical/aws-practical-deployment-evidence.md) | AWS EC2 + Docker practical deployment evidence |
| [docs/evidence/practical/gcp-practical-deployment-evidence.md](docs/evidence/practical/gcp-practical-deployment-evidence.md) | GCP Cloud Run + Artifact Registry practical deployment evidence |

---

## Evidence Reports

The repository stores practical evidence reports under `docs/evidence/`.

### Week 9 Practical Cloud Reports

Week 9 practical cloud reports are stored under:

```text
docs/evidence/practical/reports/
```

Expected reports:

```text
docs/evidence/practical/reports/
├── trivy-week9-aws.txt
├── zap-week9-aws.html
├── zap-week9-aws.json
├── zap-week9-gcp.html
└── zap-week9-gcp.json
```

Report purpose:

| Report | Purpose |
|---|---|
| `trivy-week9-aws.txt` | Runtime container vulnerability scan from the AWS EC2 deployment |
| `zap-week9-aws.html` | OWASP ZAP HTML report for the AWS endpoint |
| `zap-week9-aws.json` | OWASP ZAP JSON report for the AWS endpoint |
| `zap-week9-gcp.html` | OWASP ZAP HTML report for the GCP Cloud Run endpoint |
| `zap-week9-gcp.json` | OWASP ZAP JSON report for the GCP Cloud Run endpoint |

### Week 10 Supply Chain Reports

Week 10 supply chain reports are stored under:

```text
docs/evidence/week-10/reports/
```

Expected reports:

```text
docs/evidence/week-10/reports/
├── sbom-syft.json
├── sbom-syft-table.txt
├── grype-sbom-report.txt
└── grype-sbom-report.json
```

Report purpose:

| Report | Purpose |
|---|---|
| `sbom-syft.json` | Machine-readable SBOM generated by Syft |
| `sbom-syft-table.txt` | Human-readable SBOM package inventory |
| `grype-sbom-report.txt` | Human-readable SBOM vulnerability scan report |
| `grype-sbom-report.json` | Machine-readable Grype vulnerability scan report |

The local Docker archive used for analysis is excluded from Git tracking:

```text
docs/evidence/week-10/reports/*.tar
```

---

## Repository Structure

```text
.
├── .github/
│   └── workflows/
│       ├── security-ci.yml
│       ├── codeql.yml
│       ├── zap-dast.yml
│       └── supply-chain-security.yml
├── docs/
│   ├── week-6-dast-report.md
│   ├── week-9-multicloud-secure-deployment.md
│   ├── week-10-supply-chain-security.md
│   └── evidence/
│       ├── aws-secure-deployment-evidence.md
│       ├── gcp-secure-deployment-plan.md
│       ├── aws-vs-gcp-security-comparison.md
│       ├── week-9-final-evidence-checklist.md
│       ├── practical/
│       │   ├── aws-practical-deployment-evidence.md
│       │   ├── gcp-practical-deployment-evidence.md
│       │   └── reports/
│       │       ├── trivy-week9-aws.txt
│       │       ├── zap-week9-aws.html
│       │       ├── zap-week9-aws.json
│       │       ├── zap-week9-gcp.html
│       │       └── zap-week9-gcp.json
│       └── week-10/
│           └── reports/
│               ├── sbom-syft.json
│               ├── sbom-syft-table.txt
│               ├── grype-sbom-report.txt
│               └── grype-sbom-report.json
├── app.py
├── Dockerfile
├── requirements.txt
├── README.md
└── .pre-commit-config.yaml
```

---

## Run Locally

Install dependencies:

```bash
pip install -r requirements.txt
```

Run the application:

```bash
python app.py
```

Then open:

```text
http://localhost:5000
```

---

## Run with Docker

Build the Docker image:

```bash
docker build -t secure-devsecops-starter .
```

Run the container:

```bash
docker run -p 5000:5000 secure-devsecops-starter
```

Then open:

```text
http://localhost:5000
```

---

## CI/CD Pipeline

The GitHub Actions pipeline runs on pushes and pull requests targeting protected branches.

Current workflow triggers:

```text
push → main, develop
pull_request → main, develop
manual workflow_dispatch
```

Main security pipeline stages:

1. Checkout source code
2. Prepare security reports directory
3. Run Gitleaks secret scan
4. Run Semgrep SAST scan
5. Run Python dependency audit using pip-audit
6. Build Docker image
7. Run Trivy container image scan
8. Upload security reports as artifacts
9. Write security summary
10. Enforce final security gates

OWASP ZAP DAST workflow stages:

1. Checkout source code
2. Build Docker image
3. Run the Flask application container
4. Wait for the `/health` endpoint
5. Run OWASP ZAP Baseline Scan against the running app
6. Upload ZAP reports as GitHub Actions artifacts
7. Stop and remove the application container

The DAST workflow validates the application at runtime instead of only scanning source files or dependencies.

---

## GitHub Actions Hardening

The workflow was hardened using least-privilege permissions:

```yaml
permissions:
  contents: read
  pull-requests: read
  security-events: write
  actions: read
```

Concurrency control was also added to prevent duplicate workflow runs on the same branch:

```yaml
concurrency:
  group: ${{ github.workflow }}-${{ github.ref }}
  cancel-in-progress: true
```

This improves pipeline control, reduces noisy runs, and follows a more production-like GitHub Actions setup.

---

## Security Gates

The pipeline uses security gates to block insecure changes before merge.

| Gate | Tool | Blocking Condition |
|---|---|---|
| Secrets Gate | Gitleaks | Secret or credential detected |
| SAST Gate | Semgrep | ERROR-level SAST finding detected |
| Dependency Gate | pip-audit | Vulnerable Python dependency detected |
| Container Gate | Trivy | HIGH or CRITICAL vulnerability detected |
| Build Gate | Docker | Docker image build fails |
| Runtime Gate | ZAP setup | Application container fails to start |

The final enforcement step checks the outcome of every security stage and fails the pipeline if any blocking gate fails.

OWASP ZAP Baseline Scan is currently used as a DAST evidence and triage step. It uploads reports as artifacts so findings can be reviewed and remediated.

---

## Security Reports and Observability

Security reports are generated and uploaded as GitHub Actions artifacts.

Generated CI reports include:

```text
reports/
├── semgrep.json
├── pip-audit.json
└── trivy.txt

zap-reports/
├── zap-report.html
├── zap-report.md
└── zap-report.json
```

These reports provide evidence for:

- Security review
- Debugging failed pipelines
- Vulnerability triage
- DAST finding review
- Runtime validation
- Cloud deployment evidence
- Interview demonstration
- Portfolio documentation

---

## Security Finding and Remediation: Flask Development Server

Semgrep detected that the Flask development server was using:

```python
app.run(host="0.0.0.0", port=5000)
```

This could expose the development server publicly.

The issue was fixed by changing it to:

```python
app.run(host="127.0.0.1", port=5000, debug=False)
```

After the fix, the GitHub Actions pipeline passed successfully.

---

## Security Finding and Remediation: Docker Running as Root

During pipeline hardening, Semgrep detected that the Docker container did not specify a non-root user.

Finding:

```text
dockerfile.security.missing-user.missing-user
```

Risk:

If an attacker compromises the application process, running the container as root increases the impact inside the container environment.

Fix applied:

```dockerfile
RUN addgroup --system appgroup && adduser --system --ingroup appgroup appuser
COPY --chown=appuser:appgroup . .
USER appuser
```

After the fix, the pipeline passed successfully.

---

## Secret Scanning Test

Gitleaks was tested using a custom demo rule.

A demo secret was intentionally committed on a separate test branch to verify that secret scanning works.

Result:

- Gitleaks detected the demo secret
- The pipeline failed successfully
- The demo secret was removed
- The pipeline passed again after remediation

This confirms that secret scanning is working as a blocking CI gate.

---

## Dependency Scanning with pip-audit

pip-audit was added to scan Python dependencies in `requirements.txt`.

It detected a vulnerability in Flask 3.0.3 and recommended upgrading Flask.

The issue was fixed by updating Flask to version 3.1.3:

```text
Flask==3.1.3
gunicorn==22.0.0
```

After the upgrade, the GitHub Actions pipeline passed successfully.

---

## Container Scanning with Trivy

Trivy was added to scan the Docker image for HIGH and CRITICAL vulnerabilities.

The pipeline builds the Docker image and scans it before considering the CI successful.

Current Trivy CI behavior:

- Scans the built Docker image
- Checks for HIGH and CRITICAL vulnerabilities
- Ignores unfixed vulnerabilities
- Fails the pipeline when blocking vulnerabilities are detected

Week 9 added an important runtime validation lesson:

- GitHub Actions passed because the Trivy CI scan was configured with `ignore-unfixed: true`.
- The AWS runtime scan was executed without `--ignore-unfixed`.
- Runtime Trivy scanning identified base image vulnerabilities that were not visible in the CI result.
- The findings were related to Debian base image packages, not Python application dependencies.
- Python packages showed `0` vulnerabilities in the AWS runtime Trivy report.

This shows that scanner configuration affects visibility and that passing CI should be supported by runtime validation and evidence review.

---

## Dynamic Application Security Testing with OWASP ZAP

OWASP ZAP Baseline Scan was added to test the running Flask application dynamically.

The ZAP workflow:

1. Builds the Docker image
2. Runs the application container
3. Waits for the `/health` endpoint
4. Runs OWASP ZAP Baseline Scan against `http://127.0.0.1:5000`
5. Generates HTML, Markdown, and JSON reports
6. Uploads the reports as GitHub Actions artifacts

This adds runtime web security testing to the project.

The scan is unauthenticated and passive-focused, which makes it suitable as an early CI/CD DAST check.

Week 6 report:

```text
docs/week-6-dast-report.md
```

Week 9 practical cloud ZAP reports:

```text
docs/evidence/practical/reports/zap-week9-aws.html
docs/evidence/practical/reports/zap-week9-aws.json
docs/evidence/practical/reports/zap-week9-gcp.html
docs/evidence/practical/reports/zap-week9-gcp.json
```

---

## CodeQL Code Scanning

CodeQL was added as an additional static code analysis layer.

CodeQL provides deeper code scanning and integrates with GitHub Security features.

Current CodeQL setup:

- Runs on pull requests
- Runs on pushes to protected branches
- Scans Python code
- Uses security-extended and security-and-quality queries

Results appear in:

```text
GitHub → Security → Code scanning
```

---

## Dependabot Automation

Dependabot was added to automate dependency and workflow update checks.

Configured ecosystems:

| Ecosystem | Purpose |
|---|---|
| pip | Monitor Python dependencies |
| github-actions | Monitor GitHub Actions versions |
| docker | Monitor Docker base image updates |

Dependabot helps keep the project updated and reduces supply-chain risk by opening automated update pull requests.

---

## Shift-Left Security with pre-commit

A local pre-commit layer was added to catch issues before code reaches GitHub.

Current pre-commit hooks:

| Hook | Purpose |
|---|---|
| detect-private-key | Prevent private keys from being committed |
| check-yaml | Validate YAML files |
| check-json | Validate JSON files |
| end-of-file-fixer | Ensure files end correctly |
| trailing-whitespace | Remove unnecessary whitespace |
| Gitleaks | Detect hardcoded secrets locally |

Run all hooks manually:

```bash
pre-commit run --all-files
```

Install hooks locally:

```bash
pre-commit install
```

This adds a local security layer before CI/CD.

---

## Week 9: Multi-Cloud Practical Secure Deployment

Week 9 expanded the project from CI/CD security into practical cloud deployment evidence.

The goal was not to leave production infrastructure running. The goal was to deploy temporarily, validate security controls, collect evidence, and clean up all resources.

### AWS Practical Deployment

AWS used a VM-based deployment model:

```text
EC2 → Docker → Flask container
```

AWS work completed:

- Created temporary EC2 instance
- Restricted Security Group access to my IP
- Installed Docker on EC2
- Built the Docker image
- Ran the Flask container on port `5000`
- Validated the application in browser and with curl
- Installed and ran Trivy on the EC2 host
- Saved Trivy runtime scan report
- Ran OWASP ZAP baseline scan against the AWS endpoint
- Saved ZAP HTML and JSON reports
- Investigated why GitHub Actions did not show the same Trivy findings
- Stopped and removed the container
- Terminated the EC2 instance
- Removed temporary AWS resources after testing

AWS evidence:

```text
docs/evidence/practical/aws-practical-deployment-evidence.md
docs/evidence/practical/reports/trivy-week9-aws.txt
docs/evidence/practical/reports/zap-week9-aws.html
docs/evidence/practical/reports/zap-week9-aws.json
```

### GCP Practical Deployment

GCP used a managed serverless container deployment model:

```text
Artifact Registry → Cloud Run → HTTPS endpoint
```

GCP work completed:

- Enabled required GCP APIs
- Created Artifact Registry Docker repository
- Built and pushed image using Cloud Shell / Cloud Build
- Deployed the image to Cloud Run
- Allowed public access temporarily for testing
- Used request-based billing
- Set minimum instances to `0`
- Set maximum instances to `1`
- Opened and validated the Cloud Run URL
- Reviewed Cloud Run logs
- Ran OWASP ZAP baseline scan against the GCP endpoint
- Saved ZAP HTML and JSON reports
- Deleted the Cloud Run service
- Deleted the Artifact Registry repository
- Confirmed GCP cleanup completed

GCP evidence:

```text
docs/evidence/practical/gcp-practical-deployment-evidence.md
docs/evidence/practical/reports/zap-week9-gcp.html
docs/evidence/practical/reports/zap-week9-gcp.json
```

### AWS vs GCP Deployment Model

| Area | AWS Practical | GCP Practical |
|---|---|---|
| Runtime | EC2 VM | Cloud Run |
| Container Execution | Docker installed on VM | Managed container runtime |
| Image Storage | Built locally on EC2 | Artifact Registry |
| Network Exposure | Security Group rules | Cloud Run public access setting |
| DAST | ZAP against EC2 endpoint | ZAP against Cloud Run URL |
| Logs | Runtime and EC2 validation | Cloud Logging |
| Cleanup | Terminate EC2 and remove temporary resources | Delete Cloud Run service and Artifact Registry repo |

This demonstrates both traditional VM-based deployment and managed serverless container deployment.

---

## Week 10: Software Supply Chain Security

Week 10 expanded the project into software supply chain security.

The goal was to document what exists inside the container image, scan that inventory for vulnerabilities, and define a safe image signing strategy.

### SBOM Generation

Syft was used to generate a Software Bill of Materials for the Docker image.

Generated evidence:

```text
docs/evidence/week-10/reports/sbom-syft.json
docs/evidence/week-10/reports/sbom-syft-table.txt
```

The SBOM provides visibility into:

- OS packages
- Python packages
- Runtime components
- Package versions
- Package types
- Component metadata

### SBOM Vulnerability Scanning

Grype was used to scan the Syft-generated SBOM.

Generated evidence:

```text
docs/evidence/week-10/reports/grype-sbom-report.txt
docs/evidence/week-10/reports/grype-sbom-report.json
```

The Grype report showed that supply chain risk can come from:

- Python runtime components
- Debian base image packages
- OS-level packages
- Packages with no direct fix available

This reinforces an important DevSecOps lesson:

```text
Application dependencies are only one part of the risk.
Base images and runtime layers must also be reviewed.
```

### Cosign Image Signing Strategy

Cosign was documented as the image signing and artifact integrity strategy.

The recommended secure approach is keyless signing through GitHub Actions OIDC rather than storing private signing keys in the repository.

The signing strategy focuses on proving:

```text
The image was built by a trusted workflow.
The image has not been replaced unexpectedly.
The image can be verified before deployment.
```

### Automation

A dedicated workflow was added:

```text
.github/workflows/supply-chain-security.yml
```

The workflow:

- Builds the Docker image
- Generates SBOM using Syft
- Generates readable SBOM table output
- Scans the SBOM using Grype
- Generates TXT and JSON vulnerability reports
- Uploads reports as GitHub Actions artifacts
- Writes a supply chain security summary

Current mode:

```text
Evidence mode
```

Grype findings are collected for review and do not block the pipeline yet. This is intentional because initial findings need triage before converting them into blocking gates.

---

## Current Status

The project currently has:

- Flask app running locally
- Docker build working
- Hardened Dockerfile using a non-root user
- Basic Flask security headers configured
- GitHub Actions CI pipeline working
- Least-privilege workflow permissions configured
- Gitleaks configured and tested
- Semgrep configured and tested
- pip-audit configured and tested
- Trivy configured and tested
- CodeQL configured and passing
- Dependabot configured
- pre-commit configured and tested locally
- OWASP ZAP DAST workflow added
- Security reports uploaded as artifacts
- ZAP DAST reports uploaded as artifacts
- Real Semgrep findings fixed
- Real dependency vulnerability fixed
- Real container hardening finding fixed
- Security gates passing
- AWS practical secure deployment evidence completed
- GCP practical Cloud Run deployment evidence completed
- Runtime Trivy scan evidence documented
- CI vs runtime scan behavior documented
- AWS and GCP ZAP reports collected
- AWS and GCP temporary resources cleaned up
- Week 10 supply chain security evidence completed
- SBOM generated using Syft
- SBOM vulnerability scan completed using Grype
- Supply chain security workflow added
- Cosign image signing strategy documented

---

## What I Learned

- How to harden GitHub Actions using least-privilege permissions
- How to convert security tools from passive reports into blocking CI gates
- How to analyze and remediate real SAST findings
- How to prevent containers from running as root
- How to upload security scan reports as pipeline artifacts
- How to use CodeQL for GitHub-native code scanning
- How to automate dependency updates using Dependabot
- How to implement shift-left security using pre-commit hooks
- How to run OWASP ZAP DAST against a live containerized application
- How to use `/health` checks before runtime security scans
- How to document security findings and remediation as portfolio evidence
- How to deploy a Dockerized application on AWS EC2
- How to deploy a Dockerized application on GCP Cloud Run
- How to use Artifact Registry for container image storage
- How to compare VM-based and managed container deployment models
- How scanner configuration can hide or reveal vulnerability findings
- How to document temporary cloud resource cleanup after testing
- How to generate SBOMs for container images using Syft
- How to scan SBOMs for vulnerabilities using Grype
- How to triage supply chain findings from base image and runtime packages
- How to design a safe Cosign image signing strategy without committing private keys

---

## Next Improvements

Planned next steps:

- Implement practical Cosign keyless signing with GHCR or Artifact Registry
- Add blocking Grype gates after vulnerability triage
- Add OIDC-based cloud deployment
- Add Kubernetes security lab using a lightweight local or managed cluster
- Add cloud audit logging screenshots and detection notes
- Add incident response runbooks for common cloud findings
- Add CSPM-style cloud misconfiguration review checklist
- Add automated deployment with secure rollback documentation

---

## Related Security Projects

- [Multi-Cloud IaC Security Scanning](https://github.com/AbdelazezMohamedAzez/multi-cloud-iac-security-scanning)

---

## Portfolio Value

This repository demonstrates practical DevSecOps and Cloud Security Engineer skills:

- Secure CI/CD pipeline design
- Security gates and automation
- SAST, SCA, secret scanning, container scanning, and DAST
- Docker hardening
- Runtime vulnerability investigation
- AWS secure deployment evidence
- GCP Cloud Run deployment evidence
- Cloud cleanup discipline
- Professional security documentation
- Software supply chain security evidence
- SBOM and vulnerability triage workflow
