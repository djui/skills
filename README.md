# skills

Agent skills for AI coding assistants. Each skill is a folder with a `SKILL.md` in the open
[Agent Skills](https://agentskills.io) format, so it works in Claude (Code, desktop and web), OpenAI
Codex and ChatGPT, and other tools that read `SKILL.md`.

| Skill | What it does |
| --- | --- |
| [performance-audit](skills/performance-audit/SKILL.md) | Makes the app feel fast: loading states, images, API calls, caching, database, bundles, monitoring. |
| [security-audit](skills/security-audit/SKILL.md) | Hardens the app before launch: auth, secrets, injection, XSS/CSRF, sessions, uploads, payments, dependencies, leaked keys. |
| [cost-abuse-audit](skills/cost-abuse-audit/SKILL.md) | Stops attackers and bugs from burning paid API credits: keys, bots, quotas, token caps, rate limits, budgets, kill switch. |
| [legal-compliance-audit](skills/legal-compliance-audit/SKILL.md) | Flags and fixes common legal risks: policies, consent, privacy, dark patterns, subscriptions, accessibility, licences. Not legal advice. |

Each skill maps the app first, walks through every checklist item (done, fixed, needs you, or not
applicable), fixes what it safely can, and ends with a report.

## Install

### Claude Code

As a plugin:

```
/plugin marketplace add djui/skills
/plugin install app-audits@djui-skills
```

Or clone the repo and link the skills into `~/.claude/skills` (`make install` also links them into
`~/.codex/skills`):

```bash
git clone https://github.com/djui/skills.git && cd skills && make install
```

### Claude desktop and claude.ai

Run `make zip`, then upload a zip from `dist/` under **Settings → Capabilities → Skills**.

### ChatGPT

Run `make zip`, then upload a zip from `dist/` in ChatGPT's Skills settings.

### Codex CLI

`make install`, or copy a skill folder into `~/.codex/skills/`.

### Anything else

Copy a skill folder into the tool's skills directory, or paste the body of `SKILL.md` into a prompt
or project instructions.

## Use

Ask for it in plain words, e.g. "run a security audit on this app" or "make sure nobody can burn my
OpenAI credits". The assistant loads the matching skill on its own; in Claude Code you can also call
one directly, e.g. `/security-audit`.

## Credits

The checklists are based on four Instagram reels by
[@breakingbreach](https://www.instagram.com/breakingbreach/), extended into step-by-step skills.
