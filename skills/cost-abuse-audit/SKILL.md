---
name: cost-abuse-audit
description: Protect an app from attackers and runaway usage burning paid API credits (AI/LLM APIs, SMS, email, storage, serverless) and running up huge bills. Covers leaked keys, bots and fake signups, per-user quotas, token caps, rate and concurrency limits, uploads, storage, background jobs, autoscaling, spend tracking, budget alerts and a kill switch. Use when the user worries about API costs, credit abuse, denial-of-wallet, or wants spending limits on a (vibe-coded) app.
---

# Cost and abuse audit

Goal: nobody, whether an attacker, a bot or a bug, can make the app spend thousands of dollars on paid
APIs and infrastructure. Work through the checklist below against the actual codebase, fix what
applies, and finish with a report.

## How to work

1. **Map every paid call first.** List each place the app spends money: AI model calls, SMS and
   email, paid third-party APIs, file processing, storage, egress, background jobs, serverless and
   autoscaling. Note who can trigger each one (anonymous, signed-in, paid user) and roughly what one
   call costs.
2. **Go through every item.** For each, decide: already done, needs fixing, or not applicable (say
   why). Don't skip items silently.
3. **Enforce on the server.** Every limit must be checked server-side, atomically, so parallel
   requests can't race past it. Client-side checks are only UX.
4. **Fix safely.** Pick defaults that are generous for real users and tell the user what you chose
   so they can tune them. Steps at a provider (revoking keys, billing caps, budget alerts) need the
   user: give exact steps.
5. **Never print secret values**; refer to keys by name and location.

## Checklist

### Keys
- [ ] Keep secret keys out of frontend code; call paid APIs only from the backend.
- [ ] Revoke and replace any leaked keys (check the client bundle, the repo and git history).
- [ ] Separate test and production keys.

### Who can call
- [ ] Add bot checks (e.g. Turnstile, hCaptcha) to public forms.
- [ ] Limit fake signups and free-trial abuse (email verification, disposable-email blocking,
      per-IP/device signup limits).
- [ ] Verify paid access on the server before any paid call.
- [ ] Protect checkout from card testing (bot checks, velocity limits, the provider's fraud
      tools).
- [ ] Limit verification emails and texts (per user, per number/address, per IP, per hour).

### How much per call
- [ ] Lock model choice and token limits server-side; ignore client-supplied model or max-tokens.
- [ ] Cap input tokens and chat history length.
- [ ] Cap output tokens.
- [ ] Limit upload size and processing time.
- [ ] Block zip bombs and giant images (check decompressed size and pixel dimensions before
      processing).
- [ ] Limit batch sizes and query results.

### How often
- [ ] Rate-limit per user and per IP.
- [ ] Set daily quotas per user.
- [ ] Limit simultaneous requests per user.
- [ ] Limit paid third-party API calls.
- [ ] Prevent duplicate billable requests (idempotency keys, in-flight dedupe).
- [ ] Reserve quota before the paid call and settle afterwards, so concurrent requests can't
      overspend.
- [ ] Cap retries, use backoff, and don't retry permanent errors (4xx, content refusals).
- [ ] Test that parallel requests can't bypass any of these limits.

### Storage and files
- [ ] Use signed, expiring URLs for file access.
- [ ] Block public writes to storage buckets.
- [ ] Delete expired temporary files (lifecycle rules).
- [ ] Set log retention limits.

### Jobs and infrastructure
- [ ] Prevent recursive function triggers (e.g. a storage write that triggers itself).
- [ ] Set job timeouts.
- [ ] Stop scheduled jobs from overlapping (locks).
- [ ] Cap autoscaling and serverless concurrency.

### Spend control
- [ ] Track spending per user and per service.
- [ ] Detect spending spikes.
- [ ] Alert before the budget is reached (provider budget alerts plus in-app thresholds).
- [ ] Stop paid requests when the budget runs out.
- [ ] Add a spending kill switch that turns off paid features instantly, without a deploy.

## Report

End with:

1. A table of every paid call path with its cost driver and the limits now protecting it.
2. Every checklist item's status (done / fixed / needs the user / not applicable) and the files
   changed.
3. The limits and defaults you chose, and the provider-side steps the user should take (billing
   caps, budget alerts, key rotation).
