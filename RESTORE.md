# Restore

These dotfiles are intended to restore the desktop from git plus a small amount of local-only secret state.

## Fresh Machine

Install the minimal bootstrap tools:

```sh
sudo apt-get update
sudo apt-get install -y git stow
```

Clone the repo:

```sh
git clone git@github.com:joe-mccarthy/dotfiles.git ~/.dots
cd ~/.dots
```

Install packages and stow files. This also configures the Microsoft apt repository before installing VS Code:

```sh
./init.sh
```

For a dry stow-only restore:

```sh
./init.sh --no-install
```

Log out and back into i3 after the first restore.

## Local Secrets

Secrets are intentionally not tracked. Put machine-local environment values in:

```sh
~/.config/secrets/env
```

Use the template at `secrets/env.example` as a guide. Keep the real file mode private:

```sh
mkdir -p ~/.config/secrets
cp ~/.dots/secrets/env.example ~/.config/secrets/env
chmod 600 ~/.config/secrets/env
```

Rotate any token that was ever pasted into a shell config or terminal transcript.

## Backup Flow

Check repo health:

```sh
~/.local/bin/dots-backup check
```

Commit changes:

```sh
~/.local/bin/dots-backup commit "Describe the change"
```

Push committed changes:

```sh
~/.local/bin/dots-backup push
```

Commit and push in one step:

```sh
~/.local/bin/dots-backup sync "Describe the change"
```

## What Is Not Backed Up

Do not track caches, runtime state, browser profiles, pulse cookies, application databases, machine credentials, or access tokens. Recreate those locally or store secrets in a password manager.
