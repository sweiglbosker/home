nixos and home-manager configurations for various systems
---------------------------------------------------------

![deskop](desktop.png)

### Notes

- secret management done outside of nix, i use [pass](https://www.passwordstore.org/) 
- i use the [colemak dh](https://colemakmods.github.io/mod-dh/#qwerty-changes) keyboard layout, this is not easy to change with current modules

### Systems

- [form](/form): Mini itx desktop in my dorm.
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
