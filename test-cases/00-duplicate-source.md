## Title

CLI login loops after the browser authorization succeeds

## Body

### Description

After completing browser authorization for `gh auth login`, the CLI immediately
asks me to authenticate again. The browser reports that authorization succeeded,
but `gh auth status` says no account is authenticated.

### Reproduction steps

1. Install GitHub CLI 2.98.0 on macOS 15.6.
2. Run `gh auth login`.
3. Select GitHub.com, HTTPS, and browser authentication.
4. Complete the browser flow successfully.
5. Run `gh auth status`.

### Expected behavior

The CLI retains the authenticated account.

### Actual behavior

The CLI reports that no account is authenticated and repeats the login flow.

### Environment

- macOS 15.6
- GitHub CLI 2.98.0
- Corporate network with an authenticated proxy

### Error

`failed to write token to keyring: user interaction is not allowed`

