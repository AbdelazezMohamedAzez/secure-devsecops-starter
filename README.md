# Secure DevSecOps Starter

A simple Python Flask API used to practice DevSecOps basics.

## What this project includes

* Python Flask API
* Dockerized application
* GitHub Actions CI pipeline
* Secret scanning using Gitleaks
* SAST scanning using Semgrep
* Python dependency vulnerability scanning using pip-audit
* Container vulnerability scanning using Trivy
* Least-privilege GitHub Actions permissions
* Docker image build inside the pipeline

## Run locally

```bash
pip install -r requirements.txt
python app.py
```

Then open:

```text
http://localhost:5000
```

## Run with Docker

```bash
docker build -t secure-devsecops-starter .
docker run -p 5000:5000 secure-devsecops-starter
```

Then open:

```text
http://localhost:5000
```

## Security CI Pipeline

The GitHub Actions pipeline runs on every push and on pull requests.

Current pipeline steps:

1. Checkout the source code
2. Run Gitleaks secret scan
3. Run Semgrep SAST scan
4. Run Python dependency audit with pip-audit
5. Build the Docker image
6. Run Trivy container image scan

## Security Fix Completed

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

## Secret Scanning Test

Gitleaks was tested using a custom demo rule.

A demo secret was intentionally committed on a separate test branch to verify that secret scanning works.

Result:

* Gitleaks detected the demo secret.
* The pipeline failed successfully.
* The demo secret was removed.
* The pipeline passed again after remediation.

## Dependency Scanning with pip-audit

pip-audit was added to scan Python dependencies in `requirements.txt`.

It detected a vulnerability in Flask 3.0.3 and recommended upgrading Flask.

The issue was fixed by updating Flask to version 3.1.3:

```text
Flask==3.1.3
gunicorn==22.0.0
```

After the upgrade, the GitHub Actions pipeline passed successfully.

## Container Scanning with Trivy

Trivy was added to scan the Docker image for HIGH and CRITICAL vulnerabilities.

The pipeline now builds the Docker image and scans it before considering the CI successful.

## Current Status

The project currently has:

* Flask app running locally
* Docker build working
* Gitleaks configured and tested
* Semgrep configured and tested
* pip-audit configured and tested
* Trivy configured and tested
* One real Semgrep finding fixed
* One real dependency vulnerability fixed
* CI pipeline passing

## Project Goal

The goal of this project is to build a simple hands-on DevSecOps pipeline and improve it step by step.
