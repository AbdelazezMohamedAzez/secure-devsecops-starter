# Week 6: OWASP ZAP DAST Report

## Goal

Run Dynamic Application Security Testing (DAST) against the running Flask application using OWASP ZAP Baseline Scan.

The purpose of this week is to test the application while it is running, not only by scanning source code, dependencies, secrets, or container images.

---

## Why DAST Was Added

Previous security checks covered static and build-time risks:

| Security Area | Tool | Purpose |
|---|---|---|
| Secret scanning | Gitleaks | Detect committed secrets and tokens |
| SAST | Semgrep / CodeQL | Detect insecure code patterns |
| SCA | pip-audit / Dependabot | Detect vulnerable Python dependencies |
| Container scanning | Trivy | Detect vulnerabilities inside the Docker image |

DAST was added to test the application from the outside as a running web service.

OWASP ZAP checks for runtime web security issues such as missing security headers, exposed endpoints, insecure browser behavior, and common web misconfigurations.

---

## Target Application

The scan targets the Flask application running inside a Docker container during GitHub Actions.

```txt
http://127.0.0.1:5000
```

Health check endpoint:

```txt
/health
```

The health endpoint is used to confirm that the application is running before OWASP ZAP starts scanning.

---

## Workflow Behavior

The GitHub Actions workflow performs the following steps:

1. Checks out the repository.
2. Builds the Docker image.
3. Runs the application container.
4. Waits for the `/health` endpoint to respond.
5. Runs OWASP ZAP Baseline Scan against the running application.
6. Generates ZAP reports in HTML, Markdown, and JSON formats.
7. Uploads the reports as GitHub Actions artifacts.
8. Stops and removes the application container.

---

## OWASP ZAP Scan Type

This project uses OWASP ZAP Baseline Scan.

The baseline scan is suitable for CI/CD because it performs passive scanning against the application and reports common web security issues without performing aggressive attacks.

---

## Reports Generated

The workflow generates the following files:

```txt
zap-report.html
zap-report.md
zap-report.json
```

GitHub Actions artifact name:

```txt
zap-dast-report
```

The HTML report is intended for manual review.

The Markdown report is useful for documentation.

The JSON report can be used later for automation or policy-based gates.

---

## Security Headers Added

Basic security headers were added to the Flask application to reduce common passive scan findings.

| Header | Purpose |
|---|---|
| `X-Content-Type-Options: nosniff` | Prevents browsers from MIME-sniffing responses |
| `X-Frame-Options: DENY` | Reduces clickjacking risk by blocking iframe embedding |
| `Referrer-Policy: no-referrer` | Prevents referrer information leakage |
| `Cache-Control: no-store` | Prevents sensitive responses from being cached |
| `Content-Security-Policy: default-src 'none'; frame-ancestors 'none'` | Restricts browser content loading and blocks framing |

---

## Findings and Remediation

| Finding | Risk | Remediation | Status |
|---|---|---|---|
| Missing security headers | Low / Medium | Added standard Flask response security headers | Fixed |

---

## Validation Steps

The workflow is considered successful when:

- The Docker image builds successfully.
- The application container starts successfully.
- The `/health` endpoint returns a valid response.
- OWASP ZAP Baseline Scan runs successfully.
- ZAP reports are generated.
- The `zap-dast-report` artifact is uploaded to GitHub Actions.

---

## Local Test Commands

The application can be tested locally before pushing the workflow:

```bash
docker build -t secure-devsecops-starter:week6 .
docker run -d --name week6-app -p 5000:5000 secure-devsecops-starter:week6
curl http://127.0.0.1:5000/health
docker stop week6-app
docker rm week6-app
```

Expected health response:

```json
{"status":"healthy"}
```

---

## Result

Week 6 adds runtime application security testing to the DevSecOps pipeline.

The project now validates the application through:

- Secret scanning
- Static code scanning
- Dependency scanning
- Container image scanning
- Dynamic application security testing

This improves the pipeline from static checks only to a stronger security workflow that also tests the running application.

---

## Week 6 Status

Week 6 is complete when the OWASP ZAP workflow runs successfully and uploads the DAST report artifact.
