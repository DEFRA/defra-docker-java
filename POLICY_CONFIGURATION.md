# Anchore Grype configuration and ignored vulnerabilities
Anchore Grype is configured to report vulnerabilities that are of medium severity or higher.  Please see the official Anchore Grype documentation on [policy](https://docs.anchore.com/current/docs/engine/general/concepts/policy/) and [policy checks](https://docs.anchore.com/current/docs/overview/concepts/policy/policy_checks/) for details of the syntax.

## Known issues
The following issues have been added to the policies exclusion list

| CVE Report    |Type      | Component | Reason       | Date |
| ------------- | -------  |----------| ------------- | -----------------  |
|[CVE-2021-31879](https://nvd.nist.gov/vuln/detail/CVE-2021-31879)| Ubuntu | [wget](https://ubuntu.com/security/CVE-2021-31879) |  No upstream fix as of 2022-01-05. Deemed acceptable risk until resolved upstream. | Updated 2022/11/21 |
|[CVE-2022-37434](https://nvd.nist.gov/vuln/detail/CVE-2022-37434)| Ubuntu | [zlib1g](https://ubuntu.com/security/CVE-2022-37434) |  Ubuntu 22.04 confirmed not vulnerable | Updated 2022/11/21 |
|[CVE-2022-42800](https://nvd.nist.gov/vuln/detail/CVE-2022-42800)| Ubuntu | [zlib1g](https://ubuntu.com/security/CVE-2022-42800) |  Ubuntu confirmed not vulnerable | Updated 2022/11/21 |
|[CVE-2022-3715](https://nvd.nist.gov/vuln/detail/CVE-2022-3715)| Ubuntu | [bash](https://ubuntu.com/security/CVE-2022-3715) |  No details available. | Updated 2022/11/21 |
|[CVE-2022-3821](https://nvd.nist.gov/vuln/detail/CVE-2022-3821)| Ubuntu | [systemd](https://ubuntu.com/security/CVE-2022-3821) |  No fix available as of. Do not believe services vulnerable. | Updated 2022/11/21 |
|[CVE-2022-43551](https://nvd.nist.gov/vuln/detail/CVE-2022-43551)| Ubuntu | [curl](https://ubuntu.com/security/CVE-2022-43551) |  No fix available as of. Do not believe services vulnerable. | Updated 2023/01/03 |
|[CVE-2022-43552](https://nvd.nist.gov/vuln/detail/CVE-2022-43552)| Ubuntu | [curl](https://ubuntu.com/security/CVE-2022-43552) |  No fix available as of. Do not believe services vulnerable. | Updated 2023/01/03 |
