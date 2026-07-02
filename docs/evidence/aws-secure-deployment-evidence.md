# AWS Secure Deployment Evidence

## Objective

This document explains how the Flask DevSecOps starter application can be deployed securely on AWS with clear security controls, monitoring, and deployment evidence.

---

## Target Deployment Model

The application is deployed as a containerized Flask application.

Recommended AWS components:

- EC2 instance or container host
- VPC
- Public subnet for controlled inbound access
- Security Group with restricted inbound rules
- IAM role using least privilege
- CloudTrail for API activity logging
- CloudWatch for monitoring
- Optional ECR for container image storage

---

## Security Controls Applied

| Area | AWS Control | Purpose |
|---|---|---|
| Network Security | Security Group | Restrict inbound traffic to required ports only |
| Identity & Access | IAM Role | Avoid long-lived access keys |
| Logging | CloudTrail | Track AWS API activity |
| Monitoring | CloudWatch | Monitor application and infrastructure behavior |
| Secrets | Secrets Manager / SSM Parameter Store | Keep secrets outside code and container images |
| Container Security | Trivy | Scan Docker image before deployment |
| App Security | OWASP ZAP | Run DAST scan against the running app |
| Patch Management | Updated base image | Reduce known package vulnerabilities |

---

## Secure Deployment Checklist

- [ ] No secrets stored in source code
- [ ] No secrets stored inside Docker image
- [ ] Docker image scanned before deployment
- [ ] Application runs with restricted container permissions
- [ ] Inbound traffic limited using Security Groups
- [ ] IAM access follows least privilege
- [ ] CloudTrail enabled for account activity logging
- [ ] CloudWatch used for operational monitoring
- [ ] DAST scan performed after deployment
- [ ] Security evidence documented

---

## Evidence Notes

The deployment is designed to follow secure-by-default principles:

1. Build the Docker image locally or in CI.
2. Scan the image using Trivy.
3. Push the image to a trusted registry if required.
4. Deploy to an AWS runtime environment.
5. Restrict inbound access using Security Groups.
6. Monitor logs and activity using CloudWatch and CloudTrail.
7. Run OWASP ZAP against the deployed endpoint.
8. Document scan results and remediation actions.

---

## Risk Considerations

| Risk | Mitigation |
|---|---|
| Public exposure | Restrict Security Group inbound rules |
| Secret leakage | Use secret manager and repository scanning |
| Vulnerable image packages | Run Trivy before deployment |
| Application vulnerabilities | Run OWASP ZAP DAST scan |
| Excessive AWS permissions | Use IAM least privilege |
| Weak visibility | Enable CloudTrail and CloudWatch |

---

## Summary

This AWS deployment evidence demonstrates secure deployment thinking across networking, IAM, logging, monitoring, secrets management, container security, and application security testing.
