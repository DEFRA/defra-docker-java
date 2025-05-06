package trivy.ignore

default ignore = false

# Ignore LOW severity Ubuntu OS packages like coreutils
ignore {
  input.Type == "os"
  input.Vulnerability.Severity == "LOW"
  input.Vulnerability.PkgName == "coreutils"
}