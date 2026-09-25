## Title

Workflow compiler rejects an issue trigger after upgrading the extension

## Body

### Description

`gh aw compile` fails for a workflow that compiled successfully before upgrading
the extension.

### Reproduction steps

1. Install `gh-aw` version 0.88.7.
2. Add an `issues` trigger with `opened` and `reopened` event types.
3. Run `gh aw compile`.

### Expected behavior

The Markdown workflow compiles and creates the `.lock.yml` file.

### Actual behavior

Compilation exits with status 1.

### Environment

- macOS 15.6
- GitHub CLI 2.98.0
- `gh-aw` 0.88.7

### Error

`schema validation failed: unexpected property under on.issues`

