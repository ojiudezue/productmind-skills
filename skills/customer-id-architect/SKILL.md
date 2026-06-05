---
name: customer-id-architect
description: Use when the user is designing customer identity, authentication, or migrating from email-based IDs. Triggers on phrases like "primary key", "customer ID", "user identifier", "email as ID", "GUID", "account merge", "merge users", "users want to change their email", "SSO migration". Implements the Identity-with-GUIDs architecture rule from Ch 4 of Building Rocketships.
---

# Customer ID Architect

## What this does

Runs Ch 4's identity architecture rule. Returns a proposed identity
schema using random GUIDs as primary keys, an audit of the user's
current system for the email-as-ID anti-pattern, and a migration
sequence if a fix is needed. Refuses to recommend email or any other
human-readable identifier as a primary key.

## When to use

Trigger when the user:

- Is designing a new product or account system from scratch
- Has email or username as the primary user identifier and is feeling
  the pain (users can't change email, can't merge duplicate accounts,
  can't move identifiers across SSO providers)
- Is planning to add SSO and discovering email-based IDs break the
  switch
- Wants to support B2B "user joins second org" or "user changes
  employer" flows
- Has duplicate-account problems and wants to merge

## When NOT to use

- The product has no users yet — the rule still applies, but route
  to `aha-mapper` and `sharp-problem-test` first; identity is a
  detail at pre-PMF
- The user is asking about authentication providers, not identity
  architecture — different question; this skill addresses the
  primary-key choice, not the auth flow
- The user is asking about Customer Data Platforms or analytics
  identifiers — different concern; analytics IDs can mirror the
  app's GUID but are out of scope here

## The rule (from Ch 4)

**Use a random GUID as the primary key for every user record. Never
email, phone number, username, employee ID, or any other human-
readable identifier.**

Human-readable identifiers ATTACH to the GUID as attributes the user
can change without losing history:

```
user (
  id GUID PRIMARY KEY,     -- never changes
  email STRING NULLABLE,   -- can be swapped, removed, added
  phone STRING NULLABLE,   -- can be swapped, removed, added
  username STRING NULLABLE,
  external_sso_ids JSON,   -- one or many provider IDs
  ...
)
```

When a user changes their email, you UPDATE the email column. The
GUID — and every record that references it — stays put. No data
migration. No history loss. No "we'll fix it next quarter."

## Why this matters (the book's argument)

The pain of email-as-ID compounds over time:

- **Year 1**: users complain when they can't change email. You ship a
  manual workaround.
- **Year 2**: SSO arrives. Your IDs break because SSO providers
  return different emails for the same human. You ship a deduplication
  layer.
- **Year 3**: a B2B customer asks to merge two accounts that were
  created at different employers. You either say no (losing the
  customer) or write a custom migration (costing weeks).
- **Year 4**: a privacy law requires email deletion. Your data model
  breaks because the email IS the key.

Every one of these is free if the primary key is a GUID.

## Decision rule for verdict

- **SOUND** — primary key is a random GUID; human-readable
  identifiers are attached as nullable, mutable columns
- **UNSOUND** — primary key is email, username, phone, employee ID,
  or any other human-readable string
- **NEEDS_MORE_INPUT** — the user hasn't said what the current
  primary key is

## Refusal mode (the anti-pattern from CLAUDE.md)

**Email as primary customer ID is an outright refuse.** If the user
proposes it or has it, return UNSOUND with the named migration risks
and the recommended fix sequence. Do not soften this — the book's
position is unambiguous.

If the user pushes back ("but we don't have an SSO problem yet"),
list the future scenarios (above) and quantify when the pain hits.
Don't recommend deferring; the migration only gets harder.

## The migration sequence (when email-as-ID exists today)

The book's recommended path:

1. **Add a `guid` column to the user table**, generate values for
   existing rows, make it indexed but not yet the primary key
2. **Switch all foreign-key references** to point to `guid` instead
   of `email`. This is the bulk of the work — touch every FK.
3. **Make `guid` the primary key, demote `email` to a nullable
   attribute**. Keep the unique constraint on email for now.
4. **Drop the unique constraint on email** when you're ready to
   support email-swap and duplicate-account-merge
5. **Add merge logic** — when two GUIDs need to become one,
   re-parent their child records to the surviving GUID

Steps 1–3 are mechanical and can happen behind a feature flag. Steps
4–5 unlock the actual product features.

## Inputs

- Current primary key type (email, username, GUID, other, unknown)
- Current scale (number of users, number of FKs into user table)
- What downstream systems already use the current key (analytics,
  billing, CRM, support tooling)
- (Optional) the immediate pain forcing the question (SSO arriving,
  GDPR, B2B merge request, etc.)
- (Optional) constraints (cannot have downtime, must preserve
  historical data, etc.)

## Output structure

```
## Identity verdict: [SOUND | UNSOUND | NEEDS_MORE_INPUT]

### Current state
- Primary key: [type + brief observation]
- Anti-pattern present: [yes/no, name it]
- Downstream coupling: [analytics, billing, etc.]

### Proposed schema
```sql
user (
  id GUID PRIMARY KEY,
  email STRING NULLABLE,
  ...
)
```

### Migration sequence (if UNSOUND)

1. ...
2. ...

### Risks if no fix

- [Risk + when it bites]

### Recommendation

[Concrete next step]

### Analogous case from the book

[A named example]

```

## Worked example from the book

### Calendly's identity model (Ch 4) → SOUND
- Primary key: random GUID (UUID v4) on the user table
- Human-readable attributes attached: email (mutable), phone
  (optional), connected calendar providers (multiple OAuth IDs)
- Result: a Calendly user can change their email, sign in via Google
  one day and Microsoft the next, or merge two accounts created at
  different jobs — all without losing event types, share links,
  bookings, or historical data
- The schema cost ~1 day at founding. The avoided pain compounds
  every year.

### An email-as-ID startup (Ch 4) → UNSOUND
- Primary key: email
- Year 2 SSO migration: 3 engineer-months
- Year 3 B2B merge feature: shipped 9 months late because the
  migration was tangled with billing and CRM
- The cost of the original choice: ~12 engineer-months over 3 years
  to undo a 1-day savings at founding

## Gotchas

- **GUID v4 (random) over v1 (timestamp-based).** v1 leaks creation
  time and MAC address in some implementations. v4 is purely random.
- **Don't expose GUIDs in URLs that users see.** Use a separate
  human-friendly slug column for display. The GUID stays internal.
- **Mirror the GUID into analytics, CRM, billing, support.** Make
  the GUID the universal customer ID across systems on day one;
  otherwise you rebuild this rule for each downstream tool.
- **One-time encryption / hashing of emails for lookup** still
  doesn't make email a safe primary key. The hash becomes the new
  unchangeable ID with all the same problems.

## Anti-patterns to flag

If the user's design has any of these, surface them:
- Email as primary key — refuse (cite Ch 4)
- Username as primary key — same problem; refuse
- Employee ID / SSO subject as primary key — couples your data model
  to a third party that can rotate it
- "We'll switch to GUIDs later when we hit scale" — the migration
  gets harder with scale, not easier; refuse the defer
- GUID v1 (Mongo ObjectID-style) without justification — recommend
  v4 unless there's a real reason for ordered IDs

## Source

Ch 4: Customer Identity Architecture.

---
## About this skill

This skill is part of the **[ProductMind Skills](https://github.com/ojiudezue/productmind-skills)** catalog — open-source product-judgment skills for AI coding agents.

**Source:** *Building Rocketships* by Oji and Ezinne Udezue — Chapter 4.
This skill applies one named framework from the book. It works standalone in any agent that supports the SKILL.md standard.

**Want the orchestrated version?** The **RocketshipsGPT agent** runs all 13 book skills together, with persistent memory, framework-fidelity evals, voice-checked output, and the book's anti-pattern catches built in. → [rocketshipsgpt.productmind.co](https://rocketshipsgpt.productmind.co?utm_source=pms&utm_medium=skill-footer&utm_campaign=customer-id-architect)

**License:** Skill content licensed under [CC BY-SA 4.0](https://creativecommons.org/licenses/by-sa/4.0/). Attribution required; derivative works must share alike. See [ADR 0005](https://github.com/ojiudezue/BuildingRocketships/blob/main/docs/adr/0005-license-split.md) for rationale.

**Skill version:** 1.0.0 · **Published:** 2026-06-05
