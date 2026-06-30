# Secure DevSecOps Starter

A hands-on Python Flask API project used to practice and demonstrate DevSecOps fundamentals, secure CI/CD pipelines, automated security gates, container hardening, and shift-left security practices.

---

## Project Overview

This project started as a simple Flask API and was gradually upgraded into a hardened DevSecOps starter pipeline.

The main goal is to demonstrate how security checks can be integrated into the software delivery lifecycle before code is merged or deployed.

The pipeline does not only generate security reports. It also enforces blocking security gates when high-risk issues are detected.

---

## What This Project Includes

* Python Flask API
* Dockerized application
* GitHub Actions CI pipeline
* Least-privilege GitHub Actions permissions
* Branch-based PR workflow
* Secret scanning using Gitleaks
* SAST scanning using Semgrep
* Code scanning using CodeQL
* Python dependency vulnerability scanning using pip-audit
* Container vulnerability scanning using Trivy
* DAST scanning using OWASP ZAP Baseline Scan
* Dependency update automation using Dependabot
* Local pre-commit security checks
* Docker non-root user hardening
* Basic Flask security headers
* Security scan reports uploaded as GitHub Actions artifacts
---

## Project Goal

The goal of this project is to build a simple but practical DevSecOps pipeline and improve it step by step.

This repository demonstrates:

* How to secure a CI pipeline
* How to detect secrets before merge
* How to scan source code for security issues
* How to scan Python dependencies for vulnerabilities
* How to scan Docker images for HIGH and CRITICAL vulnerabilities
* How to run DAST against a live containerized web application
* How to harden Docker containers by avoiding root execution
* How to reduce common passive web findings using security headers
* How to collect security evidence using reports and artifacts
* How to apply shift-left security using pre-commit hooks
---

## Tech Stack

| Area                  | Tool                    |
| --------------------- | ----------------------- |
| Application           | Python Flask            |
| Web Server            | Gunicorn                |
| Containerization      | Docker                  |
| CI/CD                 | GitHub Actions          |
| Secret Scanning       | Gitleaks                |
| SAST                  | Semgrep                 |
| Code Scanning         | CodeQL                  |
| Dependency Scanning   | pip-audit               |
| Container Scanning    | Trivy                   |
| DAST                  | OWASP ZAP Baseline Scan |
| Dependency Automation | Dependabot              |
| Local Security Checks | pre-commit              |
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

The GitHub Actions pipeline runs on pushes and pull requests targeting the protected branches.

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

| Gate            | Tool      | Blocking Condition                      |
| --------------- | --------- | --------------------------------------- |
| Secrets Gate    | Gitleaks  | Secret or credential detected           |
| SAST Gate       | Semgrep   | ERROR-level SAST finding detected       |
| Dependency Gate | pip-audit | Vulnerable Python dependency detected   |
| Container Gate  | Trivy     | HIGH or CRITICAL vulnerability detected |
| Build Gate      | Docker    | Docker image build fails                |
| Runtime Gate    | ZAP setup | Application container fails to start    |

The final enforcement step checks the outcome of every security stage and fails the pipeline if any blocking gate fails.

OWASP ZAP Baseline Scan is currently used as a DAST evidence and triage step. It uploads reports as artifacts so findings can be reviewed and remediated.
---

## Security Reports and Observability

Security reports are generated and uploaded as GitHub Actions artifacts.

Generated reports include:

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

* Security review
* Debugging failed pipelines
* Vulnerability triage
* DAST finding review
* Interview demonstration
* Portfolio documentation
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

* Gitleaks detected the demo secret
* The pipeline failed successfully
* The demo secret was removed
* The pipeline passed again after remediation

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

The pipeline now builds the Docker image and scans it before considering the CI successful.

Current Trivy behavior:

* Scans the built Docker image
* Checks for HIGH and CRITICAL vulnerabilities
* Ignores unfixed vulnerabilities
* Fails the pipeline when blocking vulnerabilities are detected

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

Report documentation:

```text
docs/week-6-dast-report.md
```

Artifact name:

```text
zap-dast-report
```
---

## CodeQL Code Scanning

CodeQL was added as an additional static code analysis layer.

CodeQL provides deeper code scanning and integrates with GitHub Security features.

Current CodeQL setup:

