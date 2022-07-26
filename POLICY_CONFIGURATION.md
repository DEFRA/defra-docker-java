# Anchore Grype configuration and ignored vulnerabilities
Anchore Grype is configured to report vulnerabilities that are of medium severity or higher.  Please see the official Anchore Grype documentation on [policy](https://docs.anchore.com/current/docs/engine/general/concepts/policy/) and [policy checks](https://docs.anchore.com/current/docs/overview/concepts/policy/policy_checks/) for details of the syntax.

## Known issues
The following issues have been added to the policies exclusion list

| CVE Report    |Type      | Component | Reason       | Date |
| ------------- | -------  |----------| ------------- | -----------------  |
|[CVE-2021-33560](https://nvd.nist.gov/vuln/detail/CVE-2021-33560)| Debian | [libgcrypt20](https://security-tracker.debian.org/tracker/CVE-2021-33560) | Debian marked "wont-fix". Do not believe any projects use affected functionality. | Updated 20/07/2022 |
|[CVE-2011-3389](https://nvd.nist.gov/vuln/detail/CVE-2011-3389)| Debian | [gnutls28](https://security-tracker.debian.org/tracker/CVE-2011-3389) | "No mitigation for gnutls, it is recommended to use TLS 1.1 or 1.2 which is supported since 2.0.0". 1.0 should not be in use by servers our software connects to. | Updated 20/07/2022 |
|[CVE-2020-16156](https://nvd.nist.gov/vuln/detail/CVE-2020-16156)| Debian | [perl](https://security-tracker.debian.org/tracker/CVE-2020-16156) | Debian marked "wont-fix". Not used at runtime in any services. | Updated 20/07/2022 |
|[CVE-2019-8457](https://nvd.nist.gov/vuln/detail/CVE-2019-8457)| Debian | [sqlite3](https://security-tracker.debian.org/tracker/CVE-2019-8457) | Debian marked "wont-fix". "Affected function is not used in Debian and meant for debugging purposes, backporting the fix would be very complex." | Updated 20/07/2022 |
|[CVE-2022-1304](https://nvd.nist.gov/vuln/detail/CVE-2022-1304)| Debian | [e2fsprogs](https://security-tracker.debian.org/tracker/CVE-2022-1304) | Debian marked "wont-fix". Requires "specially crafted filesystem" to be mounted by attacker. | Updated 20/07/2022 |
|[CVE-2022-29458](https://nvd.nist.gov/vuln/detail/CVE-2022-29458)| Debian | [ncurses](https://security-tracker.debian.org/tracker/CVE-2022-1304) | Debian marked "wont-fix". | Updated 20/07/2022 |
|[CVE-2022-1586](https://nvd.nist.gov/vuln/detail/CVE-2022-1586)| Debian | [pcre2](https://security-tracker.debian.org/tracker/CVE-2022-1586) | Debian marked "wont-fix". | Updated 20/07/2022 |
|[CVE-2022-1587](https://nvd.nist.gov/vuln/detail/CVE-2022-1587)| Debian | [pcre2](https://security-tracker.debian.org/tracker/CVE-2022-1587) | Debian marked "wont-fix". | Updated 20/07/2022 |
|[CVE-2022-2097](https://nvd.nist.gov/vuln/detail/CVE-2022-2097)| Debian | [openssl](https://security-tracker.debian.org/tracker/CVE-2022-2097) | "Since OpenSSL does not support OCB based cipher suites for TLS and DTLS, they are both unaffected.", "Minor issue, fix along in next round of security updates" | Updated 20/07/2022 |
