stefan's nix configs
--------------------

![deskop](desktop.png)

### Notes

- everything uses an alternate keyboard layout
- I use the runit init system, and wrap user services using [turnstile](https://github.com/chimera-linux/turnstile) (which should in theory be session manager agnostic, but my configurations will only work for runit). 

### Current Systems

- [form](/form): Mini itx desktop in my dorm. (I barely use this these days)
    * os: NixOS
    * case: FormD T1
    * gpu: NVIDIA GeForce RTX 4080 SUPER (proprietary drivers, open-source kernel module)
    * cpu: AMD Ryzen 7800X3D
    * setup for wifi bc there is no ethernet port
    * `nixos-rebuild switch ~/home#form`

- [void](/void): Standalone home-manager setup used on two laptops.
    * os: Void Linux
    * hosts: Framework Laptop 13 (AMD), 51nb x2100
    * kernel: [linux-zen](https://github.com/zen-kernel/zen-kernel/releases)
    * prerequisites: pipewire, session manager, drivers, [turnstile](https://github.com/chimera-linux/turnstile)
    * `home-manager switch --impure --flake ~/home#void` (impure to pass env to [nixGL](https://github.com/nix-community/nixGL)
