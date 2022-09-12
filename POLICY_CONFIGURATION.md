# Anchore Grype configuration and ignored vulnerabilities
Anchore Grype is configured to report vulnerabilities that are of medium severity or higher.  Please see the official Anchore Grype documentation on [policy](https://docs.anchore.com/current/docs/engine/general/concepts/policy/) and [policy checks](https://docs.anchore.com/current/docs/overview/concepts/policy/policy_checks/) for details of the syntax.

## Known issues
The following issues have been added to the policies exclusion list

| CVE Report    |Type      | Component | Reason       | Date |
| ------------- | -------  |----------| ------------- | -----------------  |
|[CVE-2020-16156](https://nvd.nist.gov/vuln/detail/CVE-2020-16156)| Ubuntu | [perl](https://ubuntu.com/security/CVE-2020-16156) |  CPAN 2.28 allows Signature Verification Bypass. Deemed acceptable risk until resolved upstream. | Updated 2022/09/12 |
|[CVE-2021-31879](https://nvd.nist.gov/vuln/detail/CVE-2021-31879)| Ubuntu | [wget](https://ubuntu.com/security/CVE-2021-31879) |  No upstream fix as of 2022-01-05. Deemed acceptable risk until resolved upstream. | Updated 2022/09/12 |
|[CVE-2022-37434](https://nvd.nist.gov/vuln/detail/CVE-2022-37434)| Ubuntu | [zlib1g](https://ubuntu.com/security/CVE-2022-37434) |  Ubuntu 22.04 not vulnerale 2022/09/12 |
