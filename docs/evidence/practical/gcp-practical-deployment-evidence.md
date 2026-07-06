# GCP Practical Deployment Evidence

## Objective

This document captures practical Google Cloud Platform deployment evidence for the **Secure DevSecOps Starter** Flask application.

The goal was to deploy the containerized application using a managed GCP container runtime, validate it through a public temporary endpoint, collect logs and DAST evidence, and then remove all temporary cloud resources.

---

## Scope

This evidence focuses on the GCP practical part of Week 9.

The deployment used a different model from AWS to demonstrate multi-cloud deployment knowledge:

| Cloud | Deployment Model |
|---|---|
| AWS | EC2 VM + Docker |
| GCP | Cloud Run + Artifact Registry |

This avoids repeating the same VM-based deployment pattern and demonstrates a modern serverless container deployment model on GCP.

Covered areas:

- Artifact Registry repository creation
- Docker image build and push using Cloud Build / Cloud Shell
- Cloud Run deployment from Artifact Registry
- Public temporary endpoint validation
- Cloud Run logs evidence
- OWASP ZAP baseline DAST scan against the deployed endpoint
- GCP cleanup confirmation

---

## Deployment Summary

| Item | Details |
|---|---|
| Cloud Provider | Google Cloud Platform |
| Runtime | Cloud Run |
| Container Registry | Artifact Registry |
| Build Method | Cloud Shell / Cloud Build |
| Application | Dockerized Flask application |
| Image Tag | `secure-devsecops-starter:week9` |
| Cloud Run Service | `week9-secure-devsecops` |
| Artifact Registry Repository | `week9-devsecops-repo` |
| Region | `us-central1` |
| Authentication | Public access allowed temporarily for testing |
| Billing Mode | Request-based |
| Scaling | Minimum instances: 0, Maximum instances: 1 |
| Cleanup Status | Completed |

---

## GCP Resources Used

The following temporary GCP resources were used:

- Artifact Registry repository
- Container image stored in Artifact Registry
- Cloud Run service
- Cloud Run revision
- Cloud Logging entries
- Cloud Build activity for image build and push

The following resources were intentionally **not** used:

- Compute Engine VM
- Kubernetes / GKE
- Load Balancer
- Cloud SQL
- Persistent disk
- Static IP
- Long-running managed infrastructure

This kept the deployment lightweight, temporary, and cost-controlled.

---

## Target Architecture

```text
User Browser / curl / ZAP
        |
        | HTTPS
        |
Cloud Run Public Endpoint
        |
        | Runs container image
        |
Cloud Run Service
        |
        | Pulls image from
        |
Artifact Registry
```

Security approach:

- The service was public only temporarily for testing.
- Minimum instances were set to `0`.
- Maximum instances were limited to `1`.
- No database or persistent backend service was created.
- No application secrets were required for this deployment.
- All temporary resources were removed after evidence collection.

---

## Step 1: Enable Required APIs

The following APIs were enabled before deployment:

- Cloud Run API
- Artifact Registry API
- Cloud Build API
- Cloud Logging API

Purpose:

| API | Purpose |
|---|---|
| Cloud Run API | Run the containerized application |
| Artifact Registry API | Store the Docker image |
| Cloud Build API | Build and push the image |
| Cloud Logging API | Collect runtime logs |

---

## Step 2: Create Artifact Registry Repository

An Artifact Registry repository was created from the GCP Console.

Configuration:

| Setting | Value |
|---|---|
| Repository Name | `week9-devsecops-repo` |
| Format | Docker |
| Mode | Standard |
| Location Type | Region |
| Region | `us-central1` |
| Encryption | Google-managed encryption key |

Purpose:

Artifact Registry was used as the container image repository before deploying to Cloud Run.

Evidence collected:

- Repository created screenshot
- Repository region screenshot
- Docker image and tag screenshot after push

---

## Step 3: Build and Push Image

Cloud Shell was used to build and push the Docker image to Artifact Registry.

Variables used:

```bash
PROJECT_ID="<PROJECT_ID>"
REGION="us-central1"
REPO_NAME="week9-devsecops-repo"
IMAGE_NAME="$REGION-docker.pkg.dev/$PROJECT_ID/$REPO_NAME/secure-devsecops-starter:week9"
```

Repository cloned:

```bash
git clone https://github.com/AbdelazezMohamedAzez/secure-devsecops-starter.git
cd secure-devsecops-starter
```

Build and push command:

```bash
gcloud builds submit --tag "$IMAGE_NAME" --project "$PROJECT_ID"
```

Result:

```text
Image pushed successfully to Artifact Registry.
```

Evidence collected:

- Cloud Build success output
- Artifact Registry image visible
- Image tag `week9` visible

---

## Step 4: Deploy to Cloud Run

The application was deployed from the GCP Console using:

```text
Cloud Run -> Deploy container
```

Deployment settings:

| Setting | Value |
|---|---|
| Service Name | `week9-secure-devsecops` |
| Region | `us-central1` |
| Source | Existing container image |
| Image | Artifact Registry image with tag `week9` |
| Authentication | Allow public access |
| Billing | Request-based |
| Container Port | `5000` |
| Minimum Instances | `0` |
| Maximum Instances | `1` |

Reason for public access:

Public access was allowed temporarily to perform browser validation and OWASP ZAP DAST testing. The service was deleted after evidence collection.

