package trivy.ignore

default ignore = false

# Return true if the vulnerability should be ignored
ignore {
  input.Type == "os"
  input.Vulnerability.Severity == "LOW"
  input.Vulnerability.PkgName == "coreutils"
}