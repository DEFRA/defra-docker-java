#!/bin/bash

fixable=${{ steps.summary.outputs.fixable_count }}
total=${{ steps.summary.outputs.total }}

number=$(gh issue list --label "$LABEL" --state all --limit 1 --json number --jq '.[0].number // empty')
state=""
if [ -n "$number" ]; then
    state=$(gh issue view "$number" --json state --jq '.state')
fi

# Nothing to report: close the issue if one is open, otherwise do nothing.
if [ "$total" -eq 0 ]; then
    if [ -n "$number" ] && [ "$state" = "OPEN" ]; then
        gh issue edit "$number" --body-file body.md
        gh issue close "$number" --reason completed || true
    fi
    echo "No medium+ findings."
    exit 0
fi

if [ -z "$number" ]; then
    url=$(gh issue create --title "$TITLE" --label "$LABEL" --body-file body.md)
    number=${url##*/}
    state="OPEN"
else
    gh issue edit "$number" --body-file body.md
fi

# Notify only when newly actionable, so an already-open issue updates silently.
if [ "$fixable" -gt 0 ] && [ "$state" != "OPEN" ]; then
    gh issue reopen "$number" || true
    if [ -n "$REVIEW_TEAM" ]; then
        gh issue comment "$number" --body "Fixable vulnerabilities detected in the published images. cc @${REVIEW_TEAM}"
    fi
fi