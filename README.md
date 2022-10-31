```
/etc/nixos/
├── README.md         - you are here
├── configuration.nix   - Basic/misc configs
└── modules             - All the modules to build my pc
'  ├── manager.nix      - load the various managers
'  ├── config             - System Configuration files
'  │  ├── network           - Network specific
'  │  ├── nur.nix           - Nix user repository. [depricated]
'  │  ├── overlays.nix      - Experiment with overlay instead of overrides.
'  │  ├── overrides.nix     - Overrides for nixpkgs mainly. nur, unstable, homemanager
'  │  ├── programs.nix      - Misc programs to install. maybe move to apps?
'  │  ├── services.nix      - System services to start.
'  │  └── unstable.nix      - Unstable override for nixpkgs. [depricated]
'  │  '  ├── manager.nix      - What to load and misc network configs
'  │  '  ├── hosts.nix        - Excluded hosts, block traffic from these
'  │  '  ├── wireguard-profiles - Wireguard configs i use, 600 permissions
'  │  '  └── wireguard.nix    - This loads the config from the profiles above
'  └── home             - home manager
'  '  ├──  manager.nix     - load programs from apps
'  '  └── apps            - programs with extra configs
'  '  '  ├── alacritty.nix  - Terminal + tmux
'  '  '  ├── bash.nix       - .bashrc and other.
'  '  '  ├── cli-tools.nix  - cli tools
'  '  '  ├── example.nix    - just a template for easy cp
'  '  '  ├── firefox.nix    - My firefox profile
'  '  '  ├── git.nix        - git config
'  '  '  ├── neovim.nix     - Neovim config
'  '  '  ├── nushell.nix    - depricated
'  '  '  ├── sway.nix       - not working
'  '  '  ├── swaytest.nix   - also not working
'  '  '  └── zsh.nix        - my shell config
```
