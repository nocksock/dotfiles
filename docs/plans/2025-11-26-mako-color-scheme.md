# Mako Notification Color Scheme Implementation Plan

> **For Claude:** REQUIRED SUB-SKILL: Use superpowers:executing-plans to implement this plan task-by-task.

**Goal:** Configure mako notifications with dynamic color scheme support (light/dark mode) using simple black/white colors and 4px rounded borders.

**Architecture:** Create a mako stow package with base configuration and a runit service that checks gsettings color-scheme on startup to launch mako with appropriate colors. The existing color-scheme-watch service will restart mako when the color scheme changes.

**Tech Stack:** mako (Wayland notification daemon), GNU Stow, runit, gsettings

---

### Task 1: Create Mako Base Configuration

**Files:**
- Create: `mako/dot-config/mako/config`

**Step 1: Create mako stow package directory structure**

Run: `mkdir -p mako/dot-config/mako`
Expected: Directory created successfully

**Step 2: Create base mako config with border-radius and layout**

Create `mako/dot-config/mako/config`:

```ini
# Mako notification configuration
# Colors are set dynamically via command-line args in the service script

# Layout
width=350
height=150
margin=10
padding=15

# Border styling
border-size=2
border-radius=4

# Icons
icons=1
max-icon-size=48

# Behavior
default-timeout=5000
max-history=20
sort=-time

# Bindings
on-button-left=dismiss
on-button-right=dismiss-all
on-touch=dismiss
```

**Step 3: Verify config file syntax**

Run: `cat mako/dot-config/mako/config`
Expected: File contents displayed correctly with no syntax errors

**Step 4: Commit base configuration**

```bash
git add mako/dot-config/mako/config
git commit -m "feat(mako): add base notification configuration with 4px rounded borders"
```

---

### Task 2: Create Mako Service with Color Scheme Detection

**Files:**
- Create: `linux-desktop/dot-local/services/mako/run`

**Step 1: Create mako service directory**

Run: `mkdir -p linux-desktop/dot-local/services/mako`
Expected: Directory created successfully

**Step 2: Create service run script with color scheme detection**

Create `linux-desktop/dot-local/services/mako/run`:

```sh
#!/usr/bin/env sh

# Get current color scheme from gsettings
current=$(gsettings get org.gnome.desktop.interface color-scheme)

# Set colors based on color scheme
if [[ "$current" == *"dark"* ]]; then
    # Dark mode: white text on black background
    exec mako \
        --background-color=#000000FF \
        --text-color=#FFFFFFFF \
        --border-color=#333333FF \
        --progress-color=over\ #FFFFFFFF
else
    # Light mode: black text on white background
    exec mako \
        --background-color=#FFFFFFFF \
        --text-color=#000000FF \
        --border-color=#CCCCCCFF \
        --progress-color=over\ #000000FF
fi
```

**Step 3: Make service script executable**

Run: `chmod +x linux-desktop/dot-local/services/mako/run`
Expected: File is now executable

**Step 4: Verify script syntax**

Run: `sh -n linux-desktop/dot-local/services/mako/run`
Expected: No syntax errors reported

**Step 5: Commit service script**

```bash
git add linux-desktop/dot-local/services/mako/run
git commit -m "feat(mako): add runit service with dynamic color scheme support"
```

---

### Task 3: Update Color Scheme Watch Service

**Files:**
- Modify: `linux-desktop/dot-local/services/color-scheme-watch/run:5-7`

**Step 1: Read current color-scheme-watch service**

Run: `cat linux-desktop/dot-local/services/color-scheme-watch/run`
Expected: Current service contents displayed

**Step 2: Add mako to processes killed on color scheme change**

Update `linux-desktop/dot-local/services/color-scheme-watch/run`:

```sh
#!/usr/bin/env sh

# use gsettings montor changes to kill processes. restart handled by runit

gsettings monitor org.gnome.desktop.interface color-scheme | while read -r line; do
    pkill waybar
    pkill swaybg
    pkill mako
done
```

**Step 3: Verify script syntax**

Run: `sh -n linux-desktop/dot-local/services/color-scheme-watch/run`
Expected: No syntax errors reported

