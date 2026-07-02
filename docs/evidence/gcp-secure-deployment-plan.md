# GCP Secure Deployment Plan

## Objective

This document explains how the Flask DevSecOps starter application can be deployed securely on Google Cloud Platform using secure networking, IAM least privilege, container security, logging, monitoring, and secrets management.

---

## Target Deployment Model

The application can be deployed as a containerized Flask application using one of the following options:

- Cloud Run for serverless container deployment
- Compute Engine for VM-based deployment
- Artifact Registry for container image storage
- VPC and firewall rules for network control
- Secret Manager for application secrets
- Cloud Logging and Cloud Monitoring for visibility

---

## Recommended GCP Components

| Area | GCP Service | Purpose |
|---|---|---|
| Container Registry | Artifact Registry | Store container images securely |
| Runtime | Cloud Run / Compute Engine | Run the Flask application |
| Identity | IAM / Service Accounts | Apply least-privilege access |
| Secrets | Secret Manager | Store secrets outside code and images |
| Logging | Cloud Logging | Collect application and platform logs |
| Monitoring | Cloud Monitoring | Track service health and metrics |
| Network Security | VPC Firewall Rules | Restrict inbound/outbound access |
| Posture Management | Security Command Center | Review security posture and findings |

---

## Security Controls

| Security Area | Control |
|---|---|
| IAM | Use dedicated service accounts with least privilege |
| Secrets | Store secrets in Secret Manager instead of environment files |
| Container Security | Scan images before deployment |
| Network Security | Restrict ingress using Cloud Run settings or VPC firewall rules |
| Logging | Enable Cloud Logging for application and platform events |
| Monitoring | Use Cloud Monitoring for service health and alerts |
| Auditability | Review Cloud Audit Logs for administrative activity |
| Compliance | Maintain audit trails and controlled access to sensitive resources |

---

## Secure Deployment Checklist

- [ ] Container image built from trusted source
- [ ] Image scanned before deployment
- [ ] Image stored in Artifact Registry
- [ ] Dedicated service account used
- [ ] Service account follows least privilege
- [ ] Secrets stored in Secret Manager
- [ ] Public access reviewed and justified
- [ ] Cloud Logging enabled
- [ ] Cloud Monitoring enabled
- [ ] Cloud Audit Logs reviewed
- [ ] Security Command Center findings reviewed where available

---

## Risk Considerations

| Risk | Mitigation |
|---|---|
| Public service exposure | Restrict ingress and require authentication where possible |
| Excessive permissions | Use least-privilege service accounts |
| Secret leakage | Use Secret Manager and avoid secrets in code/images |
| Vulnerable container image | Scan image before deployment |
| Weak visibility | Enable Cloud Logging, Monitoring, and Audit Logs |
| Misconfigured firewall rules | Review VPC firewall rules and allow only required traffic |

---

## Summary

This GCP secure deployment plan documents how the application can be deployed with cloud-native security controls across IAM, secrets management, container image storage, network access, logging, monitoring, and auditability.
