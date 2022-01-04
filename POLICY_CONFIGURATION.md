# Anchore Grype configuration and ignored vulnerabilities
Anchore Grype is configured to report vulnerabilities that are of medium severity or higher.  Please see the official Anchore Grype documentation on [policy](https://docs.anchore.com/current/docs/engine/general/concepts/policy/) and [policy checks](https://docs.anchore.com/current/docs/overview/concepts/policy/policy_checks/) for details of the syntax.

## Known issues
The following issues have been added to the policies exclusion list

| CVE Report    |Type      | Component | Reason       | Date |
| ------------- | -------  |----------| ------------- | -----------------  |
|[CVE-2021-33574](https://nvd.nist.gov/vuln/detail/CVE-2021-33574)| Debian | [glibc](https://security-tracker.debian.org/tracker/CVE-2021-33574) | Debian marked "wont-fix". Not expected for backport. Understand [high attack complexity & small impact](https://sourceware.org/bugzilla/show_bug.cgi?id=27896#c4)| Updated 23/12/2021 |
|[CVE-2021-33560](https://nvd.nist.gov/vuln/detail/CVE-2021-33560)| Debian | [libgcrypt20](https://security-tracker.debian.org/tracker/CVE-2021-33560) | Debian marked "wont-fix". Do not believe any projects use affected functionality. | Updated 23/12/2021 |
|[CVE-2011-3389](https://nvd.nist.gov/vuln/detail/CVE-2011-3389)| Debian | [gnutls28](https://security-tracker.debian.org/tracker/CVE-2011-3389) | "No mitigation for gnutls, it is recommended to use TLS 1.1 or 1.2 which is supported since 2.0.0". 1.0 should not be in use by servers our software connects to. | Updated 23/12/2021 |
|[CVE-2020-16156](https://nvd.nist.gov/vuln/detail/CVE-2020-16156)| Debian | [perl](https://security-tracker.debian.org/tracker/CVE-2020-16156) | Debian marked "wont-fix". Not used at runtime in any services. | Updated 23/12/2021 |
