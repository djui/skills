---
name: performance-audit
description: Audit and fix the speed of a web or mobile app so it doesn't feel slow and lose users. Covers loading states, images, network calls, caching, databases, rendering, bundles, infrastructure and monitoring. Use when the user asks to make their app faster, fix slowness, improve load time or Core Web Vitals, or prepare a (vibe-coded) app for launch.
---

# Performance audit

Goal: the app should feel fast on real devices and networks, so users don't leave. Work through the
checklist below against the actual codebase, fix what applies, and finish with a report.

## How to work

1. **Map the app first.** Identify the stack (frontend framework, backend, database, hosting, CDN)
   and the main user flows. Read the code; don't guess.
2. **Go through every item.** For each, decide: already done, needs fixing, or not applicable (say
   why). Don't skip items silently.
3. **Measure where you can.** Prefer evidence (build output and bundle sizes, query plans, network
   timings, Lighthouse) over assumptions, before and after a change.
4. **Fix safely.** Make small, focused changes that keep behavior the same. Ask before changes that
   need new infrastructure, paid services or architecture moves (e.g. Redis, a job queue, a CDN,
   moving regions); propose them with the expected gain instead.
5. **Report** at the end (see below).

## Checklist

### Perceived speed
- [ ] Add skeleton loading screens instead of spinners or blank screens.
- [ ] Update the UI optimistically before the server responds, and roll back on failure.
- [ ] Stream AI responses token by token instead of waiting for the full answer.

### Images and assets
- [ ] Serve images in WebP or AVIF, sized for how they're displayed.
- [ ] Lazy-load images below the fold.
- [ ] Serve static files through a CDN.
- [ ] Enable Brotli or Gzip compression.
- [ ] Enable long-lived browser caching for static (fingerprinted) files.
- [ ] Self-host fonts and limit the number of font weights.

### Network and API calls
- [ ] Prevent duplicate API calls (dedupe in-flight requests, cache client-side).
- [ ] Debounce search and autocomplete inputs.
- [ ] Paginate API results.
- [ ] Run independent requests in parallel instead of one after another.
- [ ] Set timeouts for external API calls.

### Backend and database
- [ ] Fix N+1 queries.
- [ ] Add database indexes for common queries.
- [ ] Select only the columns you need.
- [ ] Use database connection pooling.
- [ ] Cache frequently accessed data (e.g. with Redis), with sensible invalidation.
- [ ] Move slow tasks (email, image processing, exports, webhooks) to a background job queue.

### Frontend rendering and bundles
- [ ] Render pages on the server or at build time where it fits.
- [ ] Split JavaScript by page/route.
- [ ] Remove unused dependencies.
- [ ] Load third-party scripts after the page (defer/async, or on interaction).
- [ ] Virtualize long lists.
- [ ] Prevent unnecessary re-renders.

### Infrastructure
- [ ] Place app servers close to the database.
- [ ] Load-balance traffic across multiple app instances.

### Observability and testing
- [ ] Trace slow backend requests with OpenTelemetry.
- [ ] Track real-user speed with a performance monitoring tool (RUM / Web Vitals).
- [ ] Test on slow phones and slow networks (CPU and network throttling).

## Report

End with:

1. A table of every checklist item: status (done / fixed / proposed / not applicable), what you
   changed or found, and the file(s) involved.
2. Measured before/after numbers where you have them.
3. The proposed changes you did not make, ordered by expected impact versus effort.
