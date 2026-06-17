# Secure DevSecOps Starter

A simple Python Flask API used to practice DevSecOps basics.

## What this project includes

* Python Flask API
* Dockerized application
* GitHub Actions CI pipeline
* Secret scanning using Gitleaks
* SAST scanning using Semgrep
* Least-privilege GitHub Actions permissions
* Docker image build inside the pipeline
* Container vulnerability scanning using Trivy

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

The GitHub Actions pipeline runs on every push to the `main` branch and on pull requests.

Current pipeline steps:

1. Checkout the source code
2. Run Gitleaks secret scan
3. Run Semgrep SAST scan
4. Build the Docker image

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

## Current Status

The project currently has:

* Flask app running locally
* Docker build working
* Gitleaks configured
* Semgrep configured
* One real Semgrep finding fixed
* CI pipeline passing

## Project Goal

The goal of this project is to build a simple hands-on DevSecOps pipeline and improve it step by step.


## Secret Scanning Test

Gitleaks was tested using a custom demo rule.

A demo secret was intentionally committed on a separate test branch to verify that secret scanning works.

Result:

- Gitleaks detected the demo secret.
- The pipeline failed successfully.
- The demo secret was removed.
- The pipeline passed again after remediation.


## Container Scanning with Trivy

Trivy was added to scan the Docker image for HIGH and CRITICAL vulnerabilities.

The pipeline now builds the Docker image and scans it before considering the CI successful.