* Runs on pull requests
* Runs on pushes to protected branches
* Scans Python code
* Uses security-extended and security-and-quality queries

Results appear in:

```text
GitHub → Security → Code scanning
```

---

## Dependabot Automation

Dependabot was added to automate dependency and workflow update checks.

Configured ecosystems:

| Ecosystem      | Purpose                           |
| -------------- | --------------------------------- |
| pip            | Monitor Python dependencies       |
| github-actions | Monitor GitHub Actions versions   |
| docker         | Monitor Docker base image updates |

Dependabot helps keep the project updated and reduces supply-chain risk by opening automated update pull requests.

---

## Shift-Left Security with pre-commit

A local pre-commit layer was added to catch issues before code reaches GitHub.

Current pre-commit hooks:

| Hook                | Purpose                                   |
| ------------------- | ----------------------------------------- |
| detect-private-key  | Prevent private keys from being committed |
| check-yaml          | Validate YAML files                       |
| check-json          | Validate JSON files                       |
| end-of-file-fixer   | Ensure files end correctly                |
| trailing-whitespace | Remove unnecessary whitespace             |
| Gitleaks            | Detect hardcoded secrets locally          |

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

## Current Status

The project currently has:

* Flask app running locally
* Docker build working
* Hardened Dockerfile using a non-root user
* Basic Flask security headers configured
* GitHub Actions CI pipeline working
* Least-privilege workflow permissions configured
* Gitleaks configured and tested
* Semgrep configured and tested
* pip-audit configured and tested
* Trivy configured and tested
* CodeQL configured and passing
* Dependabot configured
* pre-commit configured and tested locally
* OWASP ZAP DAST workflow added
* Security reports uploaded as artifacts
* ZAP DAST reports uploaded as artifacts
* Real Semgrep findings fixed
* Real dependency vulnerability fixed
* Security gates passing
---

## Week 1 Summary

During Week 1, the project established the DevSecOps foundation:

* Built a simple Flask API
* Dockerized the application
* Added GitHub Actions CI
* Added Gitleaks secret scanning
* Added Semgrep SAST scanning
* Added pip-audit dependency scanning
* Added Trivy container scanning
* Fixed real security findings detected by the pipeline

---

## Week 2 Summary: CI/CD Hardening

During Week 2, the project was upgraded from a basic security scanning pipeline into a hardened DevSecOps CI pipeline.

Completed hardening work:

* Added branch-based PR workflow
* Added least-privilege GitHub Actions permissions
* Added workflow concurrency control
* Converted scans into blocking security gates
* Added security scan report artifacts
* Added final security gate enforcement
* Added CodeQL code scanning
* Added Dependabot automation
* Added pre-commit local security checks
* Fixed a real Dockerfile non-root user finding

---

## Week 6 Summary: OWASP ZAP DAST Scanning

During Week 6, the project added Dynamic Application Security Testing against the running Flask application.

Completed DAST work:

* Added an OWASP ZAP Baseline Scan workflow
* Built the Docker image before scanning
* Started the application container inside GitHub Actions
* Added a `/health` readiness check before scanning
* Scanned the running application at `http://127.0.0.1:5000`
* Generated ZAP reports in HTML, Markdown, and JSON formats
* Uploaded ZAP reports as GitHub Actions artifacts
* Added basic Flask security headers to reduce common passive scan findings

This moves the project from static-only checks to runtime web security testing.
---

## What I Learned

* How to harden GitHub Actions using least-privilege permissions
* How to convert security tools from passive reports into blocking CI gates
* How to analyze and remediate real SAST findings
* How to prevent containers from running as root
* How to upload security scan reports as pipeline artifacts
* How to use CodeQL for GitHub-native code scanning
* How to automate dependency updates using Dependabot
* How to implement shift-left security using pre-commit hooks
* How to run OWASP ZAP DAST against a live containerized application
* How to use `/health` checks before runtime security scans
* How to document security findings and remediation as portfolio evidence
---

## Next Improvements

Planned next steps:

* Add Terraform and Checkov for IaC security
* Add SBOM generation using Syft
* Add container image signing using Cosign
* Add OIDC-based cloud deployment
* Deploy the application to GCP Cloud Run
* Add cloud audit logging and security monitoring
