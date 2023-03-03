# Anchore Grype configuration and ignored vulnerabilities
Anchore Grype is configured to report vulnerabilities that are of medium severity or higher with a fix available.  Please see the official Anchore Grype documentation on [policy](https://docs.anchore.com/current/docs/engine/general/concepts/policy/) and [policy checks](https://docs.anchore.com/current/docs/overview/concepts/policy/policy_checks/) for details of the syntax.

The report is output in SARIF format and uploaded to GitHub where it is published in the Security "Code Scanning" section: https://github.com/DEFRA/defra-docker-java/security/code-scanning

Because the `--only-fixed` parameter is used, vulnerabilities with no upstream fix will not fail the build/nightly scan action. All results will still be published to GitHub.

## Known issues
Any issues with fixes that we have not yet remediated will be added and detailed here:

| CVE Report    |Type      | Component | Reason       | Date |
| ------------- | -------  |----------| ------------- | -----------------  |
