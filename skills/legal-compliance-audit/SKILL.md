---
name: legal-compliance-audit
description: Review a web app for common legal, privacy, consumer-protection, accessibility and licensing risks, and fix what can be fixed in code. Covers privacy policy and terms, cookie consent and trackers, marketing consent and unsubscribe, data retention, access and deletion requests, children's data, dark patterns, fake urgency and reviews, subscriptions and refunds, accessibility, asset and open-source licences, AI labelling, DPAs and subprocessors. Use when the user asks to make their app legally compliant, GDPR/CCPA-ready, accessible, or to avoid legal trouble before launch. Not legal advice.
---

# Legal and compliance audit

Goal: the app should not get its owner into legal trouble. Work through the checklist below against
the actual codebase and product, fix what can be fixed in code, and flag what needs the owner or a
lawyer.

**This is not legal advice.** Requirements differ by country, state and industry. Say so in the
report and recommend that a qualified lawyer review the app, especially the policies you draft.

## How to work

1. **Understand the product first.** What it does, who uses it (consumers or businesses, children?),
   where users are (EU/UK, US states, elsewhere), what personal data it collects, what it charges
   for, and which third-party SDKs, analytics and AI services it uses.
2. **Go through every item.** For each, decide: already done, needs fixing, needs the owner or a
   lawyer, or not applicable (say why). Don't skip items silently.
3. **Fix in code what you can:** consent flows, unsubscribe links, cancellation, accessibility,
   removing dark patterns and fake claims, deletion endpoints, retention jobs.
4. **Draft, don't invent.** You may draft policies and pages from what the app actually does, but
   mark them as drafts for legal review. Never invent facts: no company details, certifications,
   uptime figures or reviews that the owner hasn't given you. Ask for them.

## Checklist

### Policies and agreements
- [ ] Add a privacy policy that matches the data the app really collects.
- [ ] Add terms of service.
- [ ] Add a refund policy.
- [ ] Require an explicit checkbox to accept the privacy policy and terms at signup (not
      pre-ticked).
- [ ] Record acceptance of the terms (who, when, which version).
- [ ] Add business contact details (legal name, address, contact email; an imprint where
      required).
- [ ] State realistic uptime commitments, or none.

### Consent, cookies and tracking
- [ ] Add a cookie banner with a real choice (rejecting is as easy as accepting).
- [ ] Block non-essential trackers until the user consents.
- [ ] Audit third-party SDKs, analytics and tracking: what each one collects and where it sends it.
- [ ] Ask for marketing consent separately from the terms.
- [ ] Add an unsubscribe option to every marketing email.

### Personal data
- [ ] Stop collecting data the app doesn't need.
- [ ] Set data retention limits, and delete or anonymize data after them.
- [ ] Support data access and deletion requests (export and delete account).
- [ ] Get parental consent before collecting children's data, or keep children out.
- [ ] Prevent unauthorized AI training on user data (including by AI vendors; check their
      settings and terms).
- [ ] Set up data processing agreements (DPAs) with vendors that handle personal data.
- [ ] Publish a list of subprocessors.

### Honest selling
- [ ] Remove dark patterns (confirmshaming, pre-ticked boxes, hidden opt-outs, guilt-trip
      cancellation flows).
- [ ] Remove fake countdown timers and fake scarcity.
- [ ] Remove fake reviews and testimonials.
- [ ] Remove unsupported claims ("#1", "trusted by thousands", performance or results claims
      without evidence).
- [ ] Remove false compliance claims (SOC 2, ISO 27001, HIPAA, GDPR-certified) the business
      doesn't hold.
- [ ] Don't use customer logos without permission.
- [ ] Remove hidden fees; show the full price up front.
- [ ] Disclose auto-renewals clearly before purchase.
- [ ] Make subscriptions as easy to cancel as to start.
- [ ] Label AI-generated content.

### Accessibility
- [ ] Fix color contrast (WCAG AA).
- [ ] Add alt text to meaningful images.
- [ ] Make everything usable with the keyboard, with visible focus.

### Intellectual property
- [ ] Verify licences for images, fonts and code (including AI-generated assets and stock).
- [ ] Meet open-source licence obligations (attribution, notices, copyleft terms).
- [ ] Check DMCA requirements if users can upload content (designated agent, takedown process).

### Wrap-up
- [ ] Double-check every change and draft for mistakes; don't state anything as compliant that you
      haven't verified.

## Report

End with:

1. Every checklist item's status (done / fixed / drafted for review / needs the owner / not
   applicable) and the files changed.
2. The facts you need from the owner (company details, jurisdictions, vendors, retention periods).
3. The items that most need a lawyer's review.
4. The note: "This is not legal advice. Have a qualified lawyer review your app."
