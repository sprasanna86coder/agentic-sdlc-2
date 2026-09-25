---
description: >
  Triages new and reopened issues by assessing completeness, applying bounded
  labels, finding duplicates, and posting a concise report.

on:
  issues:
    types: [opened, reopened]
  reaction: eyes
  roles: all

if: >-
  (
    github.actor == github.repository_owner ||
    github.actor == vars.WORKSHOP_OPERATOR
  ) &&
  contains(
    github.event.issue.labels.*.name,
    'workshop-fixture'
  ) == false

permissions:
  contents: read
  issues: read
  copilot-requests: none

engine:
  id: copilot
  model: auto

max-turns: 12
max-ai-credits: 25
max-daily-ai-credits: 75

safe-outputs:
  add-labels:
    allowed:
      - bug
      - feature
      - question
      # TODO 1: Add the labels needed for incomplete issues, duplicates,
      # invalid submissions, spam, priorities p0 through p2, and the three
      # suggested-team routing options.
      # Do not allow `routing/approved`; only a human reviewer may apply it.
    max: 4
  add-comment:
    max: 1

timeout-minutes: 8
---

# Issue Triage Assistant

Analyze issue #${{ github.event.issue.number }} and help maintainers understand
and route it quickly. Base every conclusion on the issue, its discussion, and
repository context. Do not invent missing details.

## 1. Gather context

1. Read the issue and its comments.
2. Inspect the repository's available labels.
3. Search issues for the same symptoms, request, error message, component, or
   expected behavior. Stop after finding two useful candidates.
4. Consult repository documentation only when the issue directly depends on
   documented behavior or contribution requirements.

## 2. Assess completeness

<!-- TODO 2A:
Define the evidence required for a bug and for a feature or task.
Define what the workflow should do when essential information is missing.
-->

If the issue is clearly spam, gibberish, or a test submission, apply `spam` or
`invalid` when available, explain the assessment briefly, and stop.

## 3. Classify and prioritize

Choose only labels that already exist and are directly supported by evidence.
Apply at most one type label, one priority label, one status label such as
`needs-info` or `duplicate`, and one suggested-team label.

<!-- TODO 2B:
Define priority/p0, priority/p1, and priority/p2 for this repository.
Include a rule that prefers leaving priority unset over guessing.
Define when to recommend each suggested-team label:
- suggested-team/workflows
- suggested-team/developer-experience
- suggested-team/support-triage
-->

## 4. Find duplicates and related issues

- A **duplicate** describes the same problem or request with strong supporting
  evidence. Apply `duplicate` and cite the issue number.
- A **related issue** shares a component or context but is a distinct problem.
  Mention it without applying `duplicate`.

Include no more than two useful matches. Never classify an issue as a
duplicate based only on similar title words.

## 5. Recommend routing

Recommend at most one suggested team when the evidence supports it. Never create
a real GitHub mention. Represent the simulated team tag in inline code, such as
`@example/workflows`.

The agent must never apply `routing/approved`. That label represents a human
maintainer's approval after reviewing the evidence and proposed route.

## 6. Assess next steps

Suggest one focused next step when the evidence supports it.

## 7. Report

<!-- TODO 3:
Define a concise maintainer-facing report containing:
- a 1–2 sentence summary
- type and priority with brief evidence
- a suggested-team label and simulated inline-code team tag
- approval status set to "Pending maintainer review"
- up to two similar issues when useful
- one focused next step

For an incomplete issue, replace speculative classification with focused
clarifying questions while retaining the routing recommendation and approval
status when supported. Keep the entire comment under 300 words.
-->
