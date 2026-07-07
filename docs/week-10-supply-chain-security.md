# Week 10: Software Supply Chain Security

## Objective

Week 10 focuses on software supply chain security for the **Secure DevSecOps Starter** project.

The goal is to move beyond standard source code and container image scanning by generating a Software Bill of Materials (SBOM), scanning that SBOM for known vulnerabilities, and documenting a safe container image signing approach using Cosign.

---

## Scope

This week covers:

- Docker image build
- SBOM generation using Syft
- SBOM vulnerability scanning using Grype
- Vulnerability triage based on SBOM scan results
- Cosign image signing concept and safe implementation plan
- GitHub Actions automation plan
- Evidence collection under `docs/evidence/week-10/`

---

## Why SBOM Matters

An SBOM, or Software Bill of Materials, is an inventory of the software components inside an application or container image.

For a container image, an SBOM helps identify:

- OS packages
- Python packages
- Runtime components
- Package versions
- Package types
- Component metadata

This is useful because security teams need to know what exists inside an image before they can assess risk.

If a new vulnerability is published later, the SBOM can help answer:

```text
Does this image contain the affected package?
Which version is installed?
Is remediation required?
```

---

## Tools Used

| Tool | Purpose |
|---|---|
| Docker | Build the application container image |
| Syft | Generate the SBOM from the Docker image |
| Grype | Scan the generated SBOM for known vulnerabilities |
| Cosign | Document image signing and artifact integrity approach |
| GitHub Actions | Automate evidence generation and report upload |

---

## Supply Chain Workflow

The Week 10 workflow follows this sequence:

```text
Source Code
    |
    v
Docker Image Build
    |
    v
SBOM Generation with Syft
    |
    v
SBOM Vulnerability Scan with Grype
    |
    v
Evidence Reports
    |
    v
Image Signing Strategy with Cosign
```

This helps document not only whether the code is secure, but also what is inside the final container image and how that image can be verified before deployment.

---

## Docker Image Build

The image was built locally for Week 10:

```bash
docker build -t secure-devsecops-starter:week10 .
```

The image was then exported as a local Docker archive for analysis:

```bash
docker save secure-devsecops-starter:week10 -o docs/evidence/week-10/reports/secure-devsecops-starter-week10.tar
```

The Docker archive was used only as a local scan source and was excluded from Git tracking because it is large and not required as repository evidence.

---

## SBOM Generation with Syft

Syft was used to generate two SBOM outputs:

```text
docs/evidence/week-10/reports/sbom-syft.json
docs/evidence/week-10/reports/sbom-syft-table.txt
```

The JSON output is useful for automation and tool-based analysis.

The table output is useful for manual review and portfolio evidence.

### Syft JSON Output

The JSON SBOM includes structured package metadata such as:

- Package name
- Package version
- Package type
- Package location
- Package metadata
- Relationships between components

This format is useful for automation, CI/CD processing, and later vulnerability analysis.

### Syft Table Output

The table output is a human-readable inventory of detected packages.

It helps quickly review which components are inside the image without manually inspecting the JSON file.

---

## SBOM Vulnerability Scanning with Grype

Grype was used to scan the Syft-generated SBOM.

Generated reports:

```text
docs/evidence/week-10/reports/grype-sbom-report.txt
docs/evidence/week-10/reports/grype-sbom-report.json
```

The scan identified vulnerabilities from the generated SBOM, mainly related to:

- Python runtime components
- Debian base image packages
- OS-level packages such as `libc`, `perl-base`, `ncurses`, `gzip`, `tar`, and related dependencies

Several findings had no direct fixed version available or were marked as `won't fix`.

This shows why SBOM visibility is useful: even if application code and Python dependencies look clean, the base image and runtime layer can still introduce risk.

---

## Grype Report Columns

The Grype table report uses the following columns:

| Column | Meaning |
|---|---|
| `NAME` | Affected package name |
| `INSTALLED` | Installed package version |
| `FIXED IN` | Version containing a fix, if available |
| `TYPE` | Package type, such as `deb`, `python`, or `binary` |
| `VULNERABILITY` | CVE or advisory ID |
| `SEVERITY` | Vulnerability severity |
| `EPSS` | Exploit prediction score |
| `RISK` | Grype risk score |

---

## Findings Summary

The Grype report included multiple severities:

```text
Critical
High
Medium
Low
Negligible
Unknown
```

Example affected package types:

```text
binary
deb
python
```

Important observation:

```text
Most findings were related to base image and runtime packages, not the Flask application code itself.
```