**Step 4: Commit color-scheme-watch update**

```bash
git add linux-desktop/dot-local/services/color-scheme-watch/run
git commit -m "feat(color-scheme-watch): add mako to processes restarted on color scheme change"
```

---

### Task 4: Update Setup Script to Include Mako Package

**Files:**
- Modify: `setup-linux-desktop:4-5`

**Step 1: Read current setup-linux-desktop script**

Run: `cat setup-linux-desktop`
Expected: Current setup script displayed

**Step 2: Add mako to stow packages**

Update `setup-linux-desktop`:

```sh
#!/usr/bin/env sh
./setup-core

stow --restow --target="$HOME" --dotfiles \
    nox-menu linux-desktop mako
```

**Step 3: Verify script syntax**

Run: `sh -n setup-linux-desktop`
Expected: No syntax errors reported

**Step 4: Commit setup script update**

```bash
git add setup-linux-desktop
git commit -m "feat(setup): add mako to linux-desktop setup"
```

---

### Task 5: Test Mako Configuration

**Files:**
- None (testing only)

**Step 1: Stop existing mako if running**

Run: `pkill mako`
Expected: mako process terminated (or "no process found" if not running)

**Step 2: Run setup script to install configuration**

Run: `./setup-linux-desktop`
Expected: Stow successfully symlinks mako config

**Step 3: Start mako service manually**

Run: `~/.local/services/mako/run &`
Expected: mako starts in background with appropriate color scheme

**Step 4: Send test notification**

Run: `notify-send "Test Notification" "This is a test of mako styling with 4px rounded borders"`
Expected: Notification appears with:
- Rounded corners (4px radius)
- Correct colors for current color scheme (black/white)
- Clean, minimal appearance

**Step 5: Test color scheme switching (if possible)**

Run: `gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'` (or 'prefer-light')
Expected: color-scheme-watch service kills mako, runit restarts it with new colors

Run: `notify-send "Color Test" "Testing color scheme switch"`
Expected: Notification appears with colors matching the new scheme

**Step 6: Document testing results**

Create verification commit message with test results

**Step 7: Final commit**

```bash
git commit --allow-empty -m "test(mako): verify color scheme switching and rounded borders work correctly"
```

---

### Task 6: Add Service to Runit Directory (If Needed)

**Files:**
- Create: symlink from `~/services/mako` to `~/.local/services/mako` (if not auto-managed)

**Step 1: Check if services are auto-managed**

Run: `ls -la ~/services/`
Expected: Verify if services are symlinks or if manual setup is needed

**Step 2: Create service symlink if needed**

If services need manual setup:
Run: `ln -s ~/.local/services/mako ~/services/mako`
Expected: Symlink created

**Step 3: Start service with sv if needed**

If using sv control:
Run: `sv up ~/services/mako`
Expected: Service starts

**Step 4: Verify service is running**

Run: `sv status ~/services/mako`
Expected: Service shows as "run"

**Step 5: Commit documentation if manual steps were needed**

```bash
git commit --allow-empty -m "docs(mako): document service setup and verification steps"
```

---

## Verification Checklist

After completing all tasks:

- [ ] Mako config file exists at `~/.config/mako/config` (via symlink)
- [ ] Config includes `border-radius=4`
- [ ] Service script exists and is executable
- [ ] Service script correctly detects dark/light mode from gsettings
- [ ] color-scheme-watch includes mako in restart list
- [ ] Test notification displays with rounded borders
- [ ] Colors match current color scheme (black/white)
- [ ] Switching color schemes restarts mako with new colors
- [ ] All changes are committed with clear messages

## Notes

- **Border radius**: Set to 4px as requested for subtle rounded corners
- **Colors**: Simple black/white scheme - dark mode uses white text on black, light mode uses black text on white
- **Border colors**: Subtle gray borders (#333 for dark, #CCC for light) to provide definition
- **Progress indicators**: Progress bars use the text color to maintain the simple aesthetic
- **Alpha values**: All colors use FF (fully opaque) for solid appearance
- **Service management**: Follows existing pattern of gsettings check on start + color-scheme-watch restart on change
