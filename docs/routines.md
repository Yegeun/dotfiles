# Morning Routines

Run `routines` in a terminal. It shows each job, when it runs, when it last ran and whether it
worked, and it warns about any `com.yegeun.*` job on this Mac that is missing from this list.

`<vault>` below means your vault's folder inside `~/Vault`. This repo is public and the vault is
private, so its name and both private clone URLs are deliberately left out of this repo.

## What runs by itself

These run through launchd on the Mac, with no Claude session involved. If the Mac is asleep at
the time, they run when it wakes.

| When | Job | What it does | Lives in |
|------|-----|--------------|----------|
| 07:00, 13:00 | `com.yegeun.sources-daily` | Crawls new papers, repos and news, then writes `~/Desktop/Papers.html`. The 13:00 run finishes the crawl and retries failed sources. | `~/Vault/<vault>`, `.claude/launchd/` |
| 09:00 | `com.yegeun.bwlreact-disk-clean` | Clears old Xcode and Next build files. | `~/Developer/bwlreact`, `scripts/disk-clean.sh` |

Logs are in `~/Library/Logs/`, named `sources-daily.log` and `bwlreact-disk-clean.log`.

## What you run by hand

Open Claude Code in your vault. Both skills come with it.

| Command | What it does |
|---------|--------------|
| `/sources daily` | Files what you exported from the Papers page and checks the feed against the vault's claims. |
| `/leet daily`, then `/leet finish` | Writes today's practice sheet, then stores the filled-in sheet and queues Anki cards. |

## How it fits together

Each job's code and schedule stay in its own repo, so they change together. `routines/jobs`
in this repo is the index: one line per job, saying which folder to look in and which script
installs the job.

- `setup-routines.sh` finds each repo, pulls it and installs its job. It is safe to re-run, and
  `update.sh` runs it too. A repo with local changes is not pulled, and a missing repo is reported
  but never cloned.
- `routines/status` is the `routines` command.

**Adding a job:** add its plist and install script to its repo, then add a line to
`routines/jobs`.

**Changing the feed's schedule:** edit the plist in `.claude/launchd/`, then run
`.claude/launchd/install.sh` from the vault.

## Moving to a new Mac

`git pull` does not carry everything, so start on the old Mac.

### On the old Mac

1. On the Papers page, press **Export thoughts**, then run `/sources daily`. Stars and notes are
   stored in the browser and do not move on their own.
2. Commit and push the vault. Nothing commits the feed's state automatically, and `routines`
   shows how much is waiting.

   ```bash
   cd ~/Vault/<vault> && git add -A && git commit -m "before moving Mac" && git push
   ```

3. Commit and push anything unfinished in `~/Developer/bwlreact`.

### On the new Mac

Use the account name `yegeunji` if you can. The scripts work under any name, but the three vault
`SKILL.md` files name `/Users/yegeunji`.

1. Install the command line tools with `xcode-select --install`. They provide git, Swift and Python.
2. Add the Mac's SSH key to GitHub.
3. Clone the two private repos by hand. Their addresses are in your GitHub account. If the network
   blocks SSH, use host `ssh.github.com` on port 443.

   ```bash
   mkdir -p ~/Vault ~/Developer
   git clone <vault clone url> ~/Vault/<vault>
   git clone <app clone url> ~/Developer/bwlreact
   ```

4. Install everything. This pulls both repos and installs both jobs.

   ```bash
   git clone https://github.com/Yegeun/dotfiles.git ~/dotfiles
   cd ~/dotfiles && ./install-all-and-symlink.sh
   ```

5. Install Claude Code from <https://claude.com/claude-code>, then run `claude` once to log in.
   The feed's summaries use it. Without it, the feed still runs, with no summaries.
6. Copy what git does not hold. `old-mac` stands for the old Mac's address, with Remote Login
   turned on in its System Settings.

   ```bash
   # The Papers page's last 30 days, git-ignored and otherwise lost
   rsync -a old-mac:Vault/<vault>/.claude/sources-state/newsletters/ \
     ~/Vault/<vault>/.claude/sources-state/newsletters/
   ```

   Then copy the `memory` folder inside your vault's entry in `~/.claude/projects/` across to the
   same place. It holds what Claude remembers about the vault, and it is in no repo.

7. Install Anki and set up the `Leetcode` note type, following `Career/LeetCode/Anki Setup.md`
   in the vault.
8. Run `routines`. After the first 07:00 run, check it again and open `~/Desktop/Papers.html`.
   If the page is missing, check the log and allow Python to use the Desktop in System Settings,
   under Privacy & Security, Files and Folders.

### Then turn the old Mac's jobs off

Two Macs running the feed would each write their own state and collide in git. Removing the plist
matters too, because otherwise the job returns at the next login.

```bash
for label in com.yegeun.sources-daily com.yegeun.bwlreact-disk-clean; do
    launchctl bootout "gui/$(id -u)/$label"
    rm ~/Library/LaunchAgents/$label.plist
done
```
