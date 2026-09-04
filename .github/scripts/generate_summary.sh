#!/bin/bash

for dir in artifacts/grype-java-*; do
    build=$(echo $dir | sed 's/artifacts\/grype\-//g')
    file="artifacts/grype-${build}/output"
    echo "Summarising ${file}..."
    [ -e "$file" ] || continue
    jq --arg build "$build" -r '
    (.matches // [])[] |
    [ 
        ($build),
        (.vulnerability.severity // "Unknown" | ascii_upcase),
        (.vulnerability.id // ""),
        (.artifact.name // ""),
        (.artifact.version // ""),
        (if (.vulnerability.fix.state // "") == "fixed" then "FIX_AVAILABLE" else "FIX_NOT_AVAILABLE" end),
        ((.vulnerability.fix.versions // []) | join(",")),
        ((.artifact.locations // []) | map(.path) | join(",")),
        ("grype")
    ] | @tsv
    ' "$file" >> summary.tsv || true
done

for dir in artifacts/trivy-java-*; do
    build=$(echo $dir | sed 's/artifacts\/trivy\-//g')
    file="artifacts/trivy-${build}/trivy-${build}.json"
    echo "Summarising ${file}..."
    [ -e "$file" ] || continue
    jq --arg build "$build" -r '
    (.Results // [])[] | . as $result | ($result.Vulnerabilities // [])[] |
    [ 
        ($build),
        (.Severity // "UNKNOWN" | ascii_upcase),
        (.VulnerabilityID // ""),
        (.PkgName // ""),
        (.InstalledVersion // ""),
        (if (.FixedVersion // "") != "" then "FIX_AVAILABLE" else "FIX_NOT_AVAILABLE" end),
        (.FixedVersion // ""),
        (($result.Target // "") + "," + (.PkgPath // "")),
        ("trivy")
    ] | @tsv
    ' "$file" >> summary.tsv || true
done

total=$(cat summary.tsv | wc -l)
fixable_count=$(cat summary.tsv | grep FIX_AVAILABLE | wc -l)
builds=$(cat summary.tsv | awk -F'\t' '{print $1}' | sort -u)

tr '\t' ',' < summary.tsv > summary.csv

render_output() {
    file="summary.tsv"
    if [ -s "$file" ]; then
        for build in $builds; do
            build_total=$(grep $build $file | wc -l)
            build_critical=$(grep $build $file | grep CRITICAL | wc -l)
            build_high=$(grep $build $file | grep HIGH | wc -l)
            build_medium=$(grep $build $file | grep MEDIUM | wc -l)
            build_fix_available=$(grep $build $file | grep FIX_AVAILABLE | wc -l)
            build_fix_not_available=$(grep $build $file | grep FIX_NOT_AVAILABLE | wc -l)
            grype_id=$(gh api repos/${GITHUB_REPOSITORY}/actions/runs/${GITHUB_RUN_ID}/artifacts | jq --arg BUILD "grype-${build}" '.artifacts[]|select(.name == $BUILD).id')
            trivy_id=$(gh api repos/${GITHUB_REPOSITORY}/actions/runs/${GITHUB_RUN_ID}/artifacts | jq --arg BUILD "trivy-${build}" '.artifacts[]|select(.name == $BUILD).id')
            grype_url="${GITHUB_SERVER_URL}/${GITHUB_REPOSITORY}/actions/runs/${GITHUB_RUN_ID}/artifacts/${grype_id}"
            trivy_url="${GITHUB_SERVER_URL}/${GITHUB_REPOSITORY}/actions/runs/${GITHUB_RUN_ID}/artifacts/${trivy_id}"
            echo "### $build"
            echo "[Download Grype report for $build](${grype_url})"
            echo "[Download Trivy report for $build](${trivy_url})"
            echo "| Total | Critical | High | Medium | Fix Available | No Fix Available |"
            echo "|---|---|---|---|---|---|"
            echo "|$build_total|$build_critical|$build_high|$build_medium|$build_fix_available|$build_fix_not_available|"
            echo
        done
    else
        echo "_None._"
    fi
}

{
    echo "_Updated $(date -u '+%Y-%m-%d %H:%M UTC') from the nightly scan of the published images._"
    echo "A total of $total vulnerabilities have been detected by trivy and grype on $(wc -w <<< "$builds") images."
    echo
    render_output
    echo
} > body.md

echo "fixable_count=$fixable_count" >> $GITHUB_OUTPUT
echo "total=$total" >> $GITHUB_OUTPUT