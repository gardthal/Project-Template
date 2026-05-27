# Secrets Management

Use environment variables for API keys, tokens, passwords, and other sensitive
configuration. Commit only placeholder names and safe defaults.

## Files

- `.env.example` is committed and documents required variables.
- `.env` is local, ignored by Git, and stores real secret values.
- `.env.*` files are ignored by Git, except `.env.example`.
- `secrets/` is ignored by Git for local credential files that cannot be stored
  as environment variables.

## Add A Secret

1. Add the variable name with an empty or safe placeholder value to
   `.env.example`.
2. Add the real value to your local `.env`.
3. Read the value from the environment in code.
4. Document how the value is used in `README.md` or this file.

Example:

```sh
OPENAI_API_KEY=sk-your-real-key-here
```

Do not paste real keys into source files, tests, docs, prompts, issues, commits,
or pull request descriptions.

## Create Your Local .env

Run setup:

```sh
./setup.sh
```

If `.env.example` exists and `.env` does not, setup creates `.env` from the
example. Then edit `.env` locally and fill in real values.

You can also create it manually:

```sh
cp .env.example .env
```

## Use Secrets In A Shell

Load the `.env` file for a command:

```sh
set -a
. ./.env
set +a
python -m your_package
```

Or export one variable for the current shell session:

```sh
export OPENAI_API_KEY="sk-your-real-key-here"
python -m your_package
```

## Use Secrets In Python

Prefer `os.environ` for required secrets so missing configuration fails clearly:

```python
import os

api_key = os.environ["OPENAI_API_KEY"]
```

Use `os.getenv` only when the value is optional:

```python
import os

app_env = os.getenv("APP_ENV", "development")
```

Python does not load `.env` files automatically. Either load `.env` in the shell
before running Python, or add a small development-only loader later if the
project needs one.

## Rotation And Exposure

- Rotate a key immediately if it is committed, logged, pasted into chat, or
  shared with the wrong audience.
- After rotating, remove the exposed value from code and history if needed.
- Prefer service-specific restricted keys over broad account-level keys.
- Use separate keys for development, CI, staging, and production.
