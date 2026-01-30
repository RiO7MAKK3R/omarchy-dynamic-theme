# Matugen Dynamic Theme for Omarchy (Hyprland)

This repository shows **how to build a wallpaper-driven dynamic theme** on **Omarchy + Hyprland** using **matugen**.

Changing the wallpaper will automatically update:
- Hyprland window borders
- Waybar colors

Everything is **scoped to one theme**.  
Other Omarchy themes remain untouched.

---

## ✅ What This Theme Does

When you change the wallpaper:

Wallpaper change
→ matugen generates colors
→ Hyprland borders update
→ Waybar reloads with new colors

yaml
Copy code

No system restart. No global overrides.

---

## 📦 Requirements

- Hyprland
- Omarchy
- Waybar
- `matugen`

Install matugen if needed:

```bash
sudo pacman -S matugen
```

📁 Step 1 — Create a New Omarchy Theme
```bash
mkdir -p ~/.config/omarchy/themes/matugen-dynamic
```

Create the theme name:

``` bash
echo "matugen-dynamic" > ~/.config/omarchy/themes/matugen-dynamic/theme.name
```

(Optional) wallpapers directory:

``` bash
mkdir ~/.config/omarchy/themes/matugen-dynamic/backgrounds
```

Step 2 — Configure Matugen
Create template directories
``` bash
mkdir -p ~/.config/matugen/templates
```

Create colors.css template
bash
Copy code
nano ~/.config/matugen/templates/colors.css
css
Copy code
@define-color background {{ colors.background.default.hex }};
@define-color foreground {{ colors.on_background.default.hex }};
@define-color primary {{ colors.primary.default.hex }};
@define-color surface {{ colors.surface.default.hex }};
Create Hyprland template
bash
Copy code
nano ~/.config/matugen/templates/hyprland.conf
ini
Copy code
general {
  col.active_border = rgb({{ colors.primary.default.hex | replace:"#","" }})
  col.inactive_border = rgb({{ colors.surface.default.hex | replace:"#","" }})
}
Create config.toml
bash
Copy code
nano ~/.config/matugen/config.toml
toml
Copy code
[config]
reload = false

[templates]
css = { input_path = "templates/colors.css", output_path = "colors.css" }
hyprland = { input_path = "templates/hyprland.conf", output_path = "hyprland.conf" }
🪟 Step 3 — Wire Matugen into Hyprland
Create the theme’s Hyprland config:

bash
Copy code
nano ~/.config/omarchy/themes/matugen-dynamic/hyprland.conf
ini
Copy code
## matugen-dynamic theme
source = ~/.config/matugen/hyprland.conf
This applies matugen colors only to this theme.

📊 Step 4 — Configure Waybar (Minimal & Stable)
Create a theme-local colors symlink
bash
Copy code
ln -sf ~/.config/matugen/colors.css \
      ~/.config/omarchy/themes/matugen-dynamic/colors.css
Create waybar.css
bash
Copy code
nano ~/.config/omarchy/themes/matugen-dynamic/waybar.css
css
Copy code
@import "colors.css";

#waybar {
  background-color: alpha(@background, 20%);
  color: @foreground;
}
This is intentionally minimal to avoid GTK CSS issues.

🔁 Step 5 — Hook Matugen into Wallpaper Changes
Omarchy already has a wallpaper switcher.
We extend it.

Edit:

bash
Copy code
nano ~/.local/share/omarchy/bin/omarchy-theme-bg-next
Find the line that updates the wallpaper symlink:

bash
Copy code
ln -nsf "$NEW_BACKGROUND" "$CURRENT_BACKGROUND_LINK"
Immediately after it, add:

bash
Copy code
# Generate colors from wallpaper
matugen image "$(readlink -f "$CURRENT_BACKGROUND_LINK")"

# Reload Waybar CSS
pkill -SIGUSR2 waybar

# Reload Hyprland (for borders)
hyprctl reload
🎯 Step 6 — Activate the Theme
Use Omarchy’s theme switcher and select:

csharp
Copy code
matugen-dynamic
Change wallpapers using Omarchy’s wallpaper keybind.

You should now see:

borders update automatically

Waybar colors update automatically

🧪 Troubleshooting
Waybar doesn’t update
Waybar does not auto-reload imported CSS.

Make sure this line exists in the script:

bash
Copy code
pkill -SIGUSR2 waybar
Waybar disappears
Run Waybar manually to see GTK errors:

bash
Copy code
waybar
Invalid GTK CSS will cause Waybar to exit.


___

---

# Matugen Dynamic Theme for Omarchy (Hyprland)