This confirms that supply chain security must review the full container image, not only direct application dependencies.

---

## Triage Notes

The findings should not all be handled the same way.

Triage approach:

| Finding Type | Action |
|---|---|
| Fix available | Upgrade the affected package or base image |
| No fix available | Document risk and monitor upstream |
| Base image issue | Review base image choice |
| Runtime issue | Consider newer runtime image |
| Low or negligible severity | Track but do not prioritize immediately |
| Unknown severity | Review manually before ignoring |
| Repeated package family findings | Investigate whether they come from shared base image components |

---

## Remediation Options

Possible future remediation actions:

- Upgrade `pip` inside the Docker image
- Rebuild with a newer Python base image
- Test a slim or more minimal base image
- Compare Debian-based image results with distroless or minimal images
- Add Grype threshold enforcement after triage is stable
- Track SBOM and vulnerability reports as CI artifacts
- Review base image update cadence
- Rebuild images regularly to pick up upstream fixes

---

## Evidence Mode vs Blocking Gate

For Week 10, the recommended initial mode is:

```text
Evidence mode
```

This means the workflow should generate SBOM and vulnerability reports first, without immediately failing the pipeline for every finding.

Reason:

- The initial scan may include many base image findings.
- Some findings may have no available fix.
- Some findings may be low, negligible, or unknown severity.
- A clear triage process should happen before enforcing blocking gates.

After findings are understood and remediation strategy is stable, Grype can be converted into a blocking security gate.

A future blocking rule could be:

```text
Fail the workflow if Grype finds Critical vulnerabilities with an available fix.
```

---

## Cosign Image Signing

Cosign is used to sign container images and verify artifact integrity.

For this project, Cosign is documented as part of the supply chain security plan.

The goal of signing is to prove:

```text
This image was built by a trusted workflow.
This image has not been replaced or modified unexpectedly.
This image can be verified before deployment.
```

A safe production approach would use keyless signing through GitHub Actions OIDC instead of committing private signing keys to the repository.

Private signing keys should never be committed to Git.

---

## Safe Cosign Implementation Plan

Recommended future approach:

```text
GitHub Actions OIDC
    |
    v
Cosign keyless signing
    |
    v
Signed container image
    |
    v
Signature verification before deployment
```

This avoids storing private keys in the repository or GitHub secrets.

A safe implementation should include:

- No private signing keys committed to the repository
- OIDC-based identity where possible
- Signature verification before deployment
- Documentation of signing identity and verification result
- Signed image stored in a trusted registry such as GHCR or Artifact Registry

---

## GitHub Actions Automation Plan

A dedicated GitHub Actions workflow can automate the Week 10 process:

```text
Checkout repository
Build Docker image
Generate SBOM with Syft
Scan SBOM with Grype
Upload SBOM and scan reports as artifacts
Write supply chain security summary
```

Recommended workflow name:

```text
Supply Chain Security
```

Recommended workflow file:

```text
.github/workflows/supply-chain-security.yml
```

Recommended initial behavior:

```text
Generate evidence first.
Do not block the pipeline until findings are reviewed.
```

---

## Evidence Files

Expected evidence files:

```text
docs/evidence/week-10/reports/sbom-syft.json
docs/evidence/week-10/reports/sbom-syft-table.txt
docs/evidence/week-10/reports/grype-sbom-report.txt
docs/evidence/week-10/reports/grype-sbom-report.json
```

Excluded local file:

```text
docs/evidence/week-10/reports/secure-devsecops-starter-week10.tar
```

The `.tar` file is excluded because it is a local Docker image archive and should not be committed.

---

## Security Lessons

Key lessons from Week 10:

- SBOMs provide visibility into what exists inside a container image.
- Vulnerability scanning should not only depend on direct application dependencies.
- Base images and runtime layers can introduce significant risk.
- Scanner configuration and scan source affect the final findings.
- Some vulnerabilities may have no direct fix and require documented risk acceptance or base image strategy changes.
- Image signing should be designed without committing private keys to source control.
- Supply chain security requires both inventory visibility and artifact integrity.

---

## Final Summary

Week 10 added software supply chain security evidence to the project.

The project now includes:

- SBOM generation
- SBOM-based vulnerability scanning
- Vulnerability triage documentation
- Image signing strategy documentation
- Supply chain security evidence

This complements the previous DevSecOps layers:

```text
SAST
SCA
Secret scanning
Container scanning
DAST
Cloud deployment evidence
Supply chain security
```

The next improvement is to automate this process through GitHub Actions and later convert selected Grype findings into controlled blocking gates.
