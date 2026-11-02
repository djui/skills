---
name: security-audit
description: Pre-launch security review and hardening of a web app so attackers can't get in. Covers authentication, secrets, database access, transport, input validation, XSS/CSRF/SQL injection, sessions, uploads, payments, dependencies and leaked secrets, and ends with a findings-and-fixes report. Use when the user asks to secure their app, run a security review, harden a (vibe-coded) app, or prepare it for launch.
---

# Security audit

Goal: keep attackers out of the app and its data. Work through the checklist below against the
actual codebase, fix what applies, test the protections, and finish with a report of findings and
fixes.

## How to work

1. **Map the attack surface first.** Identify the stack, every route and API endpoint (marking
   which are public, authenticated, admin), where data is stored, which third parties are called,
   and where secrets live.
2. **Go through every item.** For each, decide: already done, needs fixing, or not applicable (say
   why). Don't skip items silently.
3. **Use the platform's standard tools.** Prefer the framework's built-in auth, CSRF, escaping and
   session features and well-known libraries over hand-rolled security code.
4. **Fix safely.** Make focused changes and keep the app working. Some steps need the user: rotating
   keys at a provider, rewriting git history, changing hosting settings. Give them exact steps
   instead of doing these silently.
5. **Never print secret values** in output, logs or the report; refer to them by name and location.
6. **Test** each protection you add (e.g. an unauthenticated request to an admin route is refused, a
   forged CSRF request fails, an oversized upload is rejected).

## Checklist

### Authentication and access
- [ ] Set up proper authentication (a vetted provider or the framework's auth, not hand-rolled).
- [ ] Hash passwords with a slow, salted algorithm (Argon2id, bcrypt or scrypt).
- [ ] Lock down admin routes: check authorization on the server for every admin action.
- [ ] Make password reset links single-use and expiring.

### Secrets and configuration
- [ ] Hide API keys: none in frontend code, the client bundle or the repository.
- [ ] Check environment variables: secrets aren't exposed to the client (e.g. `NEXT_PUBLIC_`,
      `VITE_` prefixes) and production values aren't committed.
- [ ] Disable debug mode, verbose errors and stack traces in production.
- [ ] Scan the git history for leaked secrets (e.g. gitleaks, trufflehog).
- [ ] Revoke and replace any compromised or leaked keys.

### Data and database
- [ ] Secure the database: not publicly reachable, least-privilege credentials, row-level
      security or equivalent per-user access checks.
- [ ] Use parameterized queries or the ORM everywhere; no string-built SQL.

### Transport and browser
- [ ] Enforce HTTPS (redirect HTTP, HSTS).
- [ ] Add security headers (Content-Security-Policy, X-Content-Type-Options, frame-ancestors /
      X-Frame-Options, Referrer-Policy, Permissions-Policy).
- [ ] Restrict CORS to known origins; no `*` with credentials.
- [ ] Secure session cookies: `Secure`, `HttpOnly`, `SameSite=Lax` or `Strict`.
- [ ] Add CSRF protection to state-changing requests.

### Input and output
- [ ] Validate forms on the server, not only in the browser.
- [ ] Protect against XSS: escape output, avoid raw HTML injection, sanitize any user HTML.
- [ ] Restrict file uploads by type (checked by content, not just extension) and size, and store
      them outside the web root.

### Payments
- [ ] Verify prices and payment status on the server (never trust amounts from the client; confirm
      via provider webhooks).

### Abuse and monitoring
- [ ] Add rate limiting, especially to login, signup, password reset and expensive endpoints.
- [ ] Log and monitor suspicious activity (repeated failed logins, permission denials), without
      logging secrets or passwords.

### Dependencies and exposure
- [ ] Update vulnerable dependencies (`npm audit`, `pip-audit`, etc.).
- [ ] Remove unused packages.
- [ ] Check for exposed files: `.env`, `.git/`, backups, source maps, admin panels, debug
      endpoints.

### Wrap-up
- [ ] Run a thorough security review of the remaining code for anything the list missed.
- [ ] Test the protections.

## Report

End with a report of findings and fixes:

1. Every finding with severity (critical / high / medium / low), where it is, and its status
   (fixed / needs the user / accepted risk / not applicable).
2. What you changed and how you tested it.
3. Steps only the user can take (key rotation, hosting settings, history rewrite), in order.
