## Title

GitHub CLI forgets authentication after browser login

## Body

### Description

The browser says my GitHub CLI authorization completed, but the next command
starts the authentication flow again.

### Reproduction steps

1. Run `gh auth login`.
2. Complete browser authorization.
3. Run `gh auth status`.

### Expected behavior

The authenticated session is retained.

### Actual behavior

No account is available to the CLI.

### Environment

- macOS 15.6
- GitHub CLI 2.98.0
- Corporate proxy

### Error

`failed to write token to keyring: user interaction is not allowed`

