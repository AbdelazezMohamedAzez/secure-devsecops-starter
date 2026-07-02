# Week 9: Multi-Cloud Secure Deployment Evidence

## Objective

This week focuses on documenting a secure multi-cloud deployment approach for the DevSecOps starter application.

The goal is to demonstrate practical AWS secure deployment evidence, a GCP secure deployment plan, and a comparison between both cloud environments from a security and compliance perspective.

---

## Scope

### AWS Practical Evidence

The AWS section documents how the application can be deployed securely using:

- Secure network configuration
- Restricted security group rules
- IAM least privilege
- Containerized application deployment
- Logging and monitoring
- Vulnerability and configuration review
- Security evidence screenshots or command outputs

### GCP Secure Deployment Plan

The GCP section documents the equivalent secure deployment approach using:

- Secure VPC design
- IAM least privilege
- Artifact Registry
- Cloud Run or Compute Engine deployment option
- Cloud Logging and Monitoring
- Secret Manager
- Security Command Center or vulnerability review concepts

### Multi-Cloud Comparison

This section compares AWS and GCP security controls across:

- Identity and access management
- Network security
- Logging and monitoring
- Secrets management
- Container security
- Compliance readiness
- Operational visibility

---

## AWS Secure Deployment Evidence

Detailed AWS deployment evidence is available here:

- [AWS Secure Deployment Evidence](./evidence/aws-secure-deployment-evidence.md)

### 1. Target Architecture

The application is intended to run as a containerized Flask application.

Recommended AWS components:

- VPC
- Public subnet for controlled inbound access
- Security Group with restricted inbound rules
- EC2 or container runtime host
- IAM role with least privilege
- CloudTrail for API activity logging
- CloudWatch for operational monitoring
- Optional ECR for container image storage

### 2. Security Controls

| Area | Control |
|---|---|
| Network Security | Restrict inbound access using Security Groups |
| IAM | Use least-privilege IAM roles instead of long-lived access keys |
| Logging | Enable CloudTrail and CloudWatch logging |
| Secrets | Store secrets outside code and container images |
| Container Security | Scan images using Trivy before deployment |
| Application Security | Run DAST scan using OWASP ZAP |
| Patch Management | Keep base images and host packages updated |

---

## GCP Secure Deployment Plan

Detailed GCP deployment plan is available here:

- [GCP Secure Deployment Plan](./evidence/gcp-secure-deployment-plan.md)

### 1. Target Architecture

Recommended GCP components:

- VPC network
- Firewall rules with least privilege
- Artifact Registry for container images
- Cloud Run or Compute Engine for deployment
- Secret Manager for secrets
- Cloud Logging and Cloud Monitoring
- IAM roles with least privilege

### 2. Security Controls

| Area | GCP Control |
|---|---|
| Identity | IAM roles with least privilege |
| Secrets | Secret Manager |
| Container Registry | Artifact Registry |
| Logging | Cloud Logging |
| Monitoring | Cloud Monitoring |
| Network Security | VPC firewall rules |
| Compliance | Centralized audit logs and controlled access |

---

## AWS vs GCP Security Comparison

| Security Area | AWS | GCP |
|---|---|---|
| IAM | IAM users, roles, policies | IAM roles and service accounts |
| Secrets | AWS Secrets Manager / SSM Parameter Store | Secret Manager |
| Logging | CloudTrail / CloudWatch | Cloud Audit Logs / Cloud Logging |
| Container Registry | ECR | Artifact Registry |
| Network Controls | Security Groups / NACLs | VPC Firewall Rules |
| Monitoring | CloudWatch | Cloud Monitoring |
| Security Posture | Security Hub / Inspector | Security Command Center |

---

Detailed AWS vs GCP comparison is available here:

- [AWS vs GCP Security Comparison](./evidence/aws-vs-gcp-security-comparison.md)

## Evidence Checklist

- [ ] AWS secure deployment architecture documented
- [ ] AWS security controls documented
- [ ] Trivy container scan evidence added
- [ ] OWASP ZAP DAST evidence referenced
- [ ] GCP secure deployment plan documented
- [ ] AWS vs GCP comparison added
- [ ] Final screenshots or command outputs added
- [ ] Pull request created and merged

---

Final Week 9 checklist is available here:

- [Week 9 Final Evidence Checklist](./evidence/week-9-final-evidence-checklist.md)

## Summary

Week 9 demonstrates the ability to think beyond a single-cloud deployment and document security controls across AWS and GCP.

The project shows practical DevSecOps thinking across secure deployment, monitoring, cloud security controls, container security, and multi-cloud comparison.
