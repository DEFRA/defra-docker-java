# Anchore Grype configuration and ignored vulnerabilities
Anchore Grype is configured to report vulnerabilities that are of medium severity or higher.  Please see the official Anchore Grype documentation on [policy](https://docs.anchore.com/current/docs/engine/general/concepts/policy/) and [policy checks](https://docs.anchore.com/current/docs/overview/concepts/policy/policy_checks/) for details of the syntax.

## Known issues
The following issues have been added to the policies exclusion list

| CVE Report    |Type      | Component | Reason       | Date |
| ------------- | -------  |----------| ------------- | -----------------  |
|[CVE-2021-31879](https://nvd.nist.gov/vuln/detail/CVE-2021-31879)| Ubuntu | [wget](https://ubuntu.com/security/CVE-2021-31879) |  No upstream fix as of 2022-11-24. Deemed acceptable risk until resolved upstream. | Updated 2023/01/17 |
|[CVE-2022-3821](https://nvd.nist.gov/vuln/detail/CVE-2022-3821)| Ubuntu | [systemd](https://ubuntu.com/security/CVE-2022-3821) |  No fix available as of. Do not believe services vulnerable. | Updated 2023/01/17 |
|[CVE-2022-42898](https://nvd.nist.gov/vuln/detail/CVE-2022-42898)| Ubuntu | [krb5](https://ubuntu.com/security/CVE-2022-42898) |  RCE only affects 32-bit systems - we run purely 64-bit. Do not believe server software in use in portfolio. | Updated 2023/01/17 |