---

## Step 5: Runtime Validation

The Cloud Run endpoint opened successfully in the browser.

Evidence collected:

- Cloud Run service page screenshot
- Endpoint URL screenshot
- Browser test screenshot
- Cloud Run status showing traffic served

Validation result:

```text
The application opened successfully from the Cloud Run URL.
```

---

## Step 6: Cloud Logging Evidence

Cloud Run logs were reviewed after opening the service URL.

Evidence collected:

- Cloud Run request logs
- Timestamped request entries
- Service name visible in logs
- HTTP request activity visible

Purpose:

Cloud Logging evidence confirms that the Cloud Run service processed real requests during testing.

---

## Step 7: OWASP ZAP DAST Evidence

OWASP ZAP baseline scan was executed against the temporary Cloud Run endpoint.

The scan generated:

```text
docs/evidence/practical/reports/zap-week9-gcp.html
docs/evidence/practical/reports/zap-week9-gcp.json
```

Evidence collected:

- ZAP HTML report
- ZAP JSON report
- DAST scan against deployed GCP endpoint

Note:

The first attempt to pull the ZAP image from `ghcr.io` failed due to a registry/network connection issue. The scan was completed successfully using the Docker Hub ZAP image instead.

Security lesson:

```text
Security tooling dependencies can fail because of external registry/network issues.
A fallback image source can keep the testing workflow moving.
```

---

## GCP vs AWS Deployment Difference

This GCP deployment used a different runtime model from AWS.

| Area | AWS Practical | GCP Practical |
|---|---|---|
| Runtime | EC2 VM | Cloud Run |
| Container Execution | Docker installed on VM | Managed container runtime |
| Access Control | Security Group | Cloud Run public access setting |
| Image Storage | Built locally on VM | Artifact Registry |
| Logging | Runtime/EC2 evidence | Cloud Logging |
| Cleanup | Terminate EC2 and remove SG/key | Delete Cloud Run service and Artifact Registry repo |

This shows two deployment approaches:

- VM-based container hosting
- Serverless managed container hosting

---

## Risk Assessment

| Risk | Source | Impact | Mitigation |
|---|---|---|---|
| Temporary public access | Cloud Run public endpoint | Service reachable during testing | Delete service immediately after evidence collection |
| Image exposure | Artifact Registry image | Image remains stored after service deletion | Delete Artifact Registry repository after testing |
| Unexpected scaling | Cloud Run autoscaling | Potential extra cost | Set max instances to 1 and min instances to 0 |
| Weak visibility | Missing logs | Harder to verify runtime behavior | Review Cloud Logging evidence |
| External scanner dependency | ZAP image pull issue | DAST scan delay | Use fallback ZAP image source |

---

## Cleanup Evidence

After collecting runtime, logging, and ZAP evidence, all temporary GCP resources were deleted.

Cleanup actions completed:

- Cloud Run service deleted
- Artifact Registry repository deleted
- Container image removed as part of repository deletion
- No Compute Engine VM was created
- No GKE cluster was created
- No Load Balancer was created
- No Cloud SQL instance was created
- No static IP was created

Cleanup status:

```text
GCP cleanup completed successfully.
```

Security lesson:

Temporary cloud services should be removed immediately after testing to reduce cost, reduce exposure, and keep the environment clean.

---

## Evidence Checklist

| Evidence Item | Status |
|---|---|
| Required APIs enabled | Done |
| Artifact Registry repository created | Done |
| Docker image built and pushed | Done |
| Cloud Run service deployed | Done |
| Public endpoint opened successfully | Done |
| Cloud Run browser test captured | Done |
| Cloud Run logs reviewed | Done |
| ZAP baseline scan completed | Done |
| ZAP HTML report saved | Done |
| ZAP JSON report saved | Done |
| Cloud Run service deleted | Done |
| Artifact Registry repository deleted | Done |
| GCP cleanup completed | Done |

---

## Files Added

Expected files for this evidence:

```text
docs/evidence/practical/gcp-practical-deployment-evidence.md
docs/evidence/practical/reports/zap-week9-gcp.html
docs/evidence/practical/reports/zap-week9-gcp.json
```

Optional screenshot evidence:

```text
docs/evidence/practical/screenshots/gcp-artifact-registry-repo.png
docs/evidence/practical/screenshots/gcp-artifact-registry-image.png
docs/evidence/practical/screenshots/gcp-cloud-run-service.png
docs/evidence/practical/screenshots/gcp-cloud-run-browser-test.png
docs/evidence/practical/screenshots/gcp-cloud-run-logs.png
docs/evidence/practical/screenshots/gcp-cleanup-confirmation.png
```

---

## Final Summary

This GCP practical deployment demonstrated a managed container deployment workflow using Artifact Registry and Cloud Run.

The evidence shows that:

- The application container image can be built and pushed to Artifact Registry.
- Cloud Run can run the Flask application without managing a VM.
- The service can be tested through a temporary HTTPS endpoint.
- Cloud Logging provides runtime request evidence.
- OWASP ZAP can be used to perform DAST testing against the deployed GCP endpoint.
- All temporary GCP resources were removed after evidence collection.

This complements the AWS EC2 deployment by showing a second cloud deployment model:

```text
AWS: VM-based container deployment
GCP: Serverless managed container deployment
```
