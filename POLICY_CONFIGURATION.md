# Anchore Grype configuration and ignored vulnerabilities
Anchore Grype is configured to report vulnerabilities that are of medium severity or higher.  Please see the official Anchore Grype documentation on [policy](https://docs.anchore.com/current/docs/engine/general/concepts/policy/) and [policy checks](https://docs.anchore.com/current/docs/overview/concepts/policy/policy_checks/) for details of the syntax.

## Known issues
The following issues have been added to the policies exclusion list

| CVE Report    |Type      | Component | Reason       | Date |
| ------------- | -------  |----------| ------------- | -----------------  |
| [CVE-2014-4199 (NIST)](https://nvd.nist.gov/vuln/detail/CVE-2014-4199) | Java | [tools.jar](https://github.com/zkat/ssri) | False positive - VMWare Workstation vulnerability. See e.g. [other reports](https://stackoverflow.com/questions/54325965/vulnerabilities-on-spring-boot-loader) | 2021/07/23 |
| [CVE-2014-4200 (NIST)](https://nvd.nist.gov/vuln/detail/CVE-2014-4200) | Java | [tools.jar](https://github.com/zkat/ssri) | False positive - VMWare Workstation vulnerability. See e.g. [other reports](https://stackoverflow.com/questions/54325965/vulnerabilities-on-spring-boot-loader) | 2021/07/23 |
| [CVE-2011-3389 (Debian)](https://security-tracker.debian.org/tracker/CVE-2011-3389)  | dpkg | [hosted-git-info](https://github.com/npm/hosted-git-info) | BEAST attack. Unclear if package actually vulnerable. TLS 1.1, 1.2 & 1.3 connections via libgnutls are not affected. 1.0 should not be in use by servers our software connects to. | 2021/07/23 |
