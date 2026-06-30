# Week 7: Container Security Report

## Goal

Harden the Docker image and reduce container runtime risk before moving to IaC and cloud deployment work.

Week 7 focuses on improving the container build and runtime configuration, not adding another unrelated security tool.

---

## Why Container Security Matters

A Docker image may build successfully and still be risky if it:

- Runs as the root user
- Copies unnecessary files into the image
- Has no healthcheck
- Uses a large or noisy base image
- Stores secrets or local development files
- Has HIGH or CRITICAL vulnerabilities

Container hardening reduces the impact if the application is compromised and makes the image cleaner, smaller, and easier to scan.

---

## What Was Improved

- Added non-root container execution using `appuser`
- Added dedicated Linux group `appgroup`
- Added file ownership control using `COPY --chown`
- Added Docker `HEALTHCHECK`
- Kept a slim Python base image
- Used `pip install --no-cache-dir`
- Improved `.dockerignore` to avoid copying unnecessary files
- Continued Trivy container image scanning in CI

---

## Dockerfile Hardening Controls

| Control | Status | Purpose |
|---|---|---|
| Minimal base image | Done | Reduces image size and attack surface |
| Non-root runtime user | Done | Prevents the app from running as root |
| Dedicated app group | Done | Separates app permissions from system users |
| File ownership control | Done | Ensures app files belong to the non-root user |
| Healthcheck | Done | Allows Docker/CI to verify app runtime health |
| No dependency cache | Done | Reduces unnecessary image layers and files |
| No intentional secrets copied | Done | Reduces risk of credential leakage |
| Trivy image scan | Done | Detects HIGH and CRITICAL vulnerabilities |

---

## Recommended Dockerfile Pattern

```dockerfile
FROM python:3.12-slim

WORKDIR /app

ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

COPY requirements.txt .

RUN pip install --no-cache-dir -r requirements.txt

RUN groupadd --system appgroup \
    && useradd --system --gid appgroup --create-home --home-dir /home/appuser appuser

COPY --chown=appuser:appgroup . .

EXPOSE 5000

USER appuser

HEALTHCHECK --interval=30s --timeout=5s --start-period=10s --retries=3 \
    CMD python -c "import urllib.request; urllib.request.urlopen('http://127.0.0.1:5000/health')" || exit 1

CMD ["gunicorn", "--bind", "0.0.0.0:5000", "app:app"]
```

---

## Recommended `.dockerignore`

```text
.git
.github
__pycache__
*.pyc
*.pyo
*.pyd
.env
.venv
venv
env
reports
zap-reports
docs
README.md
.gitignore
.pre-commit-config.yaml
```

---

## Validation Commands

Run these commands locally before opening the pull request:

```bash
docker build -t secure-devsecops-starter:week7 .
docker run -d --name week7-app -p 5000:5000 secure-devsecops-starter:week7
curl http://127.0.0.1:5000/health
docker inspect --format='{{.Config.User}}' secure-devsecops-starter:week7
docker stop week7-app
docker rm week7-app
```

Expected health response:

```json
{"status":"healthy"}
```

Expected container user:

```text
appuser
```

---

## Trivy CI Validation

Trivy remains the container vulnerability scanning gate in the CI pipeline.

Expected behavior:

- Build the Docker image
- Scan the image with Trivy
- Detect HIGH and CRITICAL vulnerabilities
- Fail the pipeline when blocking vulnerabilities are found
- Upload scan evidence as a GitHub Actions artifact

---

## Risk Reduction Summary

| Risk | Before | After |
|---|---|---|
| App running as root | Higher impact if compromised | App runs as `appuser` |
| Unnecessary files in image | Higher noise and leakage risk | `.dockerignore` reduces copied files |
| Runtime health unknown | Container may appear running but app may be broken | Healthcheck validates `/health` |
| Vulnerable image packages | May go unnoticed | Trivy scans the image in CI |
| File permissions unclear | App files may be owned by root | `COPY --chown` sets ownership |

---

## Week 7 Result

Week 7 is complete when:

- Docker image builds successfully
- Container starts successfully
- `/health` endpoint works
- Container runs as `appuser`
- Trivy image scan passes in CI
- Security CI passes
- OWASP ZAP DAST still passes
- CodeQL still passes
- README is updated with Week 7 progress

---

## Interview Summary

I hardened the Docker image by running the application as a non-root user, controlling file ownership, adding a Docker healthcheck, improving `.dockerignore`, and keeping Trivy image scanning active in CI. This reduces container runtime risk and gives clear security evidence in the pipeline.
