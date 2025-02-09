# NixOS Configurations

Here are my **Work in progress** NixOS configurations.

If you are looking for my dotfiles, they are all located at [gh:haashemi/dotfiles](https://github.com/haashemi/dotfiles).

> No I don't and won't use home-manager as I want to be able to change my Linux distro any time a bit more easily.

## Usage

I don not think my configurations would work fine for anyone but me, so I recommend you to just do a walkthrough and copy any part of it that looks good for you.

## Structure:

My nix config is separated in two parts, hosts, modules.

### Hosts

Host contains the entry point configuration of each machine I want NixOS on. They import and enable the required modules in addition to the machine-specific configurations. Each host contains a `hardware.nix` file which is autogenerated by NixOS on installation, they should be regenerated on each installation too.

### Modules

Modules are set of `nixos` configurations that can be imported and everything would just work fine.

> NOTE:
> At the moment of writing this, my modules are specific to my laptop, so I'm not really sure if all of them are compatible everywhere or not.

#### About each module

Here is a review of what each module folder (or file) supposed to do.

- `desktop`:

  A full setup of each DE/WM that I might like to use. Currently I'm focusing on hyprland and plasma6 exists just for the backup plan.

- `hardware`:

  Any configuration, service, or program that makes my hardwares work properly are placed here.

- `system`:

  Any configuration that doesn't have a prefix (like `hardware.*` or whatever) or service/program that affects the way the system operates are placed here.

#### Config naming:

Each module's config is equal to its path with a `hx` prefix. For example, `modules/desktop/hyprland.nix` will be `hx.desktop.hyprland` and the rest of the options are defined in it. `default.nix` files config's are named by their parent folder.

#### Module sources/infos:

While I've been trying my best to write everything from scratch and fully document them by myself, still most of it depends on another source or wikis as they have written and explained it way better that I could possibly do.

So, sources and wikis are located at the top of each `config` clause and specific details commented in each part whenever it was needed.
