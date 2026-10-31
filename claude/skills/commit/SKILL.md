---
name: commit
description: Review pending changes, group into logical commits, and sanity-check. Use when the user asks to commit, or invokes /commit.
---

You are the /commit skill. Your job is to make a set of sensible, well-described commits from the current working tree state.

## Steps

1. **Check repo state** — run `git status` (short form) and `git diff HEAD --stat` to see what's changed
2. **Group logically** — analyze the changes and decide on 1–3 commits (e.g., features together, tests together, docs separate)
3. **Stage and commit** — for each group:
   - Stage the files: `git add <files>`
   - Create a commit with a clear message explaining *why*
   - Include `Co-Authored-By: Claude <noreply@anthropic.com>` footer
4. **Version and changelog** (only when the repo opts in, skip silently if not):
   - Opt-in is a `VERSION` file **and** a `CHANGELOG.md` at the repo root. If either is missing, skip this step entirely and say nothing about it.
   - **Every commit that changes behaviour gets an entry.** Pure refactors, formatting and internal-only docs do not.
   - Bump `VERSION` by what the change actually is, semver: breaking = major, new feature = minor, fix = patch. Several commits in one run share ONE bump, taking the largest kind among them.
   - Add the entry to `CHANGELOG.md` under a `## [<version>] - YYYY-MM-DD` heading, grouped `### Added` / `### Changed` / `### Fixed` / `### Removed`, newest release at the top.
   - **Write it for the people who use the app, not for the diff.** Say what is different for them and why it is better; never name files, functions or tables. Assume it is published on a public page, because it usually is.
   - If the repo has a version sync command (look in `package.json` scripts for `version:sync` or similar), run it so every platform's version follows, and include the files it touched.
   - Put `VERSION`, `CHANGELOG.md` and any synced files in the SAME commit as the change they describe, never a separate "bump version" commit.

5. **Sanity checks** (if tooling exists, skip gracefully if not):
   - Detect package manager from lock file (bun.lock, package-lock.json, yarn.lock, pnpm-lock.yaml)
   - Try `npm run lint` / `bun run lint` / etc. — if it exists and fails, fix and recommit; if missing, skip
   - Try `npm run test:spec` / `bun run test:spec` / etc. — if it exists and fails, report (don't auto-fix); if missing, skip
   - If no package manager found, skip sanity checks entirely
6. **Report** — list the commits you created, the new version if you bumped one, and any issues found

Ask before pushing if there are test failures or other blockers. Works on any repo, any branch, any package manager (or none).

## Releasing to TestFlight (iOS repos only)

Run this only when the user **asks for a release**, never as part of an ordinary commit. Skip the whole section if the repo has no `ios/*.xcodeproj`.

Order matters, and getting it wrong ships a broken build:

1. **Deploy the web app first.** A Release build points at the production origin, so uploading before the server is deployed ships a binary calling routes that do not exist yet.
2. **Bump the build number.** App Store Connect rejects a duplicate, so `CURRENT_PROJECT_VERSION` in `project.pbxproj` must increase on **every** upload. This is separate from `MARKETING_VERSION` (the semver from step 4 above): several uploads can share one marketing version.
3. **Green tests first** — `xcodebuild ... build test` on the simulator.
4. **Archive and upload**, from the `ios/` directory:

```bash
xcodebuild -project WLAnalytics.xcodeproj -scheme WLAnalytics \
  -configuration Release -destination 'generic/platform=iOS' \
  -archivePath build/WLAnalytics.xcarchive archive -allowProvisioningUpdates

xcodebuild -exportArchive -archivePath build/WLAnalytics.xcarchive \
  -exportOptionsPlist ExportOptions.plist -exportPath build/export \
  -allowProvisioningUpdates
```

`-allowProvisioningUpdates` is what lets automatic signing create the distribution certificate and App Store profile; without it a machine holding only a development cert fails. No Xcode GUI and no App Store Connect API key are needed: the upload authenticates through the Apple ID already signed into Xcode.

5. **Check the export rather than trusting it.** In the exported `.ipa`/archive confirm: signed with the Apple Distribution certificate, `get-task-allow` false, `beta-reports-active` true, the privacy manifest present in the bundle root, every entitlement the app needs, and **`aps-environment` set to `production`** (the source entitlements file says `development`; the export step rewrites it, and push is broken for testers if it did not).
6. **Record it** in the project's release log and changelog, including the build number, and tell the user processing takes roughly 15 minutes before the build appears in TestFlight.