This document explains how to build a wallpaper-driven dynamic theme on Omarchy using Hyprland and matugen.

Changing the wallpaper will automatically update Hyprland window borders and Waybar colors.  
All changes are scoped to a single Omarchy theme. Other themes are not affected.

---

## What this setup does

When you change the wallpaper, the following happens:

Wallpaper change  
→ matugen generates colors  
→ Hyprland borders update  
→ Waybar reloads with new colors

No session restart and no global config overrides.

---

## Requirements

You need:

- Hyprland
    
- Omarchy
    
- Waybar
    
- matugen
    

Install matugen using your package manager if it is not already installed.

---

## Step 1 — Create a new Omarchy theme

Create a new theme directory at:

~/.config/omarchy/themes/matugen-dynamic

Create the theme name file inside it:

theme.name  
with contents:  
matugen-dynamic

Optionally, create a backgrounds directory inside the theme folder if you want theme-specific wallpapers.

---

## Step 2 — Configure matugen

Create the matugen templates directory:

~/.config/matugen/templates

Create a colors.css template at:

~/.config/matugen/templates/colors.css

Define basic colors that will be consumed by GTK and Waybar:

@define-color background {{ colors.background.default.hex }};  
@define-color foreground {{ colors.on_background.default.hex }};  
@define-color primary {{ colors.primary.default.hex }};  
@define-color surface {{ colors.surface.default.hex }};

Create a Hyprland template at:

~/.config/matugen/templates/hyprland.conf

Define border colors using matugen output:

general {  
col.active_border = rgb({{ colors.primary.default.hex | replace:"#","" }})  
col.inactive_border = rgb({{ colors.surface.default.hex | replace:"#","" }})  
}

Create the matugen config file at:

~/.config/matugen/config.toml

Enable the templates:

[config]  
reload = false

[templates]  
css = { input_path = "templates/colors.css", output_path = "colors.css" }  
hyprland = { input_path = "templates/hyprland.conf", output_path = "hyprland.conf" }

---

## Step 3 — Wire matugen into the Omarchy theme (Hyprland)

Inside the theme directory, create a Hyprland config file:

~/.config/omarchy/themes/matugen-dynamic/hyprland.conf

Add:

source = ~/.config/matugen/hyprland.conf

This ensures that matugen-generated colors only apply when this theme is active.

---

## Step 4 — Configure Waybar

Waybar uses GTK CSS and must read matugen colors via a theme-local path.

Create a symlink inside the theme directory:

colors.css → ~/.config/matugen/colors.css

Then create the Waybar stylesheet at:

~/.config/omarchy/themes/matugen-dynamic/waybar.css

Import the colors and define minimal styling:

@import "colors.css";

#waybar {  
background-color: alpha(@background, 20%);  
color: @foreground;  
}

This minimal setup avoids GTK parsing issues and remains stable.

---

## Step 5 — Hook matugen into Omarchy’s wallpaper switcher

Omarchy already manages wallpaper changes. We extend that logic.

Edit the wallpaper switcher script:

~/.local/share/omarchy/bin/omarchy-theme-bg-next

Locate the line where the background symlink is updated:

ln -nsf "$NEW_BACKGROUND" "$CURRENT_BACKGROUND_LINK"

Immediately after that line, add:

Run matugen on the resolved wallpaper path  
Reload Waybar using SIGUSR2  
Reload Hyprland to apply new border colors

This ensures the full pipeline runs automatically on every wallpaper change.

---

## Step 6 — Activate the theme

Use Omarchy’s theme switcher and select:

matugen-dynamic

Change wallpapers using Omarchy’s wallpaper keybind.

You should now see:

- Hyprland borders change color automatically
    
- Waybar background and text colors update automatically
    

---

## Troubleshooting

If Waybar does not update, ensure that the Waybar reload signal is present in the wallpaper script.

If Waybar disappears, run Waybar manually to inspect GTK CSS errors. Invalid GTK CSS will cause Waybar to exit.

---

## Optional — Wallpaper animations

By default, Omarchy uses swaybg, which does not support transitions.

If you want animated wallpaper changes (fade, grow, circle reveal), replace swaybg with swww in the wallpaper script. This does not affect matugen or theming logic.

---

## Important notes

Matugen only generates colors.  
Nothing changes unless you explicitly wire those colors into components.

GTK apps and Chromium are not dynamically themed in this setup.  
This is intentional to keep the system stable and maintainable.

---

## Final advice

Limit dynamic theming to:

- system borders
    
- bars
    
- shell elements
    

Avoid aggressively theming application interiors unless you are willing to maintain it.

This approach keeps your setup clean, predictable, and future-proof.

---

If you want, next I can:

- tighten this further into a one-page guide
    
- rewrite it in a more “official documentation” tone
    
- or help you format it nicely for GitHub
    

This time it’s deliberately **plain and usable** — you can shape it however you want.

___
___
___
Matugen Dynamic Theme for Omarchy (Hyprland)

This repository documents how to build a wallpaper-driven dynamic theme on Omarchy using Hyprland and matugen.

When the wallpaper changes, the system automatically updates:

- Hyprland window borders
    
- Waybar colors
    

All changes are scoped to a single Omarchy theme. Other themes and global configs are not affected.

---

What this setup does

The full pipeline works as follows:

Wallpaper change  
→ Omarchy updates the background symlink  
→ matugen generates new colors from the wallpaper  
→ Waybar reloads its CSS  
→ Hyprland reloads border colors

No session restart is required.

---

Requirements

You need the following already working on your system:

- Hyprland
    
- Omarchy
    
- Waybar
    
- matugen
    

Matugen must be installed using your package manager.

---

Step 1 — Create a new Omarchy theme

Create a new theme directory:

~/.config/omarchy/themes/matugen-dynamic

Inside that directory, create a file called:

theme.name

Its contents should be:

matugen-dynamic

Optionally, create a backgrounds directory inside the theme folder if you want theme-specific wallpapers.

---

Step 2 — Configure matugen (templates and config)

Matugen works using templates. These define which colors are generated and in which format.

Create the templates directory:

~/.config/matugen/templates

Create a colors template at:

~/.config/matugen/templates/colors.css

Define basic colors that GTK and Waybar can consume, such as background, foreground, primary, and surface colors.

Create a Hyprland template at:

~/.config/matugen/templates/hyprland.conf

Define border colors using matugen’s generated values.

Create the matugen configuration file at:

~/.config/matugen/config.toml

This file tells matugen which templates to use and where to write the generated output files.

At runtime, matugen will generate:

- ~/.config/matugen/colors.css
    
- ~/.config/matugen/hyprland.conf
    

These generated files should NOT be committed to git.

---

Step 3 — Wire matugen into the Omarchy theme (Hyprland)

Inside the theme directory, create:

~/.config/omarchy/themes/matugen-dynamic/hyprland.conf

Add a single line that sources the matugen-generated Hyprland file.

This ensures that:

- matugen colors are applied only when this theme is active
    
- other Omarchy themes remain unchanged
    

---

Step 4 — Configure Waybar (theme-scoped)

Waybar uses GTK CSS and must be able to import matugen colors using a local path.

Create a symlink inside the theme directory that points to the generated matugen colors file.

This makes the colors available to Waybar without using absolute paths.

Then create:

~/.config/omarchy/themes/matugen-dynamic/waybar.css

Import the local colors file and define minimal styling:

- background color
    
- foreground color
    

Keep this file minimal to avoid GTK CSS parsing issues.

---

Step 5 — Hook matugen into Omarchy’s wallpaper switcher

Omarchy already manages wallpaper changes using a script.

The exact script location is:

~/.local/share/omarchy/bin/omarchy-theme-bg-next

This script is what runs when you use Omarchy’s wallpaper change keybind.

Open this script and locate the line where the wallpaper symlink is updated.

Immediately after that line, add logic to:

- run matugen on the resolved wallpaper path
    
- reload Waybar using SIGUSR2
    
- reload Hyprland so border colors update
    

This extends Omarchy’s existing workflow instead of replacing it.

---

Step 6 — Activate the theme

Use Omarchy’s theme switcher and select:

matugen-dynamic

Now change wallpapers using Omarchy’s normal wallpaper keybind.

You should observe:

- Hyprland borders changing color automatically
    
- Waybar colors updating automatically
    

---

Troubleshooting

If Waybar does not update:

- Waybar does not automatically reload imported CSS
    
- Ensure the SIGUSR2 reload signal is present in the wallpaper script
    

If Waybar disappears:

- Run Waybar manually to inspect GTK CSS errors
    
- Invalid GTK CSS will cause Waybar to exit
    

---

Optional — Wallpaper animations

By default, Omarchy uses swaybg, which does not support transitions.

If you want animated wallpaper transitions (fade, grow, circle reveal):

- install swww
    
- replace swaybg calls inside the wallpaper script with swww commands
    

This does not affect matugen or theming logic.

---

Important notes

Matugen only generates colors.  
Nothing changes unless you explicitly wire those colors into components.

GTK apps and Chromium are not dynamically themed in this setup.  
This is intentional to keep the system stable and maintainable.
