#!/bin/bash

set -x
for d in artifacts/grype-java-*; do
    build=$(echo $d | sed 's/artifacts\/grype\-//g')
    for f in artifacts/grype-java-*/output; do
        [ -e "$f" ] || continue
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
            ((.artifact.locations // []) | map(.path) | join(",")) 
        ] | @tsv
        ' "$f" >> findings.tsv || true
    done
done

for d in artifacts/trivy-java-*; do
    build=$(echo $d | sed 's/artifacts\/trivy\-//g')
    for f in artifacts/trivy-java-*/*.json; do
        [ -e "$f" ] || continue
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
            (($result.Target // "") + "," + (.PkgPath // "")) 
        ] | @tsv
        ' "$f" >> findings.tsv || true
    done
done

total=$(cat findings.tsv | wc -l)
fixable_count=$(cat findings.tsv | grep FIX_AVAILABLE | wc -l)
builds=$(cat findings.tsv | awk -F'\t' '{print $1}' | sort -u)

render_output() {
    file="findings.tsv"
    if [ -s "$file" ]; then              
        for build in $builds; do
        build_total=$(cat $file | grep $build | wc -l)
        build_critical=$(cat $file | grep $build | grep CRITICAL | wc -l)
        build_high=$(cat $file | grep $build | grep HIGH | wc -l)
        build_medium=$(cat $file | grep $build | grep MEDIUM | wc -l)
        build_fix_available=$(cat $file | grep $build | grep FIX_AVAILABLE | wc -l)
        build_fix_not_available=$(cat $file | grep $build | grep FIX_NOT_AVAILABLE | wc -l)
        grype_id=$(gh api repos/${GITHUB_REPOSITORY}/actions/runs/${GITHUB_RUN_ID}/artifacts | jq --arg BUILD "grype-${build}" '.artifacts[]|select(.name == $BUILD).id')
        trivy_id=$(gh api repos/${GITHUB_REPOSITORY}/actions/runs/${GITHUB_RUN_ID}/artifacts | jq --arg BUILD "trivy-${build}" '.artifacts[]|select(.name == $BUILD).id')
        grype_url="${GITHUB_SERVER_URL}/${GITHUB_REPOSITORY}/actions/runs/${GITHUB_RUN_ID}/artifacts/${grype_id}"
        trivy_url="${GITHUB_SERVER_URL}/${GITHUB_REPOSITORY}/actions/runs/${GITHUB_RUN_ID}/artifacts/${trivy_id}"
        echo "### $build"
        echo "[$grype_url](${grype_url})"
        echo "[$trivy_url](${trivy_url})"
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
    echo "There are $total vulnerabilities accross $(echo $builds | wc -l) images."
    echo
    render_output
    echo
} > body.md

echo "fixable_count=$fixable_count" >> $GITHUB_OUTPUT
echo "total=$total" >> $GITHUB_OUTPUT