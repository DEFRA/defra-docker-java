package trivy

import data.lib.trivy

default ignore = false

ignore {
  input.Type == "os"
  input.Vulnerability.Severity == "LOW"
  input.Vulnerability.PkgName == "coreutils"
}