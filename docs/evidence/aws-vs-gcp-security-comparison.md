# AWS vs GCP Security Comparison

## Objective

This document compares key security controls between AWS and Google Cloud Platform for securely deploying and operating a containerized Flask application.

---

## Security Control Comparison

| Security Area | AWS | GCP | Notes |
|---|---|---|---|
| Identity & Access Management | IAM Users, Groups, Roles, Policies | IAM Roles, Service Accounts | Both platforms require least-privilege access design |
| Secrets Management | AWS Secrets Manager / SSM Parameter Store | Secret Manager | Secrets should never be stored in code, images, or plain environment files |
| Container Registry | Amazon ECR | Artifact Registry | Container images should be scanned before deployment |
| Logging | CloudTrail, CloudWatch Logs | Cloud Audit Logs, Cloud Logging | Logs support investigation, compliance, and operational visibility |
| Monitoring | CloudWatch | Cloud Monitoring | Monitoring should track health, errors, and suspicious behavior |
| Network Security | Security Groups, NACLs, VPC | VPC Firewall Rules | Inbound access should be restricted to required ports only |
| Vulnerability Management | Inspector, ECR Scanning, third-party tools | Security Command Center, Artifact Analysis, third-party tools | Findings should be prioritized by severity, exploitability, and exposure |
| Runtime Options | EC2, ECS, EKS, App Runner | Compute Engine, Cloud Run, GKE | Runtime choice affects security responsibility |
| Key Management | AWS KMS | Cloud KMS | Encryption keys should be controlled and access-reviewed |
| Compliance Support | CloudTrail, Config, Security Hub | Audit Logs, Security Command Center | Evidence collection is important for audits and compliance reviews |

---

## Deployment Security Notes

### AWS

AWS provides strong control over networking and compute environments. Security Groups, IAM roles, CloudTrail, CloudWatch, and Secrets Manager are core services for secure deployment.

Recommended focus areas:

- Use IAM roles instead of long-lived access keys
- Restrict Security Group inbound rules
- Enable CloudTrail for API activity
- Use CloudWatch for application and infrastructure monitoring
- Store secrets in Secrets Manager or SSM Parameter Store
- Scan containers before deployment

---

### GCP

GCP provides strong integration between IAM, service accounts, Cloud Run, Artifact Registry, Cloud Logging, and Secret Manager.

Recommended focus areas:

- Use dedicated service accounts
- Apply least-privilege IAM roles
- Store secrets in Secret Manager
- Use Artifact Registry for container images
- Enable Cloud Logging and Cloud Monitoring
- Review Cloud Audit Logs
- Restrict public access where possible

---

## Multi-Cloud Security Lessons

- IAM design is critical in both AWS and GCP.
- Secrets must be managed outside source code and container images.
- Logging and monitoring are required for investigation and compliance evidence.
- Container images should be scanned before deployment.
- Public access should be reviewed and justified.
- Security findings should be prioritized by exposure, impact, and exploitability.
- Documentation is part of security evidence, not just an afterthought.

---

## Summary

AWS and GCP provide similar security capabilities, but the service names and implementation models are different.

A secure multi-cloud deployment should focus on consistent security principles:

- Least privilege
- Secure networking
- Secrets management
- Logging and monitoring
- Vulnerability management
- Container security
- Clear remediation evidence